import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class FollowTabs extends StatefulWidget {
  String name;
  bool fromMe;
  int tabIndex;
  FollowTabs(
      {super.key, this.tabIndex = 0, this.fromMe = false, required this.name});

  @override
  State<FollowTabs> createState() => _FollowTabsState();
}

class _FollowTabsState extends State<FollowTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          bottom: TabBar(
            dividerColor: Colors.grey.withOpacity(0.2),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Followers'),
              Tab(text: 'Following'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Followers List
            ListView.builder(
              itemCount: controller.followersUsers?.length ??
                  0, // Replace with dynamic count
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CustomCachedImageWidget(
                    size: 50,
                    imageUrl: controller.followersUsers?[index].avatar,
                  ),
                  title: Text(
                    controller.followersUsers?[index].username ?? 'ddd',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  trailing: Container(
                    height: 25.h,
                    width: 70.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Message',
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),

            ListView.builder(
              itemCount: controller.followingUsers?.length ??
                  0, // Replace with dynamic count
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CustomCachedImageWidget(
                    size: 50,
                    imageUrl: controller.followingUsers?[index].avatar,
                  ),
                  title: Text(
                    controller.followingUsers?[index].username ?? '',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  trailing: widget.fromMe
                      ? GestureDetector(
                          onTap: () {
                            if (widget.fromMe) {
                              controller.unFollowUser(
                                  controller.followingUsers?[index].id ?? 0);
                            }
                          },
                          child: Container(
                              height: 25.h,
                              width: 70.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 226, 17, 17),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Unfollow',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        )
                      : SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
