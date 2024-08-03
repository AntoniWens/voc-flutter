class RoleLgNtResponse {
  bool error;
  String message;
  Data data;

  RoleLgNtResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory RoleLgNtResponse.fromJson(Map<String, dynamic> json) => RoleLgNtResponse(
    error: json["error"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<Role> role;
  List<Language> language;
  List<Nation> nation;

  Data({
    required this.role,
    required this.language,
    required this.nation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
    language: List<Language>.from(json["language"].map((x) => Language.fromJson(x))),
    nation: List<Nation>.from(json["nation"].map((x) => Nation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "role": List<dynamic>.from(role.map((x) => x.toJson())),
    "language": List<dynamic>.from(language.map((x) => x.toJson())),
    "nation": List<dynamic>.from(nation.map((x) => x.toJson())),
  };
}

class Language {
  int id;
  String language;
  String isoCode;
  int enable;

  Language({
    required this.id,
    required this.language,
    required this.isoCode,
    required this.enable,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    language: json["language"],
    isoCode: json["iso_code"],
    enable: json["enable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language": language,
    "iso_code": isoCode,
    "enable": enable,
  };
}

class Nation {
  int id;
  String nationality;
  int enable;

  Nation({
    required this.id,
    required this.nationality,
    required this.enable,
  });

  factory Nation.fromJson(Map<String, dynamic> json) => Nation(
    id: json["id"],
    nationality: json["nationality"],
    enable: json["enable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nationality": nationality,
    "enable": enable,
  };
}

class Role {
  int id;
  String role;
  int enable;

  Role({
    required this.id,
    required this.role,
    required this.enable,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    role: json["role"],
    enable: json["enable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "enable": enable,
  };
}
