import 'package:job_feed/model/jp_village.dart';
import 'package:job_feed/model/jp_commune.dart';
import 'package:job_feed/model/jp_district.dart';
import 'package:job_feed/model/jp_province.dart';

class Address {
  final int id;
  final Province? province;
  final District? district;
  final Commune? commune;
  final Village? village;
  final String? houseNumber;
  final String? streetNumber;
  final String? postCode;

  Address({
    required this.id,
    this.province,
    this.district,
    this.commune,
    this.village,
    this.houseNumber,
    this.streetNumber,
    this.postCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      province: json['province'] != null
          ? Province.fromJson(json['province'] as Map<String, dynamic>)
          : null,
      district: json['district'] != null
          ? District.fromJson(json['district'] as Map<String, dynamic>)
          : null,
      commune: json['commune'] != null
          ? Commune.fromJson(json['commune'] as Map<String, dynamic>)
          : null,
      village: json['village'] != null
          ? Village.fromJson(json['village'] as Map<String, dynamic>)
          : null,
      houseNumber: json['house_number'] as String?,
      streetNumber: json['street_number'] as String?,
      postCode: json['post_code'] as String?,
    );
  }
}