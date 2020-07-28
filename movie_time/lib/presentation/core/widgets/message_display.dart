import 'package:flutter/material.dart';
import 'package:movie_time/presentation/core/utils/res/app_text_styles.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({Key key, @required this.message})
      : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: AppTextStyles.messageDisplay,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
