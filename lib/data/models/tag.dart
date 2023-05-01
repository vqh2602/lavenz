/// version_data : "1.0.0"
/// date : "26/02/2023"
/// version_app : ["1.0.0","1.0.1"]
/// data : [{"id":"1","name":"Sóng não","des":"Brainwave","type":"1"},{"id":"2","name":"Động vật","des":"Animal","type":"1"},{"id":"3","name":"Giai điệu","des":"Melodies","type":"1"},{"id":"4","name":"Thành phố","des":"City","type":"1"},{"id":"5","name":"Đồng quê","des":"Bucolic","type":"1"},{"id":"6","name":"Thiên nhiên","des":"Nature","type":"1"},{"id":"7","name":"Nước","des":"Water","type":"1"},{"id":"8","name":"Thời tiết","des":"Weather","type":"1"},{"id":"9","name":"Nhạc cụ","des":"Instrument","type":"1"},{"id":"10","name":"Nhà","des":"Home","type":"1"},{"id":"11","name":"Vũ trụ","des":"Universe","type":"1"},{"id":"12","name":" Thư giãn","des":"relax","type":"2"},{"id":"13","name":"Tập trung","des":"","type":"2"},{"id":"14","name":"Tâm trạng","des":"","type":"2"},{"id":"15","name":"Tri liệu","des":"","type":"2"},{"id":"16","name":"Thiền","des":"Meditation","type":"2"},{"id":"17","name":"Ngủ","des":"Deep Sleep","type":"2"},{"id":"18","name":"Thiên nhiên","des":"","type":"2"}]

class Tag {
  Tag({
    String? versionData,
    String? date,
    List<String>? versionApp,
    List<Data>? data,
  }) {
    _versionData = versionData;
    _date = date;
    _versionApp = versionApp;
    _data = data;
  }

  Tag.fromJson(dynamic json) {
    _versionData = json['version_data'];
    _date = json['date'];
    _versionApp =
        json['version_app'] != null ? json['version_app'].cast<String>() : [];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _versionData;
  String? _date;
  List<String>? _versionApp;
  List<Data>? _data;
  Tag copyWith({
    String? versionData,
    String? date,
    List<String>? versionApp,
    List<Data>? data,
  }) =>
      Tag(
        versionData: versionData ?? _versionData,
        date: date ?? _date,
        versionApp: versionApp ?? _versionApp,
        data: data ?? _data,
      );
  String? get versionData => _versionData;
  String? get date => _date;
  List<String>? get versionApp => _versionApp;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version_data'] = _versionData;
    map['date'] = _date;
    map['version_app'] = _versionApp;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// name : "Sóng não"
/// des : "Brainwave"
/// type : "1"

class Data {
  Data({
    String? id,
    String? name,
    String? des,
    String? type,
  }) {
    _id = id;
    _name = name;
    _des = des;
    _type = type;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _des = json['des'];
    _type = json['type'];
  }
  String? _id;
  String? _name;
  String? _des;
  String? _type;
  Data copyWith({
    String? id,
    String? name,
    String? des,
    String? type,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        des: des ?? _des,
        type: type ?? _type,
      );
  String? get id => _id;
  String? get name => _name;
  String? get des => _des;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['des'] = _des;
    map['type'] = _type;
    return map;
  }
}
