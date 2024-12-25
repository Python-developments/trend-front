import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStateictics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '40',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '7.3K',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Followers',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '56',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '1.2M',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Likes',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 7.h)
      ],
    );
  }
}
