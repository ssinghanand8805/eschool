import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import 'marks_grade_controller.dart';

class MarksGradeView extends GetView<MarksGradeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Grade List',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              prefixIcon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: 'Add',
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addMarksGrade(context);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: CustomTextField(
              controller: controller.searchC.value,
              hint: "Search...",
              title: "",
            ),
          ),
          GradeTable(gradingSystems: parseGradingSystems(controller.gradingSystemsJson)),
        ],
      ),
    );
  }


  addMarksGrade(context){
    AlertDialogue().show(
      context,
      newWidget: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Marks Grade",
              style: theme.textTheme.bodyMedium,
            ),
            MyCustomSD(
                listToSearch: controller.demo,
                borderColor: Colors.grey,
                valFrom: "name",
                label: "Select Exam Type",
                onChanged: (val){

                }),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.gradeNameC.value,
                    hint: "Grade Name",
                    title: "",
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomTextField(
                    controller: controller.percentUpToC.value,
                    hint: "Percent Upto",
                    title: "",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.percentFromC.value,
                    hint: "Percent From ",
                    title: "",
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10,),

                Expanded(
                  child: CustomTextField(
                    controller: controller.gradePointC.value,
                    hint: "Grade Point ",
                    title: "",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            CustomTextField(
              controller: controller.descriptionC.value,
              hint: "Description",
              maxLine: 3,
              title: "",
            ),


            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Save',
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                color: Colors.green.shade100,
                onPress: () {},
              ),
            ),
          ],
        )
      ],
    );
  }


}

class GradeTable extends StatelessWidget {
  final List<GradingSystem> gradingSystems;

  GradeTable({required this.gradingSystems});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: gradingSystems.map((gradingSystem) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('Exam Type')),
                  DataColumn(label: Text('Grade Name')),
                  DataColumn(label: Text('Percent From / Upto')),
                  DataColumn(label: Text('Grade Point')),
                  DataColumn(label: Text('Action')),
                ],
                rows: gradingSystem.grades.map((grade) {
                  return DataRow(cells: [

                    DataCell(Text(gradingSystem.examType,style: theme.textTheme.titleMedium,)),
                    DataCell(Text(grade.gradeName,style: theme.textTheme.titleMedium,)),
                    DataCell(Text(grade.percentRange,style: theme.textTheme.titleMedium,)),
                    DataCell(Text(grade.gradePoint.toString(),style: theme.textTheme.titleMedium,)),
                    DataCell( Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, size: 15),
                          onPressed: () {
                            //editHomework(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, size: 15),
                          onPressed: () {
                            print("Delete leave");
                          },
                        ),
                      ],
                    ),),
                  ]);
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}




