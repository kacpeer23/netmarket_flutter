import 'package:cloud_firestore/cloud_firestore.dart';

class AddressInfo {
  final String address;
  final String date;
  final String mobileNumber;
  final String name;
  final String pincode;
  final DateTime time;

  AddressInfo({
    required this.address,
    required this.date,
    required this.mobileNumber,
    required this.name,
    required this.pincode,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'date': date,
      'mobileNumber': mobileNumber,
      'name': name,
      'pincode': pincode,
      'time': time.toIso8601String(),
    };
  }

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      address: map['address'] as String,
      date: map['date'] as String,
      mobileNumber: map['mobileNumber'] as String,
      name: map['name'] as String,
      pincode: map['pincode'] as String,
      time: map['time'] is Timestamp
          ? (map['time'] as Timestamp).toDate() // Convert Timestamp to DateTime
          : DateTime.parse(map['time'] as String), // Parsing the ISO8601 string to DateTime
    );
  }
}
