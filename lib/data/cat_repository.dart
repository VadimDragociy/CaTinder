// data/cat_repository.dart
import 'package:dio/dio.dart';
import 'package:catinder/data/local/app_database.dart' as database;
import 'package:catinder/models/cat.dart' as domain;
import 'package:catinder/models/liked_cat.dart' as domain_lc;
import 'package:catinder/utils/cat_mapper.dart';

class CatRepository {
  final Dio dio;
  final database.AppDatabase db;
  CatRepository({required this.dio, required this.db});

  Future<database.Cat> fetchRandomCat() async {
    final response = await dio.get(
      'https://api.thecatapi.com/v1/images/search',
      queryParameters: {'limit': 1, 'has_breeds': true},
      options: Options(
        headers: {
          'x-api-key':
              'live_MdrOzTfhdteXurMEPUuHGlsSwqbbQRfwVD2TgpGxIl67UnSAWEtPEBbNj7q62mD5',
        },
      ),
    );
    if (response.data != null && response.data.isNotEmpty) {
      final catData = response.data[0];
      if (catData['breeds'] != null && catData['breeds'].isNotEmpty) {
        final cat = database.Cat(
          id: catData['id'] ?? '',
          imageUrl: catData['url'] ?? '',
          breedName: catData['breeds'][0]['name'] ?? 'Unknown',
          description:
              catData['breeds'][0]['description'] ?? 'No description available',
        );
        await db.insertCat(
          database.CatsCompanion.insert(
            id: cat.id,
            imageUrl: cat.imageUrl,
            breedName: cat.breedName,
            description: cat.description,
          ),
        );
        return cat;
      } else {
        throw Exception('Информация о породе отсутствует');
      }
    } else {
      throw Exception('Некорректный ответ сервера');
    }
  }

  Future<List<database.LikedCatWithCat>> getLikedCats() => db.getAllLikes();
  Future<void> likeCat(domain.Cat cat) => db.likeCat(catToDb(cat).id);
  Future<void> unlikeCat(domain_lc.LikedCat lc) =>
      db.unlikeCat(likedCatToDb(lc).autoId);
}
