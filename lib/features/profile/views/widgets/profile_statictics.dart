import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/features/profile/views/pages/follow_tap/follow_tap.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class ProfileStateictics extends StatelessWidget {
  int? userId;
  ProfileStateictics([this.userId]);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        children: [
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      (controller.profileModel?.totalPosts ?? 0).toString(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Posts',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(FollowTabs(
                      name: controller.profileModel?.username ?? '',
                      tabIndex: 0,
                      fromMe: userId ==
                          Get.find<SpHelper>().getUser()?.userInfo?.id,
                    ));
                  },
                  child: Column(
                    children: [
                      Text(
                        (controller.profileModel?.followers ?? 0).toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(FollowTabs(
                      name: controller.profileModel?.username ?? '',
                      tabIndex: 1,
                      fromMe: userId ==
                          Get.find<SpHelper>().getUser()?.userInfo?.id,
                    ));
                  },
                  child: Column(
                    children: [
                      Text(
                        (controller.profileModel?.following ?? 0).toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      (controller.profileModel?.likesCounts ?? 0).toString(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Likes',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 7.h)
        ],
      );
    });
  }
}
