import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/presentation/profile/controller/ProfileController.dart';

import '../../apiHelper/userData.dart';
import '../../theme/theme_helper.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage() : super();

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserData userData = UserData();
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "userData.getDatauserData.record.username",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "userData.getData userData.record.className" +
                        ' ( ' +
                        userData.getData("userData").record.section +
                        ' )',
                    style: theme.textTheme.titleMedium!,
                  ),
                  Text(
                    'Adm. No. 18001',
                    style: theme.textTheme.titleMedium!,
                  ),
                  Text(
                    'Roll Number 101',
                    style: theme.textTheme.titleMedium!,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.orange,
                    ),
                    Text(
                      'Behaviour Score: 20',
                      style: theme.textTheme.titleMedium!,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: MyHomePage()),
        ],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5.0,
                    offset: Offset(0.3, 3.0)),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.green.shade50,
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: const Color(0xFF3baee7),
                    indicatorWeight: 3,
                    indicatorColor: Colors.blue[500],
                    tabs: [
                      Tab(text: 'Personal'),
                      Tab(text: 'Parents'),
                      Tab(text: 'Others'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Admission Date: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Date Of Birth: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Gender: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Category: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Mobile Number: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Caste: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Religion: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Email: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Current Address: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Permanent Address: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Blood Group: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Height: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Weight: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Note: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Medical History: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Admission Date: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Date Of Birth: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Gender: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Category: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Mobile Number: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Caste: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Religion: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Email: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Current Address: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Permanent Address: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Blood Group: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Height: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Weight: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Note: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Medical History: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Admission Date: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Date Of Birth: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Gender: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Category: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Mobile Number: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Caste: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Religion: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Email: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Current Address: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Permanent Address: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Blood Group: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Height: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Weight: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Note: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Medical History: ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                TextSpan(text: ' world!'),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
