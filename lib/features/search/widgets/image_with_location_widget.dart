import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/utils/widgets/custom_cached_image.dart';

class ImageWithLocationWidget extends StatelessWidget {
  final List<PostModel> posts;
  const ImageWithLocationWidget(this.posts);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(5.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                posts.first.locationName,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 13.sp),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              )
            ],
          ),
        ),
        GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1.w, // Horizontal spacing
              mainAxisSpacing: 1.h, // Vertical spacing
              childAspectRatio: 1,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Container(
                child: CustomCachedImageWidget(
                  imageUrl:
                      "https://images.unsplash.com/photo-1485395037613-e83d5c1f5290?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  size: 20,
                  radius: 0,
                ),
              );
            }),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
