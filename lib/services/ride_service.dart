import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride.dart';

class RideService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createRide(Ride ride) async {
    try {
      await _firestore.collection('rides').doc(ride.id).set(ride.toJson());
    } catch (e) {
      throw Exception('Failed to create ride: $e');
    }
  }

  Stream<List<Ride>> getActiveRides(String travelerId) {
    return _firestore
        .collection('rides')
        .where('travelerId', isEqualTo: travelerId)
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Ride.fromJson(doc.data())).toList(),
        );
  }

  Future<void> completeRide(String rideId) async {
    try {
      await _firestore.collection('rides').doc(rideId).update({
        'status': 'completed',
        'completedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to complete ride: $e');
    }
  }

  Future<Ride> getRideById(String id) async {
    try {
      final doc = await _firestore.collection('rides').doc(id).get();
      return Ride.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get ride: $e');
    }
  }

  Stream<List<Ride>> getAllRides() {
    return _firestore
        .collection('rides')
        .orderBy('sharedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Ride.fromJson(doc.data())).toList(),
        );
  }
}
