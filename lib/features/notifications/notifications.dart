import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Notifications',
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
                  text: 'alex',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' is starting following you',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              trailing: Text('10:00 AM'),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 20, // You can adjust the size
                backgroundColor:
                    Colors.transparent, // Optional, remove background color
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/field.jpg',
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
                  children: <TextSpan>[
                    TextSpan(
                      text: ' is starting following you',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              trailing: Text('10:00 AM'),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 20, // You can adjust the size
                backgroundColor:
                    Colors.transparent, // Optional, remove background color
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/desert.jpg',
                    fit: BoxFit
                        .cover, // Ensures the image covers the circular bounds
                    width: double.infinity, // Fills the CircleAvatar
                    height: double.infinity, // Fills the CircleAvatar
                  ),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: 'sara',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' is starting following you',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              trailing: Text('10:00 AM'),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 20, // You can adjust the size
                backgroundColor:
                    Colors.transparent, // Optional, remove background color
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/football.jpg',
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
                  children: <TextSpan>[
                    TextSpan(
                      text: ' is starting following you',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              trailing: Text('10:00 AM'),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 20, // You can adjust the size
                backgroundColor:
                    Colors.transparent, // Optional, remove background color
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/soccer.jpg',
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
                  children: <TextSpan>[
                    TextSpan(
                      text: ' is starting following you',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              trailing: Text('10:00 AM'),
            ),
          ],
        ));
  }
}
