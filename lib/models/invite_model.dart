class InviteModel {
  String? errorFlag;
  String? message;
  Data? data;

  InviteModel({this.errorFlag, this.message, this.data});

  InviteModel.fromJson(Map<String, dynamic> json) {
    errorFlag = json['error_flag'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['error_flag'] = this.errorFlag;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? inviteId;
  String? email;
  String? role;

  Data({this.inviteId, this.email, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    inviteId = json['invite_id'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invite_id'] = this.inviteId;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}

