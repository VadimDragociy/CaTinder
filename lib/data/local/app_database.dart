// data/local/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Cats extends Table {
  TextColumn get id => text()();
  TextColumn get imageUrl => text()();
  TextColumn get breedName => text()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class LikedCatWithCat {
  final LikedCat likedCat;
  final Cat cat;

  LikedCatWithCat({required this.likedCat, required this.cat});
}

class LikedCats extends Table {
  IntColumn get autoId => integer().autoIncrement()();
  TextColumn get catId =>
      text().customConstraint('REFERENCES cats(id) NOT NULL')();
  DateTimeColumn get likedDate => dateTime()();
}

@DriftDatabase(tables: [Cats, LikedCats])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertCat(CatsCompanion entry) =>
      into(cats).insertOnConflictUpdate(entry);

  Future<List<Cat>> getAllCats() async {
    final rows = await select(cats).get();
    return rows
        .map(
          (row) => Cat(
            id: row.id,
            imageUrl: row.imageUrl,
            breedName: row.breedName,
            description: row.description,
          ),
        )
        .toList();
  }

  Future<void> likeCat(String catId) => into(likedCats).insert(
    LikedCatsCompanion(catId: Value(catId), likedDate: Value(DateTime.now())),
  );
  Future<void> unlikeCat(int autoId) =>
      (delete(likedCats)..where((t) => t.autoId.equals(autoId))).go();

  Future<List<LikedCatWithCat>> getAllLikes() async {
    final query = select(
      likedCats,
    ).join([leftOuterJoin(cats, cats.id.equalsExp(likedCats.catId))]);

    final results = await query.get();
    return results.map((row) {
      return LikedCatWithCat(
        likedCat: row.readTable(likedCats),
        cat: row.readTable(cats),
      );
    }).toList();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final docs = await getApplicationDocumentsDirectory();
    final file = File(p.join(docs.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}
