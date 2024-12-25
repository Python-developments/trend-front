import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/features/search/controllers/explore_controller.dart';
import 'package:trend/features/search/widgets/explore_posts.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class TrendingTabs extends StatelessWidget {
  TrendingTabs();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GetBuilder<ExploreController>(builder: (controller) {
      List<PostModel> posts = controller.posts
          .where((e) => e.tags.contains(controller.tag))
          .toList();
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.find<ExploreController>()
                            .pageController
                            .animateToPage(0,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.linear);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    "#${controller.tag}",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                        fontSize: 14.sp),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                    color: Colors.transparent,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "TOP POSTS",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: Get.width / 3,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(1),
                        width: Get.width / 3,
                        height: Get.width / 3,
                        child: CustomCachedImageWidget(
                          radius: 0,
                          size: 20,
                          imageUrl:
                              "https://images.unsplash.com/photo-1657585134240-9a0fadbcb351?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              ExplorePosts(
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("MOST RECENT",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.grey)),
                      Text(
                        "829,202 posts",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
