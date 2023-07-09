import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class TooltipView extends GetView<HomeController> {
  const TooltipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0.sp),
          child: Tooltip(
            message: 'Tamamlanmayan Görevler',
            child: Obx(() =>
                Text(controller.completedTodosCount == 0 ? 'Hiçbir görev tamamlanmadı.' : '${controller.completedTodosCount} görev tamamlandı.')),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.sp),
                child: Tooltip(
                  message: 'Tüm Görevler',
                  child: TextButton(onPressed: () async => await controller.loadDutyList(), child: Text('AllTodos', style: Theme.of(context).textTheme.bodySmall)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 2.0.sp),
                child: Tooltip(
                  message: 'Tamamlanmamış Görevler',
                  child: TextButton(onPressed: () async => await controller.loadUnCompletedList(), child: Text('Active', style: Theme.of(context).textTheme.bodySmall)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.sp),
                child: Tooltip(
                  message: 'Tamamlanmış Görevler',
                  child:
                      TextButton(onPressed: () async => await controller.loadCompletedList(), child: Text('Completed', style: Theme.of(context).textTheme.bodySmall)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
