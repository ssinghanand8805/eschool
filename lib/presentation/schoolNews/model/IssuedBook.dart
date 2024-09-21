class SchoolNews {
  String? returnDate;
  String? dueReturnDate;
  String? bookNo;
  String? issueDate;
  String? isReturned;
  String? bookTitle;
  String? author;
  String? subject;

  SchoolNews(
      {this.returnDate,
        this.dueReturnDate,
        this.bookNo,
        this.issueDate,
        this.isReturned,
        this.bookTitle,
        this.author,
        this.subject});

  SchoolNews.fromJson(Map<String, dynamic> json) {
    returnDate = json['return_date'];
    dueReturnDate = json['due_return_date'];
    bookNo = json['book_no'];
    issueDate = json['issue_date'];
    isReturned = json['is_returned'];
    bookTitle = json['book_title'];
    author = json['author'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['return_date'] = this.returnDate;
    data['due_return_date'] = this.dueReturnDate;
    data['book_no'] = this.bookNo;
    data['issue_date'] = this.issueDate;
    data['is_returned'] = this.isReturned;
    data['book_title'] = this.bookTitle;
    data['author'] = this.author;
    data['subject'] = this.subject;
    return data;
  }
}