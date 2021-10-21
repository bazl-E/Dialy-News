import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jokes/api.dart';
import 'package:jokes/details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    future = fetchNews();

    Timer.periodic(Duration(seconds: 10), (t) {
      setState(() {
        it = Random().nextInt(newses.length);
      });
    });
  }

  var it = 0;

  var future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<News>>(
          future: future,
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snap.hasData) {
              return Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[50],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await fetchNews();
                setState(() {
                  future = fetchNews();
                });
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.height * .36,
                    backgroundColor: Colors.black,
                    title: Text(
                      'Dialy Newses',
                      style: TextStyle(
                          backgroundColor: Colors.black,
                          fontSize: 18,
                          letterSpacing: 2),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: InkWell(
                        onTap: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return DetailSCreen(
                              id: snap.data![it].id,
                            );
                          }));
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: snap.data![it].image,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 69,
                                child: Text(
                                  snap.data![it].title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => InkWell(
                        onTap: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return DetailSCreen(
                              id: snap.data![i].id,
                            );
                          }));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 150,
                              width: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: snap.data![i].image,
                                  fit: BoxFit.cover,
                                  errorWidget: (ctx, rl, wi) => Center(
                                      child: Text(
                                    'Image Unvilable',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  placeholder: (ctx, s) => Image(
                                    image: AssetImage('assets/place.png'),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                child: Text(
                                  snap.data![i].title,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      childCount: snap.data!.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .76,
                      crossAxisCount: 2,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 30,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
