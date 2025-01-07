import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trend/features/add_post/add_post.dart';
import 'package:trend/features/add_post/new_post.dart';
import 'package:trend/features/bottom_nav_bar/bnb_controller.dart';
import 'package:trend/features/home/home_page.dart';
import 'package:trend/features/notifications/notifications.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/features/profile/views/pages/my_profile/my_profile.dart';
import 'package:trend/features/search/tabs/explore_main_page.dart';
import 'package:trend/features/search/tabs/explore_tabs.dart';
import 'package:trend/utils/colors.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ExploreMainPage(),
    const AddNewPostPage(),
    const Notifications(),
    const MyProfile(
      canBack: false,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (Get.find<BnbController>().delectedIndex.value == 4) {
          Get.put<ProfileController>(ProfileController(Get.find()))
              .getProfileById(Get.find<SpHelper>().getUser()?.userInfo?.id);
        }

        // Get.find<ProfileController>().profileModel = null;
        // Get.find<ProfileController>().userPosts = null;
        // Get.find<ProfileController>().update();
        return IndexedStack(
          index: Get.find<BnbController>().delectedIndex.value,
          children: _pages,
        );
      }),
      bottomNavigationBar: Obx(() {
        return SafeArea(
          child: Container(
            height: 40.h, // Fixed height
            color: Colors.white, // Background color
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Space icons evenly
              children: [
                GestureDetector(
                  onTap: () =>
                      Get.find<BnbController>().delectedIndex.value = 0,
                  child: SvgPicture.asset(
                    'assets/icons/home_icon.svg',
                    height: 20.5.h, // Icon size
                    color: Get.find<BnbController>().delectedIndex.value == 0
                        ? Color(AppColors.black)
                        : Color(AppColors.greyDark),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Get.find<BnbController>().delectedIndex.value = 1,
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    height: 20.5.h,
                    color: Get.find<BnbController>().delectedIndex.value == 1
                        ? Color(AppColors.black)
                        : Color(AppColors.greyDark),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Get.find<BnbController>().delectedIndex.value = 2,
                  child: SvgPicture.asset(
                    'assets/icons/plus-circle.svg',
                    height: 20.5.h,
                    color: Get.find<BnbController>().delectedIndex.value == 2
                        ? Color(AppColors.black)
                        : Color(AppColors.greyDark),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Get.find<BnbController>().delectedIndex.value = 3,
                  child: SvgPicture.asset(
                    'assets/icons/bell.svg',
                    height: 20.5.h,
                    color: Get.find<BnbController>().delectedIndex.value == 3
                        ? Color(AppColors.black)
                        : Color(AppColors.greyDark),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Get.find<BnbController>().delectedIndex.value = 4,
                  child: SvgPicture.asset(
                    'assets/icons/person.svg',
                    height: 20.5.h,
                    color: Get.find<BnbController>().delectedIndex.value == 4
                        ? Color(AppColors.black)
                        : Color(AppColors.greyDark),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
