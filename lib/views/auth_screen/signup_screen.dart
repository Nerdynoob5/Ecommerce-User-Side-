import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/home_screen/home.dart';

import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text Controllers

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Sign Up ".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: retypeController,
                      isPass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgotPass.text.make())),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
            Row(children: [
              Checkbox(
                  checkColor: redColor,
                  value: isCheck,
                  onChanged: (newValue) {
                    setState(() {
                      isCheck = newValue;
                    });
                  }),
              10.widthBox,
              Expanded(
                child: RichText(
                    text: const TextSpan(
                  children: [
                    TextSpan(
                        style: TextStyle(
                      fontFamily: bold,
                      color: fontGrey,
                    )),
                    TextSpan(
                        text: termsandCond,
                        style: TextStyle(
                          fontFamily: bold,
                          color: redColor,
                        )),
                    TextSpan(
                        text: " & ",
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        )),
                    TextSpan(
                        text: privacyPolicy,
                        style: TextStyle(
                          fontFamily: bold,
                          color: redColor,
                        ))
                  ],
                )),
              ),
            ]),
            5.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : ourButton(
                    color: isCheck == true ? redColor : lightGrey,
                    title: signup,
                    textColor: whiteColor,
                    onPress: () async {
                      if (isCheck != false) {
                        controller.isloading(true);
                        try {
                          await controller
                              .signupMethod(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) {
                            return controller.storeUserData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text);
                          }).then((value) {
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => const Home());
                          });
                        } catch (e) {
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());
                          controller.isloading(false);
                        }
                      }
                    },
                  ).box.width(context.screenWidth - 70).make(),
            10.heightBox,

            //wrapping into gesture detector of velocity x
            RichText(
                text: const TextSpan(
              children: [
                TextSpan(
                  text: alreadyHaveAccount,
                  style: TextStyle(
                    fontFamily: bold,
                    color: fontGrey,
                  ),
                ),
                TextSpan(
                  text: login,
                  style: TextStyle(
                    fontFamily: bold,
                    color: redColor,
                  ),
                ),
              ],
            )),
            GestureDetector(
              onTap: () {
                Get.back();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
