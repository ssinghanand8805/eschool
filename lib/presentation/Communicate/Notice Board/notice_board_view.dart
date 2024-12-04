
import'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_button.dart';
import '../../common_widgets/custom_loader.dart';
import 'notice_board_controller.dart';

class NoticeBoardView extends GetView<NoticeBoardController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Notice Board',
          style: theme.textTheme.bodyMedium,
        ),

      ),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return FutureBuilder(
            future: controller.fetchDataFuture,
            builder: (context,snapshot) {

              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              }
              return controller.nodeiceBoardModel.value.data == null ? Container(child: Text("no data found"),) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:  controller.nodeiceBoardModel.value.data!.length,
                  itemBuilder: (context, index) {
                    var notice = controller.nodeiceBoardModel.value.data![index];
                    String visibleTo = "";
                    if(notice.visibleStaff != null && notice.visibleStaff == 'Yes')
                    {
                      visibleTo = visibleTo + "Staff ,";
                    }
                    if(notice.visibleParent != null && notice.visibleParent == 'Yes')
                    {
                      visibleTo = visibleTo + "Parents ,";
                    }

                    if(notice.visibleStudent != null && notice.visibleStudent == 'Yes')
                    {
                      visibleTo = visibleTo + "Student ,";
                    }
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade100,
                            Colors.green.shade50,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email Icon
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                // Notice Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notice.title!.capitalizeFirst!,
                                        style: theme.textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        notice.createdAt!,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Action Icons
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Handle edit action
                                      },
                                      icon: Icon(Icons.edit, color: Colors.green),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Handle delete action
                                      },
                                      icon: Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                    ;
                },),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Get.toNamed(AppRoutes.new_messageRoute);
        },
        tooltip: 'Post New Message',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

}