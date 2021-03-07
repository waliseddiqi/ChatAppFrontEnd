import 'package:chat_app/core/enums.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget{
  final String icon;
  final double size;
  final Color backgroundColor;
  final Widget child;
  final PresentState presentState;
  const LoadingIndicator({Key key, this.icon, this.size, this.backgroundColor, this.child, this.presentState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    presentState==PresentState.Loading? Material(
      child: Center(child: CircularProgressIndicator()),
    ):child;
  }

}