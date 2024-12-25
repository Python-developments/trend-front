import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/features/profile/views/pages/edit_profile/edit_bio.dart';
import 'package:trend/features/profile/views/pages/edit_profile/profile_widget.dart';
import 'package:trend/utils/media_picker_utils.dart';
import 'package:trend/utils/routes.dart';
import 'package:trend/utils/toast_utils.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: GetBuilder<ProfileController>(builder: (controller) {
        return SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 60.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.sp,
                      ),
                      Icon(
                        Icons.arrow_back_ios,
                        size: 15.sp,
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Edit Profile",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () {
                    // controller.editProfile();
                  },
                  child: Text(
                    "Save",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 45.sp,
                        backgroundColor: Colors.white,
                        child: CustomCachedImageWidget(
                            addBorder: false,
                            size: 100.sp,
                            radius: 100.sp,
                            fileUrl: controller.avatarFileUrl,
                            imageUrl: controller.avatar),
                      ),
                      Positioned(
                        bottom: 3.sp,
                        left: 0.sp,
                        child: GestureDetector(
                          onTap: () async {
                            await controller.pickAvatarImage(context);
                          },
                          child: CircleAvatar(
                            radius: 12.sp,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              "assets/icons/content.png",
                              height: 15.sp,
                              width: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/new_user.svg",
                          height: 14.sp,
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Text(
                          "Personal Informations",
                          style: TextStyle(
                              height: 0.7,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ProfileWidget(
                          icon: "assets/icons/profile/new/user2.svg",
                          title: "Username",
                          value: controller.username ?? '',
                        ),
                        SizedBox(
                            width: 250,
                            child: Divider(
                              height: 1,
                              thickness: 0.2,
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditBio(
                                profileEdiable: ProfileEdiable.fName,
                                lineCount: 1,
                                charsCount: 10,
                                title: "First Name",
                                value: controller.fName ?? ''));
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "First Name",
                            value: controller.fName?.isEmpty ?? true
                                ? "-"
                                : controller.fName!,
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            child: Divider(
                              height: 1,
                              thickness: 0.2,
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditBio(
                                profileEdiable: ProfileEdiable.lName,
                                lineCount: 1,
                                charsCount: 10,
                                title: "Last Name",
                                value: controller.lName ?? ''));
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "Last Name",
                            value: controller.lName?.isEmpty ?? true
                                ? "-"
                                : controller.lName!,
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            child: Divider(
                              height: 1,
                              thickness: 0.2,
                            )),
                        InkWell(
                          onTap: () {
                            Get.to(EditBio(
                                profileEdiable: ProfileEdiable.bio,
                                lineCount: 3,
                                charsCount: 50,
                                title: "Bio",
                                value: controller.bio ?? ''));
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "Bio",
                            value: (controller.bio?.isEmpty ?? true
                                ? '-'
                                : controller.bio!),
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            child: Divider(
                              height: 1,
                              thickness: 0.2,
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditBio(
                                profileEdiable: ProfileEdiable.phone,
                                lineCount: 1,
                                charsCount: 10,
                                title: "Phone Number",
                                value: controller.phone ?? ''));
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "Phone",
                            value: controller.phone?.isEmpty ?? true
                                ? '-'
                                : controller.phone!,
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            child: Divider(
                              height: 1,
                              thickness: 0.2,
                            )),
                        GestureDetector(
                          onTap: () {
                            Get.to(EditBio(
                                profileEdiable: ProfileEdiable.location,
                                lineCount: 1,
                                charsCount: 10,
                                title: "Location",
                                value: controller.location ?? ''));
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "Location",
                            value: controller.location?.isEmpty ?? true
                                ? '-'
                                : controller.location!,
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            child: Divider(
                              height: 1,
                              thickness: 0.2,
                            )),
                        ProfileWidget(
                          icon: "assets/icons/profile/new/user2.svg",
                          title: "Email",
                          value: (controller.email ?? ''),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/new_user.svg",
                          height: 14.sp,
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Text(
                          "Personal Informations",
                          style: TextStyle(
                              height: 0.7,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.toNamed(AppRoutes.blockpage);
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "BlockList",
                            value: '',
                            showDivider: false,
                          ),
                        ),
                        SizedBox(
                            child: Divider(
                          height: 1,
                          thickness: 0.2,
                        )),
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(AppRoutes.login);
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "Logout",
                            value: '',
                          ),
                        ),
                        SizedBox(
                            child: Divider(
                          height: 1,
                          thickness: 0.2,
                        )),
                        InkWell(
                          onTap: () async {
                            ToastUtils(context).showCustomToast(
                              message:
                                  "Your Request has been sent, Request will be cancked if you login again to the account",
                              iconData: Icons.error_outline,
                            );
                            Get.offAllNamed(AppRoutes.login);
                          },
                          child: ProfileWidget(
                            icon: "assets/icons/profile/new/user2.svg",
                            title: "Delete Account",
                            value: '',
                            showDivider: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
      }),
    );
  }
}
