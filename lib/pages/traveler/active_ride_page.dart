import 'package:flutter/material.dart';
import 'package:ride_tracking_platform/models/ride.dart';
import 'package:ride_tracking_platform/services/ride_service.dart';

class ActiveRidePage extends StatefulWidget {
  final Ride ride;

  const ActiveRidePage({super.key, required this.ride});

  @override
  State<ActiveRidePage> createState() => _ActiveRidePageState();
}

class _ActiveRidePageState extends State<ActiveRidePage> {
  final RideService _rideService = RideService();
  bool _isSharing = false;

  Future<void> _shareRide() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      await _rideService.updateRideStatus(widget.ride.id, 'shared');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride shared successfully')),
        );
        Navigator.pop(context, true); // Return to previous page
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing ride: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Ride')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pickup: ${widget.ride.pickup}'),
            Text('Drop: ${widget.ride.drop}'),
            Text('Driver: ${widget.ride.driverName}'),
            Text('Cab: ${widget.ride.cabNumber}'),
            Text('Status: ${widget.ride.status}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSharing ? null : _shareRide,
              child: _isSharing
                  ? const CircularProgressIndicator()
                  : const Text('Share Ride'),
            ),
          ],
        ),
      ),
    );
  }
}
