class Actors {
  List<Actor> actores = new List();
  Actors();

  Actors.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((element) {
      final actor = new Actor.fromJsonMap(element);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    this.castId = json['cast_id'];
    this.character = json['character'];
    this.creditId = json['credit_id'];
    this.gender = json['gender'];
    this.id = json['id'];
    this.name = json['name'];
    this.order = json['order'];
    this.profilePath = json['profile_path'];
  }

  getPhoto() {
    if (profilePath == null) {
      return 'https://cdn.iconscout.com/icon/free/png-256/avatar-375-456327.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
