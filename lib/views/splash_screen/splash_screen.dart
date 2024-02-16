import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth_screen/home_screen/home.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating a method to change screen
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // //using getX
      // Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String icSplashBg = 'assets/icons/bg.png';
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3, // Adjust the flex value as needed
              child: Container(), // Empty container to push elements below
            ),
            // Align(
            //     alignment: Alignment.topLeft,
            //     child: Image.asset(icSplashBg, width: 300)),
            // 20.heightBox,
            // Center(child: applogoWidget()),
            // 10.heightBox,
            SizedBox(
              width: 200, // Adjust width as needed
              height: 200,
              // Adjust height as needed
              child:
                  applogoWidget(), // Assuming applogoWidget() returns an Image widget
            ),
            const SizedBox(height: 10),
            appname.text.fontFamily(bold).size(22).white.make(),
            Expanded(
              flex: 3, // Adjust the flex value as needed
              child: Container(),
            ),
            // 5.heightBox,
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
