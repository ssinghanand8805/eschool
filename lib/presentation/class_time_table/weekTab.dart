import 'package:flutter/material.dart';

class WeekTabScreen extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;

  const WeekTabScreen({
    Key? key,
    required this.tabTitles,
    required this.tabContents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tabWidth = constraints.maxWidth / tabTitles.length;
                return TabBar(
              dividerHeight: 0.0,
                  tabs: tabTitles.map((title) => SizedBox(
                    width: tabWidth,
                    child: Tab(text: title),
                  )).toList(),
                  isScrollable: false,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                  labelPadding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                );
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              children: tabContents,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}