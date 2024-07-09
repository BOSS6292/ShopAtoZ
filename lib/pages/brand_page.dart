import 'package:flutter/material.dart';

class BrandPage extends StatelessWidget {
  static const String routeName = '/';
  const BrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Brand'),
      ),
      body: const Center(),
    );
  }
}
