import 'dart:convert';

Instructor instructorFromJson(String str) => Instructor.fromJson(json.decode(str));

String instructorToJson(Instructor data) => json.encode(data.toJson());

class Instructor {
    String message;
    Data data;
    String role;
    String token;

    Instructor({
        required this.message,
        required this.data,
        required this.role,
        required this.token,
    });

    factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        role: json["role"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "role": role,
        "token": token,
    };
}

class Data {
    String idInstructor;
    String fullName;
    String gender;
    DateTime tanggalLahir;
    String phoneNumber;
    String address;
    String email;
    String lateAmount;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.idInstructor,
        required this.fullName,
        required this.gender,
        required this.tanggalLahir,
        required this.phoneNumber,
        required this.address,
        required this.email,
        required this.lateAmount,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idInstructor: json["ID_INSTRUCTOR"],
        fullName: json["FULL_NAME"],
        gender: json["GENDER"],
        tanggalLahir: DateTime.parse(json["TANGGAL_LAHIR"]),
        phoneNumber: json["PHONE_NUMBER"],
        address: json["ADDRESS"],
        email: json["EMAIL"],
        lateAmount: json["LATE_AMOUNT"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "ID_INSTRUCTOR": idInstructor,
        "FULL_NAME": fullName,
        "GENDER": gender,
        "TANGGAL_LAHIR": "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
        "PHONE_NUMBER": phoneNumber,
        "ADDRESS": address,
        "EMAIL": email,
        "LATE_AMOUNT": lateAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}