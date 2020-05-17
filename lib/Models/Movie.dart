class Movie {
  final String title;
  final String releaseYear;
  final double rating;
  final String image;
  final List<dynamic> genre;
  final String overview;
  final int id;
  final List<dynamic> genres;


  Movie({this.title, this.releaseYear, this.rating, this.image, this.genre,this.overview,this.id,this.genres});

  factory Movie.fromJson(Map <String, dynamic> json) {
    return Movie(
      title: json['title'],
      releaseYear: json['release_date'],
      rating: json['vote_average'] + 0.0,
      image: json['poster_path'],
      genre: json['genre_ids'],
      overview: json['overview'],
      id: json['id'],
      genres: json['genres'],
    );
  }


}