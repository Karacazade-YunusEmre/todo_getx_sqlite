import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/data/dependency_resolves/Getx/getx_dependency_management.dart';
import 'app/data/themes/app_theme.dart';
import 'app/routes/app_pages.dart';

void main() {
  setupDependencies();
  runApp(const MainApp());
}

void setupDependencies() {
  Get.put<GetXDependencyManagement>(GetXDependencyManagement());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
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
}

