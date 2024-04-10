import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'controller/lesson_plan_controller.dart';
class LessonPlanScreen extends GetWidget<LessonPlanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Plan'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with your data length
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Subject (Code)'),
            subtitle: Text('10:50 AM - 11:30 AM'),
            trailing: IconButton(
              icon: Icon(Icons.book),
              onPressed: () {
                // Navigate to lesson plan details screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LessonPlanDetailsScreen(),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}

class LessonPlanDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Plan Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Your Lesson Plan is here!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            // Repeat the following for each section
            ListTile(
              title: Text('Topic'),
              subtitle: Text('Wonderland'),
            ),
            ListTile(
              title: Text('Sub Topic'),
              subtitle: Text('Wonderland'),
            ),
            // ... include all other sections
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Comments',
                ),
                maxLines: null,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement send comment functionality
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
