import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trend/data/sources/fake_data.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/features/profile/views/pages/edit_profile/edit_profile.dart';
import 'package:trend/features/profile/views/widgets/profile_statictics.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(fakeProfileModel),
        builder: (controller) {
          return Scaffold(
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
                      imageUrl: controller.profileModel.avatar ?? '',
                      size: 90.r,
                    ),
                    SizedBox(height: 10.h),
                    ((controller.fName == null) && controller.lName == null)
                        ? SizedBox.shrink()
                        : Text(
                            '${controller.fName ?? ''} ${controller.lName ?? ''}',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    SizedBox(height: 5.h),
                    Text(
                      '@${controller.username}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color.fromARGB(255, 141, 141, 141),
                      ),
                    ),
                    ProfileStateictics(),
                    GestureDetector(
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
                                child:
                                    SvgPicture.asset('assets/icons/edit.svg'),
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
                    controller.bio == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Text(
                              controller.bio!,
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
                    Wrap(
                      spacing: 1.0, // Horizontal space between items
                      runSpacing: 1.0, // Vertical space between rows
                      children: List.generate(
                        9, // Number of photos
                        (index) => Container(
                          width: (MediaQuery.of(context).size.width - 5) / 3,
                          height: (MediaQuery.of(context).size.width - 5) /
                              3, // Keep height the same for square shape
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
