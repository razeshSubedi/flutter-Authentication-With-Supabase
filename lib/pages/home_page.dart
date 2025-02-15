import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String nameOfUser;
  const HomePage({
    super.key,
    required this.nameOfUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("WELCOME $nameOfUser"),
      ),
    );
  }
}
