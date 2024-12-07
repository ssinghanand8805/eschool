import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'controller/ChatController.dart';



class UserProfileModal extends StatelessWidget {
  ChatController controller;
  final List<Map<String, String>> groups;

  UserProfileModal({
    Key? key,
    required this.controller,
    required this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        backgroundColor: theme.primaryColorLight,
        title: Text(
          'User Profile',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    _buildInfoSection('Bio', controller.chatUserAbout.value),
                    _buildInfoSection('Phone', controller.chatUserPhone.value ),
                    _buildInfoSection('Email', controller.chatUserEmail.value),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: _buildInfoSection('Media', "No media share yet")),
              SizedBox(height: 20),
              _buildGroupsSection(context),
              SizedBox(height: 20),
              _buildBlockToggle(true, (value) {
               value = !value;
              }),
              SizedBox(height: 20),
              _buildReportButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(controller.photoUrl.value),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.chatName.value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4),
                Text('Online', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, String? content) {
    return Container(
    height: 80,
      decoration: BoxDecoration(
        color: Colors.white60,
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Text(
            content ?? "No information available",
            style: TextStyle(
              fontSize: 14,
              color: content != null ? Colors.grey.shade600 : Colors.redAccent.shade200,
            ),
          ),
          Spacer(),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Groups in common',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Text('2 groups', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        SizedBox(height: 16),
        ...groups
            .map((group) => _buildGroupItem(group['name']!, group['members']!))
            .toList(),
      ],
    );
  }

  Widget _buildGroupItem(String name, String members) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            radius: 24,
            child: Icon(Icons.group, color: Colors.blue, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 4),
                Text(members,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockToggle(bool isBlocked, Function(bool) onToggle) {
    return GestureDetector(
      onTap: () {
        onToggle(!isBlocked);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Block User',
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
            ),
            CupertinoSwitch(
              thumbColor: Colors.red,
              activeColor: Colors.red.shade100,
              trackColor: Colors.green.shade200,
              value: isBlocked,
              onChanged: (value) {
                onToggle(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: ElevatedButton(
        child: Text(
          'Report User',
          style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600),
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
