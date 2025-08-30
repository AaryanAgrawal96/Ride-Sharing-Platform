import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride.dart';
import '../models/feedback_model.dart';

class CompanionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Ride> trackRide(String rideId) {
    return _firestore
        .collection('rides')
        .doc(rideId)
        .snapshots()
        .map((doc) => Ride.fromJson(doc.data()!));
  }

  Future<void> submitFeedback(FeedbackModel feedback) async {
    try {
      await _firestore
          .collection('feedback')
          .doc(feedback.id)
          .set(feedback.toJson());
    } catch (e) {
      throw Exception('Failed to submit feedback: $e');
    }
  }
}
