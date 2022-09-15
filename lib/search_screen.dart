import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviez/moviez.dart';
import 'package:moviez/theme.dart';

class SearchScreen extends StatefulWidget {
  final List<Moviez> moviez;
  const SearchScreen({Key? key, required this.moviez}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Moviez> _foundMoviez = [];

  @override
  initState() {
    _foundMoviez = widget.moviez;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Moviez> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.moviez;
    } else {
      results = widget.moviez
          .where((moviez) => moviez.title!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundMoviez = results.cast<Moviez>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        Align(
          alignment: Alignment.center,
          child: MaterialButton(
            onPressed: () {},
            elevation: 1.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            padding: EdgeInsets.all(16.0),
            color: CustomColors.primaryColor,
            child: Text(
              "Suggestion Movie",
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.green,
                focusColor: Colors.white,
                hintText: "Search...",
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundMoviez.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundMoviez.length,
                      itemBuilder: (context, index) =>
                          _buildVerticalWidget(_foundMoviez[index]))
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 16.0),
                    ),
            ),
          ],
        ),
      ),
    );
  }
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
