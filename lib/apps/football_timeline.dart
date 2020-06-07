import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ShowcaseFootballTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Showcase(
      title: 'Football Timeline',
      app: _FootballTimelineApp(),
      description:
          'All the commentary events from a football match organized into '
          'a timeline, so that the user can understand what is going on in the'
          ' game.',
      template: SimpleTemplate(reverse: false),
      theme: TemplateThemeData(
        frameTheme: FrameThemeData(
          statusBarBrightness: Brightness.dark,
          frameColor: const Color(0xFF383A47),
        ),
        flutterLogoColor: FlutterLogoColor.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFFB7D8D2),
        titleTextStyle: GoogleFonts.dosis(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF117E69),
        ),
        descriptionTextStyle: GoogleFonts.dosis(
          fontSize: 24,
          height: 1.2,
          color: const Color(0xFF117E69),
        ),
        buttonTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        buttonIconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF265A57),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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

class _FootballTimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Football Timeline',
      builder: Frame.builder,
      home: _FootballTimeline(),
    );
  }
}

class _FootballTimeline extends StatefulWidget {
  @override
  _FootballTimelineState createState() => _FootballTimelineState();
}

class _FootballTimelineState extends State<_FootballTimeline> {
  List<FootballData> _firstHalf;
  List<FootballData> _secondHalf;

  @override
  void initState() {
    _firstHalf = _generateFirstHalfData();
    _secondHalf = _generateSecondHalfData();
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
            Color(0xFF117E69),
            Color(0xFF383A47),
          ],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF117E69).withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  Text(
                    '01 June 2020 16:00',
                    style: GoogleFonts.dosis(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  _Scoreboard(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _TimelineFootball(data: _firstHalf),
                        SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            const _MessageTimeline(
                              message: 'End of the first half!',
                            ),
                          ]),
                        ),
                        _TimelineFootball(data: _secondHalf),
                        SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                            const _MessageTimeline(
                              message:
                                  'There will be no more action in this match as the referee signals full time.'
                                  ' Arsenal goes home with the victory!',
                            ),
                          ]),
                        ),
                        const SliverPadding(padding: EdgeInsets.only(top: 20)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<FootballData> _generateFirstHalfData() {
    return <FootballData>[
      const FootballData(
        time: "5'",
        team: Team.arsenal,
        action: Action.foul,
        title: 'Foul!',
        subtitle: 'David Luiz brings his opponent down.',
      ),
      const FootballData(
        time: "6'",
        team: Team.arsenal,
        action: Action.foul,
        title: 'Yellow',
        subtitle: 'This yellow card was deserved.',
      ),
      const FootballData(
        time: "17'",
        team: Team.barcelona,
        action: Action.goal,
        title: 'Gooooaaaal!',
        subtitle:
            'Goal! Lionel Messi slams the ball into the open net from close range.',
      ),
      const FootballData(
        time: "30'",
        team: Team.barcelona,
        action: Action.yellowCard,
        title: 'One more!',
        subtitle: 'Piqué gets a yellow card for arguing with the referee.',
      ),
      const FootballData(
        time: "42'",
        team: Team.arsenal,
        action: Action.injury,
        title: 'Ouchh',
        subtitle:
            'Mesut Özil is writhing in pain and can now receive medical treatment.',
      ),
    ];
  }

  List<FootballData> _generateSecondHalfData() {
    return <FootballData>[
      const FootballData(
        time: "50'",
        team: Team.barcelona,
        action: Action.offside,
        title: 'Offside!',
        subtitle:
            'The referee whistle as the Luis Suárez was trying to advance for the goal.',
      ),
      const FootballData(
        time: "61'",
        team: Team.barcelona,
        action: Action.redCard,
        title: 'Red card!',
        subtitle:
            'He’s off! Busquets gets his marching orders from referee Felix Brych after the VAR review.',
      ),
      const FootballData(
        time: "72'",
        team: Team.arsenal,
        action: Action.goal,
        title: 'Goal!',
        subtitle: 'Nicolas Pépé puts the ball past the goalkeeper!',
      ),
      const FootballData(
        time: "84'",
        team: Team.arsenal,
        action: Action.goal,
        title: 'Coming from behind!!',
        subtitle:
            'Wonderful finish from Alexandre Lacazette. He drills a low shot precisely into the bottom left corner. No chance for the goalkeeper!',
      ),
    ];
  }
}

class _TimelineFootball extends StatelessWidget {
  const _TimelineFootball({Key key, this.data}) : super(key: key);

  final List<FootballData> data;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final FootballData event = data[index];

          final isLeftChild = event.team == Team.barcelona;

          final child = _TimelineFootballChild(
            action: event.action,
            title: event.title,
            subtitle: event.subtitle,
            isLeftChild: isLeftChild,
          );

          return TimelineTile(
            alignment: TimelineAlign.center,
            rightChild: isLeftChild ? null : child,
            leftChild: isLeftChild ? child : null,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicator: _TimelineFootballIndicator(time: event.time),
              drawGap: true,
            ),
            topLineStyle: LineStyle(
              color: Colors.white.withOpacity(0.2),
              width: 3,
            ),
          );
        },
        childCount: data.length,
      ),
    );
  }
}

class _MessageTimeline extends StatelessWidget {
  const _MessageTimeline({Key key, this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.dosis(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineFootballChild extends StatelessWidget {
  const _TimelineFootballChild({
    Key key,
    this.action,
    this.title,
    this.subtitle,
    this.isLeftChild,
  }) : super(key: key);

  final Action action;
  final String title;
  final String subtitle;
  final bool isLeftChild;

  @override
  Widget build(BuildContext context) {
    final rowChildren = <Widget>[
      _buildIconByAction(action),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          title,
          textAlign: isLeftChild ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.dosis(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];

    return Padding(
      padding: isLeftChild
          ? const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10)
          : const EdgeInsets.only(right: 16, top: 10, bottom: 10, left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: isLeftChild ? rowChildren.reversed.toList() : rowChildren,
          ),
          Flexible(
            child: Text(
              subtitle,
              textAlign: isLeftChild ? TextAlign.right : TextAlign.left,
              style: GoogleFonts.dosis(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconByAction(Action action) {
    final imageAsset =
        'assets/football/${action.toString().split('.').last}.png';
    return Image.asset(
      imageAsset,
      height: 20,
      width: 20,
    );
  }
}

class _TimelineFootballIndicator extends StatelessWidget {
  const _TimelineFootballIndicator({Key key, this.time}) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 3,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          time,
          style: GoogleFonts.dosis(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _Scoreboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      constraints: const BoxConstraints(maxHeight: 145),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Image.asset('assets/football/barcelona.png')),
          const SizedBox(width: 16),
          const _Score(score: '1', team: 'BAR'),
          const SizedBox(width: 16),
          const _Score(score: '2', team: 'ARS'),
          const SizedBox(width: 16),
          Expanded(child: Image.asset('assets/football/arsenal.png')),
        ],
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({Key key, this.score, this.team}) : super(key: key);

  final String score;
  final String team;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: const BoxConstraints(minWidth: 60, minHeight: 70),
          decoration: const BoxDecoration(
            color: Color(0xFF2C524C),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              score,
              style: GoogleFonts.dosis(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          team,
          style: GoogleFonts.dosis(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

enum Team {
  arsenal,
  barcelona,
}

enum Action {
  goal,
  yellowCard,
  redCard,
  offside,
  foul,
  injury,
  stoppageTime,
}

class FootballData {
  const FootballData({
    this.team,
    this.action,
    this.title,
    this.subtitle,
    this.time,
  });

  final Team team;
  final Action action;
  final String title;
  final String subtitle;
  final String time;
}
