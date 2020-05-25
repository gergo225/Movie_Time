class GenreUtil {
  static int get action => 28;
  static int get adventure => 12;
  static int get animation => 16;
  static int get comedy => 35;
  static int get drama => 18;
  static int get horror => 27;
  static int get romance => 10749;
  static int get thriller => 53;
  
  static int get crime => 80;
  static int get documentary => 99;
  static int get family => 10751;
  static int get fantasy => 14;
  static int get history => 36;
  static int get music => 10402;
  static int get mystery => 9648;
  static int get scienceFiction => 878;
  static int get war => 10752;
  static int get western => 37;

  static List<int> get allGenres => [
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
    crime: "Crime",
    documentary: "Documentary",
    family: "Familly",
    fantasy: "Fantasy",
    history: "History",
    music: "Music",
    mystery: "Mystery",
    scienceFiction: "Sci-Fi",
    war: "War",
    western: "Western",
    drama: "Drama",
    horror: "Horror",
    romance: "Romance",
    thriller: "Thriller",
  };
}
