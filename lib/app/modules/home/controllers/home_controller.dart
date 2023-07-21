import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/concrete/duty.dart';
import '../../../repositories/abstract/i_duty_repository.dart';
import 'duty_type_controller.dart';

class HomeController extends GetxController {
  final dutyList = RxList<Duty>();
  final _currentTodoText = RxnString();
  final _completedTodosCount = RxInt(0);

  late IDutyRepository dutyRepository;
  late DutyTypeController dutyTypeController;
  final formKey = GlobalKey<FormState>(debugLabel: 'DutyFormKey');
  late TextEditingController textAddController;
  late TextEditingController textEditController;

  @override
  Future<void> onInit() async {
    super.onInit();

    setupDependencies();
    initTextControllers();
    await loadDutyList();
    checkCompletedDuties();
  }

  @override
  void onClose() {
    disposeTextControllers();

    super.onClose();
  }

  ///region GetterAndSetter

  ///region CurrentTodoText
  String? get currentTodoText => _currentTodoText.value;

  set currentTodoText(String? value) => _currentTodoText.value = value;

  ///endregion CurrentTodoText

  ///region UnCompletedTodosCount

  int get completedTodosCount => _completedTodosCount.value;

  set completedTodosCount(int value) => _completedTodosCount.value = value;

  ///endregion UnCompletedTodosCount

  ///endregion GetterAndSetter

  ///region ValidatorMethods

  ///region TodoValidator
  String? todoValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Görev adı boş bırakılamaz!';
    }
    if (value != null && value.length <= 2) {
      return 'Görev adı 3 karakterden az olamaz!';
    }
    if (dutyTypeController.currentDutyType == null) {
      return 'Lütfen görev türü seçin!';
    }

    return null;
  }

  ///endregion TodoValidator

  ///endregion ValidatorMethods

  ///region SaveMethods

  void currentTodoOnSaved(String? value) {
    currentTodoText = value;
  }

  ///endregion SaveMethods

  ///region EventMethods

  ///region LoadDutyList
  Future<void> loadDutyList() async {
    final resultDutyType = await dutyRepository.getAll();

    if (resultDutyType.success) {
      dutyList.clear();
      dutyList.addAll(resultDutyType.data!);
      dutyList.refresh();
    }
  }

  ///endregion LoadDutyList

  ///region CheckCompletedDuties
  void checkCompletedDuties() {
    completedTodosCount = 0;

    for (Duty duty in dutyList) {
      if (duty.done) {
        completedTodosCount++;
      }
    }
  }

  ///endregion CheckCompletedDuties

  ///region LoadCompletedList
  Future<void> loadCompletedList() async {
    await loadDutyList();
    final completedList = <Duty>[];

    for (Duty duty in dutyList) {
      if (duty.done) {
        completedList.add(duty);
      }
    }

    dutyList.clear();
    dutyList.addAll(completedList);
  }

  ///endregion LoadCompletedList

  ///region LoadUnCompletedList
  Future<void> loadUnCompletedList() async {
    await loadDutyList();
    final unCompletedList = <Duty>[];

    for (Duty duty in dutyList) {
      if (!duty.done) {
        unCompletedList.add(duty);
      }
    }

    dutyList.clear();
    dutyList.addAll(unCompletedList);
  }

  ///endregion LoadUnCompletedList

  ///region ChangeIsComplete
  Future<void> changeDutyComplete(Duty currentDuty, bool? value) async {
    if (value != null) {
      currentDuty.done = value;

      await dutyRepository.update(currentDuty);
      await loadDutyList();
      checkCompletedDuties();
    }
  }

  ///endregion ChangeIsComplete

  ///region UpdateDuty
  void updateDuty({required String value, required Duty currentDuty}) {
    currentDuty.title = value;
    dutyList.refresh();
  }

  ///endregion UpdateDuty

  ///region AddDuty
  Future<void> addDuty() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Duty newDuty = Duty(
        title: currentTodoText!,
        done: false,
        typeId: dutyTypeController.currentDutyType!.id!,
      );

      final resultAddDuty = await dutyRepository.add(newDuty);

      if (resultAddDuty.success) {
        FocusScope.of(Get.context!).unfocus();
        textAddController.clear();

        await loadDutyList();
        checkCompletedDuties();
      }
    }
  }

  ///endregion AddDuty

  ///region RemoveDuty
  Future<void> removeDuty({required Duty currentDuty}) async {
    await dutyRepository.delete(currentDuty);
    await loadDutyList();
    checkCompletedDuties();
  }

  ///endregion RemoveDuty

  ///region ClearDutyController
  void clearDutyController() {
    textAddController.clear();
  }

  ///endregion ClearDutyController

  ///endregion EventMethods

  ///region GeneralPurposeMethods

  ///region SetupDependencies
  void setupDependencies() {
    dutyRepository = Get.find();
    dutyTypeController = Get.find();
  }

  ///endregion SetupDependencies

  ///region InitTextControllers
  void initTextControllers() {
    textAddController = TextEditingController();
    textEditController = TextEditingController();
  }

  ///endregion InitTextControllers

  ///region DisposeTextControllers
  void disposeTextControllers() {
    textAddController.dispose();
    textEditController.dispose();
  }

  ///endregion DisposeTextControllers

  ///endregion GeneralPurposeMethods
}
