import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feedback_model.dart';

class FeedbackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Stream<List<FeedbackModel>> getFeedbackByRide(String rideId) {
    return _firestore
        .collection('feedback')
        .where('rideId', isEqualTo: rideId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => FeedbackModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<Map<String, dynamic>> getOverallFeedbackSummary() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('feedback')
          .get();
      final List<FeedbackModel> allFeedback = snapshot.docs
          .map(
            (doc) => FeedbackModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      double avgRating = 0;
      if (allFeedback.isNotEmpty) {
        avgRating =
            allFeedback.map((f) => f.rating).reduce((a, b) => a + b) /
            allFeedback.length;
      }

      return {'averageRating': avgRating, 'totalFeedback': allFeedback.length};
    } catch (e) {
      throw Exception('Failed to get feedback summary: $e');
    }
  }
}
