class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({this.id, this.userId, this.title, this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'] ?? "",
      body: json['body'] ?? "",
    );
  }
}

class Card {
  final String card_id;
  final String card_holder_name;
  final String qr_image;


  Card({this.card_id, this.card_holder_name, this.qr_image});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      card_id: json['card_id'],
      card_holder_name: json['card_holder_name'],
      qr_image: json['qr_image'],
    );
  }


}

class CardDetail {
  int id;
  Affiliate affiliate;
  String cardId;
  String cardHolderName;
  String qrImage;
  bool isVerified;
  bool isPending;
  bool isCanceled;
  bool isRejected;
  bool isActive;
  String timestamp;
  int fkUser;

  CardDetail(
      {this.id,
      this.affiliate,
      this.cardId,
      this.cardHolderName,
      this.qrImage,
      this.isVerified,
      this.isPending,
      this.isCanceled,
      this.isRejected,
      this.isActive,
      this.timestamp,
      this.fkUser});

  CardDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    affiliate = json['affiliate'] != null
        ? new Affiliate.fromJson(json['affiliate'])
        : null;
    cardId = json['card_id'];
    cardHolderName = json['card_holder_name'] ?? '';
    qrImage = json['qr_image'] ?? '';
    isVerified = json['is_verified'];
    isPending = json['is_pending'];
    isCanceled = json['is_canceled'];
    isRejected = json['is_rejected'];
    isActive = json['is_active'];
    timestamp = json['timestamp'];
    // fkUser = json['fk_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.affiliate != null) {
      data['affiliate'] = this.affiliate.toJson();
    }
    data['card_id'] = this.cardId;
    data['card_holder_name'] = this.cardHolderName;
    data['qr_image'] = this.qrImage;
    data['is_verified'] = this.isVerified;
    data['is_pending'] = this.isPending;
    data['is_canceled'] = this.isCanceled;
    data['is_rejected'] = this.isRejected;
    data['is_active'] = this.isActive;
    data['timestamp'] = this.timestamp;
    data['fk_user'] = this.fkUser;
    return data;
  }
}

class Affiliate {
  int id;
  List<Template> template;
  String name;
  String location;
  String contact;
  bool isActive;
  String logo;
  String cardColor;
  String subdomain;
  int user;

  Affiliate(
      {this.id,
      this.template,
      this.name,
      this.location,
      this.contact,
      this.isActive,
      this.cardColor,
      this.logo,
      this.subdomain,
      this.user});

  Affiliate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['template'] != null) {
      template = new List<Template>();
      json['template'].forEach((v) {
        template.add(new Template.fromJson(v));
      });
    }
    name = json['name'];
    location = json['location'];
    contact = json['contact'];
    isActive = json['is_active'];
    logo = json['logo'];
    cardColor = json['card_color'];
    subdomain = json['subdomain'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.template != null) {
      data['template'] = this.template.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['location'] = this.location;
    data['contact'] = this.contact;
    data['is_active'] = this.isActive;
    data['logo'] = this.logo;
    data['subdomain'] = this.subdomain;
    data['user'] = this.user;
    return data;
  }
}

class Template {
  int id;
  String template;
  int fkAffiliate;

  Template({this.id, this.template, this.fkAffiliate});

  Template.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    template = json['template'];
    fkAffiliate = json['fk_affiliate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['template'] = this.template;
    data['fk_affiliate'] = this.fkAffiliate;
    return data;
  }
}