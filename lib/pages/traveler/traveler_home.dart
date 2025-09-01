import 'package:flutter/material.dart';
import 'package:ride_tracking_platform/services/ride_service.dart';
import 'package:ride_tracking_platform/models/ride.dart';
import '../../constants/routes.dart';

class TravelerHome extends StatefulWidget {
  final String travelerId;

  const TravelerHome({super.key, required this.travelerId});

  @override
  State<TravelerHome> createState() => _TravelerHomeState();
}

class _TravelerHomeState extends State<TravelerHome> {
  final RideService _rideService = RideService();
  List<Ride> _rides = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRides();
  }

  Future<void> _fetchRides() async {
    try {
      print('Fetching rides in TravelerHome...'); // Debug log
      final rides = await _rideService.fetchRides(widget.travelerId);
      setState(() {
        _rides = rides;
        _isLoading = false;
      });
      print('Rides fetched: $_rides'); // Debug log
    } catch (e) {
      print('Error in TravelerHome: $e'); // Debug log
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error fetching rides: $e')));
      }
    }
  }

  Future<void> _navigateToCreateRide() async {
    // Navigate to CreateRidePage and wait for it to complete
    final result = await Navigator.pushNamed(context, Routes.createRide);

    // If a new ride was created, refresh the ride list
    if (result == true) {
      _fetchRides();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rides'),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _rides.isEmpty
          ? const Center(child: Text('No rides found'))
          : ListView.builder(
              itemCount: _rides.length,
              itemBuilder: (context, index) {
                final ride = _rides[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${ride.pickup} → ${ride.drop}'),
                    subtitle: Text('Driver: ${ride.driverName}'),
                    trailing: Chip(
                      label: Text(ride.status),
                      backgroundColor: ride.status == 'active'
                          ? Colors.green[100]
                          : Colors.grey[300],
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.activeRide,
                      arguments: ride,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToCreateRide, // Call the navigation function
        label: const Text('Create Ride'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
