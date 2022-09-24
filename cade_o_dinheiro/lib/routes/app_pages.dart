import 'package:cade_o_dinheiro/bindings/tabs_binding.dart';
import 'package:cade_o_dinheiro/bindings/wallets_binding.dart';
import 'package:cade_o_dinheiro/pages/tabs_page.dart';
import 'package:cade_o_dinheiro/pages/wallets_page.dart';
import 'package:cade_o_dinheiro/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
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
  ];
}
