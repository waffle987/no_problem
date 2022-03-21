import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel {
  final String id;
  final String name;
  final String description;
  final String numberOfParties;
  final String nameOfParties;
  final String phoneNumber;
  final Timestamp timestamp;

  ComplaintModel({
    required this.id,
    required this.name,
    required this.description,
    required this.numberOfParties,
    required this.nameOfParties,
    required this.phoneNumber,
    required this.timestamp,
  });

  factory ComplaintModel.fromDocument({required DocumentSnapshot doc}) {
    return ComplaintModel(
      id: doc['id'],
      name: doc['name'],
      description: doc['description'],
      numberOfParties: doc['numberOfParties'],
      nameOfParties: doc['nameOfOtherParties'],
      phoneNumber: doc['phoneNumber'],
      timestamp: doc['timestamp'],
    );
  }
}
