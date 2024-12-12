import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/ChatNotificationService.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/SocketService.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../../login_screen/models/ChatUser.dart';
import '../../login_screen/models/Faculity.dart';
import '../models/Menus.dart';

/// A controller class for the FormScreen.
///
/// This class manages the state of the FormScreen, including the
/// current formModelObj
class DashboardController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxString schoolImageUrl = "".obs;
  RxList<MenuResponse> menuResponseModelObj = <MenuResponse>[].obs;
  // List<Response> filteredResponses =
  loadChildList(context) async {
    List<dynamic> childNameList = [];
    List<dynamic> childIdList = [];
    List<dynamic> childImageList = [];
    List<dynamic> childClassList = [];
    List<dynamic> childImagefoundList = [];
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
    print(childNameList);

    showChildList(context, childNameList, childIdList, childImageList,
        childClassList, childImagefoundList);
  }

  onSelectChildStudent(student_id, classNameSection, name) {
    UserData usersData = UserData();
    usersData.addUserIsLoggedIn(true);
    usersData.addUserHasMultipleChild(true);
    usersData.addUserStudentId(student_id);
    usersData.addUserClassSection(classNameSection);
    usersData.addUserStudentName(name);

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
                          onSelectChildStudent(childIdList[index],
                              childClassList[index], childNameList[index]);
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

  List menuData = [];
  List<MenuResponse> get getMenuDataList => menuResponseModelObj
      .value; //List<MenuResponse>.from(menuData.map((e) => MenuResponse.fromJson(e)));
  set updateELearningData(List val) {
    gridViewWidgets.removeAt(0);
    menuData = val;
    update();
  }

  List menuImageImagesPath = [
    "ic_dashboard_homework.png",
    "ic_assignment.png",
    "ic_lessonplan.png",
    "ic_onlineexam.png",
    "ic_downloadcenter.png",
    "ic_onlinecourse.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
    "ic_onlineexam.png",
  ];

  List gridViewWidgets = <Widget>[];

  ScrollController? scrollController;
  Color textColor = Colors.white;
  late Future<void> fetchDataFuture;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // TODO: implement initState
    scrollController = ScrollController()
      ..addListener(() {
        textColor = isSliverAppBarExpanded ? Colors.white : Colors.blue;
        update();
      });
    fetchDataFuture = eLearningapi();
    gridViewWidgets.add(customContainer());
    // gridViewWidgets.add(customContainer());
    // gridViewWidgets.add(customContainer());
    // gridViewWidgets.add(customContainer());
    // eLearningapi();
  }

  bool get isSliverAppBarExpanded {
    return scrollController!.hasClients &&
        scrollController!.offset > (200 - kToolbarHeight);
  }

  /// Section Widget
  Widget buildGridItem(String heading, List<MenuResponse> items, List images) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            // Creates a grid with 2 rows, adjust `crossAxisCount` for more columns
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of items per row
                crossAxisSpacing: 8.0, // Horizontal space between cells
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2 // Vertical space between cells
                ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              MenuResponse data = items[index];
              return InkWell(
                onTap: () {
                  print("========${data.shortCode.toString()}");
// Get.toNamed("/"+data.shortCode.toString());
                  showDynamicBottomSheet(context,
                      data: data.permissionCategory!, images: images);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // Change this to your preferred color
                    borderRadius:
                        BorderRadius.circular(8), // Optional rounded corners
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/projectImages/" + images[index].toString(),
                        height: 25,
                        color: Colors.indigo,
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

  void showDynamicBottomSheet(BuildContext context,
      {required List<PermissionCategory> data, required List<dynamic> images}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Adjust number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 2, // Adjust tile height
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GridTile(
                child: InkWell(
                  onTap: () {
                    print(data[index].shortCode.toString());
                    String routeName = "/" + data[index].shortCode.toString();

                    // Check if the route exists (you can manually keep track of the available routes)
                    if (Navigator.of(context).canPop() || ModalRoute.of(context)?.settings.name != routeName) {
                      // Navigate to the route if it doesn't already exist
                      Navigator.pushNamed(context, "/commingsoon");
                    } else {
                      // Optionally handle case when route already exists, e.g., show a message
                      Navigator.pushNamed( context,"/" + data[index].shortCode.toString());
                    }

                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/projectImages/" + images[index].toString(),
                          height: 25,
                          color: Colors.indigo,
                        ),
                        SizedBox(height: 8),
                        Text(
                          data[index].name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                           overflow: TextOverflow.ellipsis,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    String vUrl = prefs.getString('schoolBaseUrl')!;
    prefs.clear();
    prefs.setString('schoolBaseUrl', vUrl);
    Get.toNamed('/s_screen');
  }

  getSchoolDetails() async {
    Map<String, dynamic> body = {};
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    var data = await apiRespository.postApiCallByJsonForLogin(
        "webservice/getSchoolDetails", body);

    final prefs = await SharedPreferences.getInstance();
    print("###################${data.body}");
    await prefs.setString("schoolName", data.body["name"] ?? "");
    await prefs.setString("schoolAddress", data.body["address"] ?? "");
    await prefs.setString("schoolPhone", data.body["phone"] ?? "");
    await prefs.setString("schoolEmail", data.body["email"] ?? "");
    await prefs.setString("schoolSchoolCode", data.body["dise_code"] ?? "");
    await prefs.setString("schoolCurrentSession", data.body["session"] ?? "");
    await prefs.setString("date_format", data.body["date_format"] ?? "");
    await prefs.setString("timezone", data.body["timezone"] ?? "");
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
    getSchoolDetails();  //check for school details change

    UserData usersData = UserData();
    Faculity? f = await usersData.getFaculity();
    Map<String, dynamic> body = {
      "roleId": f!.roles!.roleId.toString(),
    };


    print("))))))))))))))${f.chatAccessToken}");
    var data = await apiRespository.postApiCallByJson(
        Constants.findPermissionsUrl, body);
    Menus menus = Menus.fromJson(data.body);

    List<MenuResponse>? filteredResponses;
    if (f!.roles!.roleId.toString() == "7") {
      print("***********");
      filteredResponses = menus.response;
      var e  = await menus.setResponsesWhereCanView(isSuperAdmin : true);
      var per = jsonEncode(e);
      final prefs = await SharedPreferences.getInstance();
       await prefs.setString('pagePermission',per);
    } else {
      filteredResponses = menus.getResponsesWhereCanView();
      var e  = await menus.setResponsesWhereCanView();
      var per = jsonEncode(e);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pagePermission',per);
    }
    menuResponseModelObj.value = filteredResponses!;
    // update();
    //print(filteredResponses);
    final prefs = await SharedPreferences.getInstance();
    var per = prefs.getString('pagePermission');
    List permArr = jsonDecode(per!);
    permArr.forEach((element) {print(element);});
    updateELearningData = filteredResponses.toList();
    gridViewWidgets
        .add(buildGridItem("", getMenuDataList, menuImageImagesPath));
    // academicStatusApi();
    update();
    print("E LEARNING DATA ${getMenuDataList.length}");
  }

  Future<void> logOutDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            'Logout',
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 19),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: theme.textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green.shade300,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              child: Text(
                'Cancel',
                style: theme.textTheme.bodyMedium,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red.shade200,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: theme.textTheme.bodyMedium,
                ),
                onPressed: () async {
                  logout();
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
          ],
        );
      },
    );
  }



  RxList FAB = [
    {
      'name':"Term"
    },
    {
      'name':"Assessment"
    },
    {
      'name':"Grade"
    },
    {
      'name':"Exam"
    },
    {
      'name':"Exam Schedule"
    },
  ].obs;




}
