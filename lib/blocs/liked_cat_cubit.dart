// blocs/liked_cat_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catinder/models/cat.dart';
import 'package:catinder/models/liked_cat.dart';

class LikedCatState {
  final List<LikedCat> likedCats;
  final String
  filter;

  int get likeCount => likedCats.length;
  LikedCatState({required this.likedCats, this.filter = ''});

  LikedCatState copyWith({List<LikedCat>? likedCats, String? filter}) {
    return LikedCatState(
      likedCats: likedCats ?? this.likedCats,
      filter: filter ?? this.filter,
    );
  }
}

class LikedCatCubit extends Cubit<LikedCatState> {
  LikedCatCubit() : super(LikedCatState(likedCats: []));

  void addLikedCat(Cat cat) {
    final likedCat = LikedCat(cat: cat, likedDate: DateTime.now());
    emit(state.copyWith(likedCats: List.from(state.likedCats)..add(likedCat)));
  }

  void removeLikedCat(LikedCat likedCat) {
    emit(
      state.copyWith(likedCats: List.from(state.likedCats)..remove(likedCat)),
    );
  }

  void updateFilter(String filter) {
    emit(state.copyWith(filter: filter));
  }

  List<LikedCat> get filteredLikedCats {
    if (state.filter.isEmpty) return state.likedCats;
    return state.likedCats
        .where(
          (likedCat) => likedCat.cat.breedName.toLowerCase().contains(
            state.filter.toLowerCase(),
          ),
        )
        .toList();
  }
}
