import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/account.dart';
import 'package:flutter_banco_douro/ui/styles/app_colors.dart';
import 'package:flutter_banco_douro/ui/widgets/account_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGrey,
        title: const Text("Sistema de Gestão de Contas"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "login");
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AccountWidget(
            account: Account(
                id: "IDO01",
                name: "Kurt",
                lastName: "Flutter",
                balance: 5000.0,
                accountType: "Conta Corrente")
                ),
      ),
    );
  }
}
