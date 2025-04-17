// injection_container.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:catinder/data/cat_repository.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<CatRepository>(() => CatRepository(dio: sl<Dio>()));
}
