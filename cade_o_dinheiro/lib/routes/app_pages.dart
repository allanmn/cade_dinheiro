import 'package:cade_o_dinheiro/bindings/budgets_binding.dart';
import 'package:cade_o_dinheiro/bindings/login_binding.dart';
import 'package:cade_o_dinheiro/bindings/register_binding.dart';
import 'package:cade_o_dinheiro/bindings/settings_binding.dart';
import 'package:cade_o_dinheiro/bindings/tabs_binding.dart';
import 'package:cade_o_dinheiro/bindings/transactions_binding.dart';
import 'package:cade_o_dinheiro/bindings/wallets_binding.dart';
import 'package:cade_o_dinheiro/pages/budgets_page.dart';
import 'package:cade_o_dinheiro/pages/login_page.dart';
import 'package:cade_o_dinheiro/pages/register_page.dart';
import 'package:cade_o_dinheiro/pages/settings_page.dart';
import 'package:cade_o_dinheiro/pages/tabs_page.dart';
import 'package:cade_o_dinheiro/pages/transactions_page.dart';
import 'package:cade_o_dinheiro/pages/wallets_page.dart';
import 'package:cade_o_dinheiro/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => TabsPage(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: Routes.WALLETS,
      page: () => WalletsPage(),
      binding: WalletsBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTIONS,
      page: () => TransactionsPage(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: Routes.BUDGETS,
      page: () => BudgetsPage(),
      binding: BudgetsBinding(),
    ),
  ];
}
