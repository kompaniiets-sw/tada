enum TimerStyle {
  classic,
  modern,
  minimal,
  gradient,
  dark,
  light;

  String get displayName {
    switch (this) {
      case TimerStyle.classic:
        return 'Classic';
      case TimerStyle.modern:
        return 'Modern';
      case TimerStyle.minimal:
        return 'Minimal';
      case TimerStyle.gradient:
        return 'Gradient';
      case TimerStyle.dark:
        return 'Dark';
      case TimerStyle.light:
        return 'Light';
    }
  }
} 