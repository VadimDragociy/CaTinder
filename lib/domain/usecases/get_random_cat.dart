// domain/usecases/get_random_cat.dart
import 'package:catinder/data/cat_repository.dart';
import 'package:catinder/models/cat.dart' as models_cat;
import 'package:catinder/utils/cat_mapper.dart';

class GetRandomCat {
  final CatRepository repository;
  GetRandomCat(this.repository);

  Future<models_cat.Cat> call() async {
    return catFromDb(await repository.fetchRandomCat());
  }
}
