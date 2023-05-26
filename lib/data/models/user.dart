import 'dart:convert';

class User {
  String? email;
  String? name;
  String? id;
  String? identifier; // gói đăng kí 1_month , 1_year
  DateTime? latestPurchaseDate; // ngàY CÒN DỊCH VỤ ( NGÀY MUA MỚI NHẤT)
  User({
    this.email,
    this.name,
    this.id,
    this.identifier,
    this.latestPurchaseDate,
  });

  User copyWith({
    String? email,
    String? name,
    String? id,
    String? identifier,
    DateTime? latestPurchaseDate,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
      identifier: identifier ?? this.identifier,
      latestPurchaseDate: latestPurchaseDate ?? this.latestPurchaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'id': id,
      'identifier': identifier,
      'latestPurchaseDate': latestPurchaseDate?.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      name: map['name'],
      id: map['id'],
      identifier: map['identifier'],
      latestPurchaseDate: map['latestPurchaseDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['latestPurchaseDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(email: $email, name: $name, id: $id, identifier: $identifier, latestPurchaseDate: $latestPurchaseDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email == email &&
        other.name == name &&
        other.id == id &&
        other.identifier == identifier &&
        other.latestPurchaseDate == latestPurchaseDate;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        id.hashCode ^
        identifier.hashCode ^
        latestPurchaseDate.hashCode;
  }
}
