// blocs/cat_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_random_cat.dart';
import '../../models/cat.dart';

/// События
abstract class CatEvent {}
class FetchCat extends CatEvent {}

/// Состояния
abstract class CatState {}
class CatInitial extends CatState {}
class CatLoading extends CatState {}
class CatLoaded extends CatState {
  final Cat cat;
  CatLoaded(this.cat);
}
class CatError extends CatState {
  final String message;
  CatError(this.message);
}

/// Bloc для загрузки котиков
class CatBloc extends Bloc<CatEvent, CatState> {
  final GetRandomCat getRandomCat;

  CatBloc({required this.getRandomCat}) : super(CatInitial()) {
    on<FetchCat>((event, emit) async {
      emit(CatLoading());
      try {
        final cat = await getRandomCat();
        emit(CatLoaded(cat));
      } catch (e) {
        emit(CatError(e.toString()));
      }
    });
  }
}
