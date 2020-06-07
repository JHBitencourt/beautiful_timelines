import 'package:flutter/material.dart';

import '../effects/expanding_dots_effect.dart';
import 'indicator_painter.dart';

class ExpandingDotsPainter extends IndicatorPainter {
  ExpandingDotsPainter({
    @required double offset,
    @required this.effect,
    @required int count,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  final ExpandingDotsEffect effect;

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    double drawingOffset = -effect.spacing;
    final dotOffset = offset - current;

    for (int i = 0; i < count; i++) {
      Color color = effect.dotColor;
      final activeDotHeight = effect.dotHeight * effect.expansionFactor;
      final expansion =
          dotOffset / 2 * ((activeDotHeight - effect.dotHeight) / .5);
      final yPos = drawingOffset + effect.spacing;
      double height = effect.dotHeight;
      if (i == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
        height = activeDotHeight - expansion;
      } else if (i - 1 == current) {
        height = effect.dotHeight + expansion;
        color =
            Color.lerp(effect.activeDotColor, effect.dotColor, 1.0 - dotOffset);
      }
      final xPos = size.width / 2;
      final rRect = RRect.fromLTRBR(
        xPos - effect.dotWidth / 2,
        yPos,
        xPos + effect.dotWidth / 2,
        yPos + height,
        dotRadius,
      );
      drawingOffset = rRect.bottom;
      canvas.drawRRect(rRect, dotPaint..color = color);
    }
  }
}
