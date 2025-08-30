import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String id;
  final String tripId;
  final String travelerId;
  final String driverName;
  final String driverPhone;
  final String cabNumber;
  final String pickup;
  final String drop;
  final String status;
  final Timestamp sharedAt;
  final Timestamp? completedAt;

  Ride({
    required this.id,
    required this.tripId,
    required this.travelerId,
    required this.driverName,
    required this.driverPhone,
    required this.cabNumber,
    required this.pickup,
    required this.drop,
    required this.status,
    required this.sharedAt,
    this.completedAt,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
    id: json['id'],
    tripId: json['tripId'],
    travelerId: json['travelerId'],
    driverName: json['driverName'],
    driverPhone: json['driverPhone'],
    cabNumber: json['cabNumber'],
    pickup: json['pickup'],
    drop: json['drop'],
    status: json['status'],
    sharedAt: json['sharedAt'],
    completedAt: json['completedAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'tripId': tripId,
    'travelerId': travelerId,
    'driverName': driverName,
    'driverPhone': driverPhone,
    'cabNumber': cabNumber,
    'pickup': pickup,
    'drop': drop,
    'status': status,
    'sharedAt': sharedAt,
    'completedAt': completedAt,
  };
}
