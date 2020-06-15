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

class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide> slides;

  /// Background color for all slides
  final Color backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  final Widget renderSkipBtn;

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
  final Widget renderPrevBtn;

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
  final Widget renderNextBtn;

  /// Change NEXT to any text you want
  final String nameNextBtn;

  /// Show or hide NEXT button
  final bool isShowNextBtn;

  // ---------- DONE button ----------
  /// Change DONE to any text you want
  final String nameDoneBtn;

  /// Render your own DONE button
  final Widget renderDoneBtn;

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

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget> listCustomTabs;

  /// Notify when tab change completed
  final Function onTabChangeCompleted;

  /// Ref function go to specific tab index
  final Function refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool isScrollable;

  /// Show or hide status bar
  final bool shouldHideStatusBar;

  // Constructor
  IntroSlider({
    // Slides
    @required this.slides,
    this.backgroundColorAllSlides,

    // Skip
    this.renderSkipBtn,
    this.widthSkipBtn,
    this.onSkipPress,
    this.nameSkipBtn = "SKIP",
    this.styleNameSkipBtn = defaultBtnNameTextStyle,
    this.colorSkipBtn = defaultBtnColor,
    this.highlightColorSkipBtn = defaultBtnHighlightColor,
    this.isShowSkipBtn = true,
    this.borderRadiusSkipBtn = defaultBtnBorderRadius,

    // Prev
    this.renderPrevBtn,
    this.widthPrevBtn,
    this.namePrevBtn = "PREV",
    this.isShowPrevBtn = true,
    this.styleNamePrevBtn = defaultBtnNameTextStyle,
    this.colorPrevBtn = defaultBtnColor,
    this.highlightColorPrevBtn = defaultBtnHighlightColor,
    this.borderRadiusPrevBtn = defaultBtnBorderRadius,

    // Done
    this.renderDoneBtn,
    this.widthDoneBtn,
    this.onDonePress,
    this.nameDoneBtn = "DONE",
    this.colorDoneBtn = defaultBtnColor,
    this.highlightColorDoneBtn = defaultBtnHighlightColor,
    this.borderRadiusDoneBtn = defaultBtnBorderRadius,
    this.styleNameDoneBtn = defaultBtnNameTextStyle,
    this.isShowDoneBtn = true,

    // Next
    this.renderNextBtn,
    this.nameNextBtn = "NEXT",
    this.isShowNextBtn = true,

    // Dots
    this.isShowDotIndicator = true,
    this.colorDot = const Color(0x80000000),
    this.colorActiveDot = const Color(0x80000000),
    this.sizeDot = 8.0,
    this.typeDotAnimation,

    // Tabs
    this.listCustomTabs,
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
        assert(isScrollable != null);

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

    tabController =
        new TabController(length: widget.slides.length, vsync: this);
    
    tabController.addListener(() {
      if (widget.onTabChangeCompleted != null) {
        widget.onTabChangeCompleted(tabController.index);
      }
    });

    // Send reference function goToTab to parent
    if (widget.refFuncGoToTab != null) {
      widget.refFuncGoToTab(goToTab);
    }
  }

  void onSkipPress() {
    if (widget.onSkipPress != null) {
      widget.onSkipPress();
    } else {
      if (!isAnimating(tabController.animation.value)) {
        tabController.animateTo(widget.slides.length - 1);
      }
    }
  }

  void onDonePress() {
    if (widget.onDonePress != null) {
      widget.onDonePress();
    }
  }

  void goToTab(index) {
    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // Checking if tab is animating
  bool isAnimating(value) {
    return tabController.animation.value -
            tabController.animation.value.truncate() !=
        0;
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
              children: widget.listCustomTabs ?? renderListTabs(),
              controller: tabController,
              physics: widget.isScrollable
                  ? ScrollPhysics()
                  : NeverScrollableScrollPhysics(),
            ),
            renderBottom(),
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
      return FlatButton(
        onPressed: onSkipPress,
        child: widget.renderSkipBtn ??
            Text(
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
    return FlatButton(
      onPressed: onDonePress,
      child: widget.renderDoneBtn ??
          Text(
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
      return FlatButton(
        onPressed: () {
          if (!isAnimating(tabController.animation.value)) {
            tabController.animateTo(tabController.index - 1);
          }
        },
        child: widget.renderPrevBtn ??
            Text(
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
    return FlatButton(
      onPressed: () {
        if (!isAnimating(tabController.animation.value)) {
          tabController.animateTo(tabController.index + 1);
        }
      },
      child: widget.renderNextBtn ??
          Text(
            widget.nameNextBtn,
            style: widget.styleNameDoneBtn,
          ),
      color: widget.colorDoneBtn,
      highlightColor: widget.highlightColorDoneBtn,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(widget.borderRadiusDoneBtn)),
    );
  }

  Widget renderBottom() {
    return Positioned(
      child: Row(
        children: <Widget>[
          // Skip button
          Container(
            alignment: Alignment.center,
            child: widget.isShowSkipBtn
                ? buildSkipButton()
                : (widget.isShowPrevBtn ? buildPrevButton() : Container()),
            width: widget.isShowSkipBtn
                ? widget.widthSkipBtn ?? MediaQuery.of(context).size.width / 4
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
                : widget.isShowNextBtn ? buildNextButton() : Container(),
            width: widget.widthDoneBtn ?? MediaQuery.of(context).size.width / 4,
            height: 50,
          ),
        ],
      ),
      bottom: 10.0,
      left: 10.0,
      right: 10.0,
    );
  }

  List<Widget> renderListTabs() {
    final tabs = <Widget>[];
    for (int i = 0; i < widget.slides.length; i++) {
      final slide = widget.slides[i];
      tabs.add(
        renderTab(
          slide.widgetTitle,
          slide.title,
          slide.maxLineTitle,
          slide.styleTitle,
          slide.marginTitle,
          slide.widgetDescription,
          slide.description,
          slide.maxLineTextDescription,
          slide.styleDescription,
          slide.marginDescription,
          slide.pathImage,
          slide.widthImage,
          slide.heightImage,
          slide.foregroundImageFit,
          slide.centerWidget,
          slide.onCenterItemPress,
          slide.backgroundColor,
          slide.colorBegin,
          slide.colorEnd,
          slide.directionColorBegin,
          slide.directionColorEnd,
          slide.backgroundImage,
          slide.backgroundImageFit,
          slide.backgroundOpacity,
          slide.backgroundOpacityColor,
          slide.backgroundBlendMode,
        ),
      );
    }
    return tabs;
  }

  Widget renderTab(
    // Title
    Widget widgetTitle,
    String title,
    int maxLineTitle,
    TextStyle styleTitle,
    EdgeInsets marginTitle,

    // Description
    Widget widgetDescription,
    String description,
    int maxLineTextDescription,
    TextStyle styleDescription,
    EdgeInsets marginDescription,

    // Image
    String pathImage,
    double widthImage,
    double heightImage,
    BoxFit foregroundImageFit,

    // Center Widget
    Widget centerWidget,
    Function onCenterItemPress,

    // Background color
    Color backgroundColor,
    Color colorBegin,
    Color colorEnd,
    AlignmentGeometry directionColorBegin,
    AlignmentGeometry directionColorEnd,

    // Background image
    String backgroundImage,
    BoxFit backgroundImageFit,
    double backgroundOpacity,
    Color backgroundOpacityColor,
    BlendMode backgroundBlendMode,
  ) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage != null
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: backgroundImageFit ?? BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  backgroundOpacityColor != null
                      ? backgroundOpacityColor
                          .withOpacity(backgroundOpacity ?? 0.5)
                      : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
                  backgroundBlendMode ?? BlendMode.darken,
                ),
              ),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor, backgroundColor]
                    : [
                        colorBegin ?? Colors.amberAccent,
                        colorEnd ?? Colors.amberAccent
                      ],
                begin: directionColorBegin ?? Alignment.topLeft,
                end: directionColorEnd ?? Alignment.bottomRight,
              ),
            ),
      child: Container(
        margin: EdgeInsets.only(bottom: 60.0),
        child: ListView(
          children: <Widget>[
            Container(
              // Title
              child: widgetTitle ??
                  Text(
                    title ?? "",
                    style: styleTitle ??
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                    maxLines: maxLineTitle != null ? maxLineTitle : 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
              margin: marginTitle ??
                  EdgeInsets.only(
                      top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
            ),

            // Image or Center widget
            GestureDetector(
              child: pathImage != null
                  ? Image.asset(
                      pathImage,
                      width: widthImage ?? 200.0,
                      height: heightImage ?? 200.0,
                      fit: foregroundImageFit ?? BoxFit.contain,
                    )
                  : Center(child: centerWidget ?? Container()),
              onTap: onCenterItemPress,
            ),

            // Description
            Container(
              child: widgetDescription ??
                  Text(
                    description ?? "",
                    style: styleDescription ??
                        TextStyle(color: Colors.white, fontSize: 18.0),
                    textAlign: TextAlign.center,
                    maxLines: maxLineTextDescription != null
                        ? maxLineTextDescription
                        : 100,
                    overflow: TextOverflow.ellipsis,
                  ),
              margin: marginDescription ??
                  EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
            ),
          ],
        ),
      ),
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

  const _DotList(
      {Key key,
      @required this.tabController,
      this.animation,
      this.count,
      this.color,
      this.activeColor,
      this.size,
      this.animationType = dotSliderAnimation.DOT_MOVEMENT,
  })
      : super(key: key);

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
            marginRightDotFocused = initValueMarginRight -
                widget.animation.value * sizeDot * 2;
            break;
          case dotSliderAnimation.SIZE_TRANSITION:
            if (widget.animation.value == currentAnimationValue) {
              break;
            }

            double diffValueAnimation =
                (widget.animation.value - currentAnimationValue).abs();

            final tabController = widget.tabController;
            
            int diffValueIndex = (currentTabIndex - tabController.index).abs();

            int activeIndex = tabController.index;

            // When press skip button
            if (tabController.indexIsChanging &&
                (activeIndex - tabController.previousIndex).abs() > 1) {
              if (diffValueAnimation < 1.0) {
                diffValueAnimation = 1.0;
              }
              sizeDots[currentTabIndex] = sizeDot * 1.5 -
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeDots[activeIndex] = sizeDot +
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityDots[currentTabIndex] =
                  1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityDots[activeIndex] =
                  0.5 + (diffValueAnimation / diffValueIndex) / 2;

            } else {

              if (widget.animation.value > currentAnimationValue) {
                // Swipe left
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex + 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex - 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
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
                    )
                )
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

  const _Dot({
    Key key, 
    @required this.width, 
    @required this.color,
    this.margin,
    this.opacity = 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final dot = Container(
        decoration: BoxDecoration(
          color: color, 
          borderRadius: BorderRadius.circular(width / 2)
        ),
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