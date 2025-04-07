import 'package:flutter/material.dart';

/// Віджет для круглої кнопки
class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final double size;

  const RoundButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Додаємо трохи внутрішнього відступу через IconButton
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5), // Трохи товстіша рамка
        shape: BoxShape.circle, // Робимо контейнер круглим для кращого вигляду
      ),
      child: IconButton(
        padding: EdgeInsets.zero, // Забираємо стандартний відступ IconButton
        constraints: BoxConstraints.tight(
          Size(size * 1.8, size * 1.8),
        ), // Обмежуємо розмір області натискання
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size, // Розмір самої іконки
          color: color,
        ),
        splashRadius: size * 1.1, // Радіус сплешу при натисканні
      ),
    );
  }
}
