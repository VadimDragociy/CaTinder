// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cat_bloc.dart';
import '../../blocs/liked_cat_cubit.dart';
import 'detailed_screen.dart';
import 'liked_cats_screen.dart';

class CatHomePage extends StatelessWidget {
  const CatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Tinder'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LikedCatsScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<CatBloc, CatState>(
        listener: (context, state) {
          if (state is CatError) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Ошибка сети'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('ОК'),
                  )
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CatLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CatLoaded) {
            final cat = state.cat;
            return GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  context.read<CatBloc>().add(FetchCat());
                } else if (details.primaryVelocity! < 0) {
                  context.read<LikedCatCubit>().addLikedCat(cat);
                  context.read<CatBloc>().add(FetchCat());
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CatDetailPage(
                              imageUrl: cat.imageUrl,
                              breedName: cat.breedName,
                              description: cat.description,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.network(
                            cat.imageUrl,
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            cat.breedName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context.read<CatBloc>().add(FetchCat());
                                },
                                child: Image.asset('assets/cross-24.png'),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<LikedCatCubit>().addLikedCat(cat);
                                  context.read<CatBloc>().add(FetchCat());
                                },
                                child: Image.asset('assets/heart-24.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<LikedCatCubit, LikedCatState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Liked cats: ${state.likeCount}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          );
        },
      ),

    );
  }
}
