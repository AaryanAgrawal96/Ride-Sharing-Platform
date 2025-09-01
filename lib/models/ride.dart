import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String id;
  final String travelerId;
  final String driverName;
  final String driverPhone;
  final String cabNumber;
  final String pickup;
  final String drop;
  final String status;
  final DateTime createdAt;

  Ride({
    required this.id,
    required this.travelerId,
    required this.driverName,
    required this.driverPhone,
    required this.cabNumber,
    required this.pickup,
    required this.drop,
    required this.status,
    required this.createdAt,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] as String,
      travelerId: json['travelerId'] as String,
      driverName: json['driverName'] as String,
      driverPhone: json['driverPhone'] as String,
      cabNumber: json['cabNumber'] as String,
      pickup: json['pickup'] as String,
      drop: json['drop'] as String,
      status: json['status'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'travelerId': travelerId,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'cabNumber': cabNumber,
      'pickup': pickup,
      'drop': drop,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
