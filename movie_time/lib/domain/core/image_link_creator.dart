/// Create link for original size image
String createOriginalImageLink(String path) =>
    _imageLinkWithSizeAndPath("original", path);

/// Create link for w342 size image. Works with posters only
String createPosterImageLink(String path) => _imageLinkWithSizeAndPath("w342", path);

/// Create link for w185 size image. Works with actor and poster images
String createSmallImageLink(String path) => _imageLinkWithSizeAndPath("w185", path);

String _imageLinkWithSizeAndPath(String size, String path) =>
    "https://image.tmdb.org/t/p/$size$path";

/// Create link for YouTube video base on video key
String createYouTubeLink(String videoKey) => "https://www.youtube.com/watch?v=$videoKey";
