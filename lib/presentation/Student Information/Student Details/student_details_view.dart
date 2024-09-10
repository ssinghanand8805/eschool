import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Student%20Details/student_details_controller.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/myCustomsd.dart';
import 'DataModal.dart';

class StudentDetailsView extends GetView<StudentDetailsController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Select Criteria',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0,right:8 ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx( () => MyCustomSD(

                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.commonApiController.classListModelMap.value,
                        valFrom: "className",
                        label: 'Class',
                        labelText: 'Class',
                        onChanged: (val) {
                          if(controller.commonApiController.classListModelMap.value.length > 0)
                          {
                            print("5555555555555");

                            controller.commonApiController.selectedClassId.value = val['id'].toString();
                            controller.commonApiController.selectedClassName.value = val['className'].toString();
                            controller.commonApiController.update();
                            controller.commonApiController.getSectionList();
                          }

                        },
                      )),
                    ),

                    SizedBox(width: 10,),

                    Expanded(
                      child: Obx( () => MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.commonApiController.sectionListModelMap.value,
                        valFrom: "section",
                        label: 'Section',
                        labelText: 'Section',
                        onChanged: (val) {
                          print(val);
                          if(controller.commonApiController.sectionListModelMap.value.length > 0)
                          {


                            controller.commonApiController.selectedSectionId.value = val['id'].toString();
                            controller.commonApiController.selectedSectionName.value = val['section'].toString();

                            controller.commonApiController.update();

                          }

                        },
                      )),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MyButton(
                    width: 100,
                    title: 'Search',
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                    color: Colors.green.shade100,
                    onPress: () {
                      controller.studentByClassSection();
                    },
                  ),
                ),

                Obx(() => CustomTextField(
                  controller: controller.searchC.value,
                  hint: "Search by student name, roll number,enrolment number,national Id,local Id etc...",
                  title: "",
                  onChanged: (val){
                    if(val.length > 2){
                      controller.searchStuInfo(val);
                      controller.update();
                    }
                    else if(val.length==0){
                      controller.updateStudentDetailsList = [];
                    }
                  },
                ),),
                SizedBox(height: 10,),


                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.getStudentDetailsList.length,
                    itemBuilder: (context, index) {
                      StudentDetailsDataModal studentData = controller.getStudentDetailsList[index];
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.getStudentDetailsList.isEmpty?Text("No data found!"):Container(
                        height: 150,width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade500)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(1, 4), // Shadow position
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Container(
                                      width: 4,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(5.0)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child: Icon(Icons.person)),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                  child: Text(
                                                    studentData.firstname.toString()+" (${studentData.gender})",
                                                      maxLines: 1,
                                                      style: theme.textTheme.bodySmall,)),

                                              InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text("Admission No.: ",style: theme.textTheme.bodySmall,),
                                                      Text(studentData.admissionNo.toString(),style: theme.textTheme.bodySmall,),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Class: ",
                                                    style: theme.textTheme.bodySmall,),
                                                  Text(
                                                    studentData.classname.toString()+" (${studentData.section})",
                                                    maxLines: 3,
                                                    style: theme.textTheme.bodySmall,),
                                                ],
                                              ),

                                              Row(

                                                children: [
                                                  Text(
                                                    "Roll No.: ",
                                                    style: theme.textTheme.bodySmall,),
                                                  Text(
                                                    studentData.rollNo.toString(),
                                                    maxLines: 3,
                                                    style: theme.textTheme.bodySmall,),
                                                ],
                                              ),


                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(

                                                    children: [
                                                      Text(
                                                        "Father Name: ",
                                                        style: theme.textTheme.bodySmall,),
                                                      Text(
                                                        studentData.fatherName.toString(),
                                                        maxLines: 3,
                                                        style: theme.textTheme.bodySmall,),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        "DOB: ",
                                                        style: theme.textTheme.bodySmall,),
                                                      Text(
                                                        studentData.dob.toString(),
                                                        maxLines: 3,
                                                        style: theme.textTheme.bodySmall,),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: 8,),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(

                                                    children: [
                                                      Text(
                                                        "Guardian Name: ",
                                                        style: theme.textTheme.bodySmall,),
                                                      Text(
                                                       studentData.guardianName.toString(),
                                                        maxLines: 3,
                                                        style: theme.textTheme.bodySmall,),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Guardian Mob.: ",
                                                        style: theme.textTheme.bodySmall,),
                                                      Text(
                                                        studentData.guardianPhone.toString(),
                                                        style: theme.textTheme.bodySmall,),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                          // Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         CircleAvatar(
                          //           backgroundColor: Colors.green.shade100,
                          //           radius: 22,
                          //           child: Icon(Icons.person,),
                          //         ),
                          //         Text("Student Name(01101)",style: theme.textTheme.bodyMedium,),
                          //       ],
                          //     ),
                          //     Row(
                          //       children: [
                          //         Text("Class",style: theme.textTheme.bodySmall),
                          //         Text("class 1(A)",style: theme.textTheme.bodySmall)
                          //       ],
                          //     )
                          //
                          //
                          //   ],
                          // ),
                        ),
                      ),
                    );
                  },),
                )



                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: DataTable(
                //     columnSpacing: Get.width * 0.2,
                //     // dataRowHeight: 100,
                //     columns: const [
                //       DataColumn(label: Text('Admission No')),
                //       DataColumn(label: Text('Student Name')),
                //       DataColumn(label: Text('Roll No.')),
                //       DataColumn(label: Text('Class')),
                //       DataColumn(label: Text('Father Name')),
                //       DataColumn(label: Text('Date of Birth')),
                //       DataColumn(label: Text('Gender')),
                //       DataColumn(label: Text('Category')),
                //       DataColumn(label: Text('Mobile Number')),
                //       DataColumn(label: Text('Action')),
                //     ],
                //     rows: controller.data.asMap().entries.map((entry) {
                //       int index = entry.key;
                //       return DataRow(
                //         cells: [
                //           DataCell(Text(entry.value['studentId'].toString(),
                //               style: theme.textTheme.bodySmall!)),
                //           DataCell(Text("Anand")),
                //           DataCell(Text("A")),
                //           DataCell(Text("A")),
                //           DataCell(Text("A")),
                //           DataCell(Text("A")),
                //           DataCell(Text("A")),
                //           DataCell(Text("A")),
                //           DataCell(Text("A")),
                //           DataCell(
                //             Row(
                //               children: [
                //                 IconButton(
                //                   icon: Icon(Icons.edit, size: 15),
                //                   onPressed: () {
                //                     //editHomework(index);
                //                   },
                //                 ),
                //                 IconButton(
                //                   icon: Icon(Icons.delete, size: 15),
                //                   onPressed: () {
                //                     print("Delete leave");
                //                   },
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       );
                //     }).toList(),
                //   ),
                // ),





              ],
            ),
          );
        }
      ),
    );
  }

}