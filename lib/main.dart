//import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//API key : aedce3b08501c13badcb4bd4a3c7b743
//https://api.themoviedb.org/3/movie/550?api_key=aedce3b08501c13badcb4bd4a3c7b743
void main() {
  runApp(MovieApp());
}

//final apiKey = "aedce3b08501c13badcb4bd4a3c7b743";

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //MovieListing stateful widget
      home: MoviesListing(),
    );
  }
}

class MoviesProvider {
  static final String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';
  static final apiKey = "aedce3b08501c13badcb4bd4a3c7b743";

  //Return JSON formatted response as Map
  //method to make http requests
  static Future<Map> getJson() async {
    //URL to fetch movies information
    final apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc";
    final apiResponse = await http.get(apiEndPoint);
    return json.decode(apiResponse.body);
  }
}

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  List<MovieModel> movies = List<MovieModel>();

  //varialbe to hold movies information
 // var movies;

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    //Updating data and  requesting to rebuild widget
    setState(() {
     List<dynamic> results = data['results'];
      results.forEach((element) {
        movies.add(MovieModel.fromJson(element));
      });
      //storing movies list in 'movies' variable
      //movies = data['results'];
    });
  }
/*
  //method to make http requests
  static dynamic getJson() async {
    //URL to fetch movies information
    final apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc";
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
  }*/

  @override
  Widget build(BuildContext context) {
    //Fetch Movies
    fetchMovies();

    return Scaffold(
      //rendering movies in ListView
      body: ListView.builder(
          itemCount: movies == null ? 0 : movies.length,
          itemBuilder: (context, index) {
            return Padding(
              //adding padding around the list row
              padding: const EdgeInsets.all(8.0),

              //displaying title of the movie only for now
              // child: Text(movies[index]["title"]),
              child: Text(movies[index].title),
            );
          }),
    );
  }
}

//JSON response is converted into MovieModel object
class MovieModel {
  final int id;
  final num popularity;
  final int vote_count;
  final bool video;
  final String poster_path;
  final String backdrop_path;
  final bool adult;
  final String original_language;
  final String original_title;
  final List<dynamic> genre_ids;
  final String title;
  final num vote_average;
  final String overview;
  final String release_date;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        vote_count = json['vote_count'],
        video = json['video'],
        poster_path = json['poster_path'],
        adult = json['adult'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        genre_ids = json['genre_ids'],
        title = json['title'],
        vote_average = json['vote_average'],
        overview = json['overview'],
        release_date = json['release_date'],
        backdrop_path = json['backdrop_path'];
}

/*
//siglechild scrolling view to provide scrolling for flexible data redering
      body: SingleChildScrollView(
        //print Api response on screen

        child: movies != null
            ? Text("TMDB api response \n $movies")
            : Text("Loading api response"),
      ),
    );
  }
}*/
