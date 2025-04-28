import 'package:flutter/material.dart';
import 'package:tada/common/widgets/icons/rounded_icon.dart';
import 'dart:async';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/utils/constants/sizes.dart';
import 'package:google_fonts/google_fonts.dart';

/// Віджет Pomodoro таймера, який відображає круговий прогрес-бар та кнопки керування
class PomodoroTimer extends StatefulWidget {
  final int focusDuration;
  final int breakDuration;
  final int longBreakDuration;

  const PomodoroTimer({
    super.key,
    required this.focusDuration,
    required this.breakDuration,
    required this.longBreakDuration,
  });

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  // Змінні для керування станом таймера
  late int _timeLeft;
  Timer? _timer;
  bool _isRunning = false;

  // Змінні для циклів помодоро
  int _currentCycle = 0;
  bool _isFocusTime = true;
  bool _isLongBreak = false;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.focusDuration;
  }

  @override
  void didUpdateWidget(PomodoroTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusDuration != widget.focusDuration ||
        oldWidget.breakDuration != widget.breakDuration ||
        oldWidget.longBreakDuration != widget.longBreakDuration) {
      _resetTimer();
    }
  }

  String get _currentStateText {
    if (_isLongBreak) return 'Long Break Time';
    return _isFocusTime ? 'Focus Session' : 'Break Time';
  }

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
          _timer?.cancel();
          setState(() {
            _isRunning = false;
            _switchToNextPhase();
          });
        }
      });
    }
  }

  void _switchToNextPhase() {
    if (_isFocusTime) {
      _isFocusTime = false;
      _timeLeft =
          _isLongBreak ? widget.longBreakDuration : widget.breakDuration;
    } else {
      _isFocusTime = true;
      _timeLeft = widget.focusDuration;

      if (!_isLongBreak) {
        _currentCycle = (_currentCycle + 1) % 4;
        _isLongBreak = _currentCycle == 0;
      } else {
        _isLongBreak = false;
      }
    }
  }

  void _pauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _timeLeft = widget.focusDuration;
      _isRunning = false;
      _currentCycle = 0;
      _isFocusTime = true;
      _isLongBreak = false;
    });
  }

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
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final timerSize =
        size.width < size.height ? size.width * 0.7 : size.height * 0.7;
    final progress =
        _isFocusTime
            ? _timeLeft / widget.focusDuration
            : (_isLongBreak
                ? _timeLeft / widget.longBreakDuration
                : _timeLeft / widget.breakDuration);

    return Container(
      color: dark ? EColors.dark : EColors.light,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Текст поточного стану
              Text(
                _currentStateText,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: ESizes.spaceBtwItems),

              // Таймер
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: CircularProgressIndicator(
                        value: 1 - progress,
                        strokeWidth: 10,
                        backgroundColor:
                            dark ? Colors.grey.shade800 : Colors.grey.shade300,
                        color: EColors.accent,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      _formatTime(_timeLeft),
                      style: GoogleFonts.robotoMono(
                        fontSize: 48,
                        fontWeight: FontWeight.normal,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: ESizes.spaceBtwSections),

              // Індикатори циклів
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isCompleted = index < _currentCycle;
                  return Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isCompleted
                              ? EColors.accent
                              : (dark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300),
                    ),
                  );
                }),
              ),

              const SizedBox(height: ESizes.spaceBtwSections * 1.5),

              // Кнопки керування
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundButton(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    icon: _isRunning ? Icons.pause : Icons.play_arrow,
                    color: dark ? EColors.white : EColors.night,
                    size: timerSize * 0.12,
                  ),
                  if (_timeLeft <
                      (_isFocusTime
                          ? widget.focusDuration
                          : (_isLongBreak
                              ? widget.longBreakDuration
                              : widget.breakDuration))) ...[
                    SizedBox(width: timerSize * 0.08),
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
        ),
      ),
    );
  }
}
