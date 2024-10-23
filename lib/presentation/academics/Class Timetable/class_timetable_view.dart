
import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import '../../common_filter/CommonFilter.dart';
import '../../common_widgets/CommonCard.dart';
import './class_timetable_modal.dart';
import 'add_class_time_table.dart';
import 'class_timetable_controller.dart';

class ClassTimetableScreen extends StatefulWidget {
  const ClassTimetableScreen({Key? key});

  @override
  State<ClassTimetableScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<ClassTimetableScreen> {
  ClassTimetableController controller = Get.put(ClassTimetableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: Text(
            'Class Time Table',
            style: theme.textTheme.bodyLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddClassTimetable()),);
                }
                ,
                child: Container(
                  height: 28,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade50
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,size: 17,),
                      Text("Add",style: theme.textTheme.titleMedium,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: GetBuilder(
    init: controller,
    builder: (context) {
    return CommonFilter(onTapAction: controller.filterData, widgetMain: MyTable( ),);
    }));




  }

  MyTable()
  {
    return SingleChildScrollView(
      child:  controller.classTimeTableList.value.timetable == null ? SizedBox() : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 10,
            ),
            _buildTimeTableCard(
              title: 'Monday'
             , day:  controller.classTimeTableList.value.timetable!.monday!
            ),
            _buildTimeTableCard(
              title: 'Tuesday',
                day:  controller.classTimeTableList.value.timetable!.tuesday!
            ),
            _buildTimeTableCard(
              title: 'Wednesday',
                 day:  controller.classTimeTableList.value.timetable!.wednesday!
            ),
            _buildTimeTableCard(
              title: 'Thursday',
                 day:  controller.classTimeTableList.value.timetable!.thursday!
            ),
            _buildTimeTableCard(
              title: 'Friday',
                 day:  controller.classTimeTableList.value.timetable!.friday!
            ),
            _buildTimeTableCard(
              title: 'Saturday',
                 day:  controller.classTimeTableList.value.timetable!.saturday!
            ),
            _buildTimeTableCard(
              title: 'Sunday',
                  day:  controller.classTimeTableList.value.timetable!.sunday!
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeTableCard({required String title, required List<Day> day}) {
    return CommonCard(
        title: title,
        newWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: day.length == 0 ? Text("No Data Found"):ListView.builder(shrinkWrap: true,
            itemCount: day.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index) {
              return Card(child: DayCard(day[index]));
            }
          ),
        ));
  }


  Widget DayCard(Day? day)
  {
    return Column(
      children: [
        Row(children: [Icon(Icons.subject,size: 15,), SizedBox(width: 10,),Text("Subject :${day!.subjectName!} (${day.code!})",style: theme.textTheme.titleMedium,),]),
        Row(children: [Icon(Icons.timelapse,size: 15,), SizedBox(width: 10,),Text("${day.timeFrom!} - ${day.timeTo!}",style: theme.textTheme.titleMedium,)]),
        Row(children: [Icon(Icons.person,size: 15,), SizedBox(width: 10,),Text("${day.name!} (${day.id!})",style: theme.textTheme.titleMedium,)]),
        Row(children: [Icon(Icons.meeting_room,size: 15,), SizedBox(width: 10,),Text("Room No.: ${day.roomNo!}",style: theme.textTheme.titleMedium,)]),
      ],
    );
  }
}
