import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/features/home/widgets/comment_sheet.dart';

class ActivitiesPost extends StatelessWidget {
  final PostModel postModel;
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
                    postModel.likedByMe
                        ? 'assets/icons/like_fill.svg'
                        : 'assets/icons/like.svg',
                    color: postModel.likedByMe ? Colors.red : Colors.grey,
                    height: 12.h,
                  ),
                  Text(
                    " ${postModel.likeCounts == 0 ? '' : postModel.likeCounts}${postModel.likeCounts <= 1 ? ' like' : ' likes'}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Comment Button
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/comment.svg',
                  color: Colors.grey,
                  height: 12.h,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
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
                  },
                  child: Text(
                    " ${postModel.commentsCounts == 0 ? '' : postModel.commentsCounts}${postModel.commentsCounts <= 1 ? ' comment' : ' comments'}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
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
                  color: Colors.grey,
                  height: 12.h,
                ),
                Text(
                  ' share',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.1,
        ),
      ],
    );
  }
}
