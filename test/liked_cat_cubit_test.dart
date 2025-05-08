import 'package:catinder/data/local/app_database.dart' as db;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:catinder/blocs/liked_cat_cubit.dart';
import 'package:catinder/data/cat_repository.dart';
import 'package:catinder/models/cat.dart';
import 'package:catinder/models/liked_cat.dart';
import 'package:bloc_test/bloc_test.dart';

class MockRepo extends Mock implements CatRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRepo mockRepo;

  final testCat = Cat(
    id: '1',
    imageUrl: 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg',
    breedName: 'Siamese',
    description: '',
  );
  final likedCat = LikedCat(
    autoId: 42,
    cat: testCat,
    likedDate: DateTime(2025),
  );

  final dbEntry = db.LikedCatWithCat(
    likedCat: db.LikedCat(autoId: 42, catId: '1', likedDate: DateTime(2025)),
    cat: const db.Cat(
      id: '1',
      imageUrl: 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg',
      breedName: 'Siamese',
      description: '',
    ),
  );

  blocTest<LikedCatCubit, LikedCatState>(
    'загружает начальные лайки',
    setUp: () {
      mockRepo = MockRepo();
      when(() => mockRepo.getLikedCats()).thenAnswer((_) async => [dbEntry]);
    },
    build: () => LikedCatCubit(mockRepo),
    expect:
        () => [
          predicate<LikedCatState>(
            (s) =>
                s.likedCats.length == 1 &&
                s.likedCats.first.autoId == 42 &&
                s.filter == '',
          ),
        ],
    verify: (_) => verify(() => mockRepo.getLikedCats()).called(1),
  );

  blocTest<LikedCatCubit, LikedCatState>(
    'лайкает кота',
    setUp: () {
      mockRepo = MockRepo();
      when(() => mockRepo.getLikedCats()).thenAnswer((_) async => []);
      when(() => mockRepo.likeCat(testCat)).thenAnswer((_) async {});
      when(() => mockRepo.getLikedCats()).thenAnswer((_) async => [dbEntry]);
    },
    build: () => LikedCatCubit(mockRepo),
    act: (c) => c.addLikedCat(testCat),
    skip: 1,
    expect:
        () => [
          predicate<LikedCatState>(
            (s) =>
                s.likedCats.length == 1 &&
                s.likedCats.first.autoId == 42 &&
                s.filter == '',
          ),
        ],
    verify: (_) {
      verify(() => mockRepo.likeCat(testCat)).called(1);
    },
  );

  blocTest<LikedCatCubit, LikedCatState>(
    'снимает лайк',
    setUp: () {
      mockRepo = MockRepo();
      when(() => mockRepo.getLikedCats()).thenAnswer((_) async => [dbEntry]);
      when(() => mockRepo.unlikeCat(likedCat)).thenAnswer((_) async {});
      when(() => mockRepo.getLikedCats()).thenAnswer((_) async => []);
    },
    build: () => LikedCatCubit(mockRepo),
    act: (c) => c.removeLikedCat(likedCat),
    skip: 1,
    expect: () => [predicate<LikedCatState>((s) => s.likedCats.isEmpty)],
    verify: (_) {
      verify(() => mockRepo.unlikeCat(likedCat)).called(1);
    },
  );
}
