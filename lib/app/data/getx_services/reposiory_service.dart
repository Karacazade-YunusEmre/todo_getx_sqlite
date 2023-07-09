import 'package:get/get.dart';

import '../../repository/abstract/i_duty_repository.dart';
import '../../repository/abstract/i_duty_type_repository.dart';
import '../../repository/concrete/duty_repository.dart';
import '../../repository/concrete/duty_type_repository.dart';
import '../../repository/concrete/helper/repository_helper.dart';

class RepositoryService extends GetxService {
  @override
  void onInit() {
    super.onInit();

    Get.lazyPut<IDutyRepository>(() => DutyRepository());
    Get.lazyPut<IDutyTypeRepository>(() => DutyTypeRepository());
    Get.lazyPut<RepositoryHelper>(() => RepositoryHelper());
  }
}
