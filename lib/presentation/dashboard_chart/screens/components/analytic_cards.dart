import 'package:flutter/material.dart';


import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../../data/data.dart';
import '../../models/analytic_info_model.dart';
import 'analytic_info_card.dart';

class AnalyticCards extends StatelessWidget {
  final List<String> data;

  const AnalyticCards({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    List<AnalyticInfo> newData = [];
    for(var i=0;i<data.length;i++)
    {
      AnalyticInfo an = AnalyticInfo(
        count: int.parse(data[i]),
        title: analyticData[i].title,
          color:analyticData[i].color,
          svgSrc:analyticData[i].svgSrc,
      );
      newData.add(an);

    }
    return Container(
      child: Responsive(
        mobile: AnalyticInfoCardGridView(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
          data:newData,
        ),
        tablet: AnalyticInfoCardGridView( data:newData,),
        desktop: AnalyticInfoCardGridView(
          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
          data:newData,
        ),
      ),
    );
  }
}

class AnalyticInfoCardGridView extends StatelessWidget {
  const AnalyticInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
    required this.data,

  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List<AnalyticInfo> data;




  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: appPadding,
        mainAxisSpacing: appPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: data[index],
      ),
    );
  }
}
