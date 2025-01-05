import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class BlockedUsers extends StatefulWidget {
  const BlockedUsers({super.key});

  @override
  State<BlockedUsers> createState() => _BlockedUsersState();
}

class _BlockedUsersState extends State<BlockedUsers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ProfileController>()
        .getBlockList(Get.find<SpHelper>().getUser()?.userInfo?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Blocked Users',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 65.w, right: 23.w),
              child: Divider(
                color: Colors.grey[300],
              ),
            );
          },
          itemCount: controller.block?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
                leading: CircleAvatar(
                  radius: 20, // You can adjust the size
                  backgroundColor:
                      Colors.transparent, // Optional, remove background color
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: controller.block?[index].avatar ?? '',
                      fit: BoxFit
                          .cover, // Ensures the image covers the circular bounds
                      width: double.infinity, // Fills the CircleAvatar
                      height: double.infinity, // Fills the CircleAvatar
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: controller.block?[index].username ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    controller.unBlockUser(controller.block?[index].id ?? 0);
                  },
                  child: Container(
                    height: 25.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 23, 173, 46),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Unblock',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ));
          },
        ),
      );
    });
  }
}
