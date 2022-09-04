import 'package:flotting_button/animations.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HawkFabMenu extends StatefulWidget {
  HawkFabMenu({
    Key? key,
  }) : super(key: key);

  @override
  _HawkFabMenuState createState() => _HawkFabMenuState();
}

class _HawkFabMenuState extends State<HawkFabMenu> with TickerProviderStateMixin {
  bool _isOpen = false;

  final Duration _duration = const Duration(seconds: 1);
  late AnimationController _iconAnimationCtrl;
  late Animation<double> _iconAnimationTween;
  late AnimationController controller;
  late AnimationController controller1;
  late Animation hightAnimation;
  late Animation animation;
  late Animation hightAnimation2;
  late Animation widthAnimation;

  late var value = false;

  @override
  void initState() {
    super.initState();
    _iconAnimationCtrl = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _iconAnimationTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_iconAnimationCtrl);
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: controller1, curve: Curves.fastOutSlowIn));
    hightAnimation = Tween<double>(begin: 100, end: 300).animate(controller);
    hightAnimation2 = Tween<double>(begin: 100, end: 50).animate(controller);
    widthAnimation = BorderRadiusTween(begin: BorderRadius.circular(100), end: BorderRadius.circular(50)).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    hightAnimation.addListener(() {
      setState(() {
        
      });
    });
    hightAnimation2.addListener(() {
      setState(() {});
    });
    widthAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _iconAnimationCtrl.dispose();
    controller.dispose();
    controller.dispose();
    super.dispose();
  }

  /// Closes the menu if open and vice versa
  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
    if (_isOpen) {
      _iconAnimationCtrl.forward();
      controller.forward();
      hightAnimation.addStatusListener((status) {
        if (AnimationStatus.completed == status) {
          controller1.forward();
        }
      });
    } else {
      _iconAnimationCtrl.reverse();
      controller.reverse();
    }
  }

  /// If the menu is open and the device's back button is pressed then menu gets closed instead of going back.
  Future<bool> _preventPopIfOpen() async {
    if (_isOpen) {
      _toggleMenu();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildMenuButton(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: hightAnimation2.value,
              width: hightAnimation.value,
              decoration: BoxDecoration(
                borderRadius: widthAnimation.value,
                color: Colors.black,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                value
                    ? Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      )
                    : SizedBox(),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns animated list of menu items
  // Widget _buildMenuItemList() {
  //   return Positioned(
  //       bottom: 100,
  //       right: 50,
  //       left: 50,
  //       child: );
  // }

  Widget _buildMenuButton(BuildContext context) {
    late Widget iconWidget;

    iconWidget = AnimatedIcon(
      icon: AnimatedIcons.menu_close,
      progress: _iconAnimationTween,
      color: Colors.black,
    );

    return Positioned(
      bottom: 40,
      right: 50,
      left: 50,
      child: FloatingActionButton(
        child: iconWidget,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _toggleMenu,
      ),
    );
  }
}
