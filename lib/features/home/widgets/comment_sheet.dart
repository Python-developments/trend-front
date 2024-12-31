import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/utils/colors.dart';

class CommentSheet extends StatelessWidget {
  final int index;
  CommentSheet({super.key, required this.index});
  int commentIndex = -1;
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
                itemCount: controller.posts[0].comments.length,
                itemBuilder: (context, commentsIndex) {
                  final comment =
                      controller.posts[index].comments[commentsIndex];

                  return Column(
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
                                  Text(
                                    comment.comment,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
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
                                              controller
                                                  .posts[index].profileModel);
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
                      Column(
                          children: comment.comments.map((e) {
                        return Padding(
                          padding: EdgeInsets.only(left: 60, bottom: 5),
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
                                      e.authorProfile.username,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      e.comment,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(AppColors.matteBlue),
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList())
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
                          .addCommentOnComments(index, commentIndex);
                    } else {
                      Get.find<HomeController>().addComment(index);
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
