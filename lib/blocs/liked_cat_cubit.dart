// blocs/liked_cat_cubit.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catinder/data/cat_repository.dart';
import 'package:catinder/models/cat.dart' as models_cat;
import 'package:catinder/models/liked_cat.dart' as models_liked_cat;
import 'dart:async';

class LikedCatState {
  final List<models_liked_cat.LikedCat> likedCats;
  final String filter;

  int get likeCount => likedCats.length;
  LikedCatState({required this.likedCats, this.filter = ''});

  LikedCatState copyWith({
    List<models_liked_cat.LikedCat>? likedCats,
    String? filter,
  }) {
    return LikedCatState(
      likedCats: likedCats ?? this.likedCats,
      filter: filter ?? this.filter,
    );
  }
}

class LikedCatCubit extends Cubit<LikedCatState> {
  final CatRepository repo;
  LikedCatCubit(this.repo) : super(LikedCatState(likedCats: [])) {
    loadFromDb();
  }
  Future<void> loadFromDb() async {
    final dbLikedCats = await repo.getLikedCats();

    final liked =
        dbLikedCats.map((e) {
          return models_liked_cat.LikedCat(
            cat: models_cat.Cat(
              id: e.cat.id,
              imageUrl: e.cat.imageUrl,
              breedName: e.cat.breedName,
              description: e.cat.description,
            ),
            likedDate: e.likedCat.likedDate,
            autoId: e.likedCat.autoId,
          );
        }).toList();

    emit(state.copyWith(likedCats: liked));
  }

  Future<void> addLikedCat(models_cat.Cat cat) async {
    await repo.likeCat(cat);
    try {
      CachedNetworkImageProvider(
        cat.imageUrl,
      ).resolve(const ImageConfiguration());
    } catch (_) {}
    await loadFromDb();
  }

  Future<void> removeLikedCat(models_liked_cat.LikedCat lc) async {
    await repo.unlikeCat(lc);
    await loadFromDb();
  }

  void updateFilter(String filter) {
    emit(state.copyWith(filter: filter));
  }

  List<models_liked_cat.LikedCat> get filteredLikedCats {
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
