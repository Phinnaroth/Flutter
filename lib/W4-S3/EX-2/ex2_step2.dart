import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Favorite cards"),
        ),
        body: const Column(
          children: [
            FavoriteCard(isFav: true),
            FavoriteCard(isFav: false),
            FavoriteCard(isFav: true),

          ],
        ),
      ),
    ));

class FavoriteCard extends StatelessWidget {
  final bool isFav;
  const FavoriteCard({
    super.key,
    required this.isFav
  });
  


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('title'),
                SizedBox(height: 5.0),
                Text('description')
              ],
            )
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border_outlined,
              color: isFav ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
