import 'package:flutter/material.dart';

// floatingActionButton:DynamicFloatingActionButton(
//  () {Navigator.push(context, MaterialPageRoute(builder: (context) => firstPage(() { })));}, // or FloatingpageRoute, // or Navigator.pop(btnContext);
// ,70,70,100,"Go back","Quit",Icon(Icons.arrow_back_ios_new,color: Colors.white,),Colors.black,).myFloatingButton(),


class DynamicFloatingActionButton {
  DynamicFloatingActionButton(this.onTap,this.btnHeight,this.btnWidth,this.btnRadius,this.btnHint,this.btnname,this.btnIcon,this.btnColor,);
  final void Function() onTap;
  final double btnHeight;
  final double btnWidth;
  final double btnRadius;
  final String btnHint;
  final String btnname;
  final Icon btnIcon;
  final Color btnColor;

  Widget myFloatingButton () {

    return Tooltip(
        message: btnHint,
        child: Container(
          height: btnHeight,
          width: btnWidth,
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
            backgroundColor: btnColor,
            icon: btnIcon,
            label: Text(btnname,textAlign: TextAlign.center,),
            onPressed: onTap,
          ),
        )
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double offsetX;   // along x axis
  final double offsetY;   // along y axis

  CustomFloatingActionButtonLocation(this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(scaffoldGeometry.scaffoldSize.width - offsetX, scaffoldGeometry.scaffoldSize.height - offsetY);
  }

  @override
  String toString() => 'CustomFloatingActionButtonLocation';
}
