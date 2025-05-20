import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/account.dart';
import 'package:flutter_banco_douro/ui/styles/app_colors.dart';

class AccountWidget extends StatelessWidget {
  final Account account;
  const AccountWidget({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.lightOrange,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${account.name} ${account.lastName}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              Text("ID: ${account.id}"),
              Text("Saldo: ${account.balance}"),
              Text("Tipo: ${account.accountType ?? "Sem Tipo de Conta"}")
            ],
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
    );
  }
}
