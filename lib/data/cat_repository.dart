// data/cat_repository.dart
import 'package:dio/dio.dart';
import 'package:catinder/models/cat.dart';

class CatRepository {
  final Dio dio;
  CatRepository({required this.dio});

  Future<Cat> fetchRandomCat() async {
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
        return Cat(
          id: catData['id'] ?? '',
          imageUrl: catData['url'] ?? '',
          breedName: catData['breeds'][0]['name'] ?? 'Unknown',
          description:
              catData['breeds'][0]['description'] ?? 'No description available',
        );
      } else {
        throw Exception('Информация о породе отсутствует');
      }
    } else {
      throw Exception('Некорректный ответ сервера');
    }
  }
}
