import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

Widget getVector(String fname, double h, double w) {
  return SvgPicture.asset(
    fname,
    height: h,
    width: w,
  );
}

Widget logo(double h, double w) {
  return SvgPicture.asset(
    'assets/images/logo.svg',
    height: h,
    width: w,
  );
}

final Widget logoMSize = getVector('assets/images/logo.svg', 25, 50);
final Widget logoLSize = getVector('assets/images/logo.svg', 55, 80);
final Widget vCamera = getVector('assets/images/videoCamera.svg', 35, 35);

final Widget svgMapPin = getVector('assets/images/pin.svg', 35, 35);
final Widget svgMail =   getVector('assets/images/mail.svg', 35, 35);

final Widget logoMin = Image.asset('assets/images/logo_min.png');
final Widget logoFund = Image.asset('assets/images/logo_fond.png');

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.all(15),
  side: BorderSide(
    width: 1.0,
    color: Colors.red,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  primary: Colors.black,
);

final ButtonStyle redFilledButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.all(15),
  backgroundColor: Colors.red,
  side: BorderSide(
    width: 1.0,
    color: Colors.red,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  primary: Colors.white,
);

Widget adsBlock(BuildContext ctx) {
  return Container(
    color: Theme.of(ctx).colorScheme.primary.withOpacity(0.2),
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        logoMin,
        logoFund,
      ],
    ),
  );
}


InputDecoration myInputDecoration ({String aHintText, IconData aSuffixIcon , String aErrortext = ''}) {
  return InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: aSuffixIcon!= null ?Icon(aSuffixIcon) : null,
                  hintText: aHintText,
                  
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                );
}