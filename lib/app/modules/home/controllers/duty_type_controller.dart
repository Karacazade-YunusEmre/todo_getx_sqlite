import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/concrete/duty_type.dart';
import '../../../repositories/abstract/i_duty_type_repository.dart';



class DutyTypeController extends GetxController {
  final dutyTypeList = RxList<DutyType>();
  final _currentDutyType = Rxn<DutyType>();

  final formKeyDutyAdd = GlobalKey<FormState>();
  late TextEditingController textControllerDuty;
  DutyType? newDutyType;

  late IDutyTypeRepository _dutyTypeRepository;

  @override
  Future<void> onInit() async {
    super.onInit();

    setupDependencies();
    await loadDutyTypeList();
    setupTextControllers();
  }

  @override
  void onClose() {
    disposeTextControllers();

    super.onClose();
  }

  ///region GetterAndSetter

  ///region CurrentDutyType
  DutyType? get currentDutyType => _currentDutyType.value;

  set currentDutyType(DutyType? value) => _currentDutyType.value = value;

  ///endregion CurrentDutyType

  ///endregion GetterAndSetter

  ///region ValidatorMethods
  String? addDutyTypeValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Görev Türü boş olamaz!';
    } else if (value != null && value.length < 3) {
      return 'Görev Türü 3 karakterden az olamaz!';
    }
    return null;
  }

  ///endregion ValidatorMethods

  ///region OnSavedMethods
  void addDutyTypeOnSaved(String? value) {
    if (value != null) {
      newDutyType = DutyType(name: value);
    }
  }

  ///endregion OnSavedMethods

  ///region EventMethods

  ///region SetupDependencies
  void setupDependencies() {
    _dutyTypeRepository = Get.find();
  }

  ///endregion SetupDependencies

  ///region LoadDutyTypeList
  Future<void> loadDutyTypeList() async {
    final dutyTypes = await _dutyTypeRepository.getAll();

    if (dutyTypes.success) {
      dutyTypeList.clear();
      dutyTypeList.addAll(dutyTypes.data!);
      dutyTypeList.refresh();
    }
  }

  ///endregion LoadDutyTypeList

  ///region ChangeDutyTypeItem
  void changeDutyTypeItem(DutyType? item) {
    currentDutyType = item;
    _currentDutyType.refresh();
  }

  ///endregion ChangeDutyTypeItem

  ///region AddDutyType
  Future<void> addDutyType() async {
    if (formKeyDutyAdd.currentState!.validate()) {
      formKeyDutyAdd.currentState!.save();

      await _dutyTypeRepository.add(newDutyType!);
    }
    await loadDutyTypeList();
    currentDutyType = null;
    textControllerDuty.clear();
    Get.back();
  }

  ///endregion AddDutyType

  ///region RemoveDutyType
  Future<void> removeDutyType({required DutyType dutyType}) async {
    final resultDelete = await _dutyTypeRepository.delete(dutyType);

    if (resultDelete.success) {
      await loadDutyTypeList();
      currentDutyType = null;
    }
  }

  ///endregion RemoveDutyType

  ///endregion EventMethods

  ///region GeneralPurposeMethods

  ///region SetupTextControllers
  void setupTextControllers() {
    textControllerDuty = TextEditingController();
  }

  ///endregion SetupTextControllers

  ///region DisposeTextControllers
  void disposeTextControllers() {
    textControllerDuty.dispose();
  }

  ///endregion DisposeTextControllers

  ///region AddDutyTypeDialog
  void addDutyTypeDialog() {
    Widget content = Form(
      key: formKeyDutyAdd,
      child: TextFormField(
        controller: textControllerDuty,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
        ),
        autofocus: true,
        validator: addDutyTypeValidator,
        onSaved: addDutyTypeOnSaved,
      ),
    );
    List<Widget> actions = [
      SizedBox(
        width: 0.15.sw,
        child: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          child: Text('Vazgeç', style: Theme.of(Get.context!).textTheme.bodyMedium),
        ),
      ),
      SizedBox(
        width: 0.15.sw,
        child: ElevatedButton(
          onPressed: () async => await addDutyType(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          child: Text('Oluştur', style: Theme.of(Get.context!).textTheme.bodyMedium),
        ),
      ),
    ];

    Get.defaultDialog(
      title: 'Görev Türü Tanımla',
      titleStyle: Theme.of(Get.context!).textTheme.labelLarge,
      content: content,
      actions: actions,
      barrierDismissible: false,
    );
  }

  ///endregion AddDutyTypeDialog

  ///endregion GeneralPurposeMethods
}
