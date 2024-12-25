import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';

class BodyPost extends StatelessWidget {
  final PostModel? postModel;
  BodyPost({super.key, this.postModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxHeight: 600, minHeight: 100),
      // height: 300,
      width: Get.height,
      child: postModel?.file == null
          ? CachedNetworkImage(
              imageUrl: postModel?.image ?? '',
              fit: BoxFit.cover,
            )
          : Image.file(
              postModel!.file!,
              fit: BoxFit.cover,
            ),
    );
  }
}
