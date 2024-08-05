class UpdateMessage {
  String id;
  String status;

  UpdateMessage({required this.id, required this.status});

  factory UpdateMessage.fromJson(Map<String, dynamic> json) => UpdateMessage(id: json['id'], status: json['status']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status
  };
}