import 'package:flutter/material.dart';
import 'package:tada/common/widgets/icons/rounded_icon.dart';
import 'dart:async';
import 'package:tada/utils/constants/colors.dart';
import 'package:tada/utils/constants/sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class FlowTimer extends StatefulWidget {
  const FlowTimer({super.key});

  @override
  State<FlowTimer> createState() => _FlowTimerState();
}

class _FlowTimerState extends State<FlowTimer> {
  // Початковий час - 0 годин, 0 хвилин, 0 секунд
  int _timeElapsed = 0;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (!_isRunning) {
      setState(() {
        _isRunning = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _timeElapsed++;
        });
      });
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
      _timeElapsed = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
    final timerSize = size.width < size.height ? size.width * 0.7 : size.height * 0.7;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(_timeElapsed),
            style: GoogleFonts.robotoMono(
              fontSize: timerSize * 0.2,
              fontWeight: FontWeight.normal,
              color: theme.colorScheme.onSurface,
            ),
          ),

          SizedBox(height: ESizes.spaceBtwSections * 1.5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundButton(
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                icon: _isRunning ? Icons.pause : Icons.play_arrow,
                color: dark ? EColors.white : EColors.night,
                size: timerSize * 0.12,
              ),

              if (_timeElapsed > 0) ...[
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
    );
  }
} 