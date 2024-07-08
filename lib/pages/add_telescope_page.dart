import 'package:flutter/material.dart';

class AddTeleScope extends StatefulWidget {
  static const String routeName = 'addtelescope';
  const AddTeleScope({super.key});

  @override
  State<AddTeleScope> createState() => _AddTeleScopeState();
}

class _AddTeleScopeState extends State<AddTeleScope> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTeleScopes'),
      ),
      body: const Center(
        child: Text('Add TeleScopes'),
      ),
    );
  }
}
