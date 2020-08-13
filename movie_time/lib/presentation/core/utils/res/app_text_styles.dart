import 'package:flutter/painting.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Actor page
  static const actorName = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  static const actorBirthday = TextStyle(
    fontSize: 20,
    color: AppColors.actorText,
  );
  static const actorBirthdayPrefix = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.actorBirthdayPrefix,
  );
  static const actorBio = TextStyle(
    color: AppColors.actorText,
  );

  // Shared
  static const subtitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.subtitle,
  );
  // Shared - desktop
  static const subtitleDesktop = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Custom list item
  static const customListItemTop = TextStyle(
    fontWeight: FontWeight.w600,
  );

  // Message display
  static const messageDisplay = TextStyle(
    fontSize: 16,
  );

  // No image widget
  static const noImage = TextStyle(
    fontSize: 12,
    color: AppColors.noImageBackground,
  );

  // Home page
  static const homeAppBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const homeCategoryUnselected = TextStyle(
    fontSize: 17,
    color: AppColors.categoryTextUnselected,
  );
  static const homeCategorySelected = TextStyle(
    fontSize: 17,
    color: AppColors.categoryTextSelected,
  );
  static const homeMovieTitle = TextStyle(
    fontSize: 24,
    color: AppColors.homeMovieTitle,
    shadows: [
      Shadow(
        color: AppColors.homeMovieTitleShadow,
        blurRadius: 4,
        offset: Offset(.5, 1),
      )
    ],
    fontWeight: FontWeight.bold,
  );

  // Movie, series page
  static const genres = TextStyle(
    fontSize: 13,
  );
  static const valueAndDescriptionValue = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  // Movie page - desktop
  static const moviePlayTrailerDesktop = TextStyle(
    fontSize: 24,
  );
  static const titleDesktop = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );
  static const genresDesktop = TextStyle(
    fontSize: 18,
    color: AppColors.genresAndRatingDesktop,
  );
  static const ratingDesktop = TextStyle(
    fontSize: 24,
    color: AppColors.genresAndRatingDesktop,
  );

  // Search page
  static const searchInput = TextStyle(
    fontSize: 18,
  );
  static const searchedMovieItemTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  // Series page
  static const seriesInfoPrefix = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const seriesInfo = TextStyle(
    fontSize: 16,
  );
  static const seriesAllSeasons = TextStyle(
    fontSize: 20,
  );
}
