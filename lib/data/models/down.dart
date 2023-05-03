class Down {
  String? versionData;
  String? date;
  List<String>? versionApp;
  String? size;
  List<Link>? link;

  Down({this.versionData, this.date, this.versionApp, this.size, this.link});

  Down.fromJson(Map<String, dynamic> json) {
    versionData = json['version_data'];
    date = json['date'];
    versionApp = json['version_app'].cast<String>();
    size = json['size'];
    if (json['link'] != null) {
      link = <Link>[];
      json['link'].forEach((v) {
        link!.add(Link.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version_data'] = versionData;
    data['date'] = date;
    data['version_app'] = versionApp;
    data['size'] = size;
    if (link != null) {
      data['link'] = link!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Link {
  String? name;
  String? url;

  Link({this.name, this.url});

  Link.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
