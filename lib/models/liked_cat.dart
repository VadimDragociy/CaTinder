// models/liked_cat.dart
import 'cat.dart';

class LikedCat {
  final Cat cat;
  final DateTime likedDate;

  LikedCat({
    required this.cat,
    required this.likedDate,
  });
}
