import 'package:flutter/material.dart';
import 'package:tada/common/widgets/icons/rounded_icon.dart';
import 'dart:async';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/utils/constants/sizes.dart';

/// Віджет Pomodoro таймера, який відображає круговий прогрес-бар та кнопки керування
class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  // Стандартна тривалість таймера - 25 хвилин (в секундах)
  static const int _defaultDuration = 25 * 60; 

  // Змінні для керування станом таймера
  int _timeLeft = _defaultDuration; 
  Timer? _timer; 
  bool _isRunning = false; 

  /// Запускає таймер, якщо він ще не запущений
  void _startTimer() {
    if (!_isRunning && _timeLeft > 0) {
      setState(() {
        _isRunning = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_timeLeft > 0) {
          setState(() {
            _timeLeft--;
          });
        } else {
          // Таймер дійшов до нуля
          _timer?.cancel();
          setState(() {
            _isRunning = false; // Зупиняємо таймер
          });
          // Тут можна додати логіку сповіщення або автоматичного переходу
        }
      });
    }
  }

  /// Зупиняє таймер
  void _pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  /// Скидає таймер до початкового значення
  void _resetTimer() {
    _timer?.cancel(); 
    setState(() {
      _timeLeft = _defaultDuration;
      _isRunning = false; 
    });
  }

  /// Форматує час у формат MM:SS
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    // Додаємо перевірку на нуль, щоб уникнути ділення на нуль, якщо _defaultDuration буде 0
    final progress = _defaultDuration > 0 ? _timeLeft / _defaultDuration : 0.0;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final timerSize =
        size.width < size.height ? size.width * 0.7 : size.height * 0.7;

    // Визначаємо, чи показувати кнопку Reset
    final showResetButton = _timeLeft < _defaultDuration && _timeLeft > 0; 

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: timerSize,
            height: timerSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Круговий прогрес-бар
                SizedBox(
                  // Обмежуємо розмір CircularProgressIndicator
                  width: timerSize,
                  height: timerSize,
                  child: CircularProgressIndicator(
                    value: 1 - progress, // Прогрес від 1 до 0
                    strokeWidth: 10,
                    backgroundColor:
                        dark
                            ? Colors.grey.shade800
                            : Colors
                                .grey
                                .shade300, // Трохи змінені кольори фону
                    color: EColors.accent,
                    strokeCap: StrokeCap.round, // Закруглені кінці
                  ),
                ),
                // Текст таймера
                Text(
                  _formatTime(_timeLeft),
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: timerSize * 0.2, // Динамічний розмір шрифту
                    fontWeight: FontWeight.normal,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ESizes.spaceBtwSections * 1.5,), 
          // Рядок з кнопками керування
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Кнопка Play/Pause (ЗАВЖДИ ВИДИМА)
              RoundButton(
                // Використовуємо _pauseTimer коли запущено, і _startTimer коли ні
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                // Іконка змінюється відповідно до стану _isRunning
                icon: _isRunning ? Icons.pause : Icons.play_arrow,
                color: dark ? EColors.white : EColors.night,
                size: timerSize * 0.12,
              ),

              // УМОВНО ПОКАЗУЄМО ВІДСТУП ТА КНОПКУ RESET
              // Використовуємо collection-if: якщо умова true, додаємо елементи списку [...]
              if (showResetButton) ...[
                SizedBox(
                  width: timerSize * 0.08,
                ), // Відступ показуємо тільки з кнопкою Reset
                // Кнопка скидання (видима тільки якщо showResetButton == true)
                RoundButton(
                  onPressed: _resetTimer,
                  icon: Icons.refresh,
                  color: dark ? EColors.white : EColors.night,
                  size: timerSize * 0.12,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

