// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'jokes.dart';

Color appColor = Colors.pink[300] as Color;

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appColor,
          title: const Text("Favorite Jokes", style: TextStyle(color: Colors.white),),
        ),
        body: const JokesList(),
      ),
    ));

class JokesList extends StatefulWidget {
  const JokesList({super.key});

  @override
  _JokesListState createState() => _JokesListState();
}

class _JokesListState extends State<JokesList> {
  int? _favoriteIndex;

  void onFavoriteClick(int index) {
    setState(() {
      _favoriteIndex = _favoriteIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        return FavoriteCard(
          title: jokes[index]['title']!,
          description: jokes[index]['description']!,
          isFavorite: _favoriteIndex == index,
          onFavoriteClick: () => onFavoriteClick(index),
        );
      },
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isFavorite;
  final VoidCallback onFavoriteClick;

  const FavoriteCard({super.key, 
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.onFavoriteClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: appColor, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0),
                Text(description),
              ],
            ),
          ),
          IconButton(
            onPressed: onFavoriteClick,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
