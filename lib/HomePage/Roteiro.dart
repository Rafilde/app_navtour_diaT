import 'package:flutter/material.dart';

class Roteiro extends StatefulWidget {
  const Roteiro({super.key});

  @override
  State<Roteiro> createState() => _RoteiroState();
}

class _RoteiroState extends State<Roteiro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Text("oi mundo Três"),
          ],
        ),
      ),
    );
  }
}