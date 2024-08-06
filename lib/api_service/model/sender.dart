class Sender {
  String id;
  String fullName;
  String photoUrl;

  Sender({
    required this.id,
    required this.fullName,
    required this.photoUrl,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    fullName: json["full_name"],
    photoUrl: json["photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "photo_url": photoUrl,
  };
}