import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/helper/svg/svg.dart';
import 'package:adscoin/helper/transform/transform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingComponent extends StatefulWidget {
  @override
  _OnBoardingComponentState createState() => _OnBoardingComponentState();
}

class _OnBoardingComponentState extends State<OnBoardingComponent> {
  @override
  Widget build(BuildContext context) {
    ScreenScaleHelper scale = ScreenScaleHelper()..init(context);
    return Material(
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Container(
            width: 411.0,
            height: 760.0,
            child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                overflow: Overflow.visible,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: Container(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Positioned(
                    left: -163.0,
                    top: -199.0,
                    right: null,
                    bottom: null,
                    width: 735.8445434570312,
                    height: 737.5784301757812,
                    child: Container(
                      width: 735.8445434570312,
                      height: 737.5784301757812,
                      child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          overflow: Overflow.visible,
                          children: [
                            Positioned(
                              left: 478.1420593261719,
                              top: 0.0,
                              right: null,
                              bottom: null,
                              width: 542.2241821289062,
                              height: 546.4508666992188,
                              child: TransformHelper.rotate(
                                  a: -0.88,
                                  b: 0.47,
                                  c: 0.47,
                                  d: 0.88,
                                  child: Container(
                                    width: 542.2241821289062,
                                    height: 546.4508666992188,
                                    child: SvgWidget(painters: [
                                      SvgPathPainter.fill()
                                        ..addPath('M211.211 447.778C169.984 553.784 31.2212 553.238 0 540.859L0 0L536.438 0C540.804 7.87768 546.918 37.6778 536.438 93.8569C523.338 164.081 470.614 261.809 397.965 277.854C228.782 315.217 265.503 308.176 211.211 447.778Z')
                                        ..setLinearGradient(
                                          startX: 560.2780822442209,
                                          startY: 701.7070748919826,
                                          endX: 130.71169770613756,
                                          endY: -156.65705094704668,
                                          colors: [
                                            Color.fromARGB(255, 255, 199, 44),
                                            Color.fromARGB(0, 255, 199, 44)
                                          ],
                                          colorStops: [0.0, 1.0],
                                        ),
                                    ]),
                                  )
                              ),
                            ),
                            Positioned(
                              left: 587.6630859375,
                              top: 210.0,
                              right: null,
                              bottom: null,
                              width: 323.9486083984375,
                              height: 288.76898193359375,
                              child: TransformHelper.rotate(
                                  a: -0.88,
                                  b: 0.47,
                                  c: 0.47,
                                  d: 0.88,
                                  child: Container(
                                    width: 323.9486083984375,
                                    height: 288.76898193359375,
                                    child: SvgWidget(painters: [
                                      SvgPathPainter.fill()
                                        ..addPath(
                                            'M126.187 236.626C101.556 292.644 18.6529 292.356 0 285.814L0 0L320.492 0C323.1 4.16292 326.753 19.9106 320.492 49.5982C312.665 86.7076 281.166 138.352 237.762 146.83C136.685 166.575 158.623 162.854 126.187 236.626Z')
                                        ..setLinearGradient(
                                          startX: 334.73476425902516,
                                          startY: 370.8132787927923,
                                          endX: 78.09291618601812,
                                          endY: -82.78456469497989,
                                          colors: [
                                            Color.fromARGB(255, 218, 41, 28),
                                            Color.fromARGB(0, 255, 199, 44)
                                          ],
                                          colorStops: [0.0, 1.0],
                                        ),
                                    ]),
                                  )),
                            ),
                            Positioned(
                              left: 378.0999450683594,
                              top: 163.0,
                              right: null,
                              bottom: null,
                              width: 348.2584228515625,
                              height: 298.7746887207031,
                              child: TransformHelper.rotate(
                                  a: -0.88,
                                  b: 0.47,
                                  c: 0.47,
                                  d: 0.88,
                                  child: Container(
                                    width: 348.2584228515625,
                                    height: 298.7746887207031,
                                    child: SvgWidget(painters: [
                                      SvgPathPainter.fill()
                                        ..addPath(
                                            'M135.656 244.825C109.177 302.784 20.0527 302.486 0 295.717L0 0L344.542 0C347.346 4.30716 351.273 20.6005 344.542 51.3167C336.128 89.712 302.265 143.146 255.604 151.918C146.942 172.346 170.527 168.497 135.656 244.825Z')
                                        ..setLinearGradient(
                                          startX: 359.8540377055389,
                                          startY: 383.6617812326858,
                                          endX: 83.95318982761188,
                                          endY: -85.65301015135918,
                                          colors: [
                                            Color.fromARGB(255, 218, 41, 28),
                                            Color.fromARGB(0, 255, 199, 44)
                                          ],
                                          colorStops: [0.0, 1.0],
                                        ),
                                    ]),
                                  )),
                            )
                          ]),
                    ),
                  ),
                  Positioned(
                    left: 25.0,
                    top: 275.0,
                    right: null,
                    bottom: null,
                    width: 223.0,
                    height: 182.0,
                    child: Container(
                      width: 223.0,
                      height: 182.0,
                      child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          overflow: Overflow.visible,
                          children: [
                            Positioned(
                              left: 0.0,
                              top: 9.381384558082573e-15,
                              right: null,
                              bottom: null,
                              width: 300.0,
                              // height: 26.0,
                              child: TransformHelper.rotate(
                                  a: 1.00,
                                  b: 0.00,
                                  c: -0.00,
                                  d: 1.00,
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Selamat datang di",style: Theme.of(context).textTheme.headline1),
                                      Text("Ads coin",style: Theme.of(context).textTheme.headline1),
                                      SizedBox(height: scale.getHeight(1)),
                                      Text("Marketplace pertama & terbaik untuk belanja tulisan iklan. Kamu bisa pilih tulisan iklan yang paling menarik untuk meningkatkan enjualan produk dalam bisnis kamu.",style: Theme.of(context).textTheme.subtitle1),
                                      SizedBox(height: scale.getHeight(1)),
                                      Text("Urusan tulisan iklan, serahkan pada kami.",style: Theme.of(context).textTheme.subtitle1),
                                      Text("Kamu tinggal posting, lalu terima orderan.",style: Theme.of(context).textTheme.subtitle1),
                                    ],
                                  )
                              ),
                            ),
                            // Positioned(
                            //   left: 0.0,
                            //   top: 27.0,
                            //   right: null,
                            //   bottom: null,
                            //   width: 77.0,
                            //   height: 26.0,
                            //   child: TransformHelper.rotate(
                            //       a: 1.00,
                            //       b: 0.00,
                            //       c: -0.00,
                            //       d: 1.00,
                            //       child:Text("Ads coin",style: Theme.of(context).textTheme.headline1)
                            //   ),
                            // ),

                            // Selamat datang di Ads Coin!
                            //
                            // Marketplace pertama & terbaik untuk belanja tulisan iklan.
                            // Kamu bisa pilih tulisan iklan yang paling menarik untuk meningkatkan
                            // penjualan produk dalam bisnis kamu.
                            //
                            // Urusan tulisan iklan, serahkan pada kami.
                            // Kamu tinggal posting, lalu terima orderan.
                            // Positioned(
                            //   left: 0.0,
                            //   top: 62.0,
                            //   right: null,
                            //   bottom: null,
                            //   width: 300.0,
                            //   height: 122.0,
                            //   child:Text("Marketplace pertama & terbaik untuk belanja tulisan iklan. Kamu bisa pilih tulisan iklan yang paling menarik untuk meningkatkan enjualan produk dalam bisnis kamu.",style: Theme.of(context).textTheme.subtitle1)
                            // ),

                          ]
                      ),
                    ),
                  ),

                  Positioned(
                    left: 130.0,
                    top: 497.0,
                    right: null,
                    bottom: null,
                    width: 150.0,
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context,RouteString.signIn),
                      child: Container(
                        width: 150.0,
                        height: 50.0,
                        child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            overflow: Overflow.visible,
                            children: [
                              Positioned(
                                left: 0.0,
                                top: 0.0,
                                right: null,
                                bottom: null,
                                width: 150.0,
                                height: 50.0,
                                child: Container(
                                  width: 150.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      color: ColorConfig.redColor,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 39.0,
                                top: 13.0,
                                right: null,
                                bottom: null,
                                width: 73.0,
                                height: 25.0,
                                child: Container(
                                  width: 73.0,
                                  height: 25.0,
                                  child: Stack(
                                      fit: StackFit.expand,
                                      alignment: Alignment.center,
                                      overflow: Overflow.visible,
                                      children: [
                                        Positioned(
                                          left: 0.0,
                                          top: 0.0,
                                          right: null,
                                          bottom: null,
                                          width: 73.0,
                                          height: 25.0,
                                          child: Container(
                                            width: 73.0,
                                            height: 25.0,
                                            child: Stack(
                                                fit: StackFit.expand,
                                                alignment: Alignment.center,
                                                overflow: Overflow.visible,
                                                children: [
                                                  Positioned(
                                                    left: 0.0,
                                                    top: 0.0,
                                                    right: null,
                                                    bottom: null,
                                                    width: 55.0,
                                                    height: 27.0,
                                                    child: Text(
                                                      '''Sign in''',
                                                      overflow: TextOverflow.visible,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        height: 1.5429999828338623,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                        /* letterSpacing: 0.0, */
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 59.0,
                                                    top: 10.0,
                                                    right: null,
                                                    bottom: null,
                                                    width: 14.0,
                                                    height: 6.0,
                                                    child: Container(
                                                      width: 14.0,
                                                      height: 6.0,
                                                      child: SvgWidget(painters: [
                                                        SvgPathPainter.stroke(
                                                          2.0,
                                                          strokeJoin: StrokeJoin.miter,
                                                        )
                                                          ..addPath(
                                                              'M14 3L14.7682 3.64018L15.3017 3L14.7682 2.35982L14 3ZM0 4L14 4L14 2L0 2L0 4ZM10.7318 0.640184L13.2318 3.64018L14.7682 2.35982L12.2682 -0.640184L10.7318 0.640184ZM12.2682 6.64018L14.7682 3.64018L13.2318 2.35982L10.7318 5.35982L12.2682 6.64018Z')
                                                          ..color = Color.fromARGB(255, 255, 255, 255),
                                                      ]),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        )
                                      ]),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),


                ]),
          ),
        ));
  }
}
