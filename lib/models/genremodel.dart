class GenreModel {
  final String name, poster_path, character;
  final int id;

  GenreModel({this.name, this.id, this.poster_path, this.character});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
        id: json['id'],
        name: json['name'],
        character: json['character'],
        poster_path: json['profile_path']);
  }
}
