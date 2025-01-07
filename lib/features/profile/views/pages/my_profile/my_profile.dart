import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trend/data/sources/fake_data.dart';
import 'package:trend/features/home/posts_page_profile.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/features/profile/views/pages/edit_profile/edit_profile.dart';
import 'package:trend/features/profile/views/widgets/profile_statictics.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class MyProfile extends StatefulWidget {
  final bool canBack;
  final int? id;
  const MyProfile({super.key, this.id, this.canBack = false});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isFollowUser = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!Get.isRegistered<ProfileController>()) {
      Get.put<ProfileController>(ProfileController(Get.find(),
          widget.id ?? Get.find<SpHelper>().getUser()?.userInfo?.id));
    } else {
      Get.find<ProfileController>().getProfileById(
          widget.id ?? Get.find<SpHelper>().getUser()?.userInfo?.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    int? userId = widget.id ?? Get.find<SpHelper>().getUser()?.userInfo?.id;
    bool isMe = (userId == Get.find<SpHelper>().getUser()?.userInfo?.id);
    return GetBuilder<ProfileController>(builder: (controller) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(), // Enables smooth scrolling
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 80.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCachedImageWidget(
                      imageUrl: controller.profileModel?.avatar ?? '',
                      size: 90.r,
                    ),
                    (controller.profileModel?.fullName == null)
                        ? SizedBox.shrink()
                        : Text(
                            '${controller.profileModel?.fullName ?? ''}',
                          ),
                    Text(
                      '@${controller.profileModel?.username}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    ProfileStateictics(widget.id ??
                        Get.find<SpHelper>().getUser()?.userInfo?.id),
                    (!isMe)
                        ? Row(
                            children: [
                              SizedBox(width: 30.w),
                              Container(
                                width: 145.w,
                                height: 28.h,
                                child: Expanded(
                                  child: Obx(() {
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (controller
                                                .profileModel?.isFollowByMe ??
                                            false) {
                                          controller
                                              .unFollowUser(widget.id ?? 0);
                                        } else {
                                          controller.followUser(widget.id ?? 0);
                                        }
                                        // setState(() {
                                        //   isFollowUser = !isFollowUser;
                                        // });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                      ),
                                      child: controller.loadingFollow.value
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ))
                                          : Text(
                                              (controller.profileModel
                                                          ?.isFollowByMe ??
                                                      false)
                                                  ? 'Following'
                                                  : "Follow",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                width: 145.w,
                                height: 28.h,
                                child: Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.grey[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.r),
                                      ),
                                      side:
                                          BorderSide.none, // Remove the border
                                    ),
                                    child: Text(
                                      'Message',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.w),
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.to(EditProfilePage());
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: Row(
                                children: [
                                  Container(
                                    height: 30.h,
                                    width: 35.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.r),
                                        bottomLeft: Radius.circular(5.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                          'assets/icons/edit.svg'),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Container(
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F1F1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Container(
                                    height: 30.h,
                                    width: 35.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.r),
                                        bottomRight: Radius.circular(5.r),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                          'assets/icons/settings.svg'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(height: 10.h),
                    controller.profileModel?.bio == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Text(
                              controller.profileModel?.bio ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                    SizedBox(height: 10.h),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1),
                        itemCount: controller.userPosts?.length ?? 0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(PostsUserPage(
                                index: index,
                                posts: controller.userPosts ?? [],
                                userId: controller.id ?? 0,
                              ));
                              // Get.to("/userposts", extra: {
                              //   "index": index,
                              //   "posts": widget.profile.posts.items,
                              //   "userId": widget.profile.id
                              // });
                            },
                            child: CustomCachedImageWidget(
                              imageUrl:
                                  controller.userPosts?[index].image ?? '',
                              size: 10,
                              radius: 0,
                              errorWidget: Icon(Icons.broken_image),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
          widget.canBack
              ? Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back)))
              : SizedBox.shrink()
        ],
      );
    });
  }
}
