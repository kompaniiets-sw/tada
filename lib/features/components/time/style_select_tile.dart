import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:tada/features/components/time/time_style.dart';

class StyleSelectTile extends StatefulWidget {
  final TimerStyle currentStyle;
  final ValueChanged<TimerStyle> onChanged;

  const StyleSelectTile({
    super.key,
    required this.currentStyle,
    required this.onChanged,
  });

  @override
  State<StyleSelectTile> createState() => _StyleSelectTileState();
}

class _StyleSelectTileState extends State<StyleSelectTile> {
  final controller = FRadioSelectGroupController<TimerStyle>();

  @override
  void initState() {
    super.initState();
    controller.value = {widget.currentStyle};
  }

  @override
  Widget build(BuildContext context) => FSelectMenuTile<TimerStyle>(
    groupController: controller,
    autoHide: true,
    validator: (value) => value == null ? 'Select style' : null,
    prefixIcon: const Icon(Icons.style_outlined),
    title: const Text('Timer Style'),
    details: ListenableBuilder(
      listenable: controller,
      builder:
          (context, _) => Text(switch (controller.value.firstOrNull) {
            TimerStyle.classic => 'Classic',
            TimerStyle.modern => 'Modern',
            TimerStyle.minimal => 'Minimal',
            TimerStyle.gradient => 'Gradient',
            TimerStyle.dark => 'Dark',
            TimerStyle.light => 'Light',
            null => 'Select style',
          }),
    ),
    menu:
        TimerStyle.values
            .map(
              (style) =>
                  FSelectTile(title: Text(style.displayName), value: style),
            )
            .toList(),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
