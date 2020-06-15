import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dot_animation_enum.dart';
import 'list_rtl_language.dart';
import 'slide_object.dart';

/// Default values
const TextStyle defaultBtnNameTextStyle = TextStyle(color: Colors.white);

const double defaultBtnBorderRadius = 30.0;

const Color defaultBtnColor = Colors.transparent;

const Color defaultBtnHighlightColor = Color(0x66FFFFFF);

class IntroSliderController {

  IntroSliderController({
    int initialIndex = 0,
    int length,
    TickerProvider vsync,
  })  : assert(length != null && length >= 0),
        assert(initialIndex != null && initialIndex >= 0 && (length == 0 || initialIndex < length)),
        tabController = TabController(initialIndex: initialIndex, length: length, vsync: vsync);

  final TabController tabController;

  dispose() {
    tabController.dispose();
  }

  void goToTab(index) {
    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

  // Checking if tab is animating
  bool get isAnimating => tabController.animation.value -
            tabController.animation.value.truncate() != 0;

  void moveToLast() {
    if (!isAnimating) {
      tabController.animateTo(tabController.length - 1);
    }
  }

  void moveToNext() {
    if (!isAnimating) {
      tabController.animateTo(tabController.index + 1);
    }
  }

  void moveToPrevious() {
    if (!isAnimating) {
      tabController.animateTo(tabController.index - 1);
    }
  }
}

class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Widget> slides;

  /// Background color for all slides
  final Color backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  final Widget skipButton;

  /// Width of view wrapper SKIP button
  final double widthSkipBtn;

  /// Fire when press SKIP button
  final Function onSkipPress;

  /// Change SKIP to any text you want
  final String nameSkipBtn;

  /// Style for text at SKIP button
  final TextStyle styleNameSkipBtn;

  /// Color for SKIP button
  final Color colorSkipBtn;

  /// Color for Skip button when press
  final Color highlightColorSkipBtn;

  /// Show or hide SKIP button
  final bool isShowSkipBtn;

  /// Rounded SKIP button
  final double borderRadiusSkipBtn;

  // ---------- PREV button ----------
  /// Render your own PREV button
  final Widget prevButton;

  /// Width of view wrapper PREV button
  final double widthPrevBtn;

  /// Change PREV to any text you want
  final String namePrevBtn;

  /// Style for text at PREV button
  final TextStyle styleNamePrevBtn;

  /// Color for PREV button
  final Color colorPrevBtn;

  /// Color for PREV button when press
  final Color highlightColorPrevBtn;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool isShowPrevBtn;

  /// Rounded PREV button
  final double borderRadiusPrevBtn;

  // ---------- NEXT button ----------
  /// Render your own NEXT button
  final Widget nextButton;

  /// Change NEXT to any text you want
  final String nameNextBtn;

  /// Show or hide NEXT button
  final bool isShowNextBtn;

  // ---------- DONE button ----------
  /// Change DONE to any text you want
  final String nameDoneBtn;

  /// Render your own DONE button
  final Widget doneButton;

  /// Width of view wrapper DONE button
  final double widthDoneBtn;

  /// Fire when press DONE button
  final Function onDonePress;

  /// Style for text at DONE button
  final TextStyle styleNameDoneBtn;

  /// Color for DONE button
  final Color colorDoneBtn;

  /// Color for DONE button when press
  final Color highlightColorDoneBtn;

  /// Rounded DONE button
  final double borderRadiusDoneBtn;

  /// Show or hide DONE button
  final bool isShowDoneBtn;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  final bool isShowDotIndicator;

  /// Color for dot when passive
  final Color colorDot;

  /// Color for dot when active
  final Color colorActiveDot;

  /// Size of each dot
  final double sizeDot;

  /// Type dots animation
  final dotSliderAnimation typeDotAnimation;

  /// Notify when tab change completed
  final Function onTabChangeCompleted;

  /// Ref function go to specific tab index
  final Function refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool isScrollable;

  /// Show or hide status bar
  final bool shouldHideStatusBar;

  final IntroSliderController controller;

  // Constructor
  IntroSlider({
    @required this.controller,
    
    // Slides
    @required this.slides,
    this.backgroundColorAllSlides,

    // Skip
    this.skipButton,
    this.widthSkipBtn,
    this.onSkipPress,
    this.nameSkipBtn = "SKIP",
    this.styleNameSkipBtn = defaultBtnNameTextStyle,
    this.colorSkipBtn = defaultBtnColor,
    this.highlightColorSkipBtn = defaultBtnHighlightColor,
    this.isShowSkipBtn = true,
    this.borderRadiusSkipBtn = defaultBtnBorderRadius,

    // Prev
    this.prevButton,
    this.widthPrevBtn,
    this.namePrevBtn = "PREV",
    this.isShowPrevBtn = true,
    this.styleNamePrevBtn = defaultBtnNameTextStyle,
    this.colorPrevBtn = defaultBtnColor,
    this.highlightColorPrevBtn = defaultBtnHighlightColor,
    this.borderRadiusPrevBtn = defaultBtnBorderRadius,

    // Done
    this.doneButton,
    this.widthDoneBtn,
    this.onDonePress,
    this.nameDoneBtn = "DONE",
    this.colorDoneBtn = defaultBtnColor,
    this.highlightColorDoneBtn = defaultBtnHighlightColor,
    this.borderRadiusDoneBtn = defaultBtnBorderRadius,
    this.styleNameDoneBtn = defaultBtnNameTextStyle,
    this.isShowDoneBtn = true,

    // Next
    this.nextButton,
    this.nameNextBtn = "NEXT",
    this.isShowNextBtn = true,

    // Dots
    this.isShowDotIndicator = true,
    this.colorDot = const Color(0x80000000),
    this.colorActiveDot = const Color(0x80000000),
    this.sizeDot = 8.0,
    this.typeDotAnimation,

    // Tabs
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Behavior
    this.isScrollable = true,
    this.shouldHideStatusBar = false,
  })  : assert(isShowDotIndicator != null),
        assert(sizeDot != null),
        assert(colorDot != null),
        assert(colorActiveDot != null),
        assert(isShowDoneBtn != null),
        assert(isShowNextBtn != null),
        assert(isShowPrevBtn != null),
        assert(isShowSkipBtn != null),
        assert(shouldHideStatusBar != null),
        assert(isScrollable != null),
        assert(controller != null);

  @override
  IntroSliderState createState() => new IntroSliderState();
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  List<Widget> tabs = new List();

  @override
  void initState() {
    super.initState();

    tabController = widget.controller.tabController;

    tabController.addListener(() {
      if (widget.onTabChangeCompleted != null) {
        widget.onTabChangeCompleted(tabController.index);
      }
    });

    // Send reference function goToTab to parent
    if (widget.refFuncGoToTab != null) {
      widget.refFuncGoToTab(widget.controller.goToTab);
    }
  }

  void onSkipPress() {
    if (widget.onSkipPress != null) {
      widget.onSkipPress();
    }

    widget.controller.moveToLast();
  }

  void onDonePress() {
    if (widget.onDonePress != null) {
      widget.onDonePress();
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Full screen view
    if (widget.shouldHideStatusBar == true) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }

    return Scaffold(
      body: DefaultTabController(
        length: widget.slides.length,
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: tabController,
              physics: widget.isScrollable
                  ? ScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              children: widget.slides,
            ),
            Positioned(
              child: Row(
                children: <Widget>[
                  // Skip button
                  Container(
                    alignment: Alignment.center,
                    child: widget.isShowSkipBtn
                        ? buildSkipButton()
                        : (widget.isShowPrevBtn
                            ? buildPrevButton()
                            : Container()),
                    width: widget.isShowSkipBtn
                        ? widget.widthSkipBtn ??
                            MediaQuery.of(context).size.width / 4
                        : (widget.isShowPrevBtn
                            ? widget.widthPrevBtn
                            : MediaQuery.of(context).size.width / 4),
                  ),

                  // Dot indicator
                  Flexible(
                    child: widget.isShowDotIndicator
                        ? _DotList(
                            count: widget.slides.length,
                            activeColor: widget.colorActiveDot,
                            color: widget.colorDot,
                            size: widget.sizeDot,
                            animationType: dotSliderAnimation.DOT_MOVEMENT,
                            tabController: tabController,
                            animation: tabController.animation,
                          )
                        : Container(),
                  ),

                  // Next, Done button
                  Container(
                    alignment: Alignment.center,
                    child: tabController.index + 1 == widget.slides.length
                        ? widget.isShowDoneBtn ? buildDoneButton() : Container()
                        : widget.isShowNextBtn
                            ? buildNextButton()
                            : Container(),
                    width: widget.widthDoneBtn ??
                        MediaQuery.of(context).size.width / 4,
                    height: 50,
                  ),
                ],
              ),
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
            ),
          ],
        ),
      ),
      backgroundColor: widget.backgroundColorAllSlides ?? Colors.transparent,
    );
  }

  Widget buildSkipButton() {
    if (tabController.index + 1 == widget.slides.length) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return widget.skipButton ?? FlatButton(
        onPressed: onSkipPress,
        child: Text(
              widget.nameSkipBtn,
              style: widget.styleNameSkipBtn,
            ),
        color: widget.colorSkipBtn,
        highlightColor: widget.highlightColorSkipBtn,
        shape: new RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.circular(widget.borderRadiusSkipBtn)),
      );
    }
  }

  Widget buildDoneButton() {
    return widget.doneButton ?? FlatButton(
      onPressed: onDonePress,
      child: Text(
            widget.nameDoneBtn,
            style: widget.styleNameDoneBtn,
          ),
      color: widget.colorDoneBtn,
      highlightColor: widget.highlightColorDoneBtn,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(widget.borderRadiusDoneBtn)),
    );
  }

  Widget buildPrevButton() {
    if (tabController.index == 0) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return widget.prevButton ??
            FlatButton(
        onPressed: () {
          widget.controller.moveToPrevious();
        },
        child: Text(
              widget.namePrevBtn,
              style: widget.styleNamePrevBtn,
            ),
        color: widget.colorPrevBtn,
        highlightColor: widget.highlightColorPrevBtn,
        shape: new RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.circular(widget.borderRadiusPrevBtn)),
      );
    }
  }

  Widget buildNextButton() {
    return widget.nextButton ?? FlatButton(
      onPressed: () {
        widget.controller.moveToNext();
      },
      child: Text(
            widget.nameNextBtn,
            style: widget.styleNameDoneBtn,
          ),
      color: widget.colorDoneBtn,
      highlightColor: widget.highlightColorDoneBtn,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(widget.borderRadiusDoneBtn)),
    );
  }
}

class _DotList extends StatefulWidget {
  final int count;

  final Color color;

  final Color activeColor;

  final double size;

  final dotSliderAnimation animationType;

  final Animation<double> animation;

  final TabController tabController;

  const _DotList({
    Key key,
    @required this.tabController,
    this.animation,
    this.count,
    this.color,
    this.activeColor,
    this.size,
    this.animationType = dotSliderAnimation.DOT_MOVEMENT,
  }) : super(key: key);

  @override
  __DotListState createState() => __DotListState();
}

class __DotListState extends State<_DotList> {
  List<Widget> dots = new List();
  List<double> sizeDots = new List();
  List<double> opacityDots = new List();

  // For DOT_MOVEMENT
  double marginLeftDotFocused = 0;
  double marginRightDotFocused = 0;

  // For SIZE_TRANSITION
  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final sizeDot = widget.size;
    double initValueMarginRight = (sizeDot * 2) * (widget.count - 1);

    switch (widget.animationType) {
      case dotSliderAnimation.DOT_MOVEMENT:
        for (int i = 0; i < widget.count; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        marginRightDotFocused = initValueMarginRight;
        break;
      case dotSliderAnimation.SIZE_TRANSITION:
        for (int i = 0; i < widget.count; i++) {
          if (i == 0) {
            sizeDots.add(sizeDot * 1.5);
            opacityDots.add(1.0);
          } else {
            sizeDots.add(sizeDot);
            opacityDots.add(0.5);
          }
        }
    }

    widget.tabController.addListener(() {
      if (widget.tabController.indexIsChanging) {
        currentTabIndex = widget.tabController.previousIndex;
      } else {
        currentTabIndex = widget.tabController.index;
      }
      currentAnimationValue = widget.tabController.animation.value;
    });

    widget.animation.addListener(() {
      setState(() {
        switch (widget.animationType) {
          case dotSliderAnimation.DOT_MOVEMENT:
            
            marginLeftDotFocused = widget.animation.value * sizeDot * 2;
            marginRightDotFocused = initValueMarginRight - widget.animation.value * sizeDot * 2;
            break;
          
          case dotSliderAnimation.SIZE_TRANSITION:
            if (widget.animation.value == currentAnimationValue) {
              break;
            }

            double diffValueAnimation = (widget.animation.value - currentAnimationValue).abs();

            final tabController = widget.tabController;

            int diffValueIndex = (currentTabIndex - tabController.index).abs();

            double dotRadius = sizeDot / 2.0;
            
            int activeIndex = tabController.index;

            // When press skip button
            bool skipButtonPressed = tabController.indexIsChanging && (activeIndex - tabController.previousIndex).abs() > 1;

            final opaque = 1.0;
            final semiopaque = 0.5;

            if(skipButtonPressed) {
              diffValueAnimation = min(diffValueAnimation, 1.0);
            }

            var opacityFactor = skipButtonPressed ? (diffValueAnimation / diffValueIndex) / 2 : diffValueAnimation / 2;
            var sizeFactor = skipButtonPressed ? 1 - (diffValueIndex - diffValueAnimation) : diffValueAnimation;

            final previousTabIndex = skipButtonPressed 
              ? activeIndex
              : widget.animation.value > currentAnimationValue 
                // Swipe left
                ? currentTabIndex + 1 
                // Swipe right
                : currentTabIndex - 1;
          
            sizeDots[currentTabIndex] = dotRadius * (3 - sizeFactor);
            opacityDots[currentTabIndex] = opaque - opacityFactor;
            
            sizeDots[previousTabIndex] = dotRadius * (2 + sizeFactor);
            opacityDots[previousTabIndex] = semiopaque + opacityFactor;
            
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final rtl = isRTLLanguage(Localizations.localeOf(context).languageCode);

    return Container(
      child: Stack(
        children: <Widget>[
          Row(
            children: [
              for (var i = 0; i < widget.count; i++)
                _Dot(
                  opacity: opacityDots[i],
                  color: widget.color,
                  width: sizeDots[i],
                )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          widget.animationType == dotSliderAnimation.DOT_MOVEMENT
              ? Center(
                  child: _Dot(
                  color: widget.activeColor,
                  width: widget.size,
                  margin: rtl
                      ? EdgeInsets.only(
                          left: marginRightDotFocused,
                          right: marginLeftDotFocused,
                        )
                      : EdgeInsets.only(
                          left: marginLeftDotFocused,
                          right: marginRightDotFocused),
                ))
              : Container()
        ],
      ),
    );
  }

  bool isRTLLanguage(language) {
    return rtlLanguages.contains(language);
  }
}

class _Dot extends StatelessWidget {
  final double width;

  final Color color;

  final double opacity;

  final EdgeInsets margin;

  const _Dot(
      {Key key,
      @required this.width,
      @required this.color,
      this.margin,
      this.opacity = 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(width / 2)),
      width: width,
      height: width,
      margin: margin ?? EdgeInsets.only(left: width / 2, right: width / 2),
    );

    return opacity < 1.0
        ? Opacity(
            opacity: opacity,
            child: dot,
          )
        : dot;
  }
}
