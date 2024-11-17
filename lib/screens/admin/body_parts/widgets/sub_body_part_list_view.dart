import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/network_image_with_loader.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/models/sub_body_part_model.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/sub_body_parts/sub_body_part_details_scrren.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class SubBodyPartListView extends StatefulWidget {
  final String id;
  const SubBodyPartListView({super.key, required this.id});

  @override
  State<SubBodyPartListView> createState() => _SubBodyPartListViewState();
}

class _SubBodyPartListViewState extends State<SubBodyPartListView> {
  BodyPartsController controller = Get.find<BodyPartsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getSubList(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? SizedBox()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.subList.length,
              itemBuilder: (context, index) {
                SubBodyPartModel model = controller.subList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => SubBodyPartDetailsScrren(
                                bodyPartModel: model,
                              ));
                        },
                        leading: SizedBox(
                          height: 150,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NetworkImageWithLoader(
                              imageUrl: model.img ?? '',
                              placeholderImage:
                                  Image.asset(AppImage.imgPlaceHolder),
                            ),
                          ),
                        ),
                        title: Wrap(
                          children: [
                            Text(
                              model.title ?? '',
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
    );
  }
}
