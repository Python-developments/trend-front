import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trend/features/home/controllers/home_controller.dart';

class PostDetails extends StatelessWidget {
  int index;
  int id;
  int userId;
  bool isMe;
  PostDetails(
      {super.key,
      this.isMe = false,
      required this.id,
      required this.index,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // Ensure it takes only necessary space
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 13.h, bottom: 5.h),
                child: Text(
                  isMe ? "Delete Post" : 'Post Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 10.h, bottom: 35.h),
              child: isMe
                  ? GestureDetector(
                      onTap: () async {
                        await Get.find<HomeController>().deletePost(index, id);
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[100],
                        ),
                        child: Row(children: [
                          Icon(
                            Icons.block_rounded,
                            color: Colors.red,
                            size: 18.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            children: [
                              Text(
                                'Delete Post',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(15.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 1.h),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/icons/hide_post.svg',
                                        height: 18.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        children: [
                                          Text(
                                            'Hide Post',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: 0.2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.find<HomeController>()
                                          .blockUser(userId);
                                    },
                                    child: Row(children: [
                                      Icon(
                                        Icons.block_rounded,
                                        color: Colors.red,
                                        size: 18.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        children: [
                                          Text(
                                            'Block User',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
            ),
          ]),
    );
  }
}
