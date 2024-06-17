import 'dart:ui';

import 'package:ems_app/utils/toast/src/widget/built_in/built_in.dart';
import 'package:ems_app/utils/toast/src/widget/built_in/flat/flat_style.dart';
import 'package:flutter/material.dart';
import 'package:ems_app/utils/toast/src/widget/built_in/widget/close_button.dart';

class FlatToastWidget extends StatelessWidget {
  const FlatToastWidget({
    super.key,
    required this.type,
    this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.boxShadow,
    this.direction,
    this.onCloseTap,
    this.showCloseButton,
    this.showProgressBar = false,
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
    this.applyBlurEffect = false,
  });

  final ToastificationType type;

  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final VoidCallback? onCloseTap;

  final bool? showCloseButton;

  final bool applyBlurEffect;

  final bool showProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  final ProgressIndicatorThemeData? progressIndicatorTheme;

  FlatStyle get defaultStyle => FlatStyle(type);

  @override
  Widget build(BuildContext context) {
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);

    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    final borderSide = defaultStyle.borderSide(context);

    final direction = this.direction ?? Directionality.of(context);

    return Directionality(
      textDirection: direction,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme.copyWith(color: iconColor),
        child: buildBody(
          context: context,
          background: background,
          borderRadius: borderRadius,
          borderSide: borderSide,
          iconColor: iconColor,
          showCloseButton: showCloseButton,
          applyBlurEffect: applyBlurEffect,
        ),
      ),
    );
  }

  Widget buildBody({
    required Color background,
    required BorderRadiusGeometry borderRadius,
    required BorderSide borderSide,
    required BuildContext context,
    required Color iconColor,
    required bool showCloseButton,
    required bool applyBlurEffect,
  }) {
    Widget body = Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        borderRadius: borderRadius,
        border: Border.fromBorderSide(borderSide),
        boxShadow: boxShadow ?? defaultStyle.boxShadow(context),
      ),
      padding: padding ?? defaultStyle.padding(context),
      child: Row(
        children: [
          icon ??
              Icon(
                defaultStyle.icon(context),
                size: 24,
                color: iconColor,
              ),
          const SizedBox(width: 12),
          Expanded(
            child: BuiltInContent(
              style: defaultStyle,
              title: title,
              description: description,
              primaryColor: primaryColor,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              showProgressBar: showProgressBar,
              progressBarValue: progressBarValue,
              progressBarWidget: progressBarWidget,
              progressIndicatorTheme: progressIndicatorTheme,
            ),
          ),
          const SizedBox(width: 8),
          ToastCloseButton(
            showCloseButton: showCloseButton,
            onCloseTap: onCloseTap,
            icon: defaultStyle.closeIcon(context),
            iconColor: foregroundColor?.withOpacity(.3) ??
                defaultStyle.closeIconColor(context),
          ),
        ],
      ),
    );

    if (applyBlurEffect) {
      body = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
