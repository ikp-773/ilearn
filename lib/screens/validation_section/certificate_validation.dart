import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:ilearn/styling/colors.dart';
import 'package:ilearn/styling/strings.dart';
import 'package:ilearn/styling/text_styles.dart';
import 'package:image_picker/image_picker.dart';

class CertificateValidation extends StatefulWidget {
  const CertificateValidation({Key? key}) : super(key: key);

  @override
  State<CertificateValidation> createState() => _CertificateValidationState();
}

class _CertificateValidationState extends State<CertificateValidation> {
  TextEditingController urlController = TextEditingController();
  File? image1;
  File? image2;

  Future getImage() async {
    try {
      final image1 = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image1 == null) {
        return;
      } else {
        final tempImage = File(image1.path);
        setState(() {
          this.image1 = tempImage;
        });
      }
    } on PlatformException catch (e) {
      Get.snackbar('Failed to pick Image', e.toString());
    }
  }

  Future getImageFromGallery() async {
    try {
      final image2 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image2 == null) {
        return;
      } else {
        final tempImage = File(image2.path);
        setState(() {
          this.image2 = tempImage;
        });
      }
    } on PlatformException catch (e) {
      Get.snackbar('Failed to pick Image', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: AnimationLimiter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 400),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    validationMsg,
                    style: colouredBoldTextStyle(Color(0xff6A6A6A), 15),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: TextFormField(
                    controller: urlController,
                    keyboardType: TextInputType.text,
                    style: smallTextStyle,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          urlController.clear();
                        },
                        child: Icon(
                          Icons.send_sharp,
                          size: 20,
                          color: Color(0xff787878),
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      fillColor: Color(0xffF2F2F2),
                      filled: true,
                      border: InputBorder.none,
                      hintStyle: smallTextStyle,
                      hintText: 'Enter certificate url for validation',
                    ),
                  ),
                ),
                image2 != null
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        clipBehavior: Clip.antiAlias,
                        // alignment: Alignment.topCenter,
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            style: BorderStyle.solid,
                            color: Color(0xff00BCF2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(image2!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: getImageFromGallery,
                        child: Container(
                          height: 230,
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffE2F3FA),
                            border: Border.all(
                              width: 3,
                              style: BorderStyle.solid,
                              color: Color(0xff00BCF2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 80,
                                color: Color(0xff00BCF2),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Upload you certificates here',
                                style:
                                    colouredBoldTextStyle(AppColor.black, 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Browse Files',
                                style: colouredBoldTextStyle(
                                  Color(0xff00BCF2),
                                  15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                image1 != null
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        clipBehavior: Clip.antiAlias,
                        // alignment: Alignment.topCenter,
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 3,
                              style: BorderStyle.solid,
                              color: Color(0xffF29A31)),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(image1!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: getImage,
                        child: Container(
                          height: 230,
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffFFE7C3),
                            border: Border.all(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Color(0xffF29A31)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                size: 80,
                                color: Color(0xffF29A31),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Upload you certificates here',
                                style:
                                    colouredBoldTextStyle(AppColor.black, 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Capture',
                                style: colouredBoldTextStyle(
                                  Color(0xffF29A31),
                                  15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Future.delayed(Duration(milliseconds: 1500))
                          .then((value) => setState(() {
                                image1 = null;
                                image2 = null;
                              }));
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffDDEAC4)),
                      alignment: Alignment.center,
                      child: Text(
                        'UPLOAD TO CLOUD',
                        style: colouredBoldTextStyle(Color(0xff00BB34), 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
