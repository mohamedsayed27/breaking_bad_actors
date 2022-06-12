import 'package:flutter/material.dart';
import 'package:flutter_breaking/app_routers.dart';

void main() {
  runApp( BreakingBad(appRouters: AppRouters(),));
}

class BreakingBad extends StatelessWidget {
  const BreakingBad({Key? key,required this.appRouters}) : super(key: key);
  final AppRouters appRouters;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouters.generateRoute,
    );
  }
}
