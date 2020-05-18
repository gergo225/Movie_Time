class GenreUtil {
  static int get action => 28;
  static int get adventure => 12;
  static int get animation => 16;
  static int get comedy => 35;
  static int get drama => 18;
  static int get horror => 27;
  static int get romance => 10749;
  static int get thriller => 53;

  static get allGenres => [
        action,
        adventure,
        animation,
        comedy,
        drama,
        horror,
        romance,
        thriller,
      ];

  static Map<int, String> genreIdAndName = {
    action: "Action",
    adventure: "Adventure",
    animation: "Animation",
    comedy: "Comedy",
    drama: "Drama",
    horror: "Horror",
    romance: "Romance",
    thriller: "Thriller",
  };
}
