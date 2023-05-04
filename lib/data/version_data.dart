/// new_ver : "1.0.3"
/// all_ver_data : [{"ver":"1.0.1","date":"12/12/2009","ver_app":["1.0.1","1.0.2"]},{"ver":"1.0.1","date":"12/12/2009","ver_app":["1.0.1","1.0.2"]},null]

class VersionData {
  VersionData({
    String? newVer,
    List<AllVerData>? allVerData,
  }) {
    _newVer = newVer;
    _allVerData = allVerData;
  }

  VersionData.fromJson(dynamic json) {
    _newVer = json['new_ver'];
    if (json['all_ver_data'] != null) {
      _allVerData = [];
      json['all_ver_data'].forEach((v) {
        _allVerData?.add(AllVerData.fromJson(v));
      });
    }
  }
  String? _newVer;
  List<AllVerData>? _allVerData;
  VersionData copyWith({
    String? newVer,
    List<AllVerData>? allVerData,
  }) =>
      VersionData(
        newVer: newVer ?? _newVer,
        allVerData: allVerData ?? _allVerData,
      );
  String? get newVer => _newVer;
  List<AllVerData>? get allVerData => _allVerData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['new_ver'] = _newVer;
    if (_allVerData != null) {
      map['all_ver_data'] = _allVerData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ver : "1.0.1"
/// date : "12/12/2009"
/// ver_app : ["1.0.1","1.0.2"]

class AllVerData {
  AllVerData({
    String? ver,
    String? date,
    List<String>? verApp,
  }) {
    _ver = ver;
    _date = date;
    _verApp = verApp;
  }

  AllVerData.fromJson(dynamic json) {
    _ver = json['ver'];
    _date = json['date'];
    _verApp = json['ver_app'] != null ? json['ver_app'].cast<String>() : [];
  }
  String? _ver;
  String? _date;
  List<String>? _verApp;
  AllVerData copyWith({
    String? ver,
    String? date,
    List<String>? verApp,
  }) =>
      AllVerData(
        ver: ver ?? _ver,
        date: date ?? _date,
        verApp: verApp ?? _verApp,
      );
  String? get ver => _ver;
  String? get date => _date;
  List<String>? get verApp => _verApp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ver'] = _ver;
    map['date'] = _date;
    map['ver_app'] = _verApp;
    return map;
  }
}
