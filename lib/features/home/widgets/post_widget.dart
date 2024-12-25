import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/features/home/activities_post.dart';
import 'package:trend/features/home/body_post.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/features/home/header_post.dart';

class PostWidget extends StatelessWidget {
  PostModel postModel;
  int index;
  PostWidget(this.postModel, this.index);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        HeaderPost(
          postModel: postModel,
        ),
        GestureDetector(
          onDoubleTap: () {
            Get.find<HomeController>().likePost(index);
          },
          child: BodyPost(
            postModel: postModel,
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        ActivitiesPost(postModel, index),
      ],
    );
  }
}
