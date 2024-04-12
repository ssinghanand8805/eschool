import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/presentation/profile/controller/ProfileController.dart';

import '../../apiHelper/Constants.dart';
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
          Card(
            color: Colors.grey.shade50,
            elevation: 0.3,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.profileModelObj.value!.studentResult!
                                  .firstname! +
                              " " +
                              controller.profileModelObj.value!.studentResult!
                                  .middlename! +
                              " " +
                              controller.profileModelObj.value!.studentResult!
                                  .lastname!,
                          style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${controller.profileModelObj.value!.studentResult!.className!}" +
                              ' ( ' +
                              controller.profileModelObj.value!.studentResult!
                                  .section! +
                              ' )',
                          style:
                              theme.textTheme.bodySmall!.copyWith(fontSize: 14),
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
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.network(Constants.imagesUrl2 +
                                  controller.profileModelObj.value!.studentResult!
                                      .barcode!),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Qr Code:',
                                style: theme.textTheme.bodySmall!
                                    .copyWith(fontSize: 14)),
                            controller.profileModelObj.value!
                                .studentResult!.qrcode != null?Image.network(
                                Constants.imagesUrl2 +
                                    controller.profileModelObj.value!
                                        .studentResult!.qrcode!,
                                height: 70,
                                width: 70):SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        controller.profileModelObj.value!.studentResult!.image !=
                                null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.orange,
                                backgroundImage: NetworkImage(controller
                                    .profileModelObj.value!.studentResult!.image
                                    .toString()),
                              )
                            : CircleAvatar(
                                radius: 60,
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
      ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Admission Date:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .admissionDate!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Date Of Birth:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.dob!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Gender:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.gender!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Category:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.category!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Mobile Number:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.mobileno!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Caste:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.cast!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Religion:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.religion!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Email:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.email!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Current Address:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .currentAddress!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Permanent Address:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .permanentAddress!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Blood Group:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .bloodGroup!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Height:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.height!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Weight:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.weight!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Note:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.note!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  backgroundColor: Colors.orange,
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
                                                  backgroundColor: Colors.orange,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Father",
                                              style: theme.textTheme.titleMedium!
                                                  .copyWith(
                                                      fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                      Column(

                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person),
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
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.call),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.fatherPhone
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
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
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.fatherName
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 0,
                                          offset: Offset(0, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  backgroundColor: Colors.orange,
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
                                                  backgroundColor: Colors.orange,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Mother",
                                              style: theme.textTheme.titleMedium!
                                                  .copyWith(
                                                      fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                      Column(

                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person),
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
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.call),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.fatherPhone
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
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
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.fatherName
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 0,
                                          offset: Offset(0, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  backgroundColor: Colors.orange,
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
                                                  backgroundColor: Colors.orange,
                                                  backgroundImage: AssetImage(
                                                      'assets/projectImages/placeholder_user.png'),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("Guardian",
                                              style: theme.textTheme.titleMedium!
                                                  .copyWith(
                                                      fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                      Column(

                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person),
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
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.call),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.motherPhone
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
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
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.motherOccupation
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/projectImages/ic_relation.png",
                                                height: 35,
                                                width: 25,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.guardianName
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/projectImages/ic_email_filled.png",
                                                height: 35,
                                                width: 25,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.guardianEmail
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/projectImages/ic_location.png",
                                                height: 35,
                                                width: 25,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                controller.profileModelObj.value!
                                                    .studentResult!.guardianAddress
                                                    .toString(),
                                                style: theme.textTheme.titleMedium,
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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Previous School:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .previousSchool!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'National Id NUmber:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentFields!.nationalIdentificationNo.toString()!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Local Id NUmber:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentFields!.localIdentificationNo.toString()!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Bank Account Number:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.bankAccountNo!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Bank Name:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.bankName!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'IFSC Code:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.ifscCode!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'RTE:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.rte!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Pickup Point:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.pickupPointName!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Vehicle Route:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .vehrouteId!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Vehicle Number:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .vehicleNo!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Driver Name:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller
                                              .profileModelObj
                                              .value!
                                              .studentResult!
                                              .driverName!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Driver Contact:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.driverContact!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Hostels Rooms:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.hostelName!,style: theme.textTheme.titleMedium),
                                    ],
                                  )),
                                  Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Room No.:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.roomNo!,style: theme.textTheme.titleMedium),
                                    ],
                                  )), Text.rich(TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Room Type:  ',
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: controller.profileModelObj
                                              .value!.studentResult!.roomType!,style: theme.textTheme.titleMedium),
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
        });
  }
}
