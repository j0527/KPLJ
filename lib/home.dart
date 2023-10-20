import 'package:blind_dating/homewidget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("소🐶팅"),
      ),
      body: const HomeWidget(),
    );
  }
}
