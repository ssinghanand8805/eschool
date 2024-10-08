import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/presentation/homework/HomeworkScreen.dart';
import 'package:lerno/presentation/profile/controller/ProfileController.dart';
import 'package:lerno/presentation/profile/studentCard.dart';

import '../../apiHelper/Constants.dart';
import '../../apiHelper/GlobalData.dart';
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
  String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text('Profile',
            style: theme.textTheme.titleMedium!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w500)),
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
                      StudentDetailsCard(
                        fullName: (controller.profileModelObj.value!
                                    .studentResult!.firstname?.capitalize ??
                                '') +
                            ' ' +
                            (controller.profileModelObj.value!.studentResult!
                                    .middlename ??
                                '') +
                            ' ' +
                            (controller.profileModelObj.value!.studentResult!
                                    .lastname?.capitalize ??
                                ''),
                        className:
                            "${controller.profileModelObj.value!.studentResult!.className ?? ''} " +
                                ' ( ' +
                                (controller.profileModelObj.value!
                                        .studentResult!.section ??
                                    '') +
                                ' )',
                        admissionNo:
                            '${controller.profileModelObj.value!.studentResult!.admissionNo ?? ''}',
                        rollNo: controller
                            .profileModelObj.value!.studentResult!.rollNo,
                        barcodeUrl: baseUrlFromPref +
                            (controller.profileModelObj.value!.studentResult!
                                    .barcode ??
                                ''),
                        qrCodeUrl: baseUrlFromPref +
                            (controller.profileModelObj.value!.studentResult!
                                    .qrcode ??
                                ''),
                        imageUrl: baseUrlFromPref +
                            (controller
                                    .profileModelObj.value!.studentResult!.image
                                    ?.toString() ??
                                ''),
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
                      color: theme.primaryColorLight,
                      child: TabBar(
                        labelStyle:
                            theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                        unselectedLabelColor: Colors.grey.shade700,
                        // labelColor: const Color(0xFF3baee7),
                        // indicatorWeight: 3,
                        indicatorColor: theme.primaryColorDark,
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
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
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
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    value: Utils.formatDateString(controller
                                        .profileModelObj
                                        .value!
                                        .studentResult!
                                        .dob!
                                        .toString()),
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Gender',
                                    value: controller.profileModelObj.value!
                                            .studentResult!.gender ??
                                        "",
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Category',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.category!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Mobile Number',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.mobileno!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Cast',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.cast!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Religion',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.religion!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Email',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.email!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Current Address',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.currentAddress!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Blood Group',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.bloodGroup!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Height',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.height!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Weight',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.weight!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Note',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.note!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          StudentParentDetailsWidget(
                            studentData: {
                              'father': {
                                'pic': controller.profileModelObj.value!.studentResult!.fatherPic,
                                'name': controller.profileModelObj.value!.studentResult!.fatherName,
                                'phone': controller.profileModelObj.value!.studentResult!.fatherPhone,
                                'occupation': controller.profileModelObj.value!.studentResult!.fatherOccupation,
                              },
                              'mother': {
                                'pic': controller.profileModelObj.value!.studentResult!.motherPic,
                                'name': controller.profileModelObj.value!.studentResult!.motherName,
                                'phone': controller.profileModelObj.value!.studentResult!.motherPhone,
                                'occupation': controller.profileModelObj.value!.studentResult!.motherOccupation,
                              },
                              'guardian': {
                                'pic': controller.profileModelObj.value!.studentResult!.guardianPic,
                                'name': controller.profileModelObj.value!.studentResult!.guardianName,
                                'phone': controller.profileModelObj.value!.studentResult!.guardianPhone,
                                'occupation': controller.profileModelObj.value!.studentResult!.guardianOccupation,
                                'relation': controller.profileModelObj.value!.studentResult!.guardianRelation,
                                'email': controller.profileModelObj.value!.studentResult!.guardianEmail,
                                'address': controller.profileModelObj.value!.studentResult!.guardianAddress,
                              },
                            },
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Previous School',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.previousSchool!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'National id Number',
                                    value: controller.profileModelObj.value!
                                        .studentFields!.nationalIdentificationNo
                                        .toString(),
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Local id Number',
                                    value: controller.profileModelObj.value!
                                        .studentFields!.localIdentificationNo
                                        .toString()!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Bank Name',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.bankName,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Bank Account Number',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.bankAccountNo!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Ifsc Code',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.ifscCode,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Previous School',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.previousSchool!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'RTE',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.rte!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Pickup Point',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.pickupPointName!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Vehicle Route',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.vehrouteId!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Vehicle Number',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.vehicleNo!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Driver Name',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.driverName!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Driver Contact',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.driverContact!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Hostels Room',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.hostelRoomId!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Room No',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.roomNo!,
                                  ),
                                  InfoRow(
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontSize: 12),
                                    style1: theme.textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                    title: 'Room Type',
                                    value: controller.profileModelObj.value!
                                        .studentResult!.roomType!,
                                  ),
                                ],
                              ),
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
