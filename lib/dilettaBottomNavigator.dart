library diletta_bottom_navigator;

import 'package:diletta_bottom_navigator/assets/halfClipper.dart';
import 'package:flutter/material.dart';

import 'package:diletta_bottom_navigator/assets/tabItem.dart';
import 'package:diletta_bottom_navigator/assets/halfPainter.dart';

const BAR_HEIGHT = 51.0;
const CIRCLE_SIZE = 31.0;
const ARC_HEIGHT = 9.5;
const FONT_FAMILY = 'Roboto';
const FONT_SIZE = 12.0;
const ICON_SIZE = 24.0;

class DilettaBottomNavigator extends StatefulWidget {

  final Function(int position) onTabChangedListener;
  final Color circleColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color textColor;
  final Color barBackgroundColor;
  final List<TabData> tabs;
  final int initialSelection;

  final double barHeight;
  final double circleSize;
  final double arcHeight;
  final double heightPercentage;
  final double widthPercentage;
  final String fontFamily;
  final double fontSize;
  final double iconSize;
  final Color activeTextColor;
  final bool separator;

  final Key key;

  DilettaBottomNavigator({
    
    @required this.tabs,
    @required this.onTabChangedListener,
    this.barHeight,
    this.circleSize,
    this.arcHeight,
    this.heightPercentage,
    this.widthPercentage,
    this.fontFamily,
    this.fontSize,
    this.iconSize,
    this.activeTextColor,
    this.key,
    this.initialSelection = 0,
    this.circleColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.textColor,
    this.barBackgroundColor,
    this.separator
  }) : 
    assert(onTabChangedListener != null),
    assert(tabs != null),
    assert(tabs.length > 1 && tabs.length < 5);

  @override
  DilettaBottomNavigatorState createState() => DilettaBottomNavigatorState();
}

class DilettaBottomNavigatorState extends State<DilettaBottomNavigator>
    with TickerProviderStateMixin, RouteAware {

  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;

  int currentSelected = 0;
  double _circleAlignX = 0;
  double _circleIconAlpha = 1;

  Color circleColor;
  Color activeIconColor;
  Color activeTextColor;
  Color inactiveIconColor;
  Color barBackgroundColor;
  Color textColor;

  double barHeight;
  double circleSize;
  double arcHeight;
  double heightPercentage;
  double widthPercentage;
  String fontFamily;
  double iconSize;
  double fontSize;
  bool separator;

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    activeIcon = widget.tabs[currentSelected].iconData;

    circleColor = (widget.circleColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor
        : widget.circleColor;

    activeIconColor = (widget.activeIconColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white
        : widget.activeIconColor;

    activeTextColor = (widget.activeTextColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white
        : widget.activeTextColor;

    barBackgroundColor = (widget.barBackgroundColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Color(0xFF212121)
            : Colors.white
        : widget.barBackgroundColor;
    textColor = (widget.textColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Colors.black54
        : widget.textColor;
    inactiveIconColor = (widget.inactiveIconColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor
        : widget.inactiveIconColor;

    barHeight = widget.barHeight != null ? widget.barHeight : BAR_HEIGHT;
    circleSize = widget.circleSize != null ? widget.circleSize : CIRCLE_SIZE;
    arcHeight = widget.arcHeight != null ? widget.arcHeight : ARC_HEIGHT;
    heightPercentage = widget.heightPercentage != null ? widget.heightPercentage : 1.0;
    widthPercentage = widget.widthPercentage != null ? widget.widthPercentage : 1.0;
    fontFamily = widget.fontFamily != null ? widget.fontFamily : FONT_FAMILY;
    fontSize = widget.fontSize != null ? widget.fontSize : FONT_SIZE;
    iconSize = widget.iconSize != null ? widget.iconSize : ICON_SIZE;
    separator = widget.separator != null ? widget.separator : true;
  }

  @override
  void initState() {
    
    _setSelected(widget.tabs[widget.initialSelection].key);
    super.initState();
  }

  _setSelected(UniqueKey key) {

    int selected = widget.tabs.indexWhere((tabData) => tabData.key == key);

    if (mounted) {

      setState(() {

        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs.length - 1) * selected);
        nextIcon = widget.tabs[selected].iconData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Stack(

      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: [

        Container(

          height: barHeight * heightPercentage,
          decoration: BoxDecoration(
            
            color: barBackgroundColor, 
            boxShadow: [

              BoxShadow(

                color: Color(0xff000000), 
                offset: Offset(0, 1),
                blurRadius: 8
              )
            ]
          ),
          child: Row(
            
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getTabs()
          ),
        ),
        Positioned.fill(

          top: (-arcHeight - 15.0) * heightPercentage,
          child: Container(

            child: AnimatedAlign(

              duration: Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeOut,
              alignment: Alignment(_circleAlignX, 1),
              child: FractionallySizedBox(

                widthFactor: 1 / widget.tabs.length,
                child: Stack(

                  alignment: Alignment.topCenter,
                  children: [

                    SizedBox(

                      height: (circleSize + 15.0) * heightPercentage,
                      width: circleSize * 5.5 * widthPercentage,
                      child: ClipRect(

                        clipper: HalfClipper(),
                        child: Container(

                          child: Center(

                            child: Padding(

                              padding: EdgeInsets.only(top: 15.0 * heightPercentage),
                              child: Container(

                                height: circleSize * heightPercentage,
                                width: circleSize * 2.5 * widthPercentage,
                                decoration: BoxDecoration(

                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [

                                    BoxShadow(

                                      color: Color(0xff000000), 
                                      blurRadius: 8
                                    )
                                  ]
                                )
                              ),
                            ),
                          ),
                        )
                      ),
                    ),
                    Padding(

                      padding: EdgeInsets.only(top: 15.0 * heightPercentage),
                      child: SizedBox(
                        
                        height: (barHeight + arcHeight) * heightPercentage,
                        width: circleSize * 2.5 * widthPercentage,
                        child: Container(
                          
                          child: CustomPaint(

                            painter: HalfPainter(barBackgroundColor),
                          ),
                        )
                      ),
                    ),
                    Padding(

                      padding: EdgeInsets.only(top: (arcHeight + 15.0) * heightPercentage),
                      child: SizedBox(

                        height: circleSize * widthPercentage,
                        width: circleSize * widthPercentage,
                        child: Container(

                          decoration: BoxDecoration(

                            shape: BoxShape.circle, 
                            color: circleColor
                          ),
                          child: AnimatedOpacity(

                            duration: Duration(milliseconds: ANIM_DURATION ~/ 5),
                            opacity: _circleIconAlpha,
                            child: Icon(
                              
                              activeIcon,
                              color: activeIconColor,
                              size: iconSize * widthPercentage,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _getTabs() {

    List<Widget> widgets = List<Widget>();

    for (int i = 0; i < widget.tabs.length; i++) {

      if (i != 0 && separator) {

        widgets.add(

          Padding(

            padding: EdgeInsets.symmetric(vertical: 8.0 * heightPercentage),
            child: Container(

              width: 0.5 * heightPercentage,
              color: widget.textColor,
            ),
          )
        );
      }

      widgets.add(
        
        TabItem(

          uniqueKey: widget.tabs[i].key,
          selected: widget.tabs[i].key == widget.tabs[currentSelected].key,
          iconData: widget.tabs[i].iconData,
          title: widget.tabs[i].title,
          iconColor: inactiveIconColor,
          activeTextColor: widget.activeTextColor,
          textColor: textColor,
          callbackFunction: (uniqueKey) {

            if (uniqueKey != widget.tabs[currentSelected].key) {

              int selected = widget.tabs
                  .indexWhere((tabData) => tabData.key == uniqueKey);
              widget.onTabChangedListener(selected);
              _setSelected(uniqueKey);
              _initAnimationAndStart(_circleAlignX, 1);
            }
          },
          widthPercentage: widthPercentage,
          heightPercentage: heightPercentage,
          fontFamily: fontFamily,
          fontSize: fontSize,
          iconSize: iconSize,
        )
      );
    }

    return widgets;
  }

  _initAnimationAndStart(double from, double to) {
    _circleIconAlpha = 0;

    Future.delayed(Duration(milliseconds: ANIM_DURATION ~/ 5), () {
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(Duration(milliseconds: (ANIM_DURATION ~/ 5 * 3)), () {
        setState(() {
          _circleIconAlpha = 1;
        });
      });
    });
  }

  void setPage(int page) {

    widget.onTabChangedListener(page);
    _setSelected(widget.tabs[page].key);
    _initAnimationAndStart(_circleAlignX, 1);

    setState(() {
      currentSelected = page;
    });
  }
}

class TabData {

  TabData({@required this.iconData, @required this.title, this.onclick});

  IconData iconData;
  String title;
  Function onclick;
  final UniqueKey key = UniqueKey();
}