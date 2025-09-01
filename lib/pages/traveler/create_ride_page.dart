import 'package:flutter/material.dart';
import 'package:ride_tracking_platform/services/ride_service.dart';
import 'package:ride_tracking_platform/models/ride.dart';
import 'package:uuid/uuid.dart';

class CreateRidePage extends StatefulWidget {
  const CreateRidePage({super.key});

  @override
  State<CreateRidePage> createState() => _CreateRidePageState();
}

class _CreateRidePageState extends State<CreateRidePage> {
  final TextEditingController _travelerIdController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _driverPhoneController = TextEditingController();
  final TextEditingController _cabNumberController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropController = TextEditingController();

  final RideService _rideService = RideService();
  bool _isLoading = false;

  @override
  void dispose() {
    _travelerIdController.dispose();
    _driverNameController.dispose();
    _driverPhoneController.dispose();
    _cabNumberController.dispose();
    _pickupController.dispose();
    _dropController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateRide() async {
    if (_isLoading) return;

    if (_travelerIdController.text.isEmpty ||
        _driverNameController.text.isEmpty ||
        _driverPhoneController.text.isEmpty ||
        _cabNumberController.text.isEmpty ||
        _pickupController.text.isEmpty ||
        _dropController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final ride = Ride(
        id: const Uuid().v4(),
        travelerId: _travelerIdController.text.trim(),
        driverName: _driverNameController.text.trim(),
        driverPhone: _driverPhoneController.text.trim(),
        cabNumber: _cabNumberController.text.trim(),
        pickup: _pickupController.text.trim(),
        drop: _dropController.text.trim(),
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await _rideService.createRide(ride);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride created successfully')),
        );
        Navigator.pop(context, true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Ride')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _travelerIdController,
              decoration: const InputDecoration(
                labelText: 'Traveler ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _driverNameController,
              decoration: const InputDecoration(
                labelText: 'Driver Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _driverPhoneController,
              decoration: const InputDecoration(
                labelText: 'Driver Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cabNumberController,
              decoration: const InputDecoration(
                labelText: 'Cab Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pickupController,
              decoration: const InputDecoration(
                labelText: 'Pickup Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dropController,
              decoration: const InputDecoration(
                labelText: 'Drop Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleCreateRide,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Create Ride'),
            ),
          ],
        ),
      ),
    );
  }
}
