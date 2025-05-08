// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catinder/injection_container.dart';
import 'package:catinder/data/cat_repository.dart';
import 'package:catinder/domain/usecases/get_random_cat.dart';
import 'package:catinder/blocs/cat_bloc.dart';
import 'package:catinder/blocs/liked_cat_cubit.dart';
import 'package:catinder/screens/home_screen.dart';
import 'package:catinder/utils/connectivity_wrapper.dart';

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
        BlocProvider(create: (_) => LikedCatCubit(catRepository)),
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
      builder: (context, child) {
        return ConnectivityWrapper(child: child!);
      },
      home: const CatHomePage(),
    );
  }
}
