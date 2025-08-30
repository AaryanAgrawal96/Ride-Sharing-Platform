import 'package:cloud_firestore/cloud_firestore.dart';

class ShareService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String generateShareLink(String rideId) {
    // TODO: Implement proper deep linking
    return 'https://ridetracking.app/share/$rideId';
  }

  Future<void> saveShareAudit(String rideId, String travelerId) async {
    try {
      await _firestore.collection('share_history').add({
        'rideId': rideId,
        'travelerId': travelerId,
        'sharedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to save share audit: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getShareHistory(String travelerId) {
    return _firestore
        .collection('share_history')
        .where('travelerId', isEqualTo: travelerId)
        .orderBy('sharedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
