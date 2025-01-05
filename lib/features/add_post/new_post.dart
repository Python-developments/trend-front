import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'package:trend/features/add_post/new_post_controller.dart';

class AddNewPostPage extends StatefulWidget {
  final Function? function;
  const AddNewPostPage({this.function});

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<NewPostController>(
        init: NewPostController(Get.find()),
        builder: (controller) {
          return Obx(() {
            log(controller.isLoading.value.toString());
            return Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    title: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20.sp,
                          ),
                          Text(
                            "Add a new post",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        controller.newPostImage == null
                            ? SizedBox()
                            : Column(
                                children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffF5F5F7)),
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30.sp),
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.file(
                                      controller.newPostImage!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.sp)),
                          margin: EdgeInsets.all(15.sp),
                          padding: EdgeInsets.all(15.sp),
                          child: Column(
                            children: [
                              TextFormField(
                                onTap: () async {
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  controller.scrollToEnd();
                                },
                                style: TextStyle(color: Colors.black),
                                controller: controller.contentController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    hintText: "Make description...",
                                    filled: true,
                                    fillColor: Color(0xffF9F9FC),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(6.sp))),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                      child: InkWell(
                                    onTap: () async {
                                      controller.pickImage(
                                          context, ImageSource.gallery);

                                      //
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.sp),
                                      child: SvgPicture.asset(
                                          'assets/icons/gallery.svg'),
                                    ),
                                  )),
                                  InkWell(
                                      child: InkWell(
                                    onTap: () async {
                                      controller.pickImage(
                                          context, ImageSource.camera);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.sp),
                                        child: SvgPicture.asset(
                                            'assets/icons/camera.svg')),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              Divider(
                                color: Color(0xffF5F5F7),
                                indent: 0,
                                height: 0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 35.sp, horizontal: 25.sp),
                    height: 40.sp,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                        ),
                        onPressed: controller.addNewPost,
                        child: Text(
                          "Save & Share",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                controller.isLoading.value
                    ? Positioned.fill(
                        child: Center(
                        child: CircularProgressIndicator(),
                      ))
                    : SizedBox.shrink()
              ],
            );
          });
        });
  }
}
