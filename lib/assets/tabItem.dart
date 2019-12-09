import 'package:flutter/material.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class TabItem extends StatelessWidget {

  final UniqueKey uniqueKey;
  final String title;
  final IconData iconData;
  final bool selected;
  final Function(UniqueKey uniqueKey) callbackFunction;
  final Color textColor;
  final Color activeTextColor;
  final Color iconColor;
  final double heightPercentage;
  final double widthPercentage;
  final String fontFamily;
  final double fontSize;
  final double iconSize;

  final double iconYAlign = ICON_ON;
  final double textYAlign = TEXT_OFF;
  final double iconAlpha = ALPHA_ON;

  TabItem({
    
    @required this.uniqueKey,
    @required this.selected,
    @required this.iconData,
    @required this.title,
    @required this.callbackFunction,
    @required this.activeTextColor,
    @required this.textColor,
    @required this.iconColor,
    @required this.heightPercentage,
    @required this.widthPercentage,
    @required this.fontFamily,
    @required this.fontSize,
    @required this.iconSize
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(

      child: GestureDetector(

        child: Container(

          color: Colors.transparent,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                
                child: Container(

                  child: AnimatedOpacity(

                    duration: Duration(milliseconds: ANIM_DURATION),
                    opacity: (selected) ? ALPHA_OFF : ALPHA_ON,
                    child: Icon(
                        
                      iconData,
                      size: iconSize * widthPercentage,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              Padding(

                padding: EdgeInsets.only(bottom: 5.0 * heightPercentage),
                child: Container(

                  child: Text(

                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(

                      fontFamily: fontFamily,
                      fontSize: fontSize * widthPercentage,
                      fontWeight: FontWeight.w400, 
                      color: (selected) ? activeTextColor : textColor
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {

          callbackFunction(uniqueKey);
        },
      ),
    );
  }
}
