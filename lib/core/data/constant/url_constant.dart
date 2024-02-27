class UrlConstant {
  static const webMovieUrl = 'https://www.themoviedb.org/movie/';
  static const w500Image = 'https://image.tmdb.org/t/p/w500';
}

extension UrlExtension on String {
  String get w500Image => '${UrlConstant.w500Image}$this';
}
