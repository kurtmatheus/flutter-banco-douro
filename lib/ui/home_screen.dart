import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/account.dart';
import 'package:flutter_banco_douro/services/account_service.dart';
import 'package:flutter_banco_douro/ui/styles/app_colors.dart';
import 'package:flutter_banco_douro/ui/widgets/account_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Account>> _futureListAccounts = AccountService().getAll();

  Future<void> refreshListAccount() async {
    setState(() {
      _futureListAccounts = AccountService().getAll();
    });
  }

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
        child: RefreshIndicator(
          onRefresh: refreshListAccount,
          child: FutureBuilder(
            future: _futureListAccounts,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  var listAccount = snapshot.data;
                  if (snapshot.data == null || listAccount!.isEmpty) {
                    return const Center(
                      child: Text("Nenhuma Conta encontrada."),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: listAccount.length,
                      itemBuilder: (context, index) {
                        return AccountWidget(account: listAccount[index]);
                      },
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
