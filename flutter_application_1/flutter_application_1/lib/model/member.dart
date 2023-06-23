import 'dart:convert';

Member memberFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData == null) {
    throw const FormatException("Invalid JSON format");
  }
  return Member.fromJson(jsonData);
}

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  String message;
  Data data;
  String role;
  String token;

  Member({
    required this.message,
    required this.data,
    required this.role,
    required this.token,
  });

  factory Member.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Invalid JSON format");
    }
    return Member(
      message: json["message"],
      data: Data.fromJson(json["data"]),
      role: json["role"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "role": role,
    "token": token,
  };
}

class Data {
  String idMember;
  String fullName;
  String gender;
  DateTime tanggalLahir;
  String phoneNumber;
  String address;
  String email;
  int depositRegularAmount;
  DateTime expireDate;
  int statusMembership;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.idMember,
    required this.fullName,
    required this.gender,
    required this.tanggalLahir,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.depositRegularAmount,
    required this.expireDate,
    required this.statusMembership,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Invalid JSON format");
    }
    return Data(
      idMember: json["ID_MEMBER"],
      fullName: json["FULL_NAME"],
      gender: json["GENDER"],
      tanggalLahir: DateTime.tryParse(json["TANGGAL_LAHIR"]) ?? DateTime(1900),
      phoneNumber: json["PHONE_NUMBER"],
      address: json["ADDRESS"],
      email: json["EMAIL"],
      depositRegularAmount: json["DEPOSIT_REGULAR_AMOUNT"],
      expireDate: DateTime.tryParse(json["EXPIRE_DATE"]) ?? DateTime(1900),
      statusMembership: json["STATUS_MEMBERSHIP"],
      createdAt: DateTime.tryParse(json["created_at"]) ?? DateTime(1900),
      updatedAt: DateTime.tryParse(json["updated_at"]) ?? DateTime(1900),
    );
  }

  Map<String, dynamic> toJson() => {
    "ID_MEMBER": idMember,
    "FULL_NAME": fullName,
    "GENDER": gender,
    "TANGGAL_LAHIR": "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    "PHONE_NUMBER": phoneNumber,
    "ADDRESS": address,
    "EMAIL": email,
    "DEPOSIT_REGULAR_AMOUNT": depositRegularAmount,
    "EXPIRE_DATE": "${expireDate.year.toString().padLeft(4, '0')}-${expireDate.month.toString().padLeft(2, '0')}-${expireDate.day.toString().padLeft(2, '0')}",
    "STATUS_MEMBERSHIP": statusMembership,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}