import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/search/controllers/explore_controller.dart';
import 'package:trend/utils/colors.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrendingPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<ExploreController>(builder: (controller) {
      List<String> tags = controller.posts.expand((e) => e.tags).toList();
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TRENDING TAGS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(AppColors.greyExtraDark),
                      fontSize: 11.sp),
                ),
                Row(
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 11.5.sp),
                    ),
                    SvgPicture.asset(
                      'assets/icons/arrow-right.svg',
                      height: 15.sp,
                      // width: 15.sp,
                      color: Color(AppColors.greyExtraDark),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.find<ExploreController>().tag = tags[index];
                          Get.find<ExploreController>()
                              .pageController
                              .animateToPage(1,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.linear);
                        },
                        child: Container(
                          height: 120,
                          width: 120,
                          color: Colors.grey.withOpacity(0.4),
                          margin: EdgeInsets.all(5),
                          child: CustomCachedImageWidget(
                            size: 200,
                            radius: 0,
                            imageUrl:
                                "https://images.unsplash.com/photo-1480563597043-1c877e682fc7?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        child: Text("#${tags[index]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      )
                    ],
                  );
                }),
          ),
        ],
      );
    });
  }
}
