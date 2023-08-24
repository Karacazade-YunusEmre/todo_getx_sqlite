import 'package:get/get.dart';

import '../../../repositories/abstract/i_duty_repository.dart';
import '../../../repositories/abstract/i_duty_type_repository.dart';
import '../../../repositories/concrete/duty_repository.dart';
import '../../../repositories/concrete/duty_type_repository.dart';
import '../../../repositories/concrete/helper/repository_helper.dart';

class Resolver extends GetxService {
  @override
  void onInit() {
    super.onInit();

    Get.lazyPut<RepositoryHelper>(() => RepositoryHelper());
    Get.lazyPut<IDutyRepository>(() => DutyRepository());
    Get.lazyPut<IDutyTypeRepository>(() => DutyTypeRepository());
  }
}
