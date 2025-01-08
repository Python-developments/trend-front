import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/features/profile/views/pages/my_profile/my_profile.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class CommentSheet extends StatelessWidget {
  final int index;
  CommentSheet({super.key, required this.index});

  int commentIndex = -1;
  setCommentIndex(int commentIndex) {
    this.commentIndex = commentIndex;
  }

  OverlayEntry? _overlayEntry;

  void _showMenu(BuildContext context, Offset position, VoidCallback onDelete) {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Dismiss the menu when tapping outside
            GestureDetector(
              onTap: _removeMenu,
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
            Positioned(
              left: position.dx, // Same horizontal position
              top: position.dy, // Just below the widget
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _removeMenu();
                      onDelete();
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6 - 35,
      child: Column(
        children: [
          // Comments header
          SizedBox(height: 5.h),
          Center(
            child: Text(
              'Comments',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 3.h),
          Divider(
            color: Colors.grey,
            thickness: 0.1,
            height: 5.h,
          ),
          // SizedBox(height: 6.h),

          // Comments list
          GetBuilder<HomeController>(builder: (controller) {
            return Expanded(
              child: ListView.builder(
                itemCount: controller.posts[index].comments.length,
                itemBuilder: (context, commentsIndex) {
                  final comment =
                      controller.posts[index].comments[commentsIndex];
                  return GestureDetector(
                    onLongPressStart: (details) async {
                      if (controller
                              .posts[index].comments[commentsIndex].autherId ==
                          Get.find<SpHelper>().getUser()?.userInfo?.id) {
                        _showMenu(
                            context,
                            Offset(details.globalPosition.dx,
                                details.globalPosition.dy), () {
                          controller.deleteMyComent(
                              index,
                              commentsIndex,
                              controller.posts[index].id ?? 0,
                              controller.posts[index].comments[commentsIndex]
                                      .id ??
                                  0);
                          // Add delete logic here
                        });
                      }
                    },
                    child: CommentWidget(
                        comment, index, commentsIndex, setCommentIndex),
                  );
                },
              ),
            );
          }),

          // Thin grey line above text field
          Divider(
            color: Colors.grey,
            thickness: 0.2,
            height: 1,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 16.w, right: 0.w, bottom: 10.h, top: 8.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16.h,
                  backgroundImage: AssetImage('assets/images/dunk.jpg'),
                ),
                SizedBox(width: 10.w),

                // Input field
                Expanded(
                  child: Container(
                    height: 35.h,
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
                        hintText: " Add comment...",
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 16.w,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),

                // Send Button
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 12),
                  child: Container(
                    width: 33.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50.h),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (commentIndex != -1) {
                          Get.find<HomeController>()
                              .addCommentOnComments(index, commentIndex);
                        } else {
                          Get.find<HomeController>().addComment(index);
                        }
                        commentIndex = -1;
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/arrow-up-send.svg',
                        color: Colors.white,
                        height: 20.h,
                      ),
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
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                GestureDetector(
                  onTap: () {
                    Get.to(MyProfile(
                      canBack: true,
                      id: widget.comment.autherId,
                    ));
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/images/image.png'),
                  ),
                ),
                SizedBox(width: 10.w),
                // Username and Comment
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.comment.author ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
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
                                  // Add extra thickness if the color is grey
                                ),
                                Text(
                                  "${widget.comment.likesCount == 0 ? '' : widget.comment.likesCount}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600),
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
                                    fontSize: 10.sp)),
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
              child: Row(
                children: [
                  Container(
                    width: 15.sp, // Set the desired width for the divider
                    height: 0.3.h, // Match the thickness of the divider
                    color: const Color.fromARGB(
                        255, 110, 110, 110), // Divider color
                  ).paddingOnly(left: 55.sp),
                  Text(
                    "View ${Get.find<HomeController>().posts[widget.postIndex].comments[widget.commentIndex].replies?.length} replies",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5.sp,
                    ),
                  ).paddingOnly(left: 5.sp), // Reduced padding for alignment
                ],
              ),
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
                          radius: 12.w,
                          backgroundImage: AssetImage(
                              'assets/images/aziz.jpg'), // Example image
                        ),
                        SizedBox(width: 10.w),
                        // Username and Comment
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.comment.replies?[subCommentIndex]
                                        .author ??
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
                                        (widget
                                                .comment
                                                .replies?[subCommentIndex]
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
                                height: 10.h,
                              ),
                              Text(
                                " ${widget.comment.replies?[subCommentIndex].likesCount == 0 ? '' : widget.comment.replies?[subCommentIndex].likesCount}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
