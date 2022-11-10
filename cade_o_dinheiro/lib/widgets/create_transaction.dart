import 'package:cade_o_dinheiro/models/budget_model.dart';
import 'package:cade_o_dinheiro/models/transaction_model.dart';
import 'package:cade_o_dinheiro/models/wallet_model.dart';
import 'package:cade_o_dinheiro/repositories/budgets_repository.dart';
import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_select/flutter_native_select.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateTransaction extends StatefulWidget {
  var budgetsRepository = Get.find<BudgetsRepository>();
  var walletsRepository = Get.find<WalletsRepository>();

  TransactionModel? transaction;
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final dateController = TextEditingController();
  final walletController = TextEditingController();
  final budgetController = TextEditingController();

  String selectedType = 'Despezas';
  WalletModel? selectedWallet;
  BudgetModel? selectedBudget;

  final transactionTypes = ['Despezas'];

  var wallets = <WalletModel>[].obs;
  var budgets = <BudgetModel>[].obs;

  CreateTransaction({
    Key? key,
    this.transaction,
  }) {
    wallets.addAll(walletsRepository.wallets);
    budgets.addAll(budgetsRepository.budgets);

    if (transaction != null) {
      nameController.text = transaction!.name;
      valueController.text = transaction!.total.toString();
      selectedType = transaction!.transactionType;
      selectedBudget = transaction?.budget;
      selectedWallet = transaction?.wallet;
      walletController.text = "${selectedWallet?.name}";
      budgetController.text = "${selectedBudget?.name}";
      dateController.text = DateFormat('dd/MM/yyyy').format(transaction!.date);
    }
  }

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormState>();

  void showWalletSelect() async {
    if (widget.wallets.isNotEmpty && widget.transaction == null) {
      final selectedItem = await FlutterNativeSelect.openSelect(
        title: 'Selecione uma carteira',
        doneText: 'Pronto!',
        clearText: 'Cancelar',
        items: widget.wallets
            .map(
              (e) => NativeSelectItem(
                value: e.name,
                label: e.name,
              ),
            )
            .toList(),
      );

      if (selectedItem != null) {
        setState(() {
          widget.selectedWallet = widget.wallets
              .firstWhere((element) => element.name == selectedItem);
          widget.walletController.text = selectedItem;
        });
      }
    }
  }

  void showBudgetSelect() async {
    if (widget.budgets.isNotEmpty && widget.transaction == null) {
      final selectedItem = await FlutterNativeSelect.openSelect(
        title: 'Selecione uma orçamento',
      doneText: 'Pronto!',
        clearText: 'Cancelar',
        items: widget.budgets
            .map(
              (e) => NativeSelectItem(
                value: e.name,
                label: e.name,
              ),
            )
            .toList(),
      );

      if (selectedItem != null) {
        setState(() {
          widget.selectedBudget = widget.budgets
              .firstWhere((element) => element.name == selectedItem);
          widget.budgetController.text = selectedItem;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      (widget.transaction != null ? 'Atualizar' : 'Nova') +
                          ' transação',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 5,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.xmark,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome da transação',
                    style: TextStyle(
                      color: AppTheme.colors.medium,
                    ),
                  ),
                  TextFormField(
                    controller: widget.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Valor da transação',
                    style: TextStyle(
                      color: AppTheme.colors.medium,
                    ),
                  ),
                  TextFormField(
                    controller: widget.valueController,
                    readOnly: widget.transaction != null,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Valor é obrigatório';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Valor inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tipo da transação',
                    style: TextStyle(
                      color: AppTheme.colors.medium,
                    ),
                  ),
                  DropdownButtonFormField(
                    value: widget.selectedType,
                    items: widget.transactionTypes
                        .map<DropdownMenuItem>(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (dynamic value) {
                      if (value != null) {
                        setState(() {
                          widget.selectedType = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Carteira',
                    style: TextStyle(
                      color: AppTheme.colors.medium,
                    ),
                  ),
                  TextFormField(
                    onTap: () => showWalletSelect(),
                    readOnly: true,
                    controller: widget.walletController,
                    validator: (dynamic value) {
                      if (value == null) {
                        return 'Carteira é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Data da transação',
                    style: TextStyle(
                      color: AppTheme.colors.medium,
                    ),
                  ),
                  TextFormField(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);

                        setState(() {
                          widget.dateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                    controller: widget.dateController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data é obrigatório';
                      }
                      try {
                        DateFormat('dd/MM/yyyy').parse(value);
                      } catch (e) {
                        return 'Data é inválida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Orçamento',
                    style: TextStyle(
                      color: AppTheme.colors.medium,
                    ),
                  ),
                  TextFormField(
                    onTap: () => showBudgetSelect(),
                    readOnly: true,
                    controller: widget.budgetController,
                    validator: (dynamic value) {
                      if (value == null) {
                        return 'Carteira é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Visibility(
                        visible: widget.transaction == null,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Get.back(
                                    result: TransactionModel(
                                      name: widget.nameController.text,
                                      total: double.parse(
                                          widget.valueController.text),
                                      date: DateFormat('dd/MM/yyyy')
                                          .parse(widget.dateController.text),
                                      budget: widget.selectedBudget!,
                                      wallet: widget.selectedWallet!,
                                      transactionType: widget.selectedType,
                                      budgetId: widget.selectedBudget?.id,
                                      walletId: widget.selectedWallet?.id,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.colors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 40,
                                width: MediaQuery.of(context).size.width - 40,
                                child: const Center(
                                  child: Text(
                                    'SALVAR',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.transaction != null,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back(
                                  result: 'excluir',
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.colors.danger),
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 25,
                                child: const Center(
                                  child: Text(
                                    'EXCLUIR',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back(
                                  result: TransactionModel(
                                    name: widget.nameController.text,
                                    total: double.parse(
                                        widget.valueController.text),
                                    date: DateFormat('dd/MM/yyyy')
                                        .parse(widget.dateController.text),
                                    budget: widget.selectedBudget!,
                                    wallet: widget.selectedWallet!,
                                    transactionType: widget.selectedType,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.colors.primary),
                                height: 40,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 25,
                                child: const Center(
                                  child: Text(
                                    'ATUALIZAR',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
