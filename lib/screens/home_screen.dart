import 'package:cached_network_image/cached_network_image.dart';
import 'package:catinder/buttons/like_dislike_buttons.dart';
import 'package:catinder/screens/detailed_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CatHomePage extends StatefulWidget {
  const CatHomePage({super.key});

  @override
  State<CatHomePage> createState() => _CatHomePageState();
}

class _CatHomePageState extends State<CatHomePage> {
  String imageUrl = '';
  String breedName = '';
  String description = '';
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    fetchCat();
  }

  Future<void> fetchCat() async {
    try {
      bool validCat = false;
      while (!validCat) {
        final response = await Dio().get(
          'https://api.thecatapi.com/v1/images/search',
          queryParameters: {'limit': 1, 'has_breeds': true},
          options: Options(
            headers: {
              'x-api-key':
                  'live_MdrOzTfhdteXurMEPUuHGlsSwqbbQRfwVD2TgpGxIl67UnSAWEtPEBbNj7q62mD5',
            },
          ),
        );
        if (response.data != null && response.data.isNotEmpty) {
          final catData = response.data[0];
          if (catData['breeds'] != null && catData['breeds'].isNotEmpty) {
            setState(() {
              imageUrl = catData['url'] ?? '';
              breedName = catData['breeds'][0]['name'] ?? 'Unknown';
              description =
                  catData['breeds'][0]['description'] ??
                  'No description available';
            });
            validCat = true;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching cat: $e');
      }
    }
  }

  void likeCat() {
    setState(() {
      likeCount++;
    });
    fetchCat();
  }

  void dislikeCat() {
    fetchCat();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Tinder'), centerTitle: true),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            dislikeCat();
          } else if (details.primaryVelocity! < 0) {
            likeCat();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CatDetailPage(
                          imageUrl: imageUrl,
                          breedName: breedName,
                          description: description,
                        ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: screenHeight / 3,
                    width: screenWidth,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => const CircularProgressIndicator(),
                  ),
                  SizedBox(height: screenHeight / 20),
                  Column(
                    children: [
                      Text(
                        breedName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight / 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LikeButton(onPressed: likeCat),
                          SizedBox(width: screenWidth / 20),
                          DislikeButton(onPressed: dislikeCat),
                        ],
                      ),
                      SizedBox(height: screenHeight / 10),
                      Text(
                        'Likes: $likeCount',
                        style: const TextStyle(fontSize: 18),
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
}
