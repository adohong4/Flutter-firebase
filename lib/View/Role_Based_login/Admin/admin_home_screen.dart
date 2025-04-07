import 'package:flutter/material.dart';
import 'package:flutter_project/Services/auth_services.dart';
import 'package:flutter_project/View/Role_Based_login/login_screen.dart';

AuthServices authServices = AuthServices();

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to the Admin Screen!"),
            ElevatedButton(
              onPressed: () {
                authServices.logOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
