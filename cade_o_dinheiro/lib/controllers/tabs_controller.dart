import 'package:get/get.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}