import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/presentation/homework/HomeworkScreen.dart';
import 'package:learnladder/presentation/profile/controller/ProfileController.dart';

import '../../apiHelper/Constants.dart';
import '../../apiHelper/userData.dart';
import '../../core/utils/common_utilities.dart';
import '../../theme/theme_helper.dart';
import '../common_widgets/custom_loader.dart';

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
                          padding: const EdgeInsets.only(left: 30.0,bottom: 5),
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
                                          .copyWith(fontSize: 14),
                                    ),
                                    Text(
                                        'Adm. No: ${controller.profileModelObj.value!.studentResult!.admissionNo!}',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(fontSize: 14)),
                                    Text(
                                        'Roll Number: ${controller.profileModelObj.value!.studentResult!.rollNo!}',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(fontSize: 14)),
                                    Row(
                                      children: [
                                        Text('BarCode:',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(fontSize: 14)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Image.network(
                                              Constants.imagesUrl2 +
                                                  controller
                                                      .profileModelObj
                                                      .value!
                                                      .studentResult!
                                                      .barcode! ??"",
                                              height: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Qr Code:',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(fontSize: 14)),
                                        controller.profileModelObj.value!
                                                    .studentResult!.qrcode !=
                                                null
                                            ? Image.network(
                                                Constants.imagesUrl2 +
                                                    controller
                                                        .profileModelObj
                                                        .value!
                                                        .studentResult!
                                                        .qrcode! ??'',
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
                                                Constants.imagesUrl + controller.profileModelObj
                                                    .value!.studentResult!.image
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
                                    title: 'Admission Date',
                                    value: Utils.formatDateString(controller.profileModelObj.value!
                                        .studentResult!.admissionDate!.toString()),
                                  ),
                                  InfoRow(
                                    title: 'Date Of Birth',
                                    value: Utils.formatDateString(controller.profileModelObj.value!
                                        .studentResult!.dob!.toString()),
                                  ),
                                  InfoRow(
                                    title: 'Gender',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.gender!,
                                  ),
                                  InfoRow(
                                    title: 'Category',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.category!,
                                  ),
                                  InfoRow(
                                    title: 'Mobile Number',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.mobileno!,
                                  ),
                                  InfoRow(
                                    title: 'Cast',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.cast!,
                                  ),
                                  InfoRow(
                                    title: 'Religion',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.religion!,
                                  ),
                                  InfoRow(
                                    title: 'Email',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.email!,
                                  ),
                                  InfoRow(
                                    title: 'Current Address',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.currentAddress!,
                                  ),
                                  InfoRow(
                                    title: 'Blood Group',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.bloodGroup!,
                                  ),
                                  InfoRow(
                                    title: 'Height',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.height!,
                                  ),
                                  InfoRow(
                                    title: 'Weight',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.weight!,
                                  ),
                                  InfoRow(
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
                                          controller.profileModelObj.value!
                                                      .studentResult!.image !=
                                                  null
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.orange,
                                                  backgroundImage: NetworkImage(
                                                      controller
                                                          .profileModelObj
                                                          .value!
                                                          .studentResult!
                                                          .fatherPic
                                                          .toString()),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.orange,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Father",
                                              style: theme
                                                  .textTheme.titleMedium!
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person,color: Colors.grey.shade700),
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
                                              Icon(Icons.call,color: Colors.grey.shade700),
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
                                                width: 25,color: Colors.grey.shade700
                                              ),
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
                                          controller.profileModelObj.value!
                                                      .studentResult!.image !=
                                                  null
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.orange,
                                                  backgroundImage: NetworkImage(
                                                      controller
                                                          .profileModelObj
                                                          .value!
                                                          .studentResult!
                                                          .fatherPic
                                                          .toString()),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.orange,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Mother",
                                              style: theme
                                                  .textTheme.titleMedium!
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person,color: Colors.grey.shade700),
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
                                              Icon(Icons.call,color: Colors.grey.shade700),
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
                                                width: 25,color: Colors.grey.shade700
                                              ),
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
                                          controller.profileModelObj.value!
                                                      .studentResult!.image !=
                                                  null
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.orange,
                                                  backgroundImage: NetworkImage(
                                                      controller
                                                          .profileModelObj
                                                          .value!
                                                          .studentResult!
                                                          .fatherPic
                                                          .toString()),
                                                )
                                              : CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor:
                                                      Colors.orange,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Guardian",
                                              style: theme
                                                  .textTheme.titleMedium!
                                                 ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person,color: Colors.grey.shade700),
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
                                              Icon(Icons.call,color: Colors.grey.shade700),
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
                                                width: 25,color: Colors.grey.shade700
                                              ),
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
                                                width: 25,color: Colors.grey.shade700
                                              ),
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
                                                 color: Colors.grey.shade700
                                              ),
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
                                                width: 25,color: Colors.grey.shade700
                                              ),
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
                                  title: 'Previous School',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.previousSchool!,
                                ),
                                InfoRow(
                                  title: 'National id Number',
                                  value: controller.profileModelObj.value!
                                      .studentFields!.nationalIdentificationNo
                                      .toString(),
                                ),
                                InfoRow(
                                  title: 'Local id Number',
                                  value: controller.profileModelObj.value!
                                      .studentFields!.localIdentificationNo
                                      .toString()!,
                                ),
                                InfoRow(
                                  title: 'Bank Name',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.bankName!,
                                ),
                                InfoRow(
                                  title: 'Bank Account Number',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.bankAccountNo!,
                                ),
                                InfoRow(
                                  title: 'Ifsc Code',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.ifscCode!,
                                ),
                                InfoRow(
                                  title: 'Previous School',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.previousSchool!,
                                ),
                                InfoRow(
                                  title: 'RTE',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.rte!,
                                ),
                                InfoRow(
                                  title: 'Pickup Point',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.pickupPointName!,
                                ),
                                InfoRow(
                                  title: 'Vehicle Route',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.vehrouteId!,
                                ),
                                InfoRow(
                                  title: 'Vehicle Number',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.vehicleNo!,
                                ),
                                InfoRow(
                                  title: 'Driver Name',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.driverName!,
                                ),
                                InfoRow(
                                  title: 'Driver Contact',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.driverContact!,
                                ),
                                InfoRow(
                                  title: 'Hostels Room',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.hostelRoomId!,
                                ),
                                InfoRow(
                                  title: 'Room No',
                                  value: controller.profileModelObj.value!
                                      .studentResult!.roomNo!,
                                ),
                                InfoRow(
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
