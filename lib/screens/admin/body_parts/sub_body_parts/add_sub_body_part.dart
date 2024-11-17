import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/empty_space.dart';
import 'package:flutter_body_parts/commons/image_selection_bottomsheet.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/commons/my_snack_msg.dart';
import 'package:flutter_body_parts/commons/my_text_area.dart';
import 'package:flutter_body_parts/commons/my_text_fields.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/models/body_part_model.dart';
import 'package:flutter_body_parts/models/sub_body_part_model.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:flutter_body_parts/utils/my_image_picker.dart';
import 'package:get/get.dart';

class AddSubBodyPart extends StatefulWidget {
  final BodyPartModel bodyPartModel;
  final SubBodyPartModel? subBodyPartModel;

  const AddSubBodyPart(
      {super.key, required this.bodyPartModel, this.subBodyPartModel});

  @override
  State<AddSubBodyPart> createState() => _AddSubBodyPartState();
}

class _AddSubBodyPartState extends State<AddSubBodyPart> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleCont = TextEditingController();
  TextEditingController desCont = TextEditingController();

  //XFile? selectedImage;
  ImgPicker imgPicker = ImgPicker();

  BodyPartsController bodyPartsController = Get.find<BodyPartsController>();

  String imgUrl = '';

  @override
  void initState() {
    super.initState();
    if (widget.subBodyPartModel != null) {
      setData(widget.subBodyPartModel!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleCont.dispose();
    desCont.dispose();
    bodyPartsController.selectedImg.value = null;
  }

  void setData(SubBodyPartModel b) {
    titleCont.text = b.title ?? '';
    desCont.text = b.description ?? '';
    imgUrl = b.img ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
            widget.subBodyPartModel == null ? 'Add Sub Body Part' : ' Update'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Upload Image',
                      style: AppStyles.textStyle14Bold(),
                    ),
                    //image Secion
                  ],
                ),
                SizedBox(
                  height: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ImageSelectionBottomSheet(
                              onGallerySelected: () {
                                imgPicker.getImageFromGallery().then((value) {
                                  bodyPartsController.setImg(value);
                                });
                                Get.back();
                              },
                              onCameraSelected: () {
                                imgPicker.getImageFromCamera().then((value) {
                                  bodyPartsController.setImg(value);
                                });
                                Get.back();
                              },
                            ),
                          );
                        },
                        child: Obx(
                          () => bodyPartsController.selectedImg.value == null
                              ? Image.asset(
                                  AppImage.addImage,
                                  height: 150,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(bodyPartsController
                                      .selectedImg.value!.path),
                                  height: 150,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticallGap(size: 20),
                Text(
                  'Fields with * is Required.',
                  style: AppStyles.textStyle(fontSize: 12, color: Colors.red),
                ),
                verticallGap(),
                MyTextFields(
                  hint: 'Enter Title',
                  lable: 'Title *',
                  controller: titleCont,
                  error: 'Title required',
                  validation: (p0) {
                    if (titleCont.text.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                verticallGap(),
                MyTextArea(
                  hint: 'Enter Description *',
                  lable: 'Description *',
                  controller: desCont,
                  error: 'Description required',
                  validation: (p0) {
                    if (desCont.text.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                verticallGap(),
                Row(
                  children: [
                    Obx(
                      () => bodyPartsController.isLoading.value
                          ? const SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: MyBtn(
                                title: widget.subBodyPartModel == null
                                    ? 'Save'
                                    : 'Update',
                                onTap: () {
                                  if (bodyPartsController.selectedImg.value ==
                                      null) {
                                    showMySnak(msg: 'Image is Required');
                                    return;
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    bodyPartsController.addSubBodyPart(
                                        widget.bodyPartModel.id ?? '',
                                        SubBodyPartModel(
                                          id: widget.subBodyPartModel != null
                                              ? widget.subBodyPartModel!.id
                                              : '0',
                                          title: titleCont.text.trim(),
                                          description: desCont.text.trim(),
                                          img: '',
                                        ));
                                  }
                                },
                                textSize: 20,
                              ),
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}