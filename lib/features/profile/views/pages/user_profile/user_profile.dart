import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/features/profile/views/widgets/profile_statictics.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isFollowUser = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(ProfileModel(
            username: "shsamara",
            email: 'shady@gmail.com',
            bio: "This is me shady from Gaza")),
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
                    Row(
                      children: [
                        SizedBox(width: 30.w),
                        Container(
                          width: 145.w,
                          height: 28.h,
                          child: Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isFollowUser = !isFollowUser;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                              ),
                              child: Text(
                                isFollowUser ? 'Following' : "Follow",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                side: BorderSide.none, // Remove the border
                              ),
                              child: Text(
                                'Message',
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                      ],
                    ),
                    SizedBox(height: 7.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'Dive into Stunning Goals and Unforgettable Highlights.\n📍 Location: Lagos, Nigeria 🇳🇬\n📞 Phone: +234 901 234 5678',
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
