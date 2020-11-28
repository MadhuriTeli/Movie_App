import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//API key : aedce3b08501c13badcb4bd4a3c7b743
//https://api.themoviedb.org/3/movie/550?api_key=aedce3b08501c13badcb4bd4a3c7b743
void main() {
  runApp(MovieApp());
}

final apiKey = "aedce3b08501c13badcb4bd4a3c7b743";

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoviesListing(),
    );
  }
}

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  //varialbe to hold movies information
  var movies;

  //method to make http requests
  static dynamic getJson() async {
    //URL to fetch movies information
    final apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&sort_by=popularity.desc";
    final apiResponse = await http.get(apiEndPoint);

    //instance of response
    return apiResponse;
  }

  //method  to fetch moves from network
  fetchMovies() async {
    //getting json
    var data = await getJson();
    setState(() {
      movies = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Fetch Movies
    fetchMovies();

    return Scaffold(
//siglechild scrolling view to provide scrolling for flexible data redering
      body: SingleChildScrollView(
        //print Api response on screen

        child: movies != null
            ? Text("TMDB api response \n $movies")
            : Text("Loading api response"),
      ),
    );
  }
}
