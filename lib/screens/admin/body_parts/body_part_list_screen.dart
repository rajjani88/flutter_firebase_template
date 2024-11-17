import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/network_image_with_loader.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/models/body_part_model.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/add_body_part.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/body_part_details_scrren.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class BodyPartListScreen extends StatefulWidget {
  const BodyPartListScreen({super.key});

  @override
  State<BodyPartListScreen> createState() => _BodyPartListState();
}

class _BodyPartListState extends State<BodyPartListScreen> {
  BodyPartsController bodyPartsController = Get.find<BodyPartsController>();

  @override
  void initState() {
    super.initState();
    bodyPartsController.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Body Parts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddBodyPart());
        },
        child: Icon(Icons.add),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: bodyPartsController.mainList.length,
          itemBuilder: (context, index) {
            BodyPartModel bodyPartModel = bodyPartsController.mainList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => BodyPartDetailsScrren(
                            bodyPartModel: bodyPartModel,
                          ));
                    },
                    leading: SizedBox(
                      height: 150,
                      width: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NetworkImageWithLoader(
                          imageUrl: bodyPartModel.img ?? '',
                          placeholderImage:
                              Image.asset(AppImage.imgPlaceHolder),
                        ),
                      ),
                    ),
                    title: Wrap(
                      children: [
                        Text(
                          bodyPartModel.title ?? '',
                          style: AppStyles.textStyle(),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
