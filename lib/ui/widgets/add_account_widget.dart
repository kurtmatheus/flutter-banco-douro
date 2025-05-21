import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/account.dart';
import 'package:flutter_banco_douro/services/account_service.dart';
import 'package:flutter_banco_douro/ui/styles/app_colors.dart';
import 'package:uuid/uuid.dart';

class AddAccountWidget extends StatefulWidget {
  const AddAccountWidget({super.key});

  @override
  State<AddAccountWidget> createState() => _AddAccountWidgetState();
}

class _AddAccountWidgetState extends State<AddAccountWidget> {
  String _accountType = "AMBROSIA";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.only(left: 32, right: 32, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Image.asset("assets/images/icon_add_account.png"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Adicionar Nova Conta",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Preencha os dados abaixo:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      label: Text("Nome"),
                    )),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      label: Text("Sobrenome"),
                    )),
                const SizedBox(
                  height: 40,
                ),
                const Text("Tipo da Conta"),
                DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(value: "AMBROSIA", child: Text("Ambrosia")),
                    DropdownMenuItem(value: "CANJICA", child: Text("Canjica")),
                    DropdownMenuItem(value: "PUDIM", child: Text("Pudim")),
                    DropdownMenuItem(value: "BRIGADEIRO", child: Text("Brigadeiro"))
                  ],
                  value: _accountType,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _accountType = value;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: isLoading ? null : onButtonCancelClicked,
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: isLoading ? null : onButtonAddAccountpressed,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.orange),
                      ),
                      child: isLoading
                          ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                                color: Colors.white70,
                              ),
                          )
                          : const Text(
                              "Adicionar",
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                    ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  onButtonCancelClicked() {
    if (!isLoading) {
      closeModal();
    }
  }

  onButtonAddAccountpressed() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      String name = _nameController.text;
      String lastName = _lastNameController.text;

      Account account = Account(
        id: const Uuid().v1(),
        name: name,
        lastName: lastName,
        balance: 0,
        accountType: _accountType,
      );

      await AccountService().addAccount(account);

      closeModal();
    }
  }

  closeModal() {
    Navigator.pop(context);
  }
}
