import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final String _errMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provide a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Password (at least 6 characters)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provide a valid password';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: _authenticate,
                  child: const Text('Login as Admin'),
              ),
              Text(_errMsg, style: const TextStyle(
                fontSize: 18,
                color: Colors.red
              ),)
            ],
          ),
        ),
      ),
    );
  }

  void _authenticate() {
  }
}
