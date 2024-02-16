import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/home_screen/components/featured_button.dart';
import 'package:emart_app/views/auth_screen/home_screen/components/search_screen.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';
// import 'package:emart_app/widgets_common/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(() =>
                        SearchScreen(title: controller.searchController.text));
                  }
                }),
                filled: true,
                fillColor: lightGolden,
                hintText: searchanything,
                hintStyle: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // swipper brands
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        ).box.roundedLg.outerShadow3Xl.make();
                      }),

                  10.heightBox,
                  // deals buttons
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 100,
                      child: VxSwiper.builder(
                        itemCount: 5, // Total count of quotes
                        aspectRatio: 1 / 0.2,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        itemBuilder: (context, index) {
                          // List of example quotes
                          List<String> quotes = [
                            "You can have anything you want in life if you dress for it. —Edith Head",
                            "Clothes mean nothing until someone lives in them. —Marc Jacobs",
                            "Style is a way to say who you are without having to speak. —Rachel Zoe",
                            "Elegance is good taste, plus a dash of daring. —Carmel Snow",
                            "Care for your clothes like the good friends they are. — Joan Crawford",
                          ];

                          return Column(
                            children: [
                              Text(
                                quotes[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                  height: 5), // Space between quotes if needed
                              // Additional content for each quote...
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // swippers brands
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        ).box.roundedLg.outerShadow3Xl.make();
                      }),

                  10.heightBox,
                  // category buttons
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 95,
                      child: VxSwiper.builder(
                        itemCount: 5, // Total count of quotes
                        aspectRatio: 1 / 0.2,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        itemBuilder: (context, index) {
                          // List of example quotes
                          List<String> quotes = [
                            "Get the look of your dreams",
                            "It’s never too late to be fabulous!",
                            "Where the customer comes first",
                            "You’ve never had it so good",
                            "We make it easy for you to look your best",
                          ];

                          return Column(
                            children: [
                              Text(
                                quotes[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                  height: 5), // Space between quotes if needed
                              // Additional content for each quote...
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  // featured categories

                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(children: [
                                featuredButton(
                                    icon: featuredImages1[index],
                                    title: featuredTitles1[index]),
                                10.heightBox,
                                featuredButton(
                                    icon: featuredImages2[index],
                                    title: featuredTitles2[index]),
                              ])).toList(),
                    ),
                  ),
                  //featured products
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No featured products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_images'][0],
                                            width: 150,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featuredData[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "${featuredData[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make(),
                                        ],
                                      )
                                          .box
                                          .white
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetails(
                                              title:
                                                  "${featuredData[index]['p_name']}",
                                              data: featuredData[index],
                                            ));
                                      }),
                                    ),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  //THIRDSWIPER
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: thirdsliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          thirdsliderList[index],
                          fit: BoxFit.fill,
                        ).box.rounded.make();
                      }),
                  //all products
                  20.heightBox,
                  StreamBuilder(
                    stream: FirestoreServices.allproducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return loadingIndicator();
                      } else {
                        var allproductsdata = snapshot.data!.docs;
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allproductsdata[index]['p_images'][0],
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
                                  "${allproductsdata[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['p_price']}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index],
                                    ));
                              });
                            });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
    //swiperbrands
  }
}
