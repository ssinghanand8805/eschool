import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../models/dashboard_model.dart';

/// A controller class for the FormScreen.
///
/// This class manages the state of the FormScreen, including the
/// current formModelObj
class DashboardController extends GetxController {

  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxString schoolImageUrl = "".obs;

  Widget customContainer(){
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
            SizedBox(height: 10,),
            Text('Loading',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey.shade600
            ),)
          ],
        ),
      ),
    );
  }

  List eLearningData = [];
  List<ModuleList> get getElearningList => List<ModuleList>.from(eLearningData.map((e) => ModuleList.fromJson(e)));
  set updateELearningData(List val){
    gridViewWidgets.removeAt(0);
    eLearningData = val;
    update();
  }


  List academicData = [];
  List<ModuleList> get getAcademicList => List<ModuleList>.from(academicData.map((e) => ModuleList.fromJson(e)));
  set updateAcademicData(List val){
    gridViewWidgets.removeAt(0);
    academicData = val;
    update();
  }


  List communicationData = [];
  List<ModuleList> get getCommunicationList => List<ModuleList>.from(communicationData.map((e) => ModuleList.fromJson(e)));
  set updateCommunicationData(List val){
    gridViewWidgets.removeAt(0);
    communicationData = val;
    update();
  }


  List otherData = [];
  List<ModuleList> get getOtherDataList => List<ModuleList>.from(otherData.map((e) => ModuleList.fromJson(e)));
  set updateOtherData(List val){
    gridViewWidgets.removeAt(0);
    otherData = val;
    update();
  }

  List eLearningImagesPath = [
    "ic_dashboard_homework.png",
    "ic_assignment.png",
    "ic_lessonplan.png",
    "ic_onlineexam.png",
    "ic_downloadcenter.png",
    "ic_onlinecourse.png",
    "ic_videocam.png",
    "ic_videocam.png",
  ];

  List academicImages =[
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
    "ic_notification.png"
  ];

  List otherImages = [
   "ic_nav_fees.png",
    "ic_leave.png",
   "ic_visitors.png",
    "ic_nav_transport.png",
    "ic_nav_hostel.png",
    "ic_dashboard_pandingtask.png",
    "ic_library.png",
    "ic_teacher.png"
  ];

  List gridViewWidgets = <Widget>[];

   ScrollController?scrollController;
  Color textColor = Colors.white;

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
      gridViewWidgets.add(customContainer());
      gridViewWidgets.add(customContainer());
      gridViewWidgets.add(customContainer());
      gridViewWidgets.add(customContainer());
    eLearningapi();
  }

  bool get isSliverAppBarExpanded {
    return scrollController!.hasClients &&
        scrollController!.offset > (200 - kToolbarHeight);
  }


  /// Section Widget
  Widget buildGridItem(String heading,List<ModuleList> items, List images) {

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
        borderRadius: BorderRadius.circular(10)
      ),// Add padding around the grid
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${heading}",
            textAlign: TextAlign.start,
            style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey.shade800
          ),),
          GridView.builder(
            padding: EdgeInsets.fromLTRB(0, 15,0,0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // Creates a grid with 2 rows, adjust `crossAxisCount` for more columns
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of items per row
              crossAxisSpacing: 8.0, // Horizontal space between cells
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.2// Vertical space between cells
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              ModuleList data = items[index];
              return InkWell(
                onTap: (){
                  print("========${data.shortCode.toString()}");
Get.toNamed("/"+data.shortCode.toString());
                },
                child: Container(
                  decoration: BoxDecoration(// Change this to your preferred color
                    borderRadius: BorderRadius.circular(8), // Optional rounded corners
                  ),
                  child: Column(
                    children: [
                      Image.asset("assets/projectImages/"+images[index].toString(),height: 25,color: Colors.indigo,),
                      SizedBox(height: 10,),
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
logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Get.toNamed('/s_screen');
}

getSchoolDetails() async {
  Map<String,dynamic> body = {
  };
  var data  = await apiRespository.postApiCallByJson("webservice/getSchoolDetails", body);
  final prefs = await SharedPreferences.getInstance();
  print("###################${data.body}");
  await  prefs.setString("schoolName",data.body["name"] ?? "");
  await  prefs.setString("schoolAddress",data.body["address"] ?? "");
  await  prefs.setString("schoolPhone",data.body["phone"] ?? "");
  await  prefs.setString("schoolEmail",data.body["email"] ?? "");
  await prefs.setString("schoolSchoolCode",data.body["dise_code"] ?? "");
  await  prefs.setString("schoolCurrentSession",data.body["session"] ?? "");
  await prefs.setString("schoolStartMonth",data.body["start_month_name"] ?? "");
  await  prefs.setString("schoolStartMonthNumber",data.body["start_month"] ?? "");
  await  prefs.setString("schoolImage",data.body["image"] ?? "");
  schoolImageUrl.value = (data.body["image"] == null || data.body["image"] == null) ? "" : Constants.imagesUrl + "uploads/school_content/logo/app_logo/" + data.body["image"];
  update();
  print("+++++++++++++++++++++${schoolImageUrl.value}");
}
  eLearningapi()async{
    getSchoolDetails();
    Map<String,dynamic> body = {
      "user" : "student",
    };
    var data  = await apiRespository.postApiCallByJson("webservice/getELearningModuleStatus", body);
    var data1 = await data.body['module_list'];
    updateELearningData = data1.where((item) => item['status'].toString() == "1").toList();
    gridViewWidgets.add(buildGridItem("E Learning", getElearningList,eLearningImagesPath));
    academicStatusApi();
    update();
    print("E LEARNING DATA ${getElearningList[0].name}");
  }

  academicStatusApi()async{
    Map<String,dynamic> body = {
      "user" : "student",
    };
    var data  = await apiRespository.postApiCallByJson("webservice/getAcademicsModuleStatus", body);
    // updateAcademicData = data.body['module_list'].where((item) => item['status'] == 1).toList();
    var data1 = await data.body['module_list'];
    print(data1);
    updateAcademicData = data1.where((item) => item['status'].toString() == "1").toList();
    gridViewWidgets.add(buildGridItem("Academics", getAcademicList,academicImages));
    communicationStatusApi();
    update();
    print("ACADEMIC DATA ${getAcademicList[0].name}");

  }

  communicationStatusApi()async{
    Map<String,dynamic> body = {
      "user" : "student",
    };
    var data  = await apiRespository.postApiCallByJson("webservice/getCommunicateModuleStatus", body);
    // updateCommunicationData = data.body['module_list'].where((item) => item['status'] == 1).toList();
    var data1 = await data.body['module_list'];
    updateCommunicationData = data1.where((item) => item['status'].toString() == "1").toList();
    gridViewWidgets.add(buildGridItem("Communicate", getCommunicationList,communicationImages));
    otherModuleApi();
    update();
    print("COMMUNICATION STATUS DATA ${getCommunicationList[0].name}");
  }

  otherModuleApi()async{
    Map<String,dynamic> body = {
      "user" : "student",
    };
    var data  = await apiRespository.postApiCallByJson("webservice/getOthersModuleStatus", body);
    // updateOtherData = data.body['module_list'].where((item) => item['status'] == 1).toList();
    var data1 = await data.body['module_list'];
    updateOtherData = data1.where((item) => item['status'].toString() == "1").toList();
    gridViewWidgets.add(buildGridItem("Other ",getOtherDataList,otherImages));

    update();
    print("OTHER MODULE DATA ${getOtherDataList[0].name}");
  }


}
