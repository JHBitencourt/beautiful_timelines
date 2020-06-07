import 'package:example_timeline_tile/example_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowcaseTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Showcase(
      title: 'Showcase Timeline',
      app: _ShowcaseTimelineApp(),
      description:
          'A set of examples of timelines built with flutter to showcase the '
          'timeline_tile package.\nScroll down to see some real world timelines,'
          ' and access the package at pub.dev.',
      template: SimpleTemplate(reverse: false),
      theme: TemplateThemeData(
        frameTheme: FrameThemeData(
          statusBarBrightness: Brightness.dark,
          frameColor: Colors.white.withOpacity(0.5),
        ),
        flutterLogoColor: FlutterLogoColor.white,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF004E92),
        titleTextStyle: GoogleFonts.nanumPenScript(
          fontSize: 80,
        ),
        descriptionTextStyle: GoogleFonts.jura(
          fontSize: 24,
          height: 1.2,
        ),
        buttonTextStyle: const TextStyle(
          color: Color(0xFF004E92),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textTheme: ButtonTextTheme.accent,
          padding: const EdgeInsets.all(16),
        ),
      ),
      links: [
        LinkData.github('https://github.com/JHBitencourt/timeline_tile'),
        LinkData.pub('https://pub.dev/packages/timeline_tile')
      ],
      logoLink: LinkData(
        icon: Image.asset(
          'assets/built_by_jhb_white.png',
          fit: BoxFit.fitHeight,
        ),
        url: 'https://github.com/JHBitencourt',
      ),
    );
  }
}

class _ShowcaseTimelineApp extends StatelessWidget {
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
