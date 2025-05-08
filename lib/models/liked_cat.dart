// models/liked_cat.dart
import 'package:catinder/models/cat.dart';

class LikedCat {
  final int autoId;
  final Cat cat;
  final DateTime likedDate;
  LikedCat({required this.autoId, required this.cat, required this.likedDate});
}
