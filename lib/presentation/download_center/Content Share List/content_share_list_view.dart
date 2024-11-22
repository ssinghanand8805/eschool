import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../common_widgets/custom_loader.dart';
import 'content_share_list_controller.dart';

class ContentShareView extends GetView<ContentShareController> {
  ContentShareView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: Text(
            'Content Share List',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        body: GetBuilder<ContentShareController>(
            init: controller,
            builder: (_) {
              return FutureBuilder(
                  future: controller.fetchDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CustomLoader();
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: CustomTextField(
                            controller: controller.searchC,
                            hint: 'Search.... ',
                            title: '',
                            onChanged: (val) {
                              controller.searchContentType(val);
                              controller.update();
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header Row
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      buildHeaderCell("Title"),
                                      buildHeaderCell("Send To"),
                                      buildHeaderCell("Share Date"),
                                      buildHeaderCell("Valid Upto"),
                                      buildHeaderCell("Action",
                                          centerText: true),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.0),

                                // Data List Section
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: GetBuilder<ContentShareController>(
                                      builder: (controller) {
                                        if (controller.filteredContentTypeList
                                                    .value.data ==
                                                null ||
                                            controller.filteredContentTypeList
                                                .value.data!.isEmpty) {
                                          return Center(
                                              child:
                                                  Text("No data available."));
                                        }

                                        return ListView.builder(
                                          itemCount: controller
                                              .filteredContentTypeList
                                              .value
                                              .data!
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final data = controller
                                                .filteredContentTypeList
                                                .value
                                                .data![index];

                                            return Card(
                                              elevation: 4.0,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    buildDataCell(
                                                        data.title ?? ""),
                                                    buildDataCell(
                                                        data.sendTo ?? ""),
                                                    buildDataCell(
                                                        data.shareDate ?? ""),
                                                    buildDataCell(
                                                        data.validUpto ?? "-"),
                                                    buildActionCell(context,controller),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }));
  }

  Widget buildHeaderCell(String text, {bool centerText = false}) {
    return Expanded(
      flex: 2,
      child: Text(
        text,
        textAlign: centerText ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildDataCell(String text) {
    return Expanded(
      flex: 2,
      child: Text(
        text,
        style: theme.textTheme.bodySmall,
      ),
    );
  }

  Widget buildActionCell(BuildContext context,ContentShareController controller) {
    return Expanded(
      flex: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove_red_eye, size: 16,color: Colors.green,),
            onPressed: () {
              showShareContents(context,controller);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, size: 16,color: Colors.red,),
            onPressed: () {
              print("Delete leave");
            },
          ),
        ],
      ),
    );
  }

  void showShareContents(BuildContext context, ContentShareController controller) {
    showCustomBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Text(
              "Shared Content",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1.5),
            const SizedBox(height: 12),

            // Subtitle
            Text(
              "Fees Structure",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Info Rows
            Row(
              children: [
                Expanded(
                  child: InfoRow(
                    title: "Upload Date:",
                    value: "04/05/2024",
                 
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoRow(
                    title: "Valid Upto:",
                    value: "04/05/2024",

                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InfoRow(
                    title: "Share Date:",
                    value: "04/05/2024",

                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoRow(
                    title: "Shared By:",
                    value: "Mohd Faheem",

                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InfoRow(
                    title: "Send To:",
                    value: "Group",

                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoRow(
                    title: "Description:",
                    value: "Description text goes here",

                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Attachments Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Attachments:",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                customDownloadButton(
                  label: "Download",
                  icon: Icons.download,
                  onPressed: () {
                    downloadFileFromAPI(
                      "${"baseUrlFromPref"}data[index].dirPath!/${"data[index].imgName!"}",
                      "fileName",
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customDownloadButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

}
