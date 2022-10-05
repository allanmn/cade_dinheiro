import 'package:cade_o_dinheiro/models/budget_model.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreateBudget extends StatefulWidget {
  BudgetModel? budget;
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final goalController = <String>['Alimentação', 'Despesas', 'Estudos', 'Lazer', 'Saúde','Transporte', 'Viagens'];
  String? selectedGoal;

  CreateBudget({
    Key? key,
    this.budget,
  }) {
    if (budget != null) {
      nameController.text = budget!.name;
      valueController.text = budget!.total.toString();
      //goalController. = budget!.goal;
    }
  }

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
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
                    (widget.budget != null ? 'Atualizar' : 'Criar') +
                        ' orçamento',
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
                  'Valor do Orçamento',
                  style: TextStyle(
                    color: AppTheme.colors.medium,
                  ),
                ),
                TextFormField(
                  controller: widget.valueController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Valor do Orçamento é obrigatório';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Valor do Orçamento inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Finalidade do Orçamento',
                  style: TextStyle(
                    color: AppTheme.colors.medium,
                  ),
                ),
                DropdownButtonFormField(
                  validator: (dynamic value) {
                    if(value == null) {
                      return 'Finalidade Obrigatória';
                    }
                    return null;
                  },
                  items: widget.goalController.map<DropdownMenuItem>((e) => DropdownMenuItem(child: Text(e),
                  value: e,)).toList(), 
                  onChanged: (dynamic value) {
                    widget.selectedGoal = value;
                }),
                
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: widget.budget == null,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Get.back(
                                  result: BudgetModel(
                                    name: widget.nameController.text,
                                    total: double.parse(
                                        widget.valueController.text), 
                                    goal: '',
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
                      visible: widget.budget != null,
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
                                result: BudgetModel(
                                  name: widget.nameController.text,
                                  total:
                                      double.parse(widget.valueController.text),
                                  goal: widget.selectedGoal!,
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
