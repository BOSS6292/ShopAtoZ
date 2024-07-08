import 'package:flutter/material.dart';

class ViewTeleScope extends StatefulWidget {
  static const String routeName = 'viewtelescope';
  const ViewTeleScope({super.key});

  @override
  State<ViewTeleScope> createState() => _ViewTeleScopeState();
}

class _ViewTeleScopeState extends State<ViewTeleScope> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ViewTeleScopes'),
      ),
      body: const Center(
        child: Text('View TeleScopes'),
      ),
    );
  }
}
