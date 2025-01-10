import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/features/search/controllers/explore_controller.dart';
import 'package:trend/features/search/tabs/explore_tabs.dart';
import 'package:trend/features/search/tabs/location_posts.dart';
import 'package:trend/features/search/tabs/trending_tab.dart';

class ExploreMainPage extends StatelessWidget {
  const ExploreMainPage();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<ExploreController>(
        init: ExploreController(Get.find()),
        builder: (controller) {
          return ExploreTagsTab();
          //  PageView.builder(
          //     physics: NeverScrollableScrollPhysics(),
          //     controller: controller.pageController,
          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return [
          //         ExploreTagsTab(),
          //         TrendingTabs(),
          //         LocationsPosts()
          //       ][index];
          //     });
        });
  }
}
