import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:servio/constants/app_colors.dart';

class Loading extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child: SpinKitFadingCircle(
          color: kMain,
          size: 50.0,
        ),
      ),
    );
  }
}
