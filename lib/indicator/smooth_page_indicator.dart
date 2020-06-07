import 'package:flutter/material.dart';

import 'effects/expanding_dots_effect.dart';
import 'effects/indicator_effect.dart';
import 'painters/indicator_painter.dart';

class SmoothPageIndicator extends AnimatedWidget {
  const SmoothPageIndicator({
    @required this.controller,
    @required this.count,
    this.textDirection,
    this.effect = const ExpandingDotsEffect(),
    Key key,
  })  : assert(controller != null),
        assert(effect != null),
        assert(count != null),
        super(listenable: controller, key: key);

  // a PageView controller to listen for page offset updates
  final PageController controller;

  /// Holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// The number of children in [PageView]
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page offset will be reversed
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    // if textDirection is not provided use the nearest directionality up the widgets tree;
    final isRTL =
        (textDirection ?? Directionality.of(context)) == TextDirection.rtl;
    return CustomPaint(
      // different effects have different sizes
      // so we calculate size based on the provided effect
      size: effect.calculateSize(count),
      // rebuild the painter with the new offset every time it updates
      painter: effect.buildPainter(
        count,
        _currentPage,
        isRTL,
      ),
    );
  }

  double get _currentPage {
    try {
      return controller.page ?? controller.initialPage.toDouble();
    } catch (e) {
      return controller.initialPage.toDouble();
    }
  }
}
