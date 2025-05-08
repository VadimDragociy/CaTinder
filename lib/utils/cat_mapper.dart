// lib/data/local/cat_mapper.dart\
// some of this may be unused
import 'package:catinder/models/cat.dart' as domain;
import 'package:catinder/data/local/app_database.dart' as db;
import 'package:catinder/models/liked_cat.dart' as domain_lc;

domain.Cat catFromDb(db.Cat c) => domain.Cat(
  id: c.id,
  imageUrl: c.imageUrl,
  breedName: c.breedName,
  description: c.description,
);

db.Cat catToDb(domain.Cat c) => db.Cat(
  id: c.id,
  imageUrl: c.imageUrl,
  breedName: c.breedName,
  description: c.description,
);

db.LikedCat likedCatToDb(domain_lc.LikedCat c) => db.LikedCat(
  autoId: c.autoId,
  likedDate: c.likedDate,
  catId: c.autoId.toString(),
);

domain_lc.LikedCat likedCatFromDb(db.LikedCat lcDb, db.Cat cDb) =>
    domain_lc.LikedCat(
      autoId: lcDb.autoId, // int!
      cat: catFromDb(cDb),
      likedDate: lcDb.likedDate,
    );
