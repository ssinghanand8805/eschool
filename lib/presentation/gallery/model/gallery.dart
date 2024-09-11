class GalleryModal {
  int? success;
  List<Data>? data;

  GalleryModal({this.success, this.data});

  GalleryModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? bookTitle;
  String? bookNo;
  String? isbnNo;
  String? subject;
  String? rackNo;
  String? publish;
  String? author;
  String? qty;
  String? perunitcost;
  String? postdate;
  String? description;
  String? available;
  String? isActive;
  String? createdAt;
  Null? updatedAt;

  Data(
      {this.id,
        this.bookTitle,
        this.bookNo,
        this.isbnNo,
        this.subject,
        this.rackNo,
        this.publish,
        this.author,
        this.qty,
        this.perunitcost,
        this.postdate,
        this.description,
        this.available,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookTitle = json['book_title'];
    bookNo = json['book_no'];
    isbnNo = json['isbn_no'];
    subject = json['subject'];
    rackNo = json['rack_no'];
    publish = json['publish'];
    author = json['author'];
    qty = json['qty'];
    perunitcost = json['perunitcost'];
    postdate = json['postdate'];
    description = json['description'];
    available = json['available'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['book_title'] = this.bookTitle;
    data['book_no'] = this.bookNo;
    data['isbn_no'] = this.isbnNo;
    data['subject'] = this.subject;
    data['rack_no'] = this.rackNo;
    data['publish'] = this.publish;
    data['author'] = this.author;
    data['qty'] = this.qty;
    data['perunitcost'] = this.perunitcost;
    data['postdate'] = this.postdate;
    data['description'] = this.description;
    data['available'] = this.available;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class GalleryImage {
  String? returnDate;
  String? dueReturnDate;
  String? bookNo;
  String? issueDate;
  String? isReturned;
  String? bookTitle;
  String? author;
  String? subject;

  GalleryImage(
      {this.returnDate,
        this.dueReturnDate,
        this.bookNo,
        this.issueDate,
        this.isReturned,
        this.bookTitle,
        this.author,
        this.subject});

  GalleryImage.fromJson(Map<String, dynamic> json) {
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