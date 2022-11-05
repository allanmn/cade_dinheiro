import 'package:cade_o_dinheiro/models/wallet_model.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreateWallet extends StatefulWidget {
  WalletModel? wallet;
  final nameController = TextEditingController();
  final valueController = TextEditingController();

  CreateWallet({
    Key? key,
    this.wallet,
  }) {
    if (wallet != null) {
      nameController.text = wallet!.name;
      valueController.text = wallet!.total.toString();
    }
  }

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    (widget.wallet != null ? 'Atualizar' : 'Nova') +
                        ' carteira',
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
                  'Nome',
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
                  'Total da Carteira',
                  style: TextStyle(
                    color: AppTheme.colors.medium,
                  ),
                ),
                TextFormField(
                  controller: widget.valueController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Total da Carteira é obrigatório';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Total da Carteira inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: widget.wallet == null,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Get.back(
                                  result: WalletModel(
                                    name: widget.nameController.text,
                                    total: double.parse(
                                        widget.valueController.text),
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
                      visible: widget.wallet != null,
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
                              width: MediaQuery.of(context).size.width / 2 - 25,
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
                                result: WalletModel(
                                  id: widget.wallet?.id,
                                  name: widget.nameController.text,
                                  total:
                                      double.parse(widget.valueController.text),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppTheme.colors.primary),
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2 - 25,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
