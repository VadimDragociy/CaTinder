// screens/liked_cats_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/liked_cat_cubit.dart';
import 'detailed_screen.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лайкнутые котики')),
      body: Column(
        children: [
          // Поле фильтрации по породе
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Фильтр по породе',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<LikedCatCubit>().updateFilter(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LikedCatCubit, LikedCatState>(
              builder: (context, state) {
                final likedCats = context.read<LikedCatCubit>().filteredLikedCats;
                if (likedCats.isEmpty) {
                  return const Center(child: Text('Нет лайкнутых котиков'));
                }
                return ListView.builder(
                  itemCount: likedCats.length,
                  itemBuilder: (context, index) {
                    final likedCat = likedCats[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          likedCat.cat.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(likedCat.cat.breedName),
                        subtitle: Text(
                          'Лайк: ${likedCat.likedDate.toLocal().toString().split('.')[0]}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<LikedCatCubit>().removeLikedCat(likedCat);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CatDetailPage(
                                imageUrl: likedCat.cat.imageUrl,
                                breedName: likedCat.cat.breedName,
                                description: likedCat.cat.description,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
