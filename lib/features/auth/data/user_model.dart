class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String? role;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    this.role,
  });

  factory UserModel.formMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role:map['role'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid':uid,'name': name, 'phone': phone, 'role': role};
  }

  UserModel copyWith({String? uid, String? name, String? phone}) {
    return UserModel(
      uid: uid?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
