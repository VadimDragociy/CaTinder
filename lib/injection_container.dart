// injection_container.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'data/cat_repository.dart';

final sl = GetIt.instance;

void setup() {
  // Регистрируем Dio (можно настроить глобальные параметры)
  sl.registerLazySingleton<Dio>(() => Dio());
  // Регистрируем CatRepository, который зависит от Dio
  sl.registerLazySingleton<CatRepository>(() => CatRepository(dio: sl<Dio>()));
}
