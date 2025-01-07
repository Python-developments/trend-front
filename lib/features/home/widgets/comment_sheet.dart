import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';

class CommentSheet extends StatelessWidget {
  final int index;
  CommentSheet({super.key, required this.index});

  int commentIndex = -1;
  setCommentIndex(int commentIndex) {
    this.commentIndex = commentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6 - 33.h,
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
            thickness: 0.1.h,
            height: 5.h,
          ),
          SizedBox(height: 6.h),

          // Comments list
          GetBuilder<HomeController>(builder: (controller) {
            return Expanded(
              child: ListView.builder(
                itemCount: controller.posts[index].comments.length,
                itemBuilder: (context, commentsIndex) {
                  final comment =
                      controller.posts[index].comments[commentsIndex];
                  return CommentWidget(
                      comment, index, commentsIndex, setCommentIndex);
                },
              ),
            );
          }),

          // Thin grey line above text field
          Divider(
            color: const Color.fromARGB(255, 105, 105, 105),
            thickness: 0.1.h,
            height: 1,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 15.w, right: 7.w, bottom: 3.h, top: 5.h),
            child: Row(
              children: [
                // Avatar on the left of input field
                CircleAvatar(
                  radius: 13.h,
                  backgroundImage: AssetImage('assets/images/image.png'),
                ),
                SizedBox(width: 10.w),

                // Input field
                Expanded(
                  child: Container(
                    height: 32.h, // Reduce height to make the input compact
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
                      cursorColor: Colors.black,
                      cursorHeight: 11.h,
                      decoration: InputDecoration(
                        hintText: " comment...",
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none, // Remove default borders
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.9.h, // Reduce vertical padding
                          horizontal: 15.w, // Add consistent horizontal padding
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 12.sp, // Match text size with compact height
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 1.w),

                // Send Button
                IconButton(
                  onPressed: () {
                    if (commentIndex != -1) {
                      Get.find<HomeController>()
                          .addCommentOnComments(index, commentIndex);
                    } else {
                      Get.find<HomeController>().addComment(index);
                    }
                    commentIndex = -1;
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(5.h),
                    child: SvgPicture.asset(
                      'assets/icons/arrow-up-send.svg',
                      height: 16.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  final Function function;
  final Comment comment;
  final int postIndex;
  final int commentIndex;
  CommentWidget(this.comment, this.postIndex, this.commentIndex, this.function);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 16,
                backgroundImage:
                    AssetImage('assets/images/image.png'), // Example image
              ),
              SizedBox(width: 9.w),
              // Username and Comment
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comment.author ?? '',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.comment.content ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.find<HomeController>().likeSubComment(
                                widget.postIndex, widget.commentIndex);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                (widget.comment.likedByMe ?? false)
                                    ? 'assets/icons/like_fill.svg'
                                    : 'assets/icons/like.svg',
                                color: (widget.comment.likedByMe ?? false)
                                    ? Colors.red
                                    : Colors.grey,
                                height: 10.h,
                              ),
                              Text(
                                "${widget.comment.likesCount == 0 ? '' : widget.comment.likesCount}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.function(widget.commentIndex);
                            Get.find<HomeController>().focusOnReplyComment(
                                Get.find<HomeController>()
                                        .posts[widget.postIndex]
                                        .author ??
                                    '');
                          },
                          child: Text("Reply",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
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
          visible: ((Get.find<HomeController>()
                          .posts[widget.postIndex]
                          .comments[widget.commentIndex]
                          .replies
                          ?.length ??
                      0) !=
                  0 &&
              !showMore),
          child: GestureDetector(
            onTap: () {
              showMore = true;
              setState(() {});
            },
            child: Text(
              "View ${Get.find<HomeController>().posts[widget.postIndex].comments[widget.commentIndex].replies?.length} more replies",
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
              itemCount: widget.comment.replies?.length,
              itemBuilder: (context, subCommentIndex) {
                return Padding(
                  padding: EdgeInsets.only(left: 60, bottom: 15, right: 17),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.comment.replies?[subCommentIndex].author ??
                                  '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "@" +
                                      (widget.comment.replies?[subCommentIndex]
                                              .author ??
                                          ''),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.blue),
                                ),
                                Text(
                                  widget.comment.replies?[subCommentIndex]
                                          .content ??
                                      '',
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
                          Get.find<HomeController>().likeSubComment(
                              widget.postIndex,
                              widget.commentIndex,
                              subCommentIndex);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              (widget.comment.replies?[subCommentIndex]
                                          .likedByMe ??
                                      false)
                                  ? 'assets/icons/like_fill.svg'
                                  : 'assets/icons/like.svg',
                              color: (widget.comment.replies?[subCommentIndex]
                                          .likedByMe ??
                                      false)
                                  ? Colors.red
                                  : Colors.grey,
                              height: 12.h,
                            ),
                            Text(
                              " ${widget.comment.replies?[subCommentIndex].likesCount == 0 ? '' : widget.comment.replies?[subCommentIndex].likesCount}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
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
          visible: (Get.find<HomeController>()
                      .posts[widget.postIndex]
                      .comments[widget.commentIndex]
                      .replies
                      ?.length !=
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
  }
}
