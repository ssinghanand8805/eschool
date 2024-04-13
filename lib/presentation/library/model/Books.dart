class Books {
  int? success;
  List<Data>? data;

  Books({this.success, this.data});

  Books.fromJson(Map<String, dynamic> json) {
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