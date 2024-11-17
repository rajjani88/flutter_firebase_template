import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/empty_space.dart';
import 'package:flutter_body_parts/commons/network_image_with_loader.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/models/body_part_model.dart';
import 'package:flutter_body_parts/screens/user/home/widgets/user_sub_body_part_list_view.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class UserBodyPartDetailsScrren extends StatefulWidget {
  final BodyPartModel bodyPartModel;
  const UserBodyPartDetailsScrren({super.key, required this.bodyPartModel});

  @override
  State<UserBodyPartDetailsScrren> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserBodyPartDetailsScrren> {
  BodyPartsController bodyPartsController = Get.find<BodyPartsController>();

  @override
  void initState() {
    super.initState();
    bodyPartsController.getSubListUser(widget.bodyPartModel.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
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
          const Divider(),
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
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.bodyPartModel.description ?? '',
                      style: AppStyles.textStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
          UserSubBodyPartListView(),
          verticallGap(),
        ],
      )),
    );
  }
}
