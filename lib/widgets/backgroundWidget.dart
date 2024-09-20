import 'package:flutter/cupertino.dart';

class Backgroundwidget extends StatelessWidget {
  final Widget child;
  const Backgroundwidget({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/4909528.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.fill,
            ),
          ),
        ),
        child
      ],
    );
  }
}
