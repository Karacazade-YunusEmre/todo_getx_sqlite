import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/components/views/appbar_view.dart';
import '../../../data/consts/messages.dart';
import 'duty_type_view.dart';
import '../controllers/home_controller.dart';
import 'tooltip_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarView(),
      body: ListView(
        children: [
          ///region AddTodoForm
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Form(
              key: controller.formKey,
              child: TextFormField(
                controller: controller.textAddController,
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    borderSide: const BorderSide(color: Colors.amber),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    borderSide: const BorderSide(color: Colors.amber),
                  ),
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                  labelText: Messages.textToDoSHintText,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, size: 14.sp),
                    onPressed: controller.clearDutyController,
                  ),
                ),
                validator: controller.todoValidator,
                onSaved: controller.currentTodoOnSaved,
                onEditingComplete: () async => await controller.addDuty(),
              ),
            ),
          ),

          ///endregion AddTodoForm

          ///region DutyTypeRow
          const DutyTypeView(),

          ///endregion DutyTypeRow

          ///region CompleteToolTips
          const TooltipView(),

          ///endregion CompleteToolTips

          ///region TodoList
          SizedBox(
            width: 0.9.sw,
            height: 0.6.sh,
            child: Obx(() => ListView.builder(
                itemCount: controller.dutyList.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentDuty = controller.dutyList[index];
                  final completed = currentDuty.done;

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    child: ListTile(
                      leading: Checkbox(
                        value: completed,
                        onChanged: (bool? value) async {
                          await controller.changeDutyComplete(currentDuty, value);
                        },
                      ),
                      title: EditableText(
                        controller: TextEditingController(text: currentDuty.title),
                        focusNode: FocusNode(),
                        style: Theme.of(context).textTheme.bodyLarge!,
                        cursorColor: Colors.black,
                        backgroundCursorColor: Colors.white,
                        onSubmitted: (String value) {
                          // controller.updateDuty(value: value, currentDuty: currentDuty)
                        },
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 18.sp),
                    ),
                    onDismissed: (DismissDirection direction) async {
                      // await controller.removeDuty(currentDuty: currentDuty)
                    },
                  );
                })),
          ),

          ///endregion TodoList
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
