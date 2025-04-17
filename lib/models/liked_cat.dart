// models/liked_cat.dart
import 'package:catinder/models/cat.dart';

class LikedCat {
  final Cat cat;
  final DateTime likedDate;

  LikedCat({required this.cat, required this.likedDate});
}
