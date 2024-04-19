import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/profile/controller/ProfileController.dart';

import '../../apiHelper/Constants.dart';
import '../../apiHelper/GlobalData.dart';
import '../../apiHelper/userData.dart';
import '../../core/utils/common_utilities.dart';
import '../../theme/theme_helper.dart';
import '../common_widgets/InfoRow.dart';
import '../common_widgets/custom_loader.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage() : super();

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserData userData = UserData();
  String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Profile'),
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader(); // CustomLoader();
                  }

                  return Column(
                    children: [
                      Container(
                        // color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.profileModelObj.value!
                                              .studentResult!.firstname! +
                                          " " +
                                          controller.profileModelObj.value!
                                              .studentResult!.middlename! +
                                          " " +
                                          controller.profileModelObj.value!
                                              .studentResult!.lastname!,
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${controller.profileModelObj.value!.studentResult!.className!}" +
                                          ' ( ' +
                                          controller.profileModelObj.value!
                                              .studentResult!.section! +
                                          ' )',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(fontSize: 13),
                                    ),
                                    Text(
                                      'Adm. No: ${controller.profileModelObj.value!.studentResult!.admissionNo!}',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(fontSize: 13),
                                    ),
                                    Text(
                                      'Roll Number: ${controller.profileModelObj.value!.studentResult!.rollNo!}',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(fontSize: 13),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'BarCode:',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(fontSize: 13),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Image.network(
                                              baseUrlFromPref +
                                                      controller
                                                          .profileModelObj
                                                          .value!
                                                          .studentResult!
                                                          .barcode! ??
                                                  "",
                                              height: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Qr Code:',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(fontSize: 13)),
                                        controller.profileModelObj.value!
                                                    .studentResult!.qrcode !=
                                                null
                                            ? Image.network(
                                            baseUrlFromPref +
                                                        controller
                                                            .profileModelObj
                                                            .value!
                                                            .studentResult!
                                                            .qrcode! ??
                                                    '',
                                                height: 35,
                                                width: 35)
                                            : SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    controller.profileModelObj.value!
                                                .studentResult!.image !=
                                            null
                                        ? CircleAvatar(
                                            radius: 45,
                                            backgroundColor: Colors.orange,
                                            backgroundImage: NetworkImage(
                                                baseUrlFromPref +
                                                    controller
                                                        .profileModelObj
                                                        .value!
                                                        .studentResult!
                                                        .image
                                                        .toString()),
                                          )
                                        : CircleAvatar(
                                            radius: 45,
                                            backgroundColor: Colors.orange,
                                            backgroundImage: AssetImage(
                                                'assets/projectImages/placeholder_user.png'),
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: MyHomePage()),
                    ],
                  );
                });
          }),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  ProfileController controller = Get.put(ProfileController());
  String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Container(
                      color: Colors.green.shade50,
                      child: TabBar(
                        labelStyle:
                            theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                        unselectedLabelColor: Colors.grey.shade700,
                        // labelColor: const Color(0xFF3baee7),
                        // indicatorWeight: 3,
                        indicatorColor: Colors.blue,
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
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Admission Date',
                                    value: Utils.formatDateString(controller
                                        .profileModelObj
                                        .value!
                                        .studentResult!
                                        .admissionDate!
                                        .toString()),
                                  ),
                                  InfoRow(
                                    title: 'Date Of Birth',
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    value: Utils.formatDateString(controller
                                        .profileModelObj
                                        .value!
                                        .studentResult!
                                        .dob!
                                        .toString()),
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Gender',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.gender!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Category',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.category!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Mobile Number',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.mobileno!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Cast',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.cast!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Religion',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.religion!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Email',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.email!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Current Address',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.currentAddress!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Blood Group',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.bloodGroup!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Height',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.height!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Weight',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.weight!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 13),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 13),
                                    title: 'Note',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.note!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          controller
                                                  .profileModelObj
                                                  .value!
                                                  .studentResult!
                                                  .fatherPic!
                                                  .isNotEmpty
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  backgroundImage: NetworkImage(
                                                      baseUrlFromPref +  controller
                                                          .profileModelObj
                                                          .value!
                                                          .studentResult!
                                                          .fatherPic
                                                          .toString()),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Father",
                                              style:
                                                  theme.textTheme.titleMedium!),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .fatherName
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.call,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .fatherPhone
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/projectImages/ic_briefcase.png",
                                                  height: 35,
                                                  width: 25,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .fatherName
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 0,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          controller
                                                  .profileModelObj
                                                  .value!
                                                  .studentResult!
                                                  .motherPic!
                                                  .isNotEmpty
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  backgroundImage: NetworkImage(
                                                      baseUrlFromPref+  controller
                                                          .profileModelObj
                                                          .value!
                                                          .studentResult!
                                                          .motherPic
                                                          .toString()),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Mother",
                                              style:
                                                  theme.textTheme.titleMedium!),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .fatherName
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.call,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .fatherPhone
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/projectImages/ic_briefcase.png",
                                                  height: 35,
                                                  width: 25,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .fatherName
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 0,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          controller
                                                  .profileModelObj
                                                  .value!
                                                  .studentResult!
                                                  .guardianPic!
                                                  .isNotEmpty
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  backgroundImage: NetworkImage(
                                                      baseUrlFromPref+   controller
                                                          .profileModelObj
                                                          .value!
                                                          .studentResult!
                                                          .guardianPic
                                                          .toString()),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: Colors.grey.shade200,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Guardian",
                                              style:
                                                  theme.textTheme.titleMedium!),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .motherName
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.call,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .motherPhone
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/projectImages/ic_briefcase.png",
                                                  height: 35,
                                                  width: 25,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .motherOccupation
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/projectImages/ic_relation.png",
                                                  height: 35,
                                                  width: 25,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .guardianName
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/projectImages/ic_email_filled.png",
                                                  height: 35,
                                                  width: 25,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .guardianEmail
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/projectImages/ic_location.png",
                                                  height: 35,
                                                  width: 25,
                                                  color: Colors.grey.shade700),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller
                                                    .profileModelObj
                                                    .value!
                                                    .studentResult!
                                                    .guardianAddress
                                                    .toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Previous School',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.previousSchool!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'National id Number',
                                  value: controller.profileModelObj.value!
                                      .studentFields!.nationalIdentificationNo
                                      .toString(),
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Local id Number',
                                  value: controller.profileModelObj.value!
                                      .studentFields!.localIdentificationNo
                                      .toString()!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Bank Name',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.bankName!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Bank Account Number',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.bankAccountNo!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Ifsc Code',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.ifscCode!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Previous School',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.previousSchool!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'RTE',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.rte!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Pickup Point',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.pickupPointName!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Vehicle Route',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.vehrouteId!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Vehicle Number',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.vehicleNo!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Driver Name',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.driverName!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Driver Contact',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.driverContact!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Hostels Room',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.hostelRoomId!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Room No',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.roomNo!,
                                ),
                                InfoRow(
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontSize: 13),
                                  style1: theme.textTheme.bodySmall!
                                      .copyWith(fontSize: 13),
                                  title: 'Room Type',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.roomType!,
                                ),
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
          );
        });
  }
}
