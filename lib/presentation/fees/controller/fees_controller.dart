import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/feesRe.dart';
import '../model/fees_modal.dart';

class FeesController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<FeesDataModal> feesDataModal = FeesDataModal().obs;

  Rx<FeesReceiptModal> feesReceiptModalObj = FeesReceiptModal().obs;
  late Future<void> fetchDataFuture;
  late Future<void> fetchDataFuture2;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFuture =
        getData();
    fetchDataFuture2 =
        getFeesReceiptData();
  }

  Future<void> getData() async {
    Map<String, dynamic> body = {"student_id": userData.getUserStudentId};
    print("Body @@@@ ${body}");
    var data =
        await apiRespository.postApiCallByJson(Constants.getFeestUrl, body);
    print("DATA TransportRoute ${data.body}");

    feesDataModal.value = FeesDataModal.fromJson(data.body);
    for (var i = 0; i < feesDataModal.value!.transportFees!.length; i++) {
      var e = new Fees(
          name: "Transport",
          type: feesDataModal.value!.transportFees![i].month,
          code: feesDataModal.value!.transportFees![i].month,
          dueDate: feesDataModal.value!.transportFees![i].dueDate,
          amount: feesDataModal.value!.transportFees![i].amountDetail,
          fineAmount: feesDataModal.value!.transportFees![i].fineAmount ?? "0",
          totalAmountDiscount: feesDataModal
              .value!.transportFees![i].totalAmountDiscount
              .toString(),
          totalAmountPaid:
              feesDataModal.value!.transportFees![i].totalAmountPaid.toString(),
          totalAmountRemaining:
              feesDataModal.value!.transportFees![i].totalAmountRemaining);
      feesDataModal.value!.studentDueFee![0].fees!.add(e);
    }

    print("111111111111111111111 ${feesDataModal.value.toJson()}");
    update();
  }

  Future<void> getFeesReceiptData() async {
    Map<String, dynamic> body = {"student_id": userData.getUserStudentId};
    print("Body @@@@ ${body}");
    var data =
        await apiRespository.postApiCallByJson(Constants.feesReceipt, body);
    print("DATA @@@@ ${data.body}");
    print("userData getRole ${userData.getRole}");
    feesReceiptModalObj.value = FeesReceiptModal.fromJson(data.body);
    print("111111111111111111111 ${feesReceiptModalObj.value.toJson()}");
    update();
  }
}
