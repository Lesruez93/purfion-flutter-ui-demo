import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

// Created on 11/04/2023
// By Lester Rusike
class HomeController extends GetxController {
  //TODO: Implement HomeController
  Timer? _timer;

  final count = 0.obs;
  RxString timerNumber = '55'.obs;
  RxInt temp = 0.obs;
  RxInt humidity = 0.obs;
  RxInt filterLife = 0.obs;

  RxString room = 'Living Room'.obs;

  @override
  void onInit() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // Run your code here at the specified interval (1 second in this case)
      int randomNumber = Random().nextInt(99) + 1;
      timerNumber.value = randomNumber.toString();
      temp.value = Random().nextInt(40) + 1;
      humidity.value = Random().nextInt(40) + 1;
      filterLife.value = Random().nextInt(99) + 1;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer to stop the interval

    super.onClose();
  }

  void increment() => count.value++;
}
