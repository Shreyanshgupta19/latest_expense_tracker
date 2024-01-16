import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_expense_tracker/utils.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // incomenewXKJ (329:26)
        width: double.infinity,
        height: 812*fem,
        decoration: BoxDecoration (
          color: Color(0xff7b61ff),
        ),
        child: Stack(
          children: [
            Positioned(
              // autogroupohhnXs2 (FCsJGqhtsbUVgXi9yDoHHn)
              left: 0*fem,
              top: 0*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(16*fem, 60*fem, 16*fem, 20*fem),
                width: 375*fem,
                height: 369*fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // frame78BRn (I827:4832;654:33)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 144*fem),
                      padding: EdgeInsets.fromLTRB(4*fem, 5*fem, 4.99*fem, 5*fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // magiconsglypharrowarrowleftUQt (I827:4832;654:34)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 111*fem, 0*fem),
                            width: 24*fem,
                            height: 16.14*fem,
                            child: Image.asset(
                              'assets/master-design/images/magicons-glyph-arrow-arrow-left-9GG.png',
                              width: 24*fem,
                              height: 16.14*fem,
                            ),
                          ),
                          Center(
                            // titleoba (I827:4832;654:35)
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 112*fem, 0*fem),
                              child: Text(
                                'Income',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Inter',
                                  fontSize: 18*ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2125*ffem/fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            // magiconsoutlineuserinterfacecr (I827:4832;654:36)
                            opacity: 0,
                            child: Container(
                              width: 22.01*fem,
                              height: 22*fem,
                              child: Image.asset(
                                'assets/master-design/images/magicons-outline-user-interface-create-KBz.png',
                                width: 22.01*fem,
                                height: 22*fem,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // howmuch9Yx (329:35)
                      margin: EdgeInsets.fromLTRB(4*fem, 0*fem, 0*fem, 13*fem),
                      child: Text(
                        'How much?',
                        style: SafeGoogleFont (
                          'Inter',
                          fontSize: 18*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2125*ffem/fem,
                          color: Color(0xfffbfbfb),
                        ),
                      ),
                    ),
                    Container(
                      // autogroupoqjnG7n (FCsJ4mDgj4GWefeM7KoQjn)
                      margin: EdgeInsets.fromLTRB(3*fem, 0*fem, 0*fem, 0*fem),
                      width: 85*fem,
                      height: 78*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // mKS (329:34)
                            left: 42*fem,
                            top: 0*fem,
                            child: Align(
                              child: SizedBox(
                                width: 43*fem,
                                height: 78*fem,
                                child: Text(
                                  '0',
                                  style: SafeGoogleFont (
                                    'Inter',
                                    fontSize: 64*ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2125*ffem/fem,
                                    color: Color(0xfffbfbfb),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // FVW (329:40)
                            left: 0*fem,
                            top: 0*fem,
                            child: Align(
                              child: SizedBox(
                                width: 45*fem,
                                height: 78*fem,
                                child: Text(
                                  '₹',
                                  style: SafeGoogleFont (
                                    'Inter',
                                    fontSize: 64*ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2125*ffem/fem,
                                    color: Color(0xfffbfbfb),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // frame295KkG (827:4970)
              left: 0*fem,
              top: 369*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(16*fem, 24*fem, 16*fem, 24*fem),
                width: 375*fem,
                height: 320*fem,
                decoration: BoxDecoration (
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only (
                    topLeft: Radius.circular(32*fem),
                    topRight: Radius.circular(32*fem),
                  ),
                ),
                child: Container(
                  // frame291oQY (827:4972)
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // inputfieldKtg (827:4973)
                        padding: EdgeInsets.fromLTRB(16*fem, 12*fem, 16*fem, 12*fem),
                        width: double.infinity,
                        height: 56*fem,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xfff1f1fa)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16*fem),
                        ),
                        child: Container(
                          // frame283c76 (I827:4973;809:299)
                          padding: EdgeInsets.fromLTRB(0*fem, 7*fem, 6.57*fem, 7*fem),
                          width: double.infinity,
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // inputw9N (I827:4973;809:300)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 214.57*fem, 0*fem),
                                child: Text(
                                  'Category',
                                  style: SafeGoogleFont (
                                    'Inter',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.125*ffem/fem,
                                    color: Color(0xff90909f),
                                  ),
                                ),
                              ),
                              Container(
                                // magiconsglypharrowarrowdown2qV (I827:4973;809:301)
                                margin: EdgeInsets.fromLTRB(0*fem, 0.05*fem, 0*fem, 0*fem),
                                width: 18.86*fem,
                                height: 8.77*fem,
                                child: Image.asset(
                                  'assets/master-design/images/magicons-glyph-arrow-arrow-down-2-6q2.png',
                                  width: 18.86*fem,
                                  height: 8.77*fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16*fem,
                      ),
                      Container(
                        // inputfieldWrg (827:4974)
                        padding: EdgeInsets.fromLTRB(16*fem, 19*fem, 16*fem, 19*fem),
                        width: double.infinity,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xfff1f1fa)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16*fem),
                        ),
                        child: Text(
                          'Description',
                          style: SafeGoogleFont (
                            'Inter',
                            fontSize: 16*ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.125*ffem/fem,
                            color: Color(0xff90909f),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16*fem,
                      ),
                      Container(
                        // inputfieldzG4 (827:4975)
                        padding: EdgeInsets.fromLTRB(16*fem, 12*fem, 16*fem, 12*fem),
                        width: double.infinity,
                        height: 56*fem,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xfff1f1fa)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16*fem),
                        ),
                        child: Container(
                          // frame28375n (I827:4975;809:299)
                          padding: EdgeInsets.fromLTRB(0*fem, 7*fem, 6.57*fem, 7*fem),
                          width: double.infinity,
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // inputEAQ (I827:4975;809:300)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 238.57*fem, 0*fem),
                                child: Text(
                                  'Wallet',
                                  style: SafeGoogleFont (
                                    'Inter',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.125*ffem/fem,
                                    color: Color(0xff90909f),
                                  ),
                                ),
                              ),
                              Container(
                                // magiconsglypharrowarrowdown2LU (I827:4975;809:301)
                                margin: EdgeInsets.fromLTRB(0*fem, 0.05*fem, 0*fem, 0*fem),
                                width: 18.86*fem,
                                height: 8.77*fem,
                                child: Image.asset(
                                  'assets/master-design/images/magicons-glyph-arrow-arrow-down-2-nyz.png',
                                  width: 18.86*fem,
                                  height: 8.77*fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16*fem,
                      ),
                      Container(
                        // inputfieldp8c (827:4976)
                        width: double.infinity,
                        height: 56*fem,
                        decoration: BoxDecoration (
                          border: Border.all(color: Color(0xfff1f1fa)),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16*fem),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              // statusbarwU8 (827:4576)
              left: 31.3939208984*fem,
              top: 14*fem,
              child: Container(
                width: 329.11*fem,
                height: 18*fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // timeFji (I827:4576;816:118)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 231.11*fem, 0*fem),
                      child: Text(
                        '9:41',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                          'Inter',
                          fontSize: 15*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2*ffem/fem,
                          letterSpacing: -0.1650000066*fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      // containerwcY (I827:4576;816:119)
                      margin: EdgeInsets.fromLTRB(0*fem, 2.16*fem, 0*fem, 4.34*fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // combinedshape4x4 (I827:4576;816:127)
                            margin: EdgeInsets.fromLTRB(0*fem, 0.08*fem, 5*fem, 0*fem),
                            width: 17.1*fem,
                            height: 10.7*fem,
                            child: Image.asset(
                              'assets/master-design/images/combined-shape-tqJ.png',
                              width: 17.1*fem,
                              height: 10.7*fem,
                            ),
                          ),
                          Container(
                            // wifim5n (I827:4576;816:132)
                            margin: EdgeInsets.fromLTRB(0*fem, 0.04*fem, 5*fem, 0*fem),
                            width: 15.4*fem,
                            height: 11.06*fem,
                            child: Image.asset(
                              'assets/master-design/images/wi-fi.png',
                              width: 15.4*fem,
                              height: 11.06*fem,
                            ),
                          ),
                          Container(
                            // batteryH48 (I827:4576;816:120)
                            width: 24.5*fem,
                            height: 11.5*fem,
                            child: Image.asset(
                              'assets/master-design/images/battery-Qdr.png',
                              width: 24.5*fem,
                              height: 11.5*fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // homeindicatorPcx (831:2207)
              left: 0*fem,
              top: 778*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(121*fem, 21*fem, 120*fem, 8*fem),
                width: 375*fem,
                height: 34*fem,
                decoration: BoxDecoration (
                  color: Color(0xffffffff),
                ),
                child: Center(
                  // homeindicator61a (I831:2207;217:6977)
                  child: SizedBox(
                    width: double.infinity,
                    height: 5*fem,
                    child: Container(
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular(100*fem),
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // group257DM6 (1189:6139)
              left: 0*fem,
              top: 690*fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 16*fem, 16*fem),
                width: 375*fem,
                height: 88*fem,
                decoration: BoxDecoration (
                  color: Color(0xffffffff),
                ),
                child: Container(
                  // buttonlargevWQ (1189:6141)
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration (
                    color: Color(0xff7e3dff),
                    borderRadius: BorderRadius.circular(16*fem),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Continue',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                          'Inter',
                          fontSize: 18*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2125*ffem/fem,
                          color: Color(0xfffbfbfb),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}