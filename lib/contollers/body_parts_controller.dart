import 'dart:developer';
import 'dart:io';

import 'package:flutter_body_parts/commons/my_snack_msg.dart';
import 'package:flutter_body_parts/models/body_part_model.dart';
import 'package:flutter_body_parts/models/sub_body_part_model.dart';
import 'package:flutter_body_parts/repository/body_part_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BodyPartsController extends GetxController {
  BodyPartRepository bodyRepo = BodyPartRepository();
  Rx<XFile?> selectedImg = Rx<XFile?>(null);

  RxBool isLoading = false.obs;

  final RxList<BodyPartModel> _mainList = <BodyPartModel>[].obs;
  RxList<BodyPartModel> get mainList => _mainList;

  final RxList<SubBodyPartModel> _subList = <SubBodyPartModel>[].obs;
  RxList<SubBodyPartModel> get subList => _subList;

  final Rx<BodyPartModel?> _selectedBodyPart = null.obs;
  Rx<BodyPartModel?> get selectedBodyPart => _selectedBodyPart;

  setImg(XFile? img) {
    selectedImg.value = img;
    refresh();
  }

  clearList() {
    _subList.value = [];
    refresh();
  }

  //create new body part
  addNewBodyPart(
    BodyPartModel bodypart, {
    bool isUpdate = false,
  }) {
    isLoading.value = true;
    String fileName = bodyRepo.getFileNameFromPath(selectedImg.value!.path);
    bodyRepo.uploadImage(File(selectedImg.value!.path), fileName).then(
      (imgUrl) {
        bodypart.img = imgUrl;
        if (isUpdate) {
          bodyRepo.updateBodyPart(bodypart).then(
            (value) {
              isLoading.value = false;
              showMySnak(msg: 'Body Part with id ${bodypart.id} is Updated');
              int pos = _mainList.value.indexWhere(
                (element) =>
                    int.parse(element.id ?? '-1') ==
                    int.parse(bodypart.id ?? ''),
              );
              _mainList[pos] = bodypart;
              _mainList.refresh();
              getList();
              Get.back();
              Get.back();
            },
          ).onError(
            (error, stackTrace) {
              isLoading.value = false;
              log('updateBodyPart : error : $error');
              showMySnak(msg: 'Something Went worng.');
            },
          );
        } else {
          // on create
          bodyRepo.addBodyPartToFirestore(bodypart).then(
            (value) {
              isLoading.value = false;
              showMySnak(msg: 'Body Part with id ${bodypart.id} is Created');
              getList();
              Get.back();
            },
          ).onError(
            (error, stackTrace) {
              isLoading.value = false;
              log('addBodyPartToFirestore : error : $error');
              showMySnak(msg: 'Something Went worng.');
            },
          ).onError(
            (error, stackTrace) {
              isLoading.value = false;
              log('uploadImage : error : $error');
              showMySnak(msg: 'Something Went worng.');
            },
          );
        }
      },
    );
  }

  //get lis tof bodyparts
  getList() {
    isLoading.value = true;
    bodyRepo.fetchBodyPartList().then(
      (bodypartList) {
        _mainList.value = bodypartList;
        isLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        log('getList :error : $error');
        isLoading.value = false;
      },
    );
  }

  //delete item from main list
  deleteBodyPart(String id) {
    bodyRepo.deleteBodyPart(id).then(
      (value) {
        _mainList.value.removeWhere(
          (element) => int.parse(element.id!) == int.parse(id),
        );
        _mainList.refresh();
        Get.back();
      },
    );
  }

  //add subbody part
  addSubBodyPart(String id, SubBodyPartModel sub, {bool isUpdate = false}) {
    isLoading.value = true;

    //without image
    if (isUpdate && selectedImg.value == null) {
      sub.parantId = id;
      bodyRepo.updateSubBodyPart(sub).then(
        (value) {
          isLoading.value = false;
          _subList.value.removeWhere(
            (element) =>
                int.parse(element.id ?? '-1') == int.parse(sub.id ?? ''),
          );
          _subList.value.add(sub);
          _subList.refresh();

          showMySnak(msg: 'Sub Body part is Updated');
          Get.back();
          Get.back();
        },
      ).onError(
        (error, stackTrace) {
          log('updateSubBodyPart :error : $error');
          isLoading.value = false;
        },
      );
      return;
    }
    //upload image
    bodyRepo
        .uploadImage(File(selectedImg.value!.path), selectedImg.value!.name)
        .then(
      (imgUrl) {
        sub.img = imgUrl;
        sub.parantId = id;

        if (isUpdate) {
          bodyRepo.updateSubBodyPart(sub).then(
            (value) {
              isLoading.value = false;
              _subList.removeWhere(
                (element) =>
                    int.parse(element.id ?? '-1') == int.parse(sub.id ?? ''),
              );
              _subList.add(sub);
              _subList.refresh();
              showMySnak(msg: 'Sub Body part is Updated');
              Get.back();
            },
          ).onError(
            (error, stackTrace) {
              log('updateSubBodyPart :error : $error');
              isLoading.value = false;
            },
          );
        } else {
          bodyRepo.addSubBodyPart(sub).then(
            (value) {
              isLoading.value = false;
              _subList.add(sub);
              showMySnak(msg: 'Sub Body part is Created');
              Get.back();
            },
          ).onError(
            (error, stackTrace) {
              log('addSubBodyPart :error : $error');
              isLoading.value = false;
            },
          );
        }
      },
    ).onError(
      (error, stackTrace) {
        log('UploadImage :error : $error');
        isLoading.value = false;
      },
    );
  }

  //image_update
  onlyImageSubUpload(SubBodyPartModel sub) {
    bodyRepo
        .uploadImage(File(selectedImg.value!.path), selectedImg.value!.name)
        .then(
      (imgUrl) {
        sub.img = imgUrl;
        bodyRepo.updateSubBodyPart(sub);
      },
    );
  }

  setSelectedbodyPart(BodyPartModel b) {
    _selectedBodyPart.value = b;
  }

  //get sublist
  getSubList(String parantID) {
    if (!isLoading.value) {
      isLoading.value = true;
    }
    bodyRepo.fetchSubBodyPartsByParentId(parantID).then(
      (bodypartList) {
        _subList.value = bodypartList;
        isLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        log('getSubList :error : $error');
        isLoading.value = false;
      },
    );
  }

  getSubListUser(String parantID) {
    bodyRepo.fetchSubBodyPartsByParentId(parantID).then(
      (bodypartList) {
        _subList.value = bodypartList;
      },
    ).onError(
      (error, stackTrace) {
        log('getSubList :error : $error');
      },
    );
  }

  deleteSubBodyPart(String id) {
    bodyRepo.deleteSubBodyPart(id).then(
      (value) {
        _subList.value.removeWhere(
          (element) => int.parse(element.id!) == int.parse(id),
        );
        _subList.refresh();
        Get.back();
      },
    );
  }
}
