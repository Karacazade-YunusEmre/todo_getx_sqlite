import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme{
  AppTheme._();

  static ThemeData get getAppTheme{
    return ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.amber, fontSize: 32.sp),
        elevation: 0,
      ),
      checkboxTheme: const CheckboxThemeData(
        checkColor: MaterialStatePropertyAll(Colors.amber),
        fillColor: MaterialStatePropertyAll(Colors.black),
      ),
    );
  }
}