import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladder/presentation/common_widgets/MainBody.dart';

class LeaveApplicationPage extends StatefulWidget {
  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  DateTime _applyDate = DateTime.now();
  DateTime? _fromDate;
  DateTime? _toDate;
  String _reason = '';
  File? image;
TextEditingController reason = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        print("image $image");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MainBody(
        label: "Add Leave from\nhere!",
        imageUrl: "assets/projectImages/leavepage.jpg",
        AppbarTitle: "Apply Leave",
        widget: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Apply Date',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _applyDate,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025),
                      );
                      if (date != null) {
                        setState(() {
                          _applyDate = date;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'From Date',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _fromDate ?? _applyDate,
                              firstDate: _applyDate,
                              lastDate: DateTime(2025),
                            );
                            if (date != null) {
                              setState(() {
                                _fromDate = date;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'To Date',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _toDate ?? (_fromDate ?? _applyDate),
                              firstDate: _fromDate ?? _applyDate,
                              lastDate: DateTime(2025),
                            );
                            if (date != null) {
                              setState(() {
                                _toDate = date;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 55,
                  child: TextField(
                    controller: reason,
                    decoration: InputDecoration(
                      hintText: 'Reason',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _reason = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 10),
                Image.asset(
                  'assets/projectImages/upload_file.jpg',
                  height: 150,
                ), // Replace with your asset
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.grey.shade400,
                  ),
                  onPressed: () {
                    _showImagePicker(context);
                  },
                  child: Text("Choose File"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.green.shade400,
                  ),
                  onPressed: () {},
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ));
  }
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Image Source',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Pick from Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Take a Picture'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
