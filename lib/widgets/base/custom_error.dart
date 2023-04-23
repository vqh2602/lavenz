import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.jpg',
              width: double.infinity * 0.5,
              height: double.infinity * 0.5,
              fit: BoxFit.cover,
            ),
            textHeadlineMedium(
                text: kDebugMode
                    ? errorDetails.summary.toString()
                    : 'Oups! Hình như đã có lỗi sảy ra!',
                textAlign: TextAlign.center,
                color: kDebugMode ? Colors.red : Colors.black),
            const SizedBox(height: 12),
            const Text(
              kDebugMode
                  ? 'https://docs.flutter.dev/testing/errors'
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
