import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ShowcaseActivityTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Showcase(
      title: 'Activity Timeline',
      app: _ActivityTimelineApp(),
      description: 'A beautiful timeline that tracks your steps, from one place'
          ' to another.',
      template: SimpleTemplate(reverse: false),
      theme: TemplateThemeData(
        frameTheme: FrameThemeData(
          statusBarBrightness: Brightness.dark,
          frameColor: Colors.black,
        ),
        flutterLogoColor: FlutterLogoColor.black,
        brightness: Brightness.light,
        backgroundColor: const Color(0xFFF2F2F2),
        titleTextStyle: GoogleFonts.patrickHand(
          fontSize: 80,
        ),
        descriptionTextStyle: GoogleFonts.patrickHand(
          fontSize: 24,
          height: 1.2,
          color: const Color(0xFF1D1E20),
        ),
        buttonTextStyle: const TextStyle(
          color: Color(0xFFF2F2F2),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        buttonIconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF1D1E20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textTheme: ButtonTextTheme.accent,
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

class _ActivityTimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activity TimelineTile',
      builder: Frame.builder,
      home: _ActivityTimeline(),
    );
  }
}

class _ActivityTimeline extends StatefulWidget {
  @override
  _ActivityTimelineState createState() => _ActivityTimelineState();
}

class _ActivityTimelineState extends State<_ActivityTimeline> {
  List<Step> _steps;

  @override
  void initState() {
    _steps = _generateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1D1E20),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: Colors.white.withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[
                  _Header(),
                  Expanded(
                    child: _TimelineActivity(steps: _steps),
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
      Step(
        type: Type.checkpoint,
        icon: Icons.home,
        message: 'Home',
        duration: 2,
        color: const Color(0xFFF2F2F2),
      ),
      Step(
        type: Type.line,
        hour: '8:38',
        message: 'Walk',
        duration: 9,
        color: const Color(0xFF40C752),
      ),
      Step(
        type: Type.line,
        hour: '8:47',
        message: 'Transport',
        duration: 12,
        color: const Color(0xFF797979),
      ),
      Step(
        type: Type.line,
        hour: '8:59',
        message: 'Run',
        duration: 3,
        color: const Color(0xFFDF54C9),
      ),
      Step(
        type: Type.checkpoint,
        icon: Icons.work,
        hour: '9:02',
        message: 'Work',
        duration: 2,
        color: const Color(0xFFF2F2F2),
      ),
      Step(
        type: Type.line,
        hour: '12:12',
        message: 'Walk',
        duration: 8,
        color: const Color(0xFF40C752),
      ),
      Step(
        type: Type.checkpoint,
        icon: Icons.local_drink,
        hour: '12:20',
        message: 'Coffee shop',
        duration: 2,
        color: const Color(0xFFF2F2F2),
      ),
      Step(
        type: Type.line,
        hour: '01:05',
        message: 'Walk',
        duration: 8,
        color: const Color(0xFF40C752),
      ),
      Step(
        type: Type.checkpoint,
        icon: Icons.work,
        hour: '01:13',
        message: 'Work',
        duration: 2,
        color: const Color(0xFFF2F2F2),
      ),
      Step(
        type: Type.line,
        hour: '05:25',
        message: 'Walk',
        duration: 3,
        color: const Color(0xFF40C752),
      ),
      Step(
        type: Type.line,
        hour: '05:28',
        message: 'Cycle',
        duration: 14,
        color: const Color(0xFF01CBFE),
      ),
      Step(
        type: Type.checkpoint,
        hour: '05:42',
        icon: Icons.home,
        message: 'Home',
        duration: 2,
        color: const Color(0xFFF2F2F2),
      ),
    ];
  }
}

class _TimelineActivity extends StatelessWidget {
  const _TimelineActivity({Key key, this.steps}) : super(key: key);

  final List<Step> steps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (BuildContext context, int index) {
        final Step step = steps[index];

        final IndicatorStyle indicator = step.isCheckpoint
            ? _indicatorStyleCheckpoint(step)
            : const IndicatorStyle(width: 0);

        final righChild = _RightChildTimeline(step: step);

        Widget leftChild;
        if (step.hasHour) {
          leftChild = _LeftChildTimeline(step: step);
        }

        return TimelineTile(
          alignment: TimelineAlign.manual,
          isFirst: index == 0,
          isLast: index == steps.length - 1,
          lineX: 0.25,
          indicatorStyle: indicator,
          leftChild: leftChild,
          rightChild: righChild,
          hasIndicator: step.isCheckpoint,
          topLineStyle: LineStyle(
            color: step.color,
            width: 8,
          ),
        );
      },
    );
  }

  IndicatorStyle _indicatorStyleCheckpoint(Step step) {
    return IndicatorStyle(
      width: 46,
      height: 100,
      indicator: Container(
        decoration: BoxDecoration(
          color: step.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Icon(
            step.icon,
            color: const Color(0xFF1D1E20),
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _RightChildTimeline extends StatelessWidget {
  const _RightChildTimeline({Key key, this.step}) : super(key: key);

  final Step step;

  @override
  Widget build(BuildContext context) {
    final double minHeight =
        step.isCheckpoint ? 100 : step.duration.toDouble() * 8;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: step.isCheckpoint ? 20 : 39, top: 8, bottom: 8, right: 8),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: step.message,
                  style: GoogleFonts.patrickHand(
                    fontSize: 22,
                    color: step.color,
                  ),
                ),
                TextSpan(
                  text: '  ${step.duration} min',
                  style: GoogleFonts.patrickHand(
                    fontSize: 22,
                    color: const Color(0xFFF2F2F2),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class _LeftChildTimeline extends StatelessWidget {
  const _LeftChildTimeline({Key key, this.step}) : super(key: key);

  final Step step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: step.isCheckpoint ? 10 : 29),
          child: Text(
            step.hour,
            textAlign: TextAlign.center,
            style: GoogleFonts.patrickHand(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Activity Tracker',
              textAlign: TextAlign.center,
              style: GoogleFonts.patrickHand(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum Type {
  checkpoint,
  line,
}

class Step {
  Step({
    this.type,
    this.hour,
    this.message,
    this.duration,
    this.color,
    this.icon,
  });

  final Type type;
  final String hour;
  final String message;
  final int duration;
  final Color color;
  final IconData icon;

  bool get isCheckpoint => type == Type.checkpoint;

  bool get hasHour => hour != null && hour.isNotEmpty;
}
