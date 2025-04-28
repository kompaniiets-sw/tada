import 'package:flutter/material.dart';
import 'package:forui/forui.dart' show FButton, FButtonStyle;
import 'package:forui/forui.dart';
import 'package:tada/features/components/buttons/settings_button.dart';
import 'package:tada/features/components/time/time_select_tile.dart';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/features/components/timer/timer_style.dart';
import 'package:tada/theme/custom_themes/switch_theme.dart';
import 'package:iconsax/iconsax.dart';

class TimerSettingsPage extends StatefulWidget {
  final bool pomodoroMode;
  final int focusTime;
  final int breakTime;
  final int longBreakTime;
  final TimerStyle currentStyle;
  final ValueChanged<bool> onPomodoroModeChanged;
  final ValueChanged<int> onFocusTimeChanged;
  final ValueChanged<int> onBreakTimeChanged;
  final ValueChanged<int> onLongBreakTimeChanged;
  final ValueChanged<TimerStyle> onStyleChanged;

  const TimerSettingsPage({
    super.key,
    required this.pomodoroMode,
    required this.focusTime,
    required this.breakTime,
    required this.longBreakTime,
    required this.currentStyle,
    required this.onPomodoroModeChanged,
    required this.onFocusTimeChanged,
    required this.onBreakTimeChanged,
    required this.onLongBreakTimeChanged,
    required this.onStyleChanged,
  });

  @override
  State<TimerSettingsPage> createState() => _TimerSettingsPageState();
}

class _TimerSettingsPageState extends State<TimerSettingsPage> {
  late bool _pomodoroMode;
  late int _focusTime;
  late int _breakTime;
  late int _longBreakTime;
  late TimerStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _pomodoroMode = widget.pomodoroMode;
    _focusTime = widget.focusTime;
    _breakTime = widget.breakTime;
    _longBreakTime = widget.longBreakTime;
    _currentStyle = widget.currentStyle;
  }

  void _saveChanges() {
    widget.onPomodoroModeChanged(_pomodoroMode);
    widget.onFocusTimeChanged(_focusTime);
    widget.onBreakTimeChanged(_breakTime);
    widget.onLongBreakTimeChanged(_longBreakTime);
    widget.onStyleChanged(_currentStyle);
    Navigator.pop(context);
  }

  void _cancelChanges() {
    if (_hasUnsavedChanges()) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Unsaved Changes'),
              content: const Text(
                'You have unsaved changes in your timer settings. Would you like to save them?',
              ),
              actions: [
                FButton(
                  label: const Text('Save'),
                  style: FButtonStyle.primary,
                  onPress: () {
                    Navigator.pop(context);
                    _saveChanges();
                  },
                ),
                FButton(
                  label: const Text('Discard'),
                  style: FButtonStyle.destructive,
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  bool _hasUnsavedChanges() {
    return _pomodoroMode != widget.pomodoroMode ||
        _focusTime != widget.focusTime ||
        _breakTime != widget.breakTime ||
        _longBreakTime != widget.longBreakTime ||
        _currentStyle != widget.currentStyle;
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark ? EColors.dark : EColors.light,
        title: const Text('Timer Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: dark ? Colors.white : null),
          onPressed: _cancelChanges,
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: dark ? EColors.dark : EColors.light,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: dark ? EColors.darkerGrey : EColors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pomodoro Mode',
                        style: TextStyle(fontSize: 16),
                      ),
                      Switch(
                        value: _pomodoroMode,
                        onChanged:
                            (value) => setState(() => _pomodoroMode = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Opacity(
                  opacity: _pomodoroMode ? 1.0 : 0.5,
                  child: IgnorePointer(
                    ignoring: !_pomodoroMode,
                    child: TimeSelectTile(
                      title: 'Focus Time',
                      currentMinutes: _focusTime,
                      onChanged:
                          _pomodoroMode
                              ? (value) => setState(() => _focusTime = value)
                              : (value) {},
                      icon: Iconsax.timer_1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Opacity(
                  opacity: _pomodoroMode ? 1.0 : 0.5,
                  child: IgnorePointer(
                    ignoring: !_pomodoroMode,
                    child: TimeSelectTile(
                      title: 'Break Time',
                      currentMinutes: _breakTime,
                      onChanged:
                          _pomodoroMode
                              ? (value) => setState(() => _breakTime = value)
                              : (value) {},
                      icon: Iconsax.coffee,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Opacity(
                  opacity: _pomodoroMode ? 1.0 : 0.5,
                  child: IgnorePointer(
                    ignoring: !_pomodoroMode,
                    child: TimeSelectTile(
                      title: 'Long Break Time',
                      currentMinutes: _longBreakTime,
                      onChanged:
                          _pomodoroMode
                              ? (value) =>
                                  setState(() => _longBreakTime = value)
                              : (value) {},
                      icon: Iconsax.cup,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FButton(
                          label: const Text('Save'),
                          onPress: _saveChanges,
                          style: FButtonStyle.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: dark ? Colors.white24 : Colors.black12,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FButton(
                            label: const Text('Cancel'),
                            onPress: _cancelChanges,
                            style: FButtonStyle.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
