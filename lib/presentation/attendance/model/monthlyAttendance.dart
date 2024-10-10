class MonthlyAttendance {
  List<MonthlySummary>? monthlySummary;
  OverallSummary? overallSummary;

  MonthlyAttendance({this.monthlySummary, this.overallSummary});

  MonthlyAttendance.fromJson(Map<String, dynamic> json) {
    if (json['monthly_summary'] != null) {
      monthlySummary = <MonthlySummary>[];
      json['monthly_summary'].forEach((v) {
        monthlySummary!.add(new MonthlySummary.fromJson(v));
      });
    }
    overallSummary = json['overall_summary'] != null
        ? new OverallSummary.fromJson(json['overall_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monthlySummary != null) {
      data['monthly_summary'] =
          this.monthlySummary!.map((v) => v.toJson()).toList();
    }
    if (this.overallSummary != null) {
      data['overall_summary'] = this.overallSummary!.toJson();
    }
    return data;
  }
}

class MonthlySummary {
  String? monthName;
  int? present;
  int? absent;
  int? leave;
  int? totalWorkingDays;
  double? attendancePercentage;

  MonthlySummary(
      {this.monthName,
        this.present,
        this.absent,
        this.leave,
        this.totalWorkingDays,
        this.attendancePercentage});

  MonthlySummary.fromJson(Map<String, dynamic> json) {
    monthName = json['MonthName'];
    present = json['Present'];
    absent = json['Absent'];
    leave = json['Leave'];
    totalWorkingDays = json['total_working_days'];
    attendancePercentage = double.parse(json['attendance_percentage'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MonthName'] = this.monthName;
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['total_working_days'] = this.totalWorkingDays;
    data['attendance_percentage'] = this.attendancePercentage;
    return data;
  }
}

class OverallSummary {
  int? present;
  int? absent;
  int? leave;
  int? totalWorkingDays;
  int? attendancePercentage;

  OverallSummary(
      {this.present,
        this.absent,
        this.leave,
        this.totalWorkingDays,
        this.attendancePercentage});

  OverallSummary.fromJson(Map<String, dynamic> json) {
    present = json['Present'];
    absent = json['Absent'];
    leave = json['Leave'];
    totalWorkingDays = json['total_working_days'];
    attendancePercentage = json['attendance_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    data['Leave'] = this.leave;
    data['total_working_days'] = this.totalWorkingDays;
    data['attendance_percentage'] = this.attendancePercentage;
    return data;
  }
}
