/// Create link for original size image
String createOriginalImageLink(String path) =>
    _imageLinkWithSizeAndPath("original", path);

/// Create link for w342 size image. Works with posters only
String createPosterImageLink(String path) =>
    _imageLinkWithSizeAndPath("w342", path);

/// Create link for w185 size image. Works with actor and poster images
String createSmallImageLink(String path) =>
    _imageLinkWithSizeAndPath("w185", path);

/// Create link for w780 size image. Works with poster and backdrop
String createLargeImageLink(String path) =>
    _imageLinkWithSizeAndPath("w780", path);

String _imageLinkWithSizeAndPath(String size, String path) =>
    _linkOrNull(path, "https://image.tmdb.org/t/p/$size$path");

String _linkOrNull(String nullable, String link) =>
    (nullable != null) ? link : null;
