import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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

  static TimeOption fromMinutes(int minutes) {
    return TimeOption.values.firstWhere(
      (option) => option.minutes == minutes,
      orElse: () => TimeOption.twentyFive,
    );
  }
}

class TimeSelectTile extends StatefulWidget {
  final String title;
  final int currentMinutes;
  final ValueChanged<int> onChanged;
  final IconData icon;

  const TimeSelectTile({
    super.key,
    required this.title,
    required this.currentMinutes,
    required this.onChanged,
    required this.icon,
  });

  @override
  State<TimeSelectTile> createState() => _TimeSelectTileState();
}

class _TimeSelectTileState extends State<TimeSelectTile> {
  final controller = FRadioSelectGroupController<TimeOption>();

  @override
  void initState() {
    super.initState();
    controller.value = {TimeOption.fromMinutes(widget.currentMinutes)};
    controller.addListener(_handleValueChange);
  }

  void _handleValueChange() {
    final selectedOption = controller.value.firstOrNull;
    if (selectedOption != null) {
      widget.onChanged(selectedOption.minutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FSelectMenuTile<TimeOption>(
      groupController: controller,
      autoHide: true,
      validator: (value) => value == null ? 'Select time' : null,
      prefixIcon: Icon(widget.icon),
      title: Text(widget.title),
      details: ListenableBuilder(
        listenable: controller,
        builder: (context, _) => Text(
          '${controller.value.firstOrNull?.minutes ?? widget.currentMinutes} min',
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
        ),
      ),
      menu: TimeOption.values.map((option) => FSelectTile(
        title: Text('${option.minutes} min'),
        value: option,
      )).toList(),
      //style: FSelectMenuTileStyle
    );
  }

  @override

  void dispose() {
    controller.dispose();
    super.dispose();
  }
} 