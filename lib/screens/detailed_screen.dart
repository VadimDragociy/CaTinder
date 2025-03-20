import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatDetailPage extends StatelessWidget {
  final String imageUrl;
  final String breedName;
  final String description;

  const CatDetailPage({
    super.key,
    required this.imageUrl,
    required this.breedName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(breedName)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
