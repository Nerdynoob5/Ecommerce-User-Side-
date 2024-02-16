import 'package:emart_app/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  String imgBackground = 'assets/icons/bg.png';
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.fill)),
    child: child,
  );
}
