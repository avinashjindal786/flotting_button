import 'package:flutter/material.dart';

class AnimatonWidget extends StatefulWidget {
  AnimatonWidget({Key? key}) : super(key: key);

  @override
  State<AnimatonWidget> createState() => _AnimatonWidgetState();
}

class _AnimatonWidgetState extends State<AnimatonWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation hightAnimation;
  late Animation hightAnimation2;
  late Animation widthAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    hightAnimation = Tween<double>(begin: 100, end: 300).animate(controller);
    hightAnimation2 = Tween<double>(begin: 100, end: 50).animate(controller);
    widthAnimation = BorderRadiusTween(begin: BorderRadius.circular(100), end: BorderRadius.circular(50)).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    hightAnimation.addListener(() {
      setState(() {});
    });

      hightAnimation.addStatusListener((status) {
        // ignore: unrelated_type_equality_checks
        if(AnimationStatus.completed == status){
          controller.reverse();
        }
      });

    
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: hightAnimation2.value,
        width: hightAnimation.value,
        decoration: BoxDecoration(
          borderRadius: widthAnimation.value,
          color: Colors.black,
        ),
      )),
    );
  }
}
