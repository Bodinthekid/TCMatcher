import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ProfileRatingStars
    extends StatelessWidget {
  final int rating;
  final double size;

  const ProfileRatingStars({
    super.key,
    required this.rating,
    this.size = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating
              ? Icons.star_rounded
              : Icons.star_border_rounded,
          color: AppColors.pokemonGold,
          size: size,
        ),
      ),
    );
  }
}