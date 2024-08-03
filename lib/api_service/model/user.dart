class User {
  String id;
  String fullName;
  String language;

  User({
    required this.id,
    required this.fullName,
    required this.language,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["full_name"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "language": language,
  };
}