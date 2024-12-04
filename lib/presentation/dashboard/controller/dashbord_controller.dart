import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../NotificationServices/PushNotificationService.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../models/BannerDetail.dart';
import '../models/dashboard_model.dart';

/// A controller class for the FormScreen.
///
/// This class manages the state of the FormScreen, including the
/// current formModelObj
class DashboardController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxString schoolImageUrl = "".obs;
  RxList<BannerDetails> bannerDetails = <BannerDetails>[].obs;
  loadChildList(context) async {
    List<dynamic> childNameList = [];
    List<dynamic> childIdList = [];
    List<dynamic> childImageList = [];
    List<dynamic> childClassList = [];
    List<dynamic> childImagefoundList = [];
    List<dynamic> childSessionIDList = [];
    List<dynamic> childClassIdList = [];
    List<dynamic> childSectionIdList = [];
    loadArray("childIdList");
    var n = await loadArray("childNameList");
    childNameList = n!;
    var i = await loadArray("childIdList");
    childIdList = i!;
    var img = await loadArray("childImageList");
    childImageList = img!;
    var cls = await loadArray("childClassList");
    childClassList = cls!;
    var imgNot = await loadArray("childImagefoundList");
    childImagefoundList = imgNot!;

    var sess = await loadArray("childSessionIDList");
    childSessionIDList = sess!;

    var clid = await loadArray("childClassIdList");
    childClassIdList = clid!;

    var secid = await loadArray("childSectionIdList");
    childSectionIdList = secid!;
    print(childNameList);

    showChildList(
        context,
        childNameList,
        childIdList,
        childImageList,
        childClassList,
        childImagefoundList,
        childSessionIDList,
        childClassIdList,
        childSectionIdList);
  }

  onSelectChildStudent(
      student_id, classNameSection, name, sessionId, classId, sectionId) {
    UserData usersData = UserData();
    usersData.addUserIsLoggedIn(true);
    usersData.addUserHasMultipleChild(true);
    usersData.addUserStudentId(student_id);
    usersData.addUserClassSection(classNameSection);
    usersData.addUserStudentName(name);
    usersData.addUserStudentClassId(classId);
    usersData.addUserStudentSectionId(sectionId);
    usersData.addStudent_session_id(sessionId.toString());

    ///navigate here to dashboard
    print('one child found:::::::::');
    usersData.saveAllDataToSharedPreferences();
    Get.toNamed(AppRoutes.sScreen);
  }

  void showChildList(
    BuildContext context,
    List<dynamic> childNameList,
    List<dynamic> childIdList,
    List<dynamic> childImageList,
    List<dynamic> childClassList,
    List<dynamic> childImagefoundList,
    List<dynamic> childSessionIDList,
    List<dynamic> childClassIdList,
    List<dynamic> childSectionIdList,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double itemHeight = 100.0; // Set a fixed height for each item
            final double bottomSheetHeight = (childNameList.length *
                    itemHeight) +
                kBottomNavigationBarHeight; // Calculate the total height of the bottom sheet
            return SizedBox(
              height: bottomSheetHeight,
              child: ListView.builder(
                itemCount: childNameList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          onSelectChildStudent(
                              childIdList[index],
                              childClassList[index],
                              childNameList[index],
                              childSessionIDList[index],
                              childClassIdList[index],
                              childSectionIdList[index]);
                        },
                        child: ListTile(
                          leading: childImagefoundList[index] != false
                              ? CircleAvatar(
                                  radius: itemHeight / 4,
                                  backgroundImage:
                                      NetworkImage(childImageList[index]))
                              : CircleAvatar(
                                  radius: itemHeight / 4,
                                  backgroundImage: AssetImage(
                                    'assets/projectImages/placeholder_user.png',
                                  ),
                                ),
                          title: Text(childNameList[index]),
                          subtitle: Text(childClassList[index]),
                        ),
                      )
                      // Add more ListTiles for more children
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<List<dynamic>?> loadArray(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString(name);
    return encodedData == null
        ? null
        : List<dynamic>.from(
            json.decode(encodedData)); // Decode JSON string to a List
  }

  Widget customContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(
              3.0,
              5.0,
            ),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Loading',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey.shade600),
            )
          ],
        ),
      ),
    );
  }

  RxList eLearningData = [].obs;
  List<ModuleList> get getElearningList =>
      List<ModuleList>.from(eLearningData.map((e) => ModuleList.fromJson(e)));
  set updateELearningData(List val) {
    // gridViewWidgets.removeAt(0);
    eLearningData.value = val;
    update();
  }

  RxList academicData = [].obs;
  List<ModuleList> get getAcademicList =>
      List<ModuleList>.from(academicData.map((e) => ModuleList.fromJson(e)));
  set updateAcademicData(List val) {
    // gridViewWidgets.removeAt(0);
    academicData.value = val;
    update();
  }

  RxList communicationData = [].obs;
  List<ModuleList> get getCommunicationList => List<ModuleList>.from(
      communicationData.map((e) => ModuleList.fromJson(e)));
  set updateCommunicationData(List val) {
    // gridViewWidgets.removeAt(0);
    communicationData.value = val;
    update();
  }

  RxList otherData = [].obs;
  List<ModuleList> get getOtherDataList =>
      List<ModuleList>.from(otherData.map((e) => ModuleList.fromJson(e)));
  set updateOtherData(List val) {
    // gridViewWidgets.removeAt(0);
    otherData.value = val;
    update();
  }

  List eLearningImagesPath = [
    "ic_briefcase.png",
    "ic_dashboard_homework.png",
    "ic_assignment.png",
    "ic_lessonplan.png",
    "ic_onlineexam.png",
    "ic_downloadcenter.png",
  ];

  List academicImages = [
    "ic_lessonplan.png",
    "ic_calender_cross.png",
    "ic_nav_attendance.png",
    "ic_nav_reportcard.png",
    "ic_nav_timeline.png",
    "ic_documents_certificate.png",
    "ic_dashboard_homework.png",
    "ic_nav_reportcard.png",
  ];

  List communicationImages = [
    "ic_notice.png",
    "ic_lock_filled.png",
    "ic_notice.png",
    "ic_leave.png",
  ];

  List otherImages = [
    "ic_nav_fees.png",
    "ic_visitors.png",
    "ic_nav_transport.png",
    "ic_nav_hostel.png",
    "ic_library.png",
    "ic_dashboard_pandingtask.png",
    "ic_events.png",
  ];

  List gridViewWidgets = <Widget>[];

  ScrollController? scrollController;
  Color textColor = Colors.white;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateSchoolInfo();
    eLearningapi();
    gridViewWidgets.add(customContainer());
    gridViewWidgets.add(customContainer());
    gridViewWidgets.add(customContainer());
    gridViewWidgets.add(customContainer());
    // TODO: implement initState
    scrollController = ScrollController()
      ..addListener(() {
        textColor = isSliverAppBarExpanded ? Colors.white : Colors.blue;
        update();
      });

    updateDeviceToken();
    // eLearningapi();
    checkCacheAndFetchData();
    printSharedPreferencesData();
  }

  updateSchoolInfo() async {
    print("PPPPP");
    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId.toString(),
    };
    var data = await apiRespository.postApiCallByJson(
        "webservice/getDashboardBannerDetails", body);


    log("UPDATE STUDENT INFO DATA ${data.body}");
    ThemeHelper().setAndChangeThemeThroughSharedPref(data);
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    List<dynamic> bannerDetailsRaw = data.body['school_details']["display_events"];

    for(var i=0;i<bannerDetailsRaw.length;i++)
      {
        bannerDetails.add(BannerDetails.fromJson(bannerDetailsRaw[i]));
      }
    if(bannerDetails.length > 0)
      {
        showResponsiveImageDialog(bannerDetails.value);
      }

    schoolImageUrl.value = (data.body['school_details']["image"] == null ||
            data.body['school_details']["image"] == null)
        ? ""
        : baseUrlFromPref +
            "uploads/school_content/logo/app_logo/" +
            data.body['school_details']["image"];
    print("WWWWWWWWW${schoolImageUrl.value}");
    update();
  }

  final PushNotificationService _notificationService =
      PushNotificationService();
  updateDeviceToken() async {
    print("PPPPP");
    String? deToken = await _notificationService.initialize();

    Map<String, dynamic> body = {
      "deviceToken": deToken,
      "userId": userData.getUserId,
      "role": userData.getRole,
    };
    print(body);
    var data =
        apiRespository.postApiCallByJson("webservice/updateDeviceToken", body);
  }

  bool get isSliverAppBarExpanded {
    return scrollController!.hasClients &&
        scrollController!.offset > (200 - kToolbarHeight);
  }

  /// Section Widget
  Widget buildGridItem(String heading, List<ModuleList> items, List images) {
    return Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(
                3.0,
                5.0,
              ),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          borderRadius:
              BorderRadius.circular(10)), // Add padding around the grid
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${heading}",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey.shade800),
          ),
          GridView.builder(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of items per row
                crossAxisSpacing: 8.0, // Horizontal space between cells
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2 // Vertical space between cells
                ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              ModuleList data = items[index];
              return InkWell(
                onTap: () {
                  print("========${data.shortCode.toString()}");
                  Get.toNamed("/" + data.shortCode.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/projectImages/" + images[index].toString(),
                        height: 25,
                        color: theme.primaryColorDark,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${data.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    userData.userData.erase();
    logoutAPI();

    Navigator.of(context).pop(); // Close the dialog

    Get.offAllNamed(AppRoutes.initialRoute);
  }

  Future<void> printSharedPreferencesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('eLearningData')) {
      String? eLearningDataStr = prefs.getString('eLearningData');
      var eLearningDataJson = jsonDecode(eLearningDataStr!);
      print('eLearning Data: $eLearningDataJson');
    } else {
      print('eLearning Data not found in SharedPreferences.');
    }

    if (prefs.containsKey('academicData')) {
      String? academicDataStr = prefs.getString('academicData');
      var academicDataJson = jsonDecode(academicDataStr!);
      print('Academic Data: $academicDataJson');
    } else {
      print('Academic Data not found in SharedPreferences.');
    }

    if (prefs.containsKey('communicationData')) {
      String? communicationDataStr = prefs.getString('communicationData');
      var communicationDataJson = jsonDecode(communicationDataStr!);
      print('Communication Data: $communicationDataJson');
    } else {
      print('Communication Data not found in SharedPreferences.');
    }

    if (prefs.containsKey('otherData')) {
      String? otherDataStr = prefs.getString('otherData');
      var otherDataJson = jsonDecode(otherDataStr!);
      print('Other Data: $otherDataJson');
    } else {
      print('Other Data not found in SharedPreferences.');
    }
  }

  Future<void> checkCacheAndFetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('eLearningData')) {
      eLearningData.value = jsonDecode(prefs.getString('eLearningData')!);

      academicData.value = jsonDecode(prefs.getString('academicData')!);
      communicationData.value =
          jsonDecode(prefs.getString('communicationData')!);
      otherData.value = jsonDecode(prefs.getString('otherData')!);
      buildGridViewData("E Learning", getElearningList, eLearningImagesPath, 0);
      buildGridViewData("Academics", getAcademicList, academicImages, 1);
      buildGridViewData(
          "Communicate", getCommunicationList, communicationImages, 2);
      buildGridViewData("Other ", getOtherDataList, otherImages, 3);
      isLoading.value = false;
      await fetchFreshData(false);
      print("Loaded from shared pref");
    } else {
      isLoading.value = true;
      print("Loaded from Live");
      await fetchFreshData(true);
    }
  }

  Future<void> saveDataToCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('eLearningData', jsonEncode(eLearningData));
    await prefs.setString('academicData', jsonEncode(academicData));
    await prefs.setString('communicationData', jsonEncode(communicationData));
    await prefs.setString('otherData', jsonEncode(otherData));
  }

  Future<bool> fetchDataFromAPI(bool isBackground) async {
    await eLearningapi();
    await academicStatusApi();
    await communicationStatusApi();
    await otherModuleApi();
    await saveDataToCache();
    return true;
  }

  Future<void> fetchFreshData(bool isBackground) async {
    final freshData = await fetchDataFromAPI(isBackground);
    if (freshData) {
      isLoading.value = false;
    }
  }

  getSchoolDetails() async {
    Map<String, dynamic> body = {};
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    var data = await apiRespository.postApiCallByJson(
        "webservice/getSchoolDetails", body);
    final prefs = await SharedPreferences.getInstance();
    print("###################${data.body}");
    await prefs.setString("schoolName", data.body["name"] ?? "");
    await prefs.setString("schoolAddress", data.body["address"] ?? "");
    await prefs.setString("schoolPhone", data.body["phone"] ?? "");
    await prefs.setString("schoolEmail", data.body["email"] ?? "");
    await prefs.setString("schoolSchoolCode", data.body["dise_code"] ?? "");
    await prefs.setString("schoolCurrentSession", data.body["session"] ?? "");
    await prefs.setString(
        "schoolStartMonth", data.body["start_month_name"] ?? "");
    await prefs.setString(
        "schoolStartMonthNumber", data.body["start_month"] ?? "");
    await prefs.setString("schoolImage", data.body["image"] ?? "");
    schoolImageUrl.value =
        (data.body["image"] == null || data.body["image"] == null)
            ? ""
            : baseUrlFromPref +
                "uploads/school_content/logo/app_logo/" +
                data.body["image"];
    update();
    print("+++++++++++++++++++++${schoolImageUrl.value}");
  }

  eLearningapi() async {
    // getSchoolDetails();
    Map<String, dynamic> body = {
      "user": "student",
    };
    var data = await apiRespository.postApiCallByJson(
        "webservice/getELearningModuleStatus", body);
    var data1 = await data.body['module_list'];
    updateELearningData =
        data1.where((item) => item['status'].toString() == "1").toList();
    // gridViewWidgets.add(
    //     buildGridItem("E Learning", getElearningList, eLearningImagesPath));
    // // academicStatusApi();
    // update();
    print("E LEARNING DATA ${getElearningList[0].name}");
    buildGridViewData("E Learning", getElearningList, eLearningImagesPath, 0);
  }

  buildGridViewData(String title, List<ModuleList> moduleList,
      List<dynamic> imagePath, int index) {
    // Ensure gridViewWidgets has enough elements up to the requested index
    if (gridViewWidgets.length <= index) {
      // If the list isn't long enough, add placeholders up to the index
      gridViewWidgets.addAll(List.generate(
          index - gridViewWidgets.length + 1, (i) => customContainer()));
    }

    // Assign the data to the specific index
    gridViewWidgets[index] = buildGridItem(title, moduleList, imagePath);

    // Update UI or state
    update();
  }

  buildGridViewData2(String title, List<ModuleList> moduleList,
      List<dynamic> imagePath, int index) {
    gridViewWidgets[index] = buildGridItem(title, moduleList, imagePath);
    update();
    // if (gridViewWidgets.length <= index) {
    //   // If the index does not exist, add placeholders up to the required index
    //   gridViewWidgets.add(customContainer());
    //  // gridViewWidgets.addAll(List.generate(index - gridViewWidgets.length + 1, (i) => customContainer()));
    //   gridViewWidgets[index] = buildGridItem(title, moduleList, imagePath);
    //   update();
    // }

    // gridViewWidgets.add(
    //     buildGridItem(title, moduleList, imagePath));
    // academicStatusApi();
  }

  academicStatusApi() async {
    Map<String, dynamic> body = {
      "user": "student",
    };
    var data = await apiRespository.postApiCallByJson(
        "webservice/getAcademicsModuleStatus", body);
    // updateAcademicData = data.body['module_list'].where((item) => item['status'] == 1).toList();
    var data1 = await data.body['module_list'];
    print(data1);
    updateAcademicData =
        data1.where((item) => item['status'].toString() == "1").toList();
    // gridViewWidgets
    //     .add(buildGridItem("Academics", getAcademicList, academicImages));
    // // communicationStatusApi();
    // update();
    print("ACADEMIC DATA ${getAcademicList[0].name}");
    buildGridViewData("Academics", getAcademicList, academicImages, 1);
  }

  communicationStatusApi() async {
    Map<String, dynamic> body = {
      "user": "student",
    };
    var data = await apiRespository.postApiCallByJson(
        "webservice/getCommunicateModuleStatus", body);
    // updateCommunicationData = data.body['module_list'].where((item) => item['status'] == 1).toList();
    var data1 = await data.body['module_list'];
    updateCommunicationData =
        data1.where((item) => item['status'].toString() == "1").toList();
    // gridViewWidgets.add(buildGridItem(
    //     "Communicate", getCommunicationList, communicationImages));
    // // otherModuleApi();
    // update();
    print("COMMUNICATION STATUS DATA ${getCommunicationList[0].name}");
    buildGridViewData(
        "Communicate", getCommunicationList, communicationImages, 2);
  }

  otherModuleApi() async {
    Map<String, dynamic> body = {
      "user": "student",
    };
    var data = await apiRespository.postApiCallByJson(
        "webservice/getOthersModuleStatus", body);
    // updateOtherData = data.body['module_list'].where((item) => item['status'] == 1).toList();
    var data1 = await data.body['module_list'];
    updateOtherData =
        data1.where((item) => item['status'].toString() == "1").toList();
    // gridViewWidgets.add(buildGridItem("Other ", getOtherDataList, otherImages));
    //
    // update();
    print("OTHER MODULE DATA ${getOtherDataList[0].name}");
    buildGridViewData("Other ", getOtherDataList, otherImages, 3);
  }

  Future<bool> logoutAPI() async {
    String? deToken = await _notificationService.getToken();
    String deviceToken = deToken!;
    Map<String, dynamic> body = {"deviceToken": deviceToken};

    print("Logout Request Body: $body");

    var response =
        await apiRespository.postApiCallByJson(Constants.logout, body);

    print("Logout Response: ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      print("Logout failed: ${response.body}");
      return false;
    }
  }

  Future<void> logOutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing on tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
          title: Text(
            'Logout',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black, // Use a consistent color
            ),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[800], // Darker grey for better contrast
            ),
          ),
          actions: <Widget>[
            // Cancel Button
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              child: Text(
                'Cancel',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white, // White text for contrast
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            SizedBox(width: 8), // Space between buttons
            // Logout Button
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              child: Text(
                'Logout',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white, // White text for contrast
                ),
              ),
              onPressed: () async {
                await logout(context); // Await logout action if it's a Future
              },
            ),
          ],
        );
      },
    );
  }
}

void showResponsiveImageDialog(List<BannerDetails> mediaItems) {
  PageController _pageController = PageController();
  Timer? _autoScrollTimer;

  void startAutoScroll() {
    _autoScrollTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage >= mediaItems.length) {
          nextPage = 0; // Loop back to the first item
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double dialogWidth = MediaQuery.of(context).size.width * 0.85;
          double dialogHeight = MediaQuery.of(context).size.height * 0.45;

          return StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                children: [
                  // PageView with automatic scrolling
                  Container(
                    width: dialogWidth,
                    height: dialogHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: mediaItems.length,
                      onPageChanged: (index) {
                        // Optional: Update UI or perform actions on page change
                      },
                      itemBuilder: (context, index) {
                        final item = mediaItems[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title Section
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                item.title ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            ),

                            // Image Section
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                item.featureImage ?? '',
                                fit: BoxFit.contain,
                                //width: double.infinity,
                                // height: double.infinity,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  "assets/projectImages/no_data.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // HTML Description Section
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Html(
                                data: item.description ?? '',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(13.0),
                                    color: Colors.black,
                                  ),
                                  "h1": Style(
                                    fontSize: FontSize(12.0),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                  "h2": Style(
                                    fontSize: FontSize(12.0),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal.shade700,
                                  ),
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Close Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        stopAutoScroll(); // Stop auto-scroll when dialog is closed
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 16,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  ).then((_) => stopAutoScroll()); // Ensure auto-scroll stops when dialog is closed

  startAutoScroll();
}





