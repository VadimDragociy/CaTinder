// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart';
import 'data/cat_repository.dart';
import 'domain/usecases/get_random_cat.dart';
import 'blocs/cat_bloc.dart';
import 'blocs/liked_cat_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  setup();
  final catRepository = sl<CatRepository>();
  final getRandomCat = GetRandomCat(catRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CatBloc(getRandomCat: getRandomCat)..add(FetchCat()),
        ),
        BlocProvider(create: (_) => LikedCatCubit()),
      ],
      child: const CatApp(),
    ),
  );
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Tinder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CatHomePage(),
    );
  }
}

