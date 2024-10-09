import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';

class MonthlyAttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Attendance', style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),),
        backgroundColor:Colors.green.shade100,
      ),
      body: Container(
       color: Color(0xFFE6E6E6),
        child: Column(
          children: [
            _buildSummaryCard(),
            SizedBox(height: 20),
            _buildMonthCard('JUL', 6, 5, 1, 0, 83.33),
            SizedBox(height: 10),
            _buildMonthCard('AUG', 22, 18, 4, 0, 81.82),
            SizedBox(height: 10),
            _buildMonthCard('SEP', 15, 14, 1, 0, 93.33),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.green.shade700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSummaryItem('Total Present', '37', Colors.white),
          _buildSummaryItem('Total Absent', '6', Colors.red),
          _buildSummaryItem('Total Leave', '0', Colors.orange),
          _buildSummaryItem('Percentage', '86.0'+'%', Colors.white),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 14)),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMonthCard(String month, int total, int present, int absent, int leave, double percentage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF217346),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  month,
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Working $total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,)),
                  Text('Your Present $present', style: TextStyle(color: Colors.green, fontSize: 14)),
                  Text('Your Absent $absent', style: TextStyle(color: Colors.red, fontSize: 14)),
                  Text('Your Leave $leave', style: TextStyle(color: Colors.orange, fontSize: 14)),
                ],
              ),
            ),
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(
              '${percentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF217346)),
            ),
          ),
        ],
      ),
    );
  }
}