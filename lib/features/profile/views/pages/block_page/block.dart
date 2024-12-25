import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockedUsers extends StatelessWidget {
  const BlockedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Blocked Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          ListTile(
              leading: CircleAvatar(
                radius: 20, // You can adjust the size
                backgroundColor:
                    Colors.transparent, // Optional, remove background color
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ppl.jpg',
                    fit: BoxFit
                        .cover, // Ensures the image covers the circular bounds
                    width: double.infinity, // Fills the CircleAvatar
                    height: double.infinity, // Fills the CircleAvatar
                  ),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: 'sarah',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              trailing: Container(
                height: 25.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 23, 173, 46),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Unblock',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 65.w, right: 23.w),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          ListTile(
              leading: CircleAvatar(
                radius: 20, // You can adjust the size
                backgroundColor:
                    Colors.transparent, // Optional, remove background color
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ppl.jpg',
                    fit: BoxFit
                        .cover, // Ensures the image covers the circular bounds
                    width: double.infinity, // Fills the CircleAvatar
                    height: double.infinity, // Fills the CircleAvatar
                  ),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: 'alex',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              trailing: Container(
                height: 25.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 23, 173, 46),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Unblock',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 65.w, right: 23.w),
            child: Divider(
              color: Colors.grey[300],
            ),
          ),
          ListTile(
              leading: CircleAvatar(
                radius: 20, // You can adjust the size
                backgroundColor:
                    Colors.transparent, // Optional, remove background color
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ppl.jpg',
                    fit: BoxFit
                        .cover, // Ensures the image covers the circular bounds
                    width: double.infinity, // Fills the CircleAvatar
                    height: double.infinity, // Fills the CircleAvatar
                  ),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: 'mohammed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              trailing: Container(
                height: 25.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 23, 173, 46),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Unblock',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
