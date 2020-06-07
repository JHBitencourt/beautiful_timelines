import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ShowcaseSuccessTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Showcase(
      title: 'Success Timeline',
      app: _SuccessTimelineApp(),
      description: 'The 7even steps to success show how to build a connected '
          'timeline.',
      template: SimpleTemplate(reverse: false),
      theme: TemplateThemeData(
        frameTheme: FrameThemeData(
          statusBarBrightness: Brightness.dark,
          frameColor: Colors.white.withOpacity(0.7),
        ),
        flutterLogoColor: FlutterLogoColor.original,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFFFCCCA9),
        titleTextStyle: GoogleFonts.acme(
          fontSize: 70,
          fontWeight: FontWeight.w900,
          color: const Color(0xFFB96320),
        ),
        descriptionTextStyle: GoogleFonts.architectsDaughter(
          fontSize: 24,
          height: 1.2,
          color: const Color(0xFFB96320),
        ),
        buttonTextStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        buttonIconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFFB96320),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(16),
        ),
      ),
      links: [
        LinkData.github('https://github.com/JHBitencourt/timeline_tile'),
      ],
      logoLink: LinkData(
        icon: Image.asset(
          'assets/built_by_jhb_black.png',
          fit: BoxFit.fitHeight,
        ),
        url: 'https://github.com/JHBitencourt',
      ),
    );
  }
}

class _SuccessTimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Success TimelineTile',
      builder: Frame.builder,
      home: _SuccessTimeline(),
    );
  }
}

class _SuccessTimeline extends StatefulWidget {
  @override
  _SuccessTimelineState createState() => _SuccessTimelineState();
}

class _SuccessTimelineState extends State<_SuccessTimeline> {
  List<Step> _steps;

  @override
  void initState() {
    _steps = _generateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFCCCA9),
            Color(0xFFFFA578),
          ],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFFFCB69F).withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[
                  _Header(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[_TimelineSteps(steps: _steps)],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Step> _generateData() {
    return <Step>[
      const Step(
        step: 1,
        title: 'Decide What You Want',
        message:
            'Step number one, decide exactly what it is you want in each part of your life. Become a "meaningful specific" rather than a "wandering generality."',
      ),
      const Step(
        step: 2,
        title: 'Write it Down',
        message:
            'Second, write it down, clearly and in detail. Always think on paper. A goal that is not in writing is not a goal at all. It is merely a wish and it has no energy behind it.',
      ),
      const Step(
        step: 3,
        title: 'Set a Deadline',
        message:
            'Third, set a deadline for your goal. A deadline acts as a "forcing system” in your subconscious mind. It motivates you to do the things necessary to make your goal come true. If it is a big enough goal, set sub-deadlines as well. Don’t leave this to chance.',
      ),
      const Step(
        step: 4,
        title: 'Make a List',
        message:
            'Fourth, make a list of everything that you can think of that you are going to have to do to achieve your goal. When you think of new tasks and activities, write them on your list until your list is complete.',
      ),
      const Step(
        step: 5,
        title: 'Organize Your List',
        message:
            'Fifth, organize your list into a plan. Decide what you will have to do first and what you will have to do second. Decide what is more important and what is less important. And then write out your plan on paper, the same way you would develop a blueprint to build your dream house.',
      ),
      const Step(
        step: 6,
        title: 'Take Action',
        message:
            'The sixth step is for you to take action on your plan. Do something. Do anything. But get busy. Get going.',
      ),
      const Step(
        step: 7,
        title: 'Do Something Every Day',
        message:
            'Do something every single day that moves you in the direction of your most important goal at the moment. Develop the discipline of doing something 365 days each year that is moving you forward. You will be absolutely astonished at how much you accomplish when you utilize this formula in your life every single day.',
      ),
    ];
  }
}

class _TimelineSteps extends StatelessWidget {
  const _TimelineSteps({Key key, this.steps}) : super(key: key);

  final List<Step> steps;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd)
            return const TimelineDivider(
              color: Color(0xFFCB8421),
              thickness: 5,
              begin: 0.1,
              end: 0.9,
            );

          final int itemIndex = index ~/ 2;
          final Step step = steps[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final child = _TimelineStepsChild(
            title: step.title,
            subtitle: step.message,
            isLeftAlign: isLeftAlign,
          );

          final isFirst = itemIndex == 0;
          final isLast = itemIndex == steps.length - 1;
          double indicatorY;
          if (isFirst) {
            indicatorY = 0.2;
          } else if (isLast) {
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }

          return TimelineTile(
            alignment: TimelineAlign.manual,
            rightChild: isLeftAlign ? child : null,
            leftChild: isLeftAlign ? null : child,
            lineX: isLeftAlign ? 0.1 : 0.9,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicatorY: indicatorY,
              indicator: _TimelineStepIndicator(step: '${step.step}'),
            ),
            topLineStyle: const LineStyle(
              color: Color(0xFFCB8421),
              width: 5,
            ),
          );
        },
        childCount: max(0, steps.length * 2 - 1),
      ),
    );
  }
}

class _TimelineStepIndicator extends StatelessWidget {
  const _TimelineStepIndicator({Key key, this.step}) : super(key: key);

  final String step;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFCB8421),
      ),
      child: Center(
        child: Text(
          step,
          style: GoogleFonts.architectsDaughter(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TimelineStepsChild extends StatelessWidget {
  const _TimelineStepsChild({
    Key key,
    this.title,
    this.subtitle,
    this.isLeftAlign,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftAlign
          ? const EdgeInsets.only(right: 32, top: 16, bottom: 16, left: 10)
          : const EdgeInsets.only(left: 32, top: 16, bottom: 16, right: 10),
      child: Column(
        crossAxisAlignment:
            isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: GoogleFonts.acme(
              fontSize: 22,
              color: const Color(0xFFB96320),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: isLeftAlign ? TextAlign.right : TextAlign.left,
            style: GoogleFonts.architectsDaughter(
              fontSize: 16,
              color: const Color(0xFFB96320),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Seven steps to success!',
              textAlign: TextAlign.center,
              style: GoogleFonts.architectsDaughter(
                fontSize: 26,
                color: const Color(0xFFB96320),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Step {
  const Step({
    this.step,
    this.title,
    this.message,
  });

  final int step;
  final String title;
  final String message;
}
