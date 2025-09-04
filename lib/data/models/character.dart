class Character {
  late List<Result> results;

  Character({
    required this.results,
  });
  Character.fromJson(Map<String, dynamic> json) {
    results = (json['results'] as List<dynamic>)
        .map((result) => Result.fromJson(result))
        .toList();
  }
}

class Result {
  late int id;
  late String name;
  late String image;
  late String url;
  Result({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
  }
}
