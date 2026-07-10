class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String? role;
  final bool isOnline;
  final String? stand;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    this.role,
    this.isOnline=false,
    this.stand
  });

  factory UserModel.formMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role:map['role'] ?? '',
      isOnline: map['isOnline'] ?? false,
        stand: map['stand'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid':uid,'name': name, 'phone': phone, 'role': role,'isOnline':isOnline,'stand':stand};
  }

  UserModel copyWith({String? uid, String? name, String? phone,bool? isOnline,String? stand}) {
    return UserModel(
      uid: uid?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      isOnline: isOnline ?? this.isOnline,
      stand: stand ?? this.stand,
    );
  }
}
