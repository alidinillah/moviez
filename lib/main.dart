import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviez/moviez.dart';
import 'package:moviez/search_screen.dart';
import 'package:moviez/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moviez',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final moviezData = [
    Moviez(
        id: 1,
        title: "John Wick 4",
        genre: "Action, Crime",
        rating: 5,
        image: "assets/images/img_john.png"),
    Moviez(
        id: 2,
        title: "Bohemian",
        genre: "Documentary",
        rating: 5,
        image: "assets/images/img_bohemian.png"),
    Moviez(
        id: 3,
        title: "Mulan Session",
        genre: "History, War",
        rating: 3,
        image: "assets/images/img_mulan.png"),
    Moviez(
        id: 4,
        title: "Beauty & Beast",
        genre: "Sci-Fiction",
        rating: 5,
        image: "assets/images/img_beauty.png"),
    Moviez(
        id: 5,
        title: "The Dark II",
        genre: "Horror",
        rating: 4,
        image: "assets/images/img_dark.png"),
    Moviez(
        id: 6,
        title: "The Dark Knight",
        genre: "Heroes",
        rating: 5,
        image: "assets/images/img_knight.png"),
    Moviez(
        id: 7,
        title: "The Dark Tower",
        genre: "Action",
        rating: 4,
        image: "assets/images/img_tower.png"),
  ];


  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0.0,
        backgroundColor: CustomColors.backgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Moviez',
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.bold,
                color: CustomColors.primaryColor,
                fontSize: 28.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Watch much easier',
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w400,
                color: CustomColors.secondaryColor,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                    moviez: moviezData),
              ),
            ),
            icon: const Icon(Icons.search_rounded),
            iconSize: 30.0,
            color: CustomColors.primaryColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: List.generate(
                  3,
                  (index) => _buildHorizontalWidget(moviezData[index]),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From Disney',
                    style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primaryColor,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        moviezData.length,
                        (index) => (moviezData[index].id ?? 0) > 3
                            ? _buildVerticalWidget(moviezData[index])
                            : Container(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHorizontalWidget(Moviez moviez) {
  int? rate = moviez.rating!.toInt();
  int? disrate = 5 - rate;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRect(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 25.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Transform.translate(
                offset: const Offset(0.0, 18.0),
                child: Transform.scale(
                  scale: 0.85,
                  child: Opacity(
                    opacity: 0.7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        moviez.image.toString(),
                        fit: BoxFit.cover,
                        width: 356.0,
                        height: 200.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0,
                      sigmaY: 10.0,
                    ),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  moviez.image.toString(),
                  fit: BoxFit.cover,
                  width: 356.0,
                  height: 200.0,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                moviez.title.toString(),
                style: TextStyle(
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w800,
                  color: CustomColors.primaryColor,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                moviez.genre.toString(),
                style: TextStyle(
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w400,
                  color: CustomColors.secondaryColor,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(width: 120.0),
          Row(
            children: [
              Row(
                children: List.generate(
                  rate,
                  (index) => const Padding(
                    padding: EdgeInsets.only(right: 2.0),
                    child: Icon(
                      Icons.star,
                      size: 18.0,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              if (rate < 5)
                Row(
                  children: List.generate(
                    disrate,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 2.0),
                      child: Icon(
                        Icons.star,
                        size: 18.0,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      )
    ],
  );
}

Widget _buildVerticalWidget(Moviez moviez) {
  int rate = moviez.rating!.toInt();
  int disrate = 5 - rate;

  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Row(
      children: [
        Container(
          width: 100.0,
          height: 127.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(moviez.image.toString()),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              moviez.title.toString(),
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w800,
                color: CustomColors.primaryColor,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              moviez.genre.toString(),
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w400,
                color: CustomColors.secondaryColor,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Row(
                  children: List.generate(
                    rate,
                    (index) => const Padding(
                      padding: EdgeInsets.only(right: 2.0),
                      child: Icon(
                        Icons.star,
                        size: 18.0,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
                if (rate < 5)
                  Row(
                    children: List.generate(
                      disrate,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(
                          Icons.star,
                          size: 18.0,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
