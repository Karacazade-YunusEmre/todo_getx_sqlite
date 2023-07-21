import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../models/concrete/duty_type.dart';
import '../controllers/duty_type_controller.dart';

class DutyTypeView extends GetView<DutyTypeController> {
  const DutyTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 0.1.sh,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 0.4.sw,
              height: 0.06.sh,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: DropdownButtonHideUnderline(
                child: Obx(() => DropdownButton<DutyType>(
                      items: getDutyTypeItems,
                      onChanged: controller.changeDutyTypeItem,
                      value: controller.currentDutyType,
                      hint: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Text(
                          'Görev Türü',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      alignment: Alignment.center,
                    )),
              ),
            ),
            SizedBox(
              width: 0.4.sw,
              height: 0.06.sh,
              child: ElevatedButton(
                onPressed: controller.addDutyTypeDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: Text(
                  'Görev Türü Ekle',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<DutyType>> get getDutyTypeItems {
    final items = <DropdownMenuItem<DutyType>>[];

    for (DutyType dutyType in controller.dutyTypeList) {
      DropdownMenuItem<DutyType> item = DropdownMenuItem<DutyType>(
        value: dutyType,
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) async => await controller.removeDutyType(dutyType: dutyType),
          direction: DismissDirection.startToEnd,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dutyType.name,
                  style: Theme.of(Get.context!).textTheme.bodyMedium,
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.red),
              ],
            ),
          ),
        ),
      );

      items.add(item);
    }

    return items;
  }
}
