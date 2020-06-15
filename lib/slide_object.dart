import 'package:flutter/material.dart';

class Slide extends StatelessWidget {
  // Title widget
  /// If non-null, used instead of [title] and its relevant properties
  final Widget widgetTitle;

  // Title
  /// Change text title at top
  final String title;

  /// Change max number of lines title at top
  final int maxLineTitle;

  /// Style for text title
  final TextStyle styleTitle;

  /// Margin for text title
  final EdgeInsets marginTitle;

  // Image
  /// Path to your local image
  final String pathImage;

  /// Width of image
  final double widthImage;

  /// Height of image
  final double heightImage;

  /// Scale of image
  final BoxFit foregroundImageFit;

  /// Fire when press image or center widget
  final Function onCenterItemPress;

  // Custom your center widget instead of image (if this widget exist, center image will hide)
  final Widget centerWidget;

  //endregion

  // Description widget
  /// If non-null, used instead of [description] and its relevant properties
  final Widget widgetDescription;

  // Description
  /// Change text description at bottom
  final String description;

  /// Maximum line of text description
  final int maxLineTextDescription;

  /// Style for text description
  final TextStyle styleDescription;

  /// Margin for text description
  final EdgeInsets marginDescription;

  // Background color
  /// Background tab color
  final Color backgroundColor;

  /// Gradient tab color begin
  final Color colorBegin;

  /// Gradient tab color end
  final Color colorEnd;

  /// Direction color begin
  final AlignmentGeometry directionColorBegin;

  /// Direction color end
  final AlignmentGeometry directionColorEnd;

  // Background image
  final String backgroundImage;
  final BoxFit backgroundImageFit;
  final double backgroundOpacity;
  final Color backgroundOpacityColor;
  final BlendMode backgroundBlendMode;

  Slide({
    // Title
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
    this.styleTitle,
    this.marginTitle,

    // Image (if specified centerWidget is not displayed)
    this.pathImage,
    this.widthImage,
    this.heightImage,
    this.foregroundImageFit,

    // Center widget
    this.centerWidget,
    this.onCenterItemPress,

    // Description
    this.widgetDescription,
    this.description,
    this.maxLineTextDescription,
    this.styleDescription,
    this.marginDescription,

    // Background color
    this.backgroundColor,
    this.colorBegin,
    this.colorEnd,
    this.directionColorBegin,
    this.directionColorEnd,

    // Background image
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundOpacity,
    this.backgroundOpacityColor,
    this.backgroundBlendMode,
  });

  @override
  Widget build(BuildContext context) {
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
