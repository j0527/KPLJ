import 'package:get/get.dart';

class IndicatorCurrent extends GetxController{
  RxInt current = 0.obs;

  setCurrent(int value) {
    current.value = value;
    update();
  }

}