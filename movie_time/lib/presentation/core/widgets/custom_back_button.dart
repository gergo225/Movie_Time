import 'package:flutter/material.dart';
import 'package:movie_time/presentation/core/utils/res/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
      child: Material(
        type: MaterialType.button,
        color: AppColors.backButtonBackground,
        child: BackButton(),
      ),
    );
  }
}
