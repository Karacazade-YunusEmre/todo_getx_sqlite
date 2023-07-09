import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/data/getx_services/reposiory_service.dart';
import 'app/routes/app_pages.dart';

void main() {
  startServices();
  runApp(getMaterialApp());
}

void startServices(){
  Get.put<RepositoryService>(RepositoryService());
}

Widget getMaterialApp() {
  return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "ToDo App with Getx and Sqlite",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      });
}
