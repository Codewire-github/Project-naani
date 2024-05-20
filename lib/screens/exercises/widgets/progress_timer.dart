import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naani/common/colors.dart';

class ProgressTimer extends StatefulWidget {
  final Duration countdownDuration;
  final Duration timerDuration;
  final VoidCallback onTimerComplete;

  ProgressTimer({
    Key? key,
    required this.countdownDuration,
    required this.timerDuration,
    required this.onTimerComplete,
  }) : super(key: key);

  @override
  _ProgressTimerState createState() => _ProgressTimerState();
}

class _ProgressTimerState extends State<ProgressTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  double _progressValue = 0.0;
  bool _timerStarted = false;
  int _countdownValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.timerDuration,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onTimerComplete();
      }
    });
    startCountdown();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownValue < widget.countdownDuration.inSeconds) {
          _countdownValue++;
          _progressValue = _countdownValue / widget.countdownDuration.inSeconds;
        } else {
          timer.cancel();
          setState(() {
            _timerStarted = true;
          });
          startTimer();
        }
      });
    });
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    int totalSeconds = widget.timerDuration.inSeconds;
    int elapsedSeconds = 0;

    _timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        elapsedSeconds++;
        _progressValue = elapsedSeconds / totalSeconds;
      });
      if (elapsedSeconds >= totalSeconds) {
        timer.cancel();
      }
    });
    _controller.forward();
  }

  String getRemainingTime() {
    int remainingSeconds = ((_controller.duration!.inSeconds -
            _controller.value * _controller.duration!.inSeconds))
        .toInt();
    if (remainingSeconds > 0) {
      return '$remainingSeconds sec';
    } else {
      return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                LinearProgressIndicator(
                  value: _progressValue,
                  borderRadius: BorderRadius.circular(30),
                  backgroundColor:
                      Colors.grey[400], // Change background color if needed
                  valueColor: AlwaysStoppedAnimation<Color>(_timerStarted
                      ? Colors.orange[600]!
                      : primaryGreenColor), // Change progress bar color
                  minHeight: 35, // Adjust height to make it thicker
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _timerStarted
                          ? getRemainingTime()
                          : 'Starting in ${widget.countdownDuration.inSeconds - _countdownValue} s',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
