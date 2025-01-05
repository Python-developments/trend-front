import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/home/widgets/post_details.dart';
import 'package:trend/features/profile/views/pages/my_profile/my_profile.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class HeaderPost extends StatelessWidget {
  final int index;
  final Post? postModel;
  const HeaderPost({super.key, required this.postModel, required this.index});
  String getTimeAgoShort(DateTime createdAt) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d'; // e.g. "1 d"
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h'; // e.g. "5 h"
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m'; // e.g. "10 m"
    } else {
      return '${difference.inSeconds}s'; // e.g. "30 s"
    }
  }

  bool isArabic(String text) {
    // A simple check to see if any character is within the Arabic Unicode block
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    bool isArabicPost = isArabic(postModel?.description ?? '');
    // Format the timestamp into a human-readable string like "1 min ago", "5 hrs ago"
    String timeAgo = getTimeAgoShort(postModel!.createdAt);
    bool isMe =
        postModel?.autherId == Get.find<SpHelper>().getUser()?.userInfo?.id;
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
                  Get.to(MyProfile(
                    id: postModel?.autherId ?? 0,
                    canBack: true,
                  ));
                },
                child: Row(
                  children: [
                    CustomCachedImageWidget(
                        size: 32, imageUrl: postModel?.authorAvatar),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postModel?.author ?? '',
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
                    timeAgo,
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
                          return PostDetails(
                            isMe: isMe,
                            id: postModel?.id ?? 0,
                            index: index,
                            userId: postModel?.autherId ?? 0,
                          );
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
          (postModel?.description?.isEmpty ?? true)
              ? SizedBox.shrink()
              : Column(
                  children: [
                    SizedBox(height: 5.h),
                    Text(
                      postModel?.description ?? '',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
