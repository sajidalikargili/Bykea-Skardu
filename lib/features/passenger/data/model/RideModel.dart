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
  final List<String>? declinedRiders;
  final int? passengerRating;
  final String? passengerComment;

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
    this.declinedRiders,
    this.passengerRating,
    this.passengerComment
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RideModel &&
        other.rideId == rideId &&
        other.status == status &&
        other.pickupStand == pickupStand &&
        other.distination == distination &&
        other.riderId == riderId &&
        other.riderName == riderName &&
        other.riderPhone == riderPhone &&
        other.fare == fare &&
      other.passengerRating==passengerRating&&
      other.passengerComment==passengerComment;
  }

  @override
  int get hashCode => Object.hash(
    rideId,
    status,
    pickupStand,
    distination,
    riderId,
    riderName,
    riderPhone,
    fare,
    passengerRating,
    passengerComment
  );

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
      declinedRiders: List<String>.from(
        map['declinedRiders'] ?? [],
      ),
      passengerRating: map["passengerRating"] ?? 0,
      passengerComment: map["passengerComment"] ?? "",
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
      'riderName': riderName,
      'riderPhone': riderPhone,
      'fare': fare,
      'declinedRiders': declinedRiders ?? [],
      "passengerRating": passengerRating,
      "passengerComment": passengerComment,
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
    List<String>? declinedRiders,
    int? passengerRating,
    String? passengerComment,
  }) {
    return RideModel(
      rideId: rideId ?? this.rideId,
      passengerId: passengerId ?? this.passengerId,
      pickupStand: pickupStand ?? this.pickupStand,
      distination: distination ?? this.distination,
      status: status ?? this.status,
      riderId: riderId ?? this.riderId,
      riderName: riderName ?? this.riderName,
      riderPhone: riderPhone ?? this.riderPhone,
      fare: fare ?? this.fare,
      declinedRiders: declinedRiders ?? this.declinedRiders,
      passengerRating: passengerRating ?? this.passengerRating,
      passengerComment: passengerComment ?? this.passengerComment,
    );
  }
}