import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  static const String routeName = '/';
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Dashboard Page'),
      ),
    );
  }
}
