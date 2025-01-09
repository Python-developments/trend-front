import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/features/home/widgets/post_widget.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';

class PostsUserPage extends StatefulWidget {
  final List<Post> posts;
  final int index;
  final int userId;
  const PostsUserPage(
      {super.key,
      required this.posts,
      required this.index,
      required this.userId});

  @override
  State<PostsUserPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsUserPage> {
  int page = 1;
  FlutterListViewController controller = FlutterListViewController();
  @override
  void initState() {
    super.initState();
    controller.sliverController.jumpToIndex(widget.index);
    Get.find<HomeController>().getUserPosts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    List<Post> posts = widget.posts;
    return Scaffold(
      body: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'T  R  E  N  D',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: ScrollablePositionedList.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => PostWidget(
                    isprofilePost: true,
                    index: index,
                    postModel: posts[index],
                    function: () {},
                  ),
              initialScrollIndex: widget.index)),
    );
  }
}
