class Property {
  final String id;
  final String code;
  final String title;
  final String description;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final dynamic price; // can be int or string
  final String currencyCode;
  final String type;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final double areaSqm;
  final bool furnished;
  final bool isAvailable;
  final int viewCount;
  final double averageRating;
  final int totalRatings;
  final bool isFavorited;
  final int favoriteCount;
  final List<String> images;
  final List<dynamic> amenities; // can be string[] or PropertyAmenity[]
  final double? latitude;
  final double? longitude;
  final String? placeId;
  final String? projectName;
  final String? developer;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String ownerId;
  final String propertyTypeId;
  final PropertyOwner? owner;
  final PropertyTypeDetail? propertyType;
  final String? mapsUrl;

  Property({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.price,
    required this.currencyCode,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.areaSqm,
    required this.furnished,
    required this.isAvailable,
    required this.viewCount,
    required this.averageRating,
    required this.totalRatings,
    required this.isFavorited,
    required this.favoriteCount,
    required this.images,
    required this.amenities,
    this.latitude,
    this.longitude,
    this.placeId,
    this.projectName,
    this.developer,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerId,
    required this.propertyTypeId,
    this.owner,
    this.propertyType,
    this.mapsUrl,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json['id'],
        code: json['code'],
        title: json['title'],
        description: json['description'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
        zipCode: json['zipCode'],
        country: json['country'],
        price: json['price'],
        currencyCode: json['currencyCode'],
        type: json['type'],
        bedrooms: json['bedrooms'],
        bathrooms: json['bathrooms'],
        area: (json['area'] as num).toDouble(),
        areaSqm: (json['areaSqm'] as num).toDouble(),
        furnished: json['furnished'],
        isAvailable: json['isAvailable'],
        viewCount: json['viewCount'],
        averageRating: (json['averageRating'] as num).toDouble(),
        totalRatings: json['totalRatings'],
        isFavorited: json['isFavorited'],
        favoriteCount: json['favoriteCount'],
        images: List<String>.from(json['images'] ?? []),
        amenities: json['amenities'] ?? [],
        latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
        longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
        placeId: json['placeId'],
        projectName: json['projectName'],
        developer: json['developer'],
        status: json['status'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        ownerId: json['ownerId'],
        propertyTypeId: json['propertyTypeId'],
        owner: json['owner'] != null ? PropertyOwner.fromJson(json['owner']) : null,
        propertyType: json['propertyType'] != null
            ? PropertyTypeDetail.fromJson(json['propertyType'])
            : null,
        mapsUrl: json['mapsUrl'],
      );
}

class PropertyOwner {
  final String id;
  final String name;
  final String email;
  final String phone;

  PropertyOwner({required this.id, required this.name, required this.email, required this.phone});

  factory PropertyOwner.fromJson(Map<String, dynamic> json) => PropertyOwner(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
      );
}

class PropertyTypeDetail {
  final String id;
  final String code;
  final String name;
  final String? description;
  final String? icon;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  PropertyTypeDetail({
    required this.id,
    required this.code,
    required this.name,
    this.description,
    this.icon,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PropertyTypeDetail.fromJson(Map<String, dynamic> json) => PropertyTypeDetail(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'],
        icon: json['icon'],
        isActive: json['isActive'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
}

class PropertyAmenity {
  final String propertyId;
  final String amenityId;
  final Amenity amenity;

  PropertyAmenity({required this.propertyId, required this.amenityId, required this.amenity});

  factory PropertyAmenity.fromJson(Map<String, dynamic> json) => PropertyAmenity(
        propertyId: json['propertyId'],
        amenityId: json['amenityId'],
        amenity: Amenity.fromJson(json['amenity']),
      );
}

class Amenity {
  final String id;
  final String name;
  final String category;

  Amenity({required this.id, required this.name, required this.category});

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json['id'],
        name: json['name'],
        category: json['category'],
      );

}

class MapData {
  final double latMean;
  final double longMean;
  final int depth;

  MapData({
    required this.latMean,
    required this.longMean,
    required this.depth,
  });

  factory MapData.fromJson(Map<String, dynamic> json) {
    return MapData(
      latMean: (json['latMean'] as num).toDouble(),
      longMean: (json['longMean'] as num).toDouble(),
      depth: json['depth'],
    );
  }
}