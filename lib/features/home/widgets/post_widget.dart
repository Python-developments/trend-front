import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/features/home/activities_post.dart';
import 'package:trend/features/home/body_post.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/features/home/header_post.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';

class PostWidget extends StatelessWidget {
  final Function function;
  final bool isprofilePost;
  final Post postModel;
  final int index;
  PostWidget(
      {required this.postModel,
      required this.index,
      required this.function,
      required this.isprofilePost});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        HeaderPost(
          postModel: postModel,
          index: index,
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
