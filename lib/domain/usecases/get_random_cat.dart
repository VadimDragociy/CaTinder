// domain/usecases/get_random_cat.dart
import '../../data/cat_repository.dart';
import '../../models/cat.dart';

class GetRandomCat {
  final CatRepository repository;
  GetRandomCat(this.repository);

  Future<Cat> call() async {
    return await repository.fetchRandomCat();
  }
}
