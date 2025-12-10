class User {
  final int? id;
  final String email;
  final String? password; // In real app, this should be hashed
  final String name;
  final String? phone;
  final String? address;
  final String? avatarUrl;

  User({
    this.id,
    required this.email,
    this.password,
    required this.name,
    this.phone,
    this.address,
    this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'address': address,
      'avatar_url': avatarUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      avatarUrl: map['avatar_url'],
    );
  }

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    String? phone,
    String? address,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
