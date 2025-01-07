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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h), // Add space between the title and the list
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Number of notifications
              itemBuilder: (context, index) {
                // Sample data
                final data = [
                  {'name': 'alex', 'image': 'assets/images/ppl.jpg'},
                  {'name': 'mohammed', 'image': 'assets/images/field.jpg'},
                  {'name': 'sara', 'image': 'assets/images/desert.jpg'},
                  {'name': 'alex', 'image': 'assets/images/football.jpg'},
                  {'name': 'alex', 'image': 'assets/images/soccer.jpg'},
                ];

                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.h), // Reduce vertical gap
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w), // Adjust padding
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          data[index]['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: data[index]['name'],
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
