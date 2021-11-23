//Yavuz Selim GÜLER
//1306160016
import 'dart:async';
import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  TimerText({this.stopwatch});
  final Stopwatch stopwatch;
  TimerTextState createState() => new TimerTextState(stopwatch: stopwatch);
}

class TimerTextState extends State<TimerText> {
  Timer timer;
  final Stopwatch stopwatch;

  TimerTextState({this.stopwatch}) {
    timer = new Timer.periodic(new Duration(milliseconds: 30), callback);
  }
  
  void callback(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle timerTextStyle = const TextStyle(fontSize: 20.0, fontFamily: "Open Sans");
    var formattedTime = stopwatch.elapsed;
    return new Text(formattedTime.toString(), style: timerTextStyle);
  }
}