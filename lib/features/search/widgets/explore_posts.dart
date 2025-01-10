import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/search/controllers/explore_controller.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class ExplorePosts extends StatelessWidget {
  Widget title;
  ExplorePosts(this.title);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<ExploreController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          SizedBox(
            height: 10.h,
          ),
          GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.w, // Horizontal spacing
                mainAxisSpacing: 5.h, // Vertical spacing
                childAspectRatio: 1,
              ),
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                return Container(
                  child: CustomCachedImageWidget(
                    imageUrl: controller.posts[index].image,
                    size: 20,
                    radius: 0,
                  ),
                );
              }),
        ],
      );
    });
  }
}
