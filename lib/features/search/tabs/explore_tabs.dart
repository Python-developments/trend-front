import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:trend/features/search/controllers/explore_controller.dart';
import 'package:trend/features/search/widgets/explore_posts.dart';
import 'package:trend/features/search/widgets/trending_tags.dart';

class ExploreTagsTab extends StatelessWidget {
  const ExploreTagsTab();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<ExploreController>(
        init: ExploreController(),
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 45.h), // Add padding for the status bar
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 33.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                            fit: BoxFit.contain,
                            height: 10,
                            width: 10,
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.find<ExploreController>()
                              .pageController
                              .animateToPage(2,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.linear);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 0.w),
                          height: 170.h,
                          width: double
                              .infinity, // Ensures the image takes the full width of the screen
                          child: Image.asset(
                            'assets/images/football.jpg',
                            fit: BoxFit
                                .cover, // Ensures the image covers the entire container
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 150,
                          child: TrendingPosts()),
                      Divider(
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      ExplorePosts(
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "EXPLORE POSTS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 13.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
