import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel {
  final String name;
  final String description;
  final String numberOfParties;
  final String nameOfParties;
  final String phoneNumber;
  final Timestamp timestamp;

  ComplaintModel({
    required this.name,
    required this.description,
    required this.numberOfParties,
    required this.nameOfParties,
    required this.phoneNumber,
    required this.timestamp,
  });

  factory ComplaintModel.fromDocument({required DocumentSnapshot doc}) {
    return ComplaintModel(
      name: doc['name'],
      description: doc['description'],
      numberOfParties: doc['numberOfParties'],
      nameOfParties: doc['nameOfParties'],
      phoneNumber: doc['phoneNumber'],
      timestamp: doc['timestamp'],
    );
  }
}
