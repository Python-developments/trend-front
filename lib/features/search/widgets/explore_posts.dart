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
            height: 5.h,
          ),
          GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1.w, // Horizontal spacing
                mainAxisSpacing: 1.h, // Vertical spacing
                childAspectRatio: 1,
              ),
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                return Container(
                  child: CustomCachedImageWidget(
                    imageUrl:
                        "https://images.unsplash.com/photo-1485395037613-e83d5c1f5290?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
