class User {
  Profile? profile;
  Branch? branch;

  User({this.profile, this.branch});

  User.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    branch =
    json['branch'] != null ? Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? image;
  int? isPhoneVerified;
  String? createdAt;
  String? updatedAt;
  String? phone;
  int? branchId;

  Profile(
      {this.id,
        this.fName,
        this.lName,
        this.email,
        this.image,
        this.isPhoneVerified,
        this.createdAt,
        this.updatedAt,
        this.phone,
        this.branchId});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    image = json['image'];
    isPhoneVerified = json['is_phone_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['email'] = email;
    data['image'] = image;
    data['is_phone_verified'] = isPhoneVerified;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['phone'] = phone;
    data['branch_id'] = branchId;
    return data;
  }
}

class Branch {
  int? id;
  String? name;

  Branch(
      {this.id,
        this.name,
     });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}
