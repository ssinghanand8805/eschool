import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/settings/settingController.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/alert_dialogue.dart';
import '../../widgets/custom_button.dart';
import '../academics/Promote Student/promote_student_modal.dart';
import '../common_widgets/custom_loader.dart';

class SettingView extends GetView<SettingController> {
  SettingView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            // title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.settings_outlined),
                title: Text('Current Session'),
                value: FutureBuilder(
                    future: controller.fetchDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Text(
                            'Loading'); // CustomLoader if the data is still loading
                      }
                      return Text(controller.currentActiveSessionName.value);
                    }),
                trailing: GestureDetector(
                    onTap: () {
                      getAllSession(context);
                    },
                    child: Icon(Icons.edit, size: 18)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getAllSession(context) {
    return showCustomBottomSheet(
      context: context,
      child: Container(
        height: Get.height * 0.68,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FutureBuilder to load session data
            controller.SessionlistModel!.length > 0
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.SessionlistModel.length,
                      itemBuilder: (context, index) {
                        Sessionlist session =
                            controller.SessionlistModel[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CupertinoListTile(
                            trailing: Obx(() => CupertinoSwitch(
                                  value: session.id.toString() ==
                                      controller.currentActiveSession.value,
                                  onChanged: (bool value) {
                                    if (value) {
                                      controller.currentActiveSession.value =
                                          session.id.toString();
                                    }
                                  },
                                )),
                            title: Text(
                              session.session.toString(),
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/projectImages/no_data.png"),
                        Text("No data found!"),
                      ],
                    ),
                  ),

            // Save button at the bottom
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Save',
                textStyle: TextStyle(color: Colors.white),
                color: CupertinoColors.activeGreen,
                onPress: () {
                  controller.updateSession();
                  // Implement the save functionality here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
