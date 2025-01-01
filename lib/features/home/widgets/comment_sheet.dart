import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/utils/colors.dart';

class CommentSheet extends StatefulWidget {
  final int index;
  CommentSheet({super.key, required this.index});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  int commentIndex = -1;
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      child: Column(
        children: [
          // Comments header
          SizedBox(height: 10.h),
          Center(
            child: Text(
              'Comments',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 6.h),
          Divider(
            color: Colors.grey,
            thickness: 0.1,
            height: 5.h,
          ),
          SizedBox(height: 6.h),

          // Comments list
          GetBuilder<HomeController>(builder: (controller) {
            return Expanded(
              child: ListView.builder(
                itemCount: controller.posts[widget.index].comments.length,
                itemBuilder: (context, commentsIndex) {
                  final comment =
                      controller.posts[widget.index].comments[commentsIndex];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage(
                                  'assets/images/image.png'), // Example image
                            ),
                            SizedBox(width: 10.w),
                            // Username and Comment
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.authorProfile.username,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        comment.comment,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Get.find<HomeController>()
                                              .likeSubComment(
                                                  widget.index, commentsIndex);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              comment.likedByMe
                                                  ? 'assets/icons/like_fill.svg'
                                                  : 'assets/icons/like.svg',
                                              color: comment.likedByMe
                                                  ? Colors.red
                                                  : Colors.grey,
                                              height: 12.h,
                                            ),
                                            Center(
                                              child: Text(
                                                " ${comment.likeCounts == 0 ? '' : comment.likeCounts}",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Like",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          commentIndex = commentsIndex;
                                          controller.focusOnReplyComment(
                                              controller.posts[widget.index]
                                                  .profileModel);
                                        },
                                        child: Text("Reply",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: (controller.posts[widget.index]
                                    .comments[commentsIndex].comments.length !=
                                0 &&
                            !showMore),
                        child: GestureDetector(
                          onTap: () {
                            showMore = true;
                            setState(() {});
                          },
                          child: Text(
                            "View ${controller.posts[widget.index].comments[commentsIndex].comments.length} more replies",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp),
                          ).paddingOnly(left: 50.sp),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Visibility(
                        visible: showMore,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: comment.comments.length,
                            itemBuilder: (context, subCommentIndex) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 60, bottom: 15, right: 17),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Avatar
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundImage: AssetImage(
                                          'assets/images/image.png'), // Example image
                                    ),
                                    SizedBox(width: 10.w),
                                    // Username and Comment
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment.comments[subCommentIndex]
                                                .authorProfile.username,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "@" +
                                                    comment
                                                        .comments[
                                                            subCommentIndex]
                                                        .authorProfile
                                                        .username,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11.sp,
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                comment
                                                    .comments[subCommentIndex]
                                                    .comment,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.find<HomeController>()
                                            .likeSubComment(widget.index,
                                                commentsIndex, subCommentIndex);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            comment.comments[subCommentIndex]
                                                    .likedByMe
                                                ? 'assets/icons/like_fill.svg'
                                                : 'assets/icons/like.svg',
                                            color: comment
                                                    .comments[subCommentIndex]
                                                    .likedByMe
                                                ? Colors.red
                                                : Colors.grey,
                                            height: 12.h,
                                          ),
                                          Text(
                                            " ${comment.comments[subCommentIndex].likeCounts == 0 ? '' : comment.comments[subCommentIndex].likeCounts}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Visibility(
                        visible: (controller.posts[widget.index]
                                    .comments[commentsIndex].comments.length !=
                                0 &&
                            showMore),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showMore = false;
                                setState(() {});
                              },
                              child: Text(
                                "Hide replies",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp),
                              ).paddingOnly(left: 50.sp),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),

          // Thin grey line above text field
          Divider(
            color: Colors.grey,
            thickness: 0.1,
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, bottom: 16.h, top: 8.h),
            child: Row(
              children: [
                // Avatar on the left of input field
                CircleAvatar(
                  radius: 15.h,
                  backgroundImage: AssetImage('assets/images/image.png'),
                ),
                SizedBox(width: 10.w),

                // Input field
                Expanded(
                  child: Container(
                    height: 35.h, // Reduce height to make the input compact
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 234, 234, 234),
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      focusNode: Get.find<HomeController>().commentFocusNode,
                      controller: Get.find<HomeController>().commentController,
                      decoration: InputDecoration(
                        hintText: "comment...",
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none, // Remove default borders
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, // Reduce vertical padding
                          horizontal: 16.w, // Add consistent horizontal padding
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 12.sp, // Match text size with compact height
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),

                // Send Button
                IconButton(
                  onPressed: () {
                    if (commentIndex != -1) {
                      Get.find<HomeController>()
                          .addCommentOnComments(widget.index, commentIndex);
                      showMore = true;
                      setState(() {});
                    } else {
                      Get.find<HomeController>().addComment(widget.index);
                    }
                    commentIndex = -1;
                  },
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
