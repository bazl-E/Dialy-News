import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jokes/api.dart';

class DetailSCreen extends StatelessWidget {
  const DetailSCreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: getNews(id).image,
              fit: BoxFit.cover,
              height: 220,
              width: double.infinity,
              errorWidget: (ctx, rl, wi) => Center(
                  child: Text(
                'Image Unvilable',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              placeholder: (ctx, s) => Image(
                image: AssetImage('assets/place.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
