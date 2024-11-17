import 'package:flutter/material.dart';
import 'package:flutter_body_parts/commons/network_image_with_loader.dart';
import 'package:flutter_body_parts/contollers/body_parts_controller.dart';
import 'package:flutter_body_parts/models/body_part_model.dart';
import 'package:flutter_body_parts/models/sub_body_part_model.dart';
import 'package:flutter_body_parts/screens/admin/body_parts/sub_body_parts/sub_body_part_details_scrren.dart';
import 'package:flutter_body_parts/screens/user/home/user_body_part_details_screen.dart';
import 'package:flutter_body_parts/utils/app_images.dart';
import 'package:flutter_body_parts/utils/app_styles.dart';
import 'package:get/get.dart';

class UserBodyPartListView extends StatefulWidget {
  const UserBodyPartListView({
    super.key,
  });

  @override
  State<UserBodyPartListView> createState() => _UserBodyPartListViewState();
}

class _UserBodyPartListViewState extends State<UserBodyPartListView> {
  BodyPartsController controller = Get.find<BodyPartsController>();

  @override
  void initState() {
    super.initState();
    controller.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: SizedBox(
                height: 46,
                width: 46,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.mainList.length,
              itemBuilder: (context, index) {
                BodyPartModel model = controller.mainList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => UserBodyPartDetailsScrren(
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
