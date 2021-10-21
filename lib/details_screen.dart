import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jokes/api.dart';

class DetailSCreen extends StatelessWidget {
  const DetailSCreen({Key? key, required this.title}) : super(key: key);
  final String title;

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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Hero(
              tag: title,
              child: CachedNetworkImage(
                imageUrl: getNews(title).image,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              getNews(title).title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${getNews(title).author} ,',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                SizedBox(width: 10),
                Text(
                  getNews(title).date,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              getNews(title).content,
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launchURL(getNews(title).moreLink);
            },
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Read more...',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
