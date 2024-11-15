class BookDataModal {
  int? status;
  String? error;
  Data? data;

  BookDataModal({this.status, this.error, this.data});

  BookDataModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Listbooktype>? listbooktype;
  List<Listbook>? listbook;

  Data({this.listbooktype, this.listbook});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['listbooktype'] != null) {
      listbooktype = <Listbooktype>[];
      json['listbooktype'].forEach((v) {
        listbooktype!.add(new Listbooktype.fromJson(v));
      });
    }
    if (json['listbook'] != null) {
      listbook = <Listbook>[];
      json['listbook'].forEach((v) {
        listbook!.add(new Listbook.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listbooktype != null) {
      data['listbooktype'] = this.listbooktype!.map((v) => v.toJson()).toList();
    }
    if (this.listbook != null) {
      data['listbook'] = this.listbook!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listbooktype {
  String? id;
  String? bookTypeName;

  Listbooktype({this.id, this.bookTypeName});

  Listbooktype.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookTypeName = json['book_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['book_type_name'] = this.bookTypeName;
    return data;
  }
}

class Listbook {
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
  String? bookTypeId;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Listbook(
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
        this.bookTypeId,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Listbook.fromJson(Map<String, dynamic> json) {
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
    bookTypeId = json['book_type_id'];
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
    data['book_type_id'] = this.bookTypeId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
