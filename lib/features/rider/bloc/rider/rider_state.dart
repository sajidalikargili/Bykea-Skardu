import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:bykea_skardu/features/passenger/data/model/RideModel.dart';

class RiderState {
  String? selectStand;
  bool isOnline;
  RideModel? ride;
  List<RideModel> rides;
  final UserModel? passenger;
  RiderState({
    this.selectStand,
    this.isOnline = false,
    this.ride,
    this.rides = const [],
    this.passenger,
  });

  RiderState copyWith({
    String? selectStand,
    bool? isOnline,
    RideModel? ride,
    List<RideModel>? rides,
    UserModel? passenger,
  }) {
    return RiderState(
      selectStand: selectStand ?? this.selectStand,
      isOnline: isOnline ?? this.isOnline,
      ride: ride ?? this.ride,
      rides: rides ?? this.rides,
      passenger: passenger ?? this.passenger
    );
  }
}