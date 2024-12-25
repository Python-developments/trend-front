import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/features/home/widgets/post_details.dart';
import 'package:trend/features/profile/views/pages/user_profile/user_profile.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class HeaderPost extends StatelessWidget {
  final PostModel? postModel;
  const HeaderPost({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(UserProfile());
                },
                child: Row(
                  children: [
                    CustomCachedImageWidget(
                        size: 32, imageUrl: postModel?.profileModel.avatar),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postModel?.profileModel.username ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Wrap '10m' and 'Icon' in a Row
              Row(
                children: [
                  Text(
                    '10m',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return PostDetails();
                        },
                      );
                    },
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          (postModel?.content.isEmpty ?? true)
              ? SizedBox.shrink()
              : Column(
                  children: [
                    SizedBox(height: 5.h),
                    Text(
                      postModel?.content ?? '',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
