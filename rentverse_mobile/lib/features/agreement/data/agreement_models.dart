import 'dart:convert';

/// Represents a rental agreement
class Agreement {
  final String id;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final String currencyCode;
  final double rentAmount;
  final double? securityDeposit;
  final String? notes;

  final Party landlord;
  final Party tenant;
  final Property property;
  final Signatures? signatures;

  Agreement({
    required this.id,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.currencyCode,
    required this.rentAmount,
    this.securityDeposit,
    this.notes,
    required this.landlord,
    required this.tenant,
    required this.property,
    this.signatures,
  });

  factory Agreement.fromJson(Map<String, dynamic> json) => Agreement(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt']),
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        currencyCode: json['currencyCode'],
        rentAmount: (json['rentAmount'] as num).toDouble(),
        securityDeposit: json['securityDeposit'] != null
            ? (json['securityDeposit'] as num).toDouble()
            : null,
        notes: json['notes'],
        landlord: Party.fromJson(json['landlord']),
        tenant: Party.fromJson(json['tenant']),
        property: Property.fromJson(json['property']),
        signatures: json['signatures'] != null
            ? Signatures.fromJson(json['signatures'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'currencyCode': currencyCode,
        'rentAmount': rentAmount,
        'securityDeposit': securityDeposit,
        'notes': notes,
        'landlord': landlord.toJson(),
        'tenant': tenant.toJson(),
        'property': property.toJson(),
        'signatures': signatures?.toJson(),
      };
}

/// Represents either the landlord or tenant
class Party {
  final String id;
  final String name;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String email;

  Party({
    required this.id,
    required this.name,
    this.firstName,
    this.lastName,
    this.phone,
    required this.email,
  });

  factory Party.fromJson(Map<String, dynamic> json) => Party(
        id: json['id'],
        name: json['name'] ?? '${json['firstName']} ${json['lastName']}',
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
      };
}

/// Represents the property being rented
class Property {
  final String id;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String propertyType;
  final int bedrooms;
  final int bathrooms;
  final double? areaSqm;
  final bool furnished;
  final List<String>? amenities;
  final String? description;

  Property({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    this.areaSqm,
    required this.furnished,
    this.amenities,
    this.description,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json['id'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
        zipCode: json['zipCode'],
        country: json['country'],
        propertyType: json['propertyType']['name'] ?? json['propertyType'],
        bedrooms: json['bedrooms'],
        bathrooms: json['bathrooms'],
        areaSqm:
            json['areaSqm'] != null ? (json['areaSqm'] as num).toDouble() : null,
        furnished: json['furnished'] ?? false,
        amenities: json['amenities'] != null
            ? List<String>.from(json['amenities'].map((a) => a['amenity']['name']))
            : null,
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
        'propertyType': {'name': propertyType},
        'bedrooms': bedrooms,
        'bathrooms': bathrooms,
        'areaSqm': areaSqm,
        'furnished': furnished,
        'amenities': amenities != null
            ? amenities!.map((a) => {'amenity': {'name': a}}).toList()
            : null,
        'description': description,
      };
}

class Lease {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final Party tenant;
  final Party landlord;
  final Property property;
  final double rentAmount;
  final double? securityDeposit;
  final String currencyCode;
  final String? notes;
  final DateTime createdAt;

  Lease({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.tenant,
    required this.landlord,
    required this.property,
    required this.rentAmount,
    this.securityDeposit,
    required this.currencyCode,
    this.notes,
    required this.createdAt,
  });
}

/// Holds digital signature information
class Signatures {
  final SignatureInfo? landlord;
  final SignatureInfo? tenant;

  Signatures({this.landlord, this.tenant});

  factory Signatures.fromJson(Map<String, dynamic> json) => Signatures(
        landlord: json['landlord'] != null
            ? SignatureInfo.fromJson(json['landlord'])
            : null,
        tenant:
            json['tenant'] != null ? SignatureInfo.fromJson(json['tenant']) : null,
      );

  Map<String, dynamic> toJson() => {
        'landlord': landlord?.toJson(),
        'tenant': tenant?.toJson(),
      };
}

/// Single signature info
class SignatureInfo {
  final String? qrCode; // base64 or URL to QR code image
  final String? signDate;

  SignatureInfo({this.qrCode, this.signDate});

  factory SignatureInfo.fromJson(Map<String, dynamic> json) => SignatureInfo(
        qrCode: json['qrCode'],
        signDate: json['signDate'],
      );

  Map<String, dynamic> toJson() => {
        'qrCode': qrCode,
        'signDate': signDate,
      };
}