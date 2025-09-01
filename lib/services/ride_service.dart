import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride.dart';

class RideService {
  final _ridesCollection = FirebaseFirestore.instance.collection('rides');

  Future<String> createRide(Ride ride) async {
    try {
      final docRef = await _ridesCollection.add(ride.toJson());
      return docRef.id;
    } catch (e) {
      print('Error creating ride: $e');
      rethrow;
    }
  }

  Future<List<Ride>> fetchRides(String travelerId) async {
    try {
      print('Fetching rides for travelerId: $travelerId'); // Debug log
      final querySnapshot = await _ridesCollection
          .where(
            'travelerId',
            isEqualTo: 'Aaryan',
          ) // Replace with a known travelerId
          .get();

      print('Raw Firestore query results: ${querySnapshot.docs}'); // Debug log

      final rides = querySnapshot.docs
          .map((doc) => Ride.fromJson(doc.data()))
          .toList();

      print('Fetched rides: $rides'); // Debug log
      return rides;
    } catch (e) {
      print('Error fetching rides: $e');
      rethrow;
    }
  }

  Future<Ride?> fetchActiveRide(String travelerId) async {
    try {
      print('Fetching active ride for travelerId: $travelerId'); // Debug log
      final querySnapshot = await _ridesCollection
          .where('travelerId', isEqualTo: travelerId)
          .where('status', isEqualTo: 'active')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final activeRide = Ride.fromJson(querySnapshot.docs.first.data());
        print('Fetched active ride: $activeRide'); // Debug log
        return activeRide;
      }
      print('No active ride found'); // Debug log
      return null;
    } catch (e) {
      print('Error fetching active ride: $e');
      rethrow;
    }
  }

  Future<void> updateRideStatus(String rideId, String status) async {
    try {
      await _ridesCollection.doc(rideId).update({
        'status': status,
        'sharedAt': status == 'shared' ? Timestamp.now() : null,
      });
      print('Ride status updated to $status'); // Debug log
    } catch (e) {
      print('Error updating ride status: $e');
      rethrow;
    }
  }
}
