import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/referal_info_detail.dart';

import '../../constants/constants.dart';
import '../../data/data.dart';
import '../../models/dashboard_chart_data.dart';
import '../../models/referal_info_model.dart';


class TopReferals extends StatelessWidget {
  final Roles data;
  const TopReferals({Key? key,required this.data,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReferalInfoModel> newData = [];
    ReferalInfoModel admin = ReferalInfoModel(
      count: int.parse(data.admin!.toString()),
      title: "Admin",
      color:referalData[0].color,
      svgSrc:referalData[0].svgSrc,
    );
    newData.add(admin);
    ReferalInfoModel teacher = ReferalInfoModel(
      count: int.parse(data.teacher!.toString()),
      title: "Teacher",
      color:referalData[0].color,
      svgSrc:referalData[0].svgSrc,
    );
    newData.add(teacher);
    ReferalInfoModel accountant = ReferalInfoModel(
      count: int.parse(data.accountant!.toString()),
      title: "Accountant",
      color:referalData[0].color,
      svgSrc:referalData[0].svgSrc,
    );
    newData.add(accountant);
    ReferalInfoModel librarian = ReferalInfoModel(
      count: int.parse(data.librarian!.toString()),
      title: "Librarian",
      color:referalData[0].color,
      svgSrc:referalData[0].svgSrc,
    );
    newData.add(librarian);
    ReferalInfoModel receptionist = ReferalInfoModel(
      count: int.parse(data.receptionist!.toString()),
      title: "Receptionist",
      color:referalData[0].color,
      svgSrc:referalData[0].svgSrc,
    );
    newData.add(receptionist);
    ReferalInfoModel superAdmin = ReferalInfoModel(
      count: int.parse(data.superAdmin!.toString()),
      title: "Super Admin",
      color:referalData[0].color,
      svgSrc:referalData[0].svgSrc,
    );
    newData.add(superAdmin);


    return Container(
      height: 350,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Staff',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),

            ],
          ),
          SizedBox(
            height: appPadding,
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: newData.length,
              itemBuilder: (context, index) => ReferalInfoDetail(
                info: newData[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
