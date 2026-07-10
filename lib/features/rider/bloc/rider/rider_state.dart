import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';
class RiderState {
  static const _unset = Object();
  String? selectStand;
  bool isOnline;
  RideModel? ride;
  List<RideModel> rides;
  final UserModel? passenger;
  final UserModel? rider;
  final int totalRides;
  final int completedRides;
  final int cancelledRides;
  final double totalEarnings;
  final List<RideModel> bookings;
  final int? passengerRating;
  final String? passengerComment;
  RiderState({
    this.selectStand,
    this.isOnline = false,
    this.ride,
    this.rides = const [],
    this.passenger,
    this.rider,
    this.totalRides = 0,
    this.completedRides = 0,
    this.cancelledRides = 0,
    this.totalEarnings = 0,
    this.bookings= const [],
    this.passengerRating,
    this.passengerComment

  });

  RiderState copyWith({
    String? selectStand,
    bool? isOnline,
    Object? ride = _unset,
    List<RideModel>? rides,
    Object? passenger = _unset,
    UserModel? rider,
    int? totalRides,
    int? completedRides,
    int? cancelledRides,
    double? totalEarnings,
    List<RideModel>? bookings,
   int? passengerRating,
  String? passengerComment,

  }) {
    return RiderState(
      selectStand: selectStand ?? this.selectStand,
      isOnline: isOnline ?? this.isOnline,
      ride: identical(ride, _unset)
          ? this.ride
          : ride as RideModel?,
      rides: rides ?? this.rides,
      passenger: identical(passenger, _unset)
          ? this.passenger
          : passenger as UserModel?,
      rider: rider ?? this.rider,
      totalRides: totalRides ?? this.totalRides,
      completedRides: completedRides ?? this.completedRides,
      cancelledRides: cancelledRides ?? this.cancelledRides,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      bookings: bookings ?? this.bookings,
        passengerRating:passengerRating ?? this.passengerRating,
        passengerComment:passengerComment ?? this.passengerComment
    );
  }
}