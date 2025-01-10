import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/features/home/widgets/comment_sheet.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';

class ActivitiesPost extends StatelessWidget {
  final Post postModel;
  final int index;
  const ActivitiesPost(this.postModel, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Like Button
            GestureDetector(
              onTap: () {
                Get.find<HomeController>().likePost(index);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    (postModel.likedByMe ?? false)
                        ? 'assets/icons/like_fill.svg'
                        : 'assets/icons/like.svg',
                    color: (postModel.likedByMe ?? false)
                        ? Colors.red
                        : Colors.black,
                    height: 13.h,
                  ),
                  Text(
                    " ${postModel.likesCount == 0 ? '' : postModel.likesCount}${postModel.likesCount <= 1 ? ' like' : ' likes'}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Comment Button
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/comment.svg',
                  color: Colors.black,
                  height: 13.h,
                ),
                GestureDetector(
                  onTap: () async {
                    Get.find<HomeController>().addLestnerOnCommentController();
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Allows the bottom sheet to adjust with the keyboard
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context)
                                .viewInsets
                                .bottom, // Adjust for keyboard
                          ),
                          child: CommentSheet(
                            index: index,
                          ),
                        );
                      },
                    );
                    Get.find<HomeController>().disploseListener();
                  },
                  child: Text(
                    " ${postModel.commentsCount == 0 ? '' : postModel.commentsCount}${postModel.commentsCount <= 1 ? ' comment' : ' comments'}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            // Share Button
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/share.svg',
                  color: Colors.black,
                  height: 12.h,
                ),
                Text(
                  ' share',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
