import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../consts/messages.dart';

class AppBarView extends GetView implements PreferredSizeWidget {
  const AppBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: const Text(Messages.appBarTitle),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size(1.sw, 0.1.sh);
}
