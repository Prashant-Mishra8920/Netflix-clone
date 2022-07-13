class Trending {
    Trending({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    final int page;
    final List<Result> results;
    final int totalPages;
    final int totalResults;
}

class Result {
    Result({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
        required this.popularity,
        required this.firstAirDate,
        required this.name,
        required this.originCountry,
        required this.originalName,
    });

    final bool adult;
    final String backdropPath;
    final List<int> genreIds;
    final int id;
    final OriginalLanguage originalLanguage;
    final String originalTitle;
    final String overview;
    final String posterPath;
    final DateTime releaseDate;
    final String title;
    final bool video;
    final double voteAverage;
    final int voteCount;
    final double popularity;
    final DateTime firstAirDate;
    final String name;
    final List<String> originCountry;
    final String originalName;
}

enum OriginalLanguage { EN, ZH }
