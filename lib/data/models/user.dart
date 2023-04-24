/// name : "test1"
/// birthday : "2002-12-12"
/// avatar : ""
/// address : ""
/// weight : 55.6
/// height : 120.6
/// gender : true
/// email : "vqh2602@gmail.com"
/// updated_at : "2023-03-12T14:05:49.000000Z"
/// created_at : "2023-03-12T14:05:49.000000Z"
/// id : 1

class User {
  User({
    String? name,
    String? birthday,
    String? avatar,
    String? address,
    num? weight,
    num? height,
    num? gender,
    String? email,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) {
    _name = name;
    _birthday = birthday;
    _avatar = avatar;
    _address = address;
    _weight = weight;
    _height = height;
    _gender = gender;
    _email = email;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  User.fromJson(dynamic json) {
    _name = json['name'];
    _birthday = json['birthday'];
    _avatar = json['avatar'];
    _address = json['address'];
    _weight = json['weight'];
    _height = json['height'];
    _gender = json['gender'];
    _email = json['email'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _name;
  String? _birthday;
  String? _avatar;
  String? _address;
  num? _weight;
  num? _height;
  num? _gender;
  String? _email;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  User copyWith({
    String? name,
    String? birthday,
    String? avatar,
    String? address,
    num? weight,
    num? height,
    num? gender,
    String? email,
    String? updatedAt,
    String? createdAt,
    num? id,
  }) =>
      User(
        name: name ?? _name,
        birthday: birthday ?? _birthday,
        avatar: avatar ?? _avatar,
        address: address ?? _address,
        weight: weight ?? _weight,
        height: height ?? _height,
        gender: gender ?? _gender,
        email: email ?? _email,
        updatedAt: updatedAt ?? _updatedAt,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
      );
  String? get name => _name;
  String? get birthday => _birthday;
  String? get avatar => _avatar;
  String? get address => _address;
  num? get weight => _weight;
  num? get height => _height;
  num? get gender => _gender;
  String? get email => _email;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['birthday'] = _birthday;
    map['avatar'] = _avatar;
    map['address'] = _address;
    map['weight'] = _weight;
    map['height'] = _height;
    map['gender'] = _gender;
    map['email'] = _email;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
