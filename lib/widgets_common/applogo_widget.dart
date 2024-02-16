import 'package:emart_app/consts/consts.dart';

Widget applogoWidget() {
  String icApplogo = 'assets/images/logo desgin sajni.png';
  return Image.asset(icApplogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .make();
}
