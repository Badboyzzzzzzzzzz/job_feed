class CreatedBy {
  final int id;
  final String userCode;
  final String fullname;
  final String? phoneNumber;
  final String? email;
  final String? profileImage;
  final String? address;
  final String? dob;
  final String? coverImg;
  final bool online;

  CreatedBy({
    required this.id,
    required this.userCode,
    required this.fullname,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.address,
    this.dob,
    this.coverImg,
    required this.online,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'] as int,
      userCode: json['user_code'] as String,
      fullname: json['fullname'] as String,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      profileImage: json['profile_image'] as String?,
      address: json['address'] as String?,
      dob: json['dob'] as String?,
      coverImg: json['cover_img'] as String?,
      online: json['online'] as bool? ?? false,
    );
  }
}

class Company {
  final int id;
  final String name;
  final String? logo;
  final String? description;
  final String? email;
  final String? phone;
  final String? website;
  final String? specialize;
  final String? createdAt;
  final CreatedBy? createdBy;

  Company({
    required this.id,
    required this.name,
    this.logo,
    this.description,
    this.email,
    this.phone,
    this.website,
    this.specialize,
    this.createdAt,
    this.createdBy,
  });

  static String _cleanPath(String path) {
    String cleanedPath = path;
    if (cleanedPath.startsWith('/static/media/')) {
      cleanedPath = cleanedPath.replaceFirst('/static/media/', '');
    }
    if (!cleanedPath.startsWith('http://') &&
        !cleanedPath.startsWith('https://')) {
      cleanedPath = 'https://$cleanedPath';
    }
    return cleanedPath;
  }

  String? get logoUrl {
    if (logo == null || logo!.isEmpty) return null;
    if (logo!.startsWith('http://') || logo!.startsWith('https://')) {
      return logo;
    }
    return _cleanPath(logo!);
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      specialize: json['specialize'] as String?,
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] != null
          ? CreatedBy.fromJson(json['created_by'] as Map<String, dynamic>)
          : null,
    );
  }
}
