import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final animationDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    controller.forward();
  }

  void toggleAnimation() {
    if (controller.isCompleted)
      controller.reverse();
    else {
      if (controller.isDismissed) {
        controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Text('Leading'),
        title: Text(
          'Flutter Menu',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          MyAppBarIcon(
            animationDuration: animationDuration,
            toggleAnimation: toggleAnimation,
          ),
          SizedBox(width: 10),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(builder: (context, bc) {
          final appBarHeight = Scaffold.of(context).appBarMaxHeight;

          return SizedBox(
            width: double.infinity,
            height: size.height - appBarHeight! - 50,
            child: Stack(
              children: [
                //Flutter
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, child) => Positioned(
                    bottom: -30,
                    right: -280 + (200 * controller.value),
                    child: Opacity(opacity: 0.3, child: child),
                  ),
                  child: FlutterLogo(
                    size: size.shortestSide * 0.9,
                  ),
                ),
                TopicsWidget(bc: bc, controller: controller),
                MyAnimatedButton(
                  controller: controller,
                  bc: bc,
                  toggleAnimation: toggleAnimation,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class MyAnimatedButton extends StatelessWidget {
  MyAnimatedButton({
    required this.controller,
    required this.bc,
    required this.toggleAnimation,
  })  : bounceAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.bounceOut,
            ),
            reverseCurve: Interval(
              0.0,
              1.0,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: ValueKey('myUniqueButton'));

  final AnimationController controller;
  final BoxConstraints bc;
  final void Function() toggleAnimation;
  final Animation<double> bounceAnimation;
  final double width = 220;

  double getPosition() {
    double positionX = (bc.maxWidth - width) / 2;

    // if (controller.status == AnimationStatus.forward) {
    //   return positionX;
    // }

    positionX *= bounceAnimation.value;

    return positionX;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Center(
        child: GestureDetector(
          onTap: toggleAnimation,
          child: Container(
            width: 220,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: -1,
                  color: Colors.black54,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      builder: (_, child) => Positioned(
        bottom: bc.maxHeight * 0.04,
        // right: -220 + controller.value * (bc.maxWidth / 2 + 110),
        child: Transform(
          transform: Matrix4.identity()
            ..translate(getPosition())
            ..scale(bounceAnimation.value),
          child: child!,
        ),
      ),
    );
  }
}

class TopicsWidget extends StatelessWidget {
  TopicsWidget({
    required this.bc,
    required this.controller,
  })  : topicAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear),
            reverseCurve: Interval(0.0, 1.0, curve: Curves.linear),
          ),
        ),
        topicAnimation2 = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 1.0, curve: Curves.linear),
            reverseCurve: Interval(0.0, 1.0, curve: Curves.linear),
          ),
        ),
        topicAnimation3 = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.3, 1.0, curve: Curves.linear),
            reverseCurve: Interval(0.0, 1.0, curve: Curves.linear),
          ),
        ),
        topicAnimation4 = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.4, 1.0, curve: Curves.linear),
            reverseCurve: Interval(0.0, 1.0, curve: Curves.linear),
          ),
        ),
        topicAnimation5 = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1.0, curve: Curves.linear),
            reverseCurve: Interval(0.0, 1.0, curve: Curves.linear),
          ),
        ),
        super(key: ValueKey('topics-key'));

  final BoxConstraints bc;
  final AnimationController controller;

  final Animation<double> topicAnimation;
  final Animation<double> topicAnimation2;
  final Animation<double> topicAnimation3;
  final Animation<double> topicAnimation4;
  final Animation<double> topicAnimation5;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: bc.maxWidth,
      height: bc.maxHeight,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.1),
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) => _buildAnimation(context),
        ),
      ),
    );
  }

  Stack _buildAnimation(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          height: bc.maxHeight * 0.1,
          left: 400 - (400 * topicAnimation.value),
          child: Text(
            'Declarative style',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Positioned(
          top: bc.maxHeight * 0.1,
          height: bc.maxHeight * 0.1,
          left: 400 - (400 * topicAnimation2.value),
          child: Text(
            'Premade Widgets',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Positioned(
          top: bc.maxHeight * 0.2,
          height: bc.maxHeight * 0.1,
          left: 400 - (400 * topicAnimation3.value),
          child: Text(
            'Stateful hot reload',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Positioned(
          top: bc.maxHeight * 0.3,
          height: bc.maxHeight * 0.1,
          left: 400 - (400 * topicAnimation4.value),
          child: Text(
            'Native performance',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Positioned(
          top: bc.maxHeight * 0.4,
          height: bc.maxHeight * 0.1,
          left: 400 - (400 * topicAnimation5.value),
          child: Text(
            'Great community',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

class MyAppBarIcon extends StatefulWidget {
  MyAppBarIcon({
    required this.animationDuration,
    required this.toggleAnimation,
  });

  final Duration animationDuration;
  final void Function() toggleAnimation;

  @override
  _MyAppBarIconState createState() => _MyAppBarIconState();
}

class _MyAppBarIconState extends State<MyAppBarIcon> {
  bool isOpen = false;

  void toggle() {
    widget.toggleAnimation();

    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: IconButton(
        onPressed: toggle,
        icon: Icon(Icons.menu, color: Colors.black),
      ),
      secondChild: IconButton(
        onPressed: toggle,
        icon: Icon(Icons.close, color: Colors.black),
      ),
      crossFadeState:
          isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: widget.animationDuration,
    );
  }
}
