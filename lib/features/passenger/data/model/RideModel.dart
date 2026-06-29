class RideModel {
  final String rideId;
  final String passengerId;
  final String pickupStand;
  final String distination;
  final String status;
  final String? riderId;
  final String? riderName;
  final String? riderPhone;
  final String? fare;

  RideModel({
    required this.rideId,
    required this.passengerId,
    required this.pickupStand,
    required this.distination,
    required this.status,
    this.riderId,
    this.riderName,
    this.riderPhone,
    this.fare,
  });
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RideModel &&
        other.rideId == rideId &&
        other.status == status &&
        other.pickupStand == pickupStand &&
        other.distination == distination;
    // add all your fields here
  }

  @override
  int get hashCode => Object.hash(rideId, status, pickupStand, distination);
  factory RideModel.fromMap(Map<String, dynamic> map) {
    return RideModel(
      rideId: map['rideId'] ?? '',
      passengerId: map['passengerId'] ?? '',
      pickupStand: map['pickupStand'] ?? '',
      distination: map['distination'] ?? '',
      status: map['status'] ?? '',
      riderId: map['riderId'],
      riderName: map['riderName'],
      riderPhone: map['riderPhone'],
      fare: map['fare'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rideId': rideId,
      'passengerId': passengerId,
      'pickupStand': pickupStand,
      'distination': distination,
      'status': status,
      'riderId': riderId,
      'riderName':riderName,
      'riderPhone':riderPhone,
      'fare': fare,
    };
  }

  RideModel copyWith({
    String? rideId,
    String? passengerId,
    String? pickupStand,
    String? distination,
    String? status,
    String? riderId,
    String? riderName,
    String? riderPhone,
    String? fare,
  }) {
    return RideModel(
      rideId: rideId ?? this.rideId,
      passengerId: passengerId ?? this.passengerId,
      pickupStand: pickupStand ?? this.pickupStand,
      distination: distination ?? this.distination,
      status: status ?? this.status,
      riderId: riderId ?? this.riderId,
      riderName: riderName ?? this.riderPhone,
      riderPhone: riderName ?? this.riderPhone,
      fare: fare ?? this.fare,
    );

  }
}