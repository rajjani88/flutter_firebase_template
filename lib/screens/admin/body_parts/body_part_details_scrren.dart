import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/empty_space.dart';
import 'package:flutter_body_parts/commons/my_btn.dart';
import 'package:flutter_body_parts/commons/network_image_with_loader.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/models/body_part_model.dart';
import 'package:flutter_body_parts/models/sub_body_part_model.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/add_body_part.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/sub_body_parts/add_sub_body_part.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/widgets/sub_body_part_list_view.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class BodyPartDetailsScrren extends StatefulWidget {
  final BodyPartModel bodyPartModel;
  const BodyPartDetailsScrren({super.key, required this.bodyPartModel});

  @override
  State<BodyPartDetailsScrren> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BodyPartDetailsScrren> {
  BodyPartsController bodyPartsController = Get.find<BodyPartsController>();

  @override
  void dispose() {
    super.dispose();
    bodyPartsController.clearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddBodyPart(
                      bodyPartModel: widget.bodyPartModel,
                    ));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: NetworkImageWithLoader(
                    imageUrl: widget.bodyPartModel.img ?? '',
                    placeholderImage: Image.asset(AppImage.imgPlaceHolder),
                  ),
                ),
              ),
            ],
          ),
          verticallGap(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  widget.bodyPartModel.title ?? '',
                  style: AppStyles.textStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                )
              ],
            ),
          ),
          verticallGap(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.bodyPartModel.description ?? '',
                    style: AppStyles.textStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          SubBodyPartListView(
            id: widget.bodyPartModel.id ?? '',
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyBtn(
                  title: 'Add Sub Body Part Detail ',
                  onTap: () {
                    Get.to(() =>
                        AddSubBodyPart(bodyPartModel: widget.bodyPartModel));
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyBtn(
                  bgColo: Colors.red,
                  title: 'Delete',
                  onTap: () {
                    bodyPartsController
                        .deleteBodyPart(widget.bodyPartModel.id ?? '');
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
