// screens/detailed_screen.dart
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}
