import 'package:flutter/material.dart';
import 'package:movie_time/presentation/core/widgets/message_display.dart';

class ErrorTryAgain extends StatelessWidget {
  final Function tryAgain;
  final String errorMessage;

  ErrorTryAgain({@required this.errorMessage, @required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MessageDisplay(message: errorMessage),
            FlatButton(
              color: Colors.blue,
              onPressed: tryAgain,
              child: Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
