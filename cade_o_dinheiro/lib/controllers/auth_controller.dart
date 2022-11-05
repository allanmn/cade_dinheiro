import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // email, passoword, name
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  get userEmail {
    if (_user.value != null) {
      return _user.value?.email;
    }
  }

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print('login page');
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/');
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Helpers.toast(
        title: 'Erro',
        message: 'E-mail ou senha incorretos.',
        backgroundColor: AppTheme.colors.danger,
      );
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Helpers.toast(
        title: 'Erro',
        message: 'Erro ao logar usuário.',
        backgroundColor: AppTheme.colors.danger,
      );
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
