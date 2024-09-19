class BrowserResponse {
  BrowserResponse({this.genres, this.message, this.status_message});

  BrowserResponse.fromJson(dynamic json) {
    message = json['message'];
    status_message = json['status_message'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Browser.fromJson(v));
      });
    }
  }
  List<Browser>? genres;
  String? message;
  String? status_message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Browser {
  Browser({
    this.id,
    this.name,
  });

  Browser.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}