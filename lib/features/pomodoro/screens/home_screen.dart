import 'package:flutter/material.dart';
import 'package:forui/forui.dart'
    show
        FButton,
        FButtonStyle,
        FSelectMenuTile,
        FSelectTile,
        FRadioSelectGroupController,
        FPortalFollowerShift,
        FHidePopoverRegion,
        FDialog;
import 'package:iconsax/iconsax.dart';
import 'package:tada/common/widgets/appbar/header_appbar.dart';
import 'package:tada/helpers/helper_functions.dart';
import 'package:tada/features/components/pomodoro/pomodoro_timer.dart';
import 'package:tada/features/components/flow_timer/flow_timer.dart';
import 'package:tada/features/pages/timer_settings_page.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/features/components/timer/timer_style.dart';
import 'package:get/get.dart';

enum TimeOption {
  five(5),
  ten(10),
  fifteen(15),
  twenty(20),
  twentyFive(25),
  thirty(30),
  thirtyFive(35),
  forty(40),
  fortyFive(45),
  fifty(50);

  final int minutes;
  const TimeOption(this.minutes);
}

class TimeSelectTile extends StatefulWidget {
  final String title;
  final int currentValue;
  final List<TimeOption> options;
  final ValueChanged<int> onChanged;
  final IconData icon;

  const TimeSelectTile({
    required this.title,
    required this.currentValue,
    required this.options,
    required this.onChanged,
    required this.icon,
    super.key,
  });

  @override
  State<TimeSelectTile> createState() => _TimeSelectTileState();
}

class _TimeSelectTileState extends State<TimeSelectTile> {
  late final FRadioSelectGroupController<TimeOption> controller;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    controller = FRadioSelectGroupController(
      value: widget.options.firstWhere(
        (option) => option.minutes == widget.currentValue,
        orElse: () => widget.options.first,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isMenuOpen = !isMenuOpen),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color:
                  dark
                      ? EColors.darkerGrey
                      : Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      widget.icon,
                      size: 20,
                      color:
                          dark
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                            dark
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${controller.value.firstOrNull?.minutes ?? widget.currentValue} min',
                      style: TextStyle(
                        color:
                            dark
                                ? Colors.white
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isMenuOpen ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                      size: 20,
                      color:
                          dark
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isMenuOpen)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children:
                  widget.options
                      .map(
                        (option) => GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.value = {option};
                              widget.onChanged(option.minutes);
                              isMenuOpen = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: dark ? Colors.white24 : Colors.black12,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${option.minutes} min',
                                  style: TextStyle(
                                    color:
                                        dark
                                            ? Colors.white
                                            : Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                  ),
                                ),
                                if (controller.value.contains(option))
                                  Icon(
                                    Iconsax.tick_circle,
                                    size: 20,
                                    color:
                                        dark
                                            ? Colors.white
                                            : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _focusTime = 25;
  int _breakTime = 5;
  int _longBreakTime = 15;
  TimerStyle _currentStyle = TimerStyle.classic;
  bool _pomodoroMode = true;

  void _updateTimerSettings(int focusTime, int breakTime, int longBreakTime) {
    setState(() {
      _focusTime = focusTime;
      _breakTime = breakTime;
      _longBreakTime = longBreakTime;
    });
  }

  Widget _buildSettingsButton() {
    return IconButton(
      onPressed:
          () => Get.to(
            () => TimerSettingsPage(
              pomodoroMode: _pomodoroMode,
              focusTime: _focusTime,
              breakTime: _breakTime,
              longBreakTime: _longBreakTime,
              currentStyle: _currentStyle,
              onPomodoroModeChanged:
                  (value) => setState(() => _pomodoroMode = value),
              onFocusTimeChanged:
                  (value) =>
                      _updateTimerSettings(value, _breakTime, _longBreakTime),
              onBreakTimeChanged:
                  (value) =>
                      _updateTimerSettings(_focusTime, value, _longBreakTime),
              onLongBreakTimeChanged:
                  (value) =>
                      _updateTimerSettings(_focusTime, _breakTime, value),
              onStyleChanged: (style) => setState(() => _currentStyle = style),
            ),
          ),
      icon: const Icon(Iconsax.setting_2),
    );
  }

  Widget _buildTimerContent() {
    return _pomodoroMode
        ? PomodoroTimer(
          focusDuration: _focusTime * 60,
          breakDuration: _breakTime * 60,
          longBreakDuration: _longBreakTime * 60,
        )
        : const FlowTimer();
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: HeaderAppbar(title: 'Tada', actions: [_buildSettingsButton()]),
      backgroundColor: dark ? EColors.dark : EColors.light,
      body: _buildTimerContent(),
    );
  }
}

// Extracted functions
Widget _buildTimeSelectHeader(
  BuildContext context,
  String title,
  IconData icon,
  bool dark,
) {
  return Row(
    children: [
      Icon(
        icon,
        size: 20,
        color: dark ? Colors.white : Theme.of(context).colorScheme.onSurface,
      ),
      const SizedBox(width: 8),
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: dark ? Colors.white : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ],
  );
}

Widget _buildTimeSelectValue(
  BuildContext context,
  int value,
  bool dark,
  bool isMenuOpen,
) {
  return Row(
    children: [
      Text(
        '$value min',
        style: TextStyle(
          color: dark ? Colors.white : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      const SizedBox(width: 8),
      Icon(
        isMenuOpen ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
        size: 20,
        color: dark ? Colors.white : Theme.of(context).colorScheme.onSurface,
      ),
    ],
  );
}

Widget _buildTimeOptionTile(
  BuildContext context,
  TimeOption option,
  bool dark,
  bool isSelected,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: dark ? Colors.white24 : Colors.black12),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${option.minutes} min',
          style: TextStyle(
            color:
                dark ? Colors.white : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (isSelected)
          Icon(
            Iconsax.tick_circle,
            size: 20,
            color: dark ? Colors.white : Theme.of(context).colorScheme.primary,
          ),
      ],
    ),
  );
}
