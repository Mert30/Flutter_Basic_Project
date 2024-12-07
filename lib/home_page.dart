import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  int seconds = 0;
  bool isRunning = false;

  Future<void> startButton() async {
    setState(() {
      if (isRunning) return;
      isRunning = true;

      timer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
        setState(() {
          seconds++;
        });
      });
    });
  }

  Future<void> pauseButton() async {
    setState(() {
      if (!isRunning) return; // Zaten durduysa bir şey yapma
      isRunning = false;
      timer.cancel();
    });
  }

  Future<void> resetButton() async {
    setState(() {
      pauseButton(); // Önce durdur
      setState(() {
        seconds = 0;
      });
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "= Stopwatch =",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 31, 30, 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                formatTime(seconds),
                style: const TextStyle(
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: startButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 31, 30, 30),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: pauseButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 31, 30, 30),
                    ),
                    child: const Text(
                      "Pause",
                      style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: resetButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 31, 30, 30),
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
