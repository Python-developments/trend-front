import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/features/home/widgets/post_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'T  R  E  N  D',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Container(
                height: 37,
                width: 37,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.2,
                        color: const Color.fromARGB(255, 160, 160, 160)),
                    color: const Color.fromARGB(255, 251, 251, 251),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/icons/chat.svg'),
                )),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: const Color.fromARGB(255, 243, 243, 243),
            thickness: 1,
            height: 1,
          ),
          GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      return PostWidget(controller.posts[index], index);
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
