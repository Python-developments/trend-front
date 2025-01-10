// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:trend/data/models/post_model.dart';
// import 'package:trend/features/search/controllers/explore_controller.dart';
// import 'package:trend/features/search/widgets/image_with_location_widget.dart';
// import 'package:trend/networks/models/get_all_posts_response.dart';

// class LocationsPosts extends StatelessWidget {
//   List<List<Post>> categorizePostsByLocation(List<Post> posts) {
//     // Initialize a list to store the categorized posts (list of lists).
//     List<List<Post>> categorizedPosts = [];

//     // A list to keep track of the locations we've already encountered.
//     List<String> encounteredLocations = [];

//     // Iterate over each post in the original list.
//     for (var post in posts) {
//       // If we haven't encountered this location before, create a new list for it.
//       if (!encounteredLocations.contains(post.)) {
//         // Add the location to the list of encountered locations.
//         encounteredLocations.add(post.locationName);

//         // Create a new list for posts from this location.
//         List<Post> locationPosts =
//             posts.where((p) => p.locationName == post.locationName).toList();

//         // Add this list of posts to the final categorized list.
//         categorizedPosts.add(locationPosts);
//       }
//     }

//     return categorizedPosts;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return GetBuilder<ExploreController>(builder: (controller) {
//       List<List<Post>> postsGroups =
//           categorizePostsByLocation(controller.posts);
//       return SafeArea(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Get.find<ExploreController>()
//                           .pageController
//                           .animateToPage(0,
//                               duration: Duration(milliseconds: 100),
//                               curve: Curves.linear);
//                     },
//                     icon: Icon(Icons.arrow_back)),
//                 Text(
//                   "TRENDING PLACES",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       color: Colors.grey,
//                       fontSize: 14.sp),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.arrow_back),
//                   color: Colors.transparent,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: postsGroups.length,
//                   itemBuilder: (context, index) {
//                     return ImageWithLocationWidget(postsGroups[index]);
//                   }),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
