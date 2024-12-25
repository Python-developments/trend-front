import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key});

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
                  'Post Details',
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
              child: Column(
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
                            Row(children: [
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
