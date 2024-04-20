class LoginModel {
    int? id;
    String? fName;
    String? lName;
    String? phone;
    String? email;
    String? image;
    String? password;
    dynamic rememberToken;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic fcmToken;
    int? adminRoleId;
    int? status;
    String? identityNumber;
    String? identityType;
    String? identityImage;
    dynamic lastLoginAt;
    dynamic lastLoginIp;

    LoginModel({
        this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.fcmToken,
        this.adminRoleId,
        this.status,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.lastLoginAt,
        this.lastLoginIp,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"],
        adminRoleId: json["admin_role_id"],
        status: json["status"],
        identityNumber: json["identity_number"],
        identityType: json["identity_type"],
        identityImage: json["identity_image"],
        lastLoginAt: json["last_login_at"],
        lastLoginIp: json["last_login_ip"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "email": email,
        "image": image,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "fcm_token": fcmToken,
        "admin_role_id": adminRoleId,
        "status": status,
        "identity_number": identityNumber,
        "identity_type": identityType,
        "identity_image": identityImage,
        "last_login_at": lastLoginAt,
        "last_login_ip": lastLoginIp,
    };
}
