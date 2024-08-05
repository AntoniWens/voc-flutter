

import 'package:floor/floor.dart';

@Entity()
class AllChat {
  @PrimaryKey()
  String id;
  String userOneId;
  String userOneFullname;
  String userOneLanguage;
  String userTwoId;
  String userTwoFullname;
  String userTwoLanguage;

  AllChat({
      required this.id,
      required this.userOneId,
      required this.userOneFullname,
      required this.userOneLanguage,
      required this.userTwoId,
      required this.userTwoFullname,
      required this.userTwoLanguage,});
}