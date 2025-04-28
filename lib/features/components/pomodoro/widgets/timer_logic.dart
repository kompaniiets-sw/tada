import 'package:flutter/material.dart';
import 'dart:async';

class TimerLogic extends ChangeNotifier {
  static const int defaultDuration = 25 * 60; // Стандартна тривалість таймера
  int _timeLeft = defaultDuration; // Залишок часу
  Timer? _timer; // Об'єкт таймера
  bool _isRunning = false; // Чи запущений таймер

  int get timeLeft => _timeLeft;
  bool get isRunning => _isRunning;

  /// Запускає таймер, якщо він ще не запущений
  void startTimer() {
    if (!_isRunning && _timeLeft > 0) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_timeLeft > 0) {
          _timeLeft--;
          notifyListeners(); // Оновлюємо UI
        } else {
          _timer?.cancel();
          _isRunning = false; // Зупиняємо таймер
          notifyListeners(); // Оновлюємо UI
        }
      });
    }
  }

  /// Зупиняє таймер
  void pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      notifyListeners(); // Оновлюємо UI
    }
  }

  /// Скидає таймер до початкового значення
  void resetTimer() {
    _timer?.cancel();
    _timeLeft = defaultDuration;
    _isRunning = false; // Таймер не запущений після скидання
    notifyListeners(); // Оновлюємо UI
  }

  /// Форматує час у формат MM:SS
  String formatTime() {
    int minutes = _timeLeft ~/ 60;
    int remainingSeconds = _timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}