import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
// import 'package:emart_app/views/category_screen/cat_details2.dart';
// import 'package:emart_app/views/category_screen/cat_details3.dart';
// import 'package:emart_app/views/category_screen/cat_details4.dart';
// import 'package:emart_app/views/category_screen/cat_details5.dart';
// import 'package:emart_app/views/category_screen/cat_details6.dart';
// import 'package:emart_app/views/category_screen/cat_details7.dart';
// import 'package:emart_app/views/category_screen/cat_details8.dart';
// import 'package:emart_app/views/category_screen/cat_details9.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: categories.text.fontFamily(bold).white.make(),
            ),
            body: Container(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 200),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(categoriesImages[index],
                              height: 100, width: 150, fit: BoxFit.cover),
                          10.heightBox,
                          categoriesList[index]
                              .text
                              .color(darkFontGrey)
                              .align(TextAlign.center)
                              .make(),
                        ],
                      )
                          .box
                          .white
                          .rounded
                          .clip(Clip.antiAlias)
                          .outerShadowSm
                          .make()
                          .onTap(() {
                        controller.getSubCategories(categoriesList[index]);
                        Get.to(
                          () => CategoryDetails(title: categoriesList[index]),
                        );
                        // switch (index) {
                        //   case 0:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() => const CategoryDetails(
                        //         title: 'Artificial Flowers'));
                        //     break;
                        //   case 1:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() => const CategoryDetails2(
                        //         title: 'Wooden Decorations'));
                        //     break;
                        //   case 2:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() =>
                        //         const CategoryDetails3(title: 'Brass Decor'));
                        //     break;
                        //   case 3:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() => const CategoryDetails4(
                        //         title: 'Scented Candles'));
                        //     break;
                        //   case 4:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() => const CategoryDetails5(
                        //         title: 'Handmade Soaps'));
                        //     break;
                        //   case 5:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() =>
                        //         const CategoryDetails6(title: 'Elegant Jutis'));
                        //     break;
                        //   case 6:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() => const CategoryDetails7(
                        //         title: 'Sarees & Kurtis'));
                        //     break;
                        //   case 7:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() => const CategoryDetails8(
                        //         title: 'T-Shirts & Shirts'));
                        //     break;
                        //   case 8:
                        //     controller.getSubCategories(categoriesList[index]);
                        //     Get.to(() =>
                        //         const CategoryDetails9(title: 'Wooden Decor'));
                        //     break;
                        // }
                      });
                    }))));
  }
}
