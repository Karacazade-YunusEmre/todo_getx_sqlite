import 'package:get/get.dart';

import '../controllers/duty_type_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DutyTypeController>(() => DutyTypeController());
  }
}
