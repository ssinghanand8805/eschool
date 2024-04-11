import 'package:learnladder/core/app_export.dart';
import 'package:learnladder/presentation/homework/controller/homework_controller.dart';
import 'package:learnladder/presentation/homework/model/Homework.dart';
import 'package:flutter/material.dart';



class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
HomeWorkController controller = Get.put(HomeWorkController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(onTabChanged);
    getSubjects();
  }

  void getSubjects()
  {

    controller.getSubjects(context);
    controller.getData(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(onTabChanged);
    super.dispose();
  }
  void onTabChanged() {
    // Your code here
    if (!_tabController.indexIsChanging) {
      // Your code here
      print('Tab changed to: ${_tabController.index}');
      // controller.homeworkModelObj.value.homeworklist = [];
     // controller.currentSelectedSubejectId.value =  1;
      controller.status.value =  _tabController.index == 0 ? 'pending' :  _tabController.index == 1 ? 'submitted' : 'evaluated';
      controller.getData(context);
      print('#############: ${controller.homeworkModelObj.value.homeworklist}');
     // controller.update();
    }
    else
      {
        controller.homeworkModelObj.value.homeworklist = [];
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homework'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Submitted'),
            Tab(text: 'Evaluated'),
            Tab(text: 'All'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeworkTabContent(status: 'Pending'),
          HomeworkTabContent(status: 'Submitted'),
          HomeworkTabContent(status: 'Evaluated'),
          HomeworkTabContent(status: 'All'),
        ],
      ),
    );
  }
}

class HomeworkTabContent extends GetWidget<HomeWorkController> {
  final String status;

  const HomeworkTabContent({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_){
        return ListView.builder(
          itemCount: controller.homeworkModelObj.value.homeworklist?.length, // Replace with actual count
          itemBuilder: (context, index) {
            return HomeworkCard(status: status,homework: controller.homeworkModelObj.value.homeworklist![index],);
          },
        );
      },
    );
  }
}

class HomeworkCard extends GetView<HomeWorkController> {
  final String status;
  final Homeworklist homework;

  const HomeworkCard({Key? key, required this.status,required this.homework}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(

                  "${homework.subjectName.toString()} (${homework.subjectCode.toString()})",
                  //'{homework.} (Code)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                statusButton(status),
                submitButton(context),
              ],
            ),
            Divider(),
            InfoRow(title: 'Homework Date', value: homework.homeworkDate.toString()),
            InfoRow(title: 'Submission Date', value: homework.submitDate.toString()),
            InfoRow(title: 'Created By', value: '${homework.createdByName.toString()} (${homework.createdByEmployeeId.toString()})'),
            InfoRow(title: 'Evaluated By', value: '${homework.evaluatedBy.toString()}'),
            InfoRow(title: 'Evaluation Date', value: '${homework.evaluationDate.toString()}'),
            InfoRow(title: 'Max Marks', value: '${homework.marks.toString()}'),
            InfoRow(title: 'Marks Obtained', value: '${homework.evaluationMarks.toString()}'),
            Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Please submit homework before last date.' ),

          ],
        ),
      ),
    );
  }

  Widget statusButton(String status) {
    Color color;
    switch (status) {
      case 'Pending':
        color = Colors.red;
        break;
      case 'Submitted':
        color = Colors.orange;
        break;
      case 'Evaluated':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: color),
      onPressed: () {},
      child: Text(status),
    );
  }
  Widget submitButton(context) {


    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.grey),
      onPressed: () {
        Get.toNamed("/sumithomework");

      },
      child: Text("Submit"),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
void showUploadHomeworkPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upload Homework from here!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Documents',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Image.asset('assets/upload_image.png'), // Replace with your asset
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement file selection functionality
                },
                child: Text('Choose File'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement submit functionality
                },
                child: Text('SUBMIT'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50), // Fixed height for button
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
