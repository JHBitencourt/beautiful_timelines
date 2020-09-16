import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ShowcaseHorizontalTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Showcase(
      title: 'Horizontal Timelines',
      app: _HorizontalTimelineApp(),
      description: 'Some horizontal timelines.',
      template: SimpleTemplate(reverse: false),
      theme: TemplateThemeData(
        frameTheme: FrameThemeData(
          statusBarBrightness: Brightness.dark,
          frameColor: const Color(0xFF383A47),
        ),
        flutterLogoColor: FlutterLogoColor.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFFE8E8E8),
        titleTextStyle: GoogleFonts.sniglet(
          fontSize: 60,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        descriptionTextStyle: GoogleFonts.sniglet(
          fontSize: 24,
          height: 1.2,
          color: Colors.black,
        ),
        buttonTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        buttonIconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF585858),
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

class _HorizontalTimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horizontal Timeline',
      builder: Frame.builder,
      home: _HorizontalTimeline(),
    );
  }
}

class _HorizontalTimeline extends StatefulWidget {
  @override
  _HorizontalTimelineState createState() => _HorizontalTimelineState();
}

class _HorizontalTimelineState extends State<_HorizontalTimeline> {
  @override
  void initState() {
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
            Color(0xFFF8F8F8),
            Colors.white,
          ],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF35577D).withOpacity(0.2),
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
                    'Horizontal Timelines',
                    style: GoogleFonts.sniglet(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  const Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverPadding(padding: EdgeInsets.only(top: 20)),
                        SliverToBoxAdapter(
                          child: _MessageTimeline(message: 'Months timeline:'),
                        ),
                        _TimelineMonths(),
                        SliverPadding(padding: EdgeInsets.only(top: 20)),
                        SliverToBoxAdapter(
                          child: _MessageTimeline(message: 'App timeline:'),
                        ),
                        _AppTimeline(),
                        SliverPadding(padding: EdgeInsets.only(top: 20)),
                        SliverToBoxAdapter(
                          child:
                              _MessageTimeline(message: 'Delivery timeline:'),
                        ),
                        SliverPadding(padding: EdgeInsets.only(top: 20)),
                        _DeliveryTimeline(),
                        SliverPadding(padding: EdgeInsets.only(top: 60)),
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
}

const months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

class _TimelineMonths extends StatefulWidget {
  const _TimelineMonths();

  @override
  _TimelineMonthsState createState() => _TimelineMonthsState();
}

class _TimelineMonthsState extends State<_TimelineMonths> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int currentMonth = DateTime.now().month;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo((currentMonth - 1) * 100.0);
    });

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(8),
        constraints: const BoxConstraints(maxHeight: 100),
        decoration: BoxDecoration(
          color: const Color(0xFF35577D).withOpacity(0.5),
          border: Border.all(width: 1, color: const Color(0xFF35577D)),
        ),
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: months.length,
          itemBuilder: (BuildContext context, int index) {
            return TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isFirst: index == 0,
              isLast: index == months.length - 1,
              beforeLineStyle: LineStyle(color: Colors.white.withOpacity(0.8)),
              indicatorStyle: IndicatorStyle(
                color: index == currentMonth - 1
                    ? Colors.purpleAccent
                    : Colors.white,
                indicator: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: index == currentMonth - 1
                            ? const Color(0xFF35577D)
                            : Colors.white,
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: index == currentMonth - 1
                        ? const Color(0xFF35577D)
                        : Colors.white,
                  ),
                ),
              ),
              endChild: Container(
                constraints: const BoxConstraints(minWidth: 100),
                child: Center(
                  child: Text(
                    months[index],
                    style: GoogleFonts.sniglet(
                      fontSize: 18,
                      color: index == currentMonth - 1
                          ? const Color(0xFF35577D)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MessageTimeline extends StatelessWidget {
  const _MessageTimeline({Key key, this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.sniglet(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const deliverySteps = [
  'Take your phone',
  'Choose a restaurant',
  'Order the food',
  'Wait for delivery',
  'Pay',
  'Eat and enjoy',
];

class _DeliveryTimeline extends StatefulWidget {
  const _DeliveryTimeline();

  @override
  _DeliveryTimelineState createState() => _DeliveryTimelineState();
}

class _DeliveryTimelineState extends State<_DeliveryTimeline> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const currentStep = 3;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(8),
        constraints: const BoxConstraints(maxHeight: 210),
        color: const Color(0xFF5D6173),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemCount: deliverySteps.length,
          itemBuilder: (BuildContext context, int index) {
            final step = deliverySteps[index];
            var indicatorSize = 30.0;
            var beforeLineStyle = LineStyle(
              color: Colors.white.withOpacity(0.8),
            );

            _DeliveryStatus status;
            LineStyle afterLineStyle;
            if (index < currentStep) {
              status = _DeliveryStatus.done;
            } else if (index > currentStep) {
              status = _DeliveryStatus.todo;
              indicatorSize = 20;
              beforeLineStyle = const LineStyle(color: Color(0xFF747888));
            } else {
              afterLineStyle = const LineStyle(color: Color(0xFF747888));
              status = _DeliveryStatus.doing;
            }

            return TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.6,
              isFirst: index == 0,
              isLast: index == deliverySteps.length - 1,
              beforeLineStyle: beforeLineStyle,
              afterLineStyle: afterLineStyle,
              indicatorStyle: IndicatorStyle(
                width: indicatorSize,
                height: indicatorSize,
                indicator: _IndicatorDelivery(status: status),
              ),
              startChild: _StartChildDelivery(index: index),
              endChild: _EndChildDelivery(
                text: step,
                current: index == currentStep,
              ),
            );
          },
        ),
      ),
    );
  }
}

enum _DeliveryStatus { done, doing, todo }

class _StartChildDelivery extends StatelessWidget {
  const _StartChildDelivery({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset('assets/delivery/horizontal/$index.png', height: 64),
      ),
    );
  }
}

class _EndChildDelivery extends StatelessWidget {
  const _EndChildDelivery({
    Key key,
    @required this.text,
    @required this.current,
  }) : super(key: key);

  final String text;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sniglet(
                    fontSize: 16,
                    color: current ? const Color(0xFF2ACA8E) : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({Key key, this.status}) : super(key: key);

  final _DeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _DeliveryStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Color(0xFF5D6173)),
          ),
        );
      case _DeliveryStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2ACA8E),
          ),
          child: const Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        );
      case _DeliveryStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF747888),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5D6173),
              ),
            ),
          ),
        );
    }
    return Container();
  }
}

const appSteps = [
  'Configure',
  'Code',
  'Test',
  'Deploy',
  'Scale',
];

class _AppTimeline extends StatelessWidget {
  const _AppTimeline();

  @override
  Widget build(BuildContext context) {
    const currentStep = 1;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(8),
        constraints: const BoxConstraints(maxHeight: 120),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: const Color(0xFF9F92E2)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: appSteps.length,
          itemBuilder: (BuildContext context, int index) {
            var beforeLineStyle = const LineStyle(
              thickness: 20,
              color: Color(0xFFD4D4D4),
            );

            LineStyle afterLineStyle;
            if (index <= currentStep) {
              beforeLineStyle = const LineStyle(
                thickness: 20,
                color: Color(0xFF9F92E2),
              );
            }

            if (index == currentStep) {
              afterLineStyle = const LineStyle(
                thickness: 20,
                color: Color(0xFFD4D4D4),
              );
            }

            final isFirst = index == 0;
            final isLast = index == appSteps.length - 1;
            var indicatorX = 0.5;
            if (isFirst) {
              indicatorX = 0.3;
            } else if (isLast) {
              indicatorX = 0.7;
            }

            return TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.8,
              isFirst: isFirst,
              isLast: isLast,
              beforeLineStyle: beforeLineStyle,
              afterLineStyle: afterLineStyle,
              hasIndicator: index <= currentStep || isLast,
              indicatorStyle: IndicatorStyle(
                width: 20,
                height: 20,
                indicatorXY: indicatorX,
                color: const Color(0xFFD4D4D4),
                indicator: index <= currentStep ? const _IndicatorApp() : null,
              ),
              startChild: Container(
                constraints: const BoxConstraints(minWidth: 120),
                margin: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/app/$index.png', height: 40),
                    const SizedBox(width: 8),
                    Text(
                      appSteps[index],
                      style: GoogleFonts.sniglet(
                        fontSize: 14,
                        color: index <= currentStep
                            ? const Color(0xFF9F92E2)
                            : const Color(0xFFD4D4D4),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _IndicatorApp extends StatelessWidget {
  const _IndicatorApp();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF9F92E2),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
