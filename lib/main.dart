import 'package:example_timeline_tile/example_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';

import 'apps/activity_timeline.dart';
import 'apps/delivery_timeline.dart';
import 'apps/football_timeline.dart';
import 'apps/showcase_timeline.dart';
import 'apps/success_timeline.dart';
import 'apps/weather_timeline.dart';
import 'indicator/effects/expanding_dots_effect.dart';
import 'indicator/smooth_page_indicator.dart';

void main() => runApp(Examples());

class Examples extends StatefulWidget {
  @override
  _ExamplesState createState() => _ExamplesState();
}

class _ExamplesState extends State<Examples> {
  PageController _pageController;
  List<Widget> _apps;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _apps = [
      ShowcaseTimeline(),
      ShowcaseFootballTimeline(),
      ShowcaseWeatherTimeline(),
      ShowcaseActivityTimeline(),
      ShowcaseDeliveryTimeline(),
      ShowcaseSuccessTimeline(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _apps.length,
            itemBuilder: (BuildContext context, int index) {
              return _apps[index];
            },
          ),
          PageIndicator(
            pageController: _pageController,
            count: _apps.length,
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key key,
    @required this.pageController,
    @required this.count,
  }) : super(key: key);

  final PageController pageController;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SmoothPageIndicator(
          controller: pageController,
          count: count,
          effect: const ExpandingDotsEffect(
            radius: 14,
            dotHeight: 10,
            dotWidth: 10,
            dotColor: Colors.black12,
            activeDotColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Showcase TimelineTile',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.nanumPenScriptTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: Frame.builder,
      home: ShowcaseTimelineTile(),
    );
  }
}
