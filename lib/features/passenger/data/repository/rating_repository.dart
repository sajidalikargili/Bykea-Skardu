import 'package:bykea_skardu/core/service/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart' hide FirebaseService;

class RatingRepository {
  static Future<void> submitRideRating({required String rideId,required int rating,required String comment}) async{
  await FirebaseService.submitRideRating(rideId: rideId, rating: rating, comment: comment);
}
}