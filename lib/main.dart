import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/data/dependency_resolves/Getx/getx_dependency_management.dart';
import 'app/data/themes/app_theme.dart';
import 'app/routes/app_pages.dart';

void main() {
  initDependencyManagement();
  runApp(getMaterialApp());
}

void initDependencyManagement() {
  Get.put<GetXDependencyManagement>(GetXDependencyManagement());
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
        theme: AppTheme.getAppTheme,
      );
    },
  );
}
