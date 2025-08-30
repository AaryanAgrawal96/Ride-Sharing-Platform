import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String id;
  final String rideId;
  final String companionId;
  final double rating;
  final String comment;
  final Timestamp createdAt;

  FeedbackModel({
    required this.id,
    required this.rideId,
    required this.companionId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
    id: json['id'],
    rideId: json['rideId'],
    companionId: json['companionId'],
    rating: json['rating'].toDouble(),
    comment: json['comment'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'rideId': rideId,
    'companionId': companionId,
    'rating': rating,
    'comment': comment,
    'createdAt': createdAt,
  };
}
