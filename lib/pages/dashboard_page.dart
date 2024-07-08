import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_a_z/auth/auth_service.dart';
import 'package:shop_a_z/pages/login_page.dart';

class DashBoardPage extends StatefulWidget {
  static const String routeName = '/';
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: (){
                AuthService.logOut().then((value) => context.goNamed(LoginPage.routeName));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Dashboard Page'),
      ),
    );
  }
}
