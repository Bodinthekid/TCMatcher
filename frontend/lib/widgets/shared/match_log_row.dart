import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class MatchLogRow extends StatelessWidget {
  final bool isWin;
  final String opponent;
  final String gameFormat;
  final String score;
  final String dateLabel;

  const MatchLogRow({
    super.key,
    required this.isWin,
    required this.opponent,
    required this.gameFormat,
    required this.score,
    required this.dateLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isWin ? AppColors.winGreenBg : AppColors.lossRedBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isWin ? 'W' : 'L',
              style: TextStyle(
                color: isWin ? AppColors.winGreen : AppColors.lossRed,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  opponent,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  gameFormat,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                score,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateLabel,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}