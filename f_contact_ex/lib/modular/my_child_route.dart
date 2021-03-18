import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyChildRoute<T> extends _ModularRouteImpl<T> {
  MyChildRoute(
    String routerName, {
    List<ModularRoute> children = const [],
    required Widget Function(BuildContext, ModularArguments) child,
    List<RouteGuard>? guards,
    TransitionType transition = TransitionType.defaultTransition,
    CustomTransition? customTransition,
    RouteBuilder<T>? routeGenerator,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(routerName,
            routerOutlet: [],
            duration: duration,
            child: child,
            routeGenerator: routeGenerator,
            customTransition: customTransition,
            children: children,
            guards: guards,
            transition: transition);
}

class _ModularRouteImpl<T> extends ModularRoute<T> {
  @override
  final Module? currentModule;
  @override
  final ModularArguments args;
  @override
  final List<ModularRoute> children;
  @override
  final List<ModularRoute> routerOutlet;

  @override
  final Uri? uri;

  @override
  final String? modulePath;

  @override
  final String routerName;

  @override
  final ModularChild? child;

  @override
  final Module? module;

  @override
  final Map<String, String>? params;

  @override
  final List<RouteGuard>? guards;
  @override
  final TransitionType transition;

  @override
  final CustomTransition? customTransition;

  @override
  final Duration duration;

  @override
  final RouteBuilder<T>? routeGenerator;

  @override
  final Map<
      TransitionType,
      PageRouteBuilder<T> Function(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings,
  )> transitions = {
    TransitionType.fadeIn: fadeInTransition,
    TransitionType.noTransition: noTransition,
    TransitionType.rightToLeft: rightToLeft,
    TransitionType.leftToRight: leftToRight,
    TransitionType.upToDown: upToDown,
    TransitionType.downToUp: downToUp,
    TransitionType.scale: scale,
    TransitionType.rotate: rotate,
    TransitionType.size: size,
    TransitionType.rightToLeftWithFade: rightToLeftWithFade,
    TransitionType.leftToRightWithFade: leftToRightWithFade,
  };

  _ModularRouteImpl(
    this.routerName, {
    this.children = const [],
    this.args = const ModularArguments(),
    this.module,
    this.child,
    this.uri,
    this.guards,
    this.routerOutlet = const [],
    this.params,
    this.currentModule,
    this.transition = TransitionType.defaultTransition,
    this.routeGenerator,
    this.customTransition,
    this.duration = const Duration(milliseconds: 300),
    this.modulePath = '/',
  })  : assert(module == null ? true : children.isEmpty,
            'Módulo não pode conter rotas aninhadas (children)'),
        assert((transition == TransitionType.custom &&
                customTransition != null) ||
            transition != TransitionType.custom && customTransition == null),
        assert((module == null && child != null) ||
            (module != null && child == null)),
        assert(routerName == '**' ? child != null : true);

  @override
  ModularRoute<T> copyWith(
      {ModularChild? child,
      String? routerName,
      Module? module,
      List<ModularRoute>? children,
      List<ModularRoute>? routerOutlet,
      Module? currentModule,
      Map<String, String>? params,
      Uri? uri,
      List<RouteGuard>? guards,
      TransitionType? transition,
      RouteBuilder<T>? routeGenerator,
      String? modulePath,
      Duration? duration,
      Completer<T>? popRoute,
      ModularArguments? args,
      CustomTransition? customTransition}) {
    return _ModularRouteImpl<T>(
      routerName ?? this.routerName,
      child: child ?? this.child,
      args: args ?? this.args,
      children: children ?? this.children,
      module: module ?? this.module,
      routerOutlet: routerOutlet ?? this.routerOutlet,
      currentModule: currentModule ?? this.currentModule,
      params: params ?? this.params,
      uri: uri ?? this.uri,
      modulePath: modulePath ?? this.modulePath,
      guards: guards ?? this.guards,
      duration: duration ?? this.duration,
      routeGenerator: routeGenerator ?? this.routeGenerator,
      transition: transition ?? this.transition,
      customTransition: customTransition ?? this.customTransition,
    );
  }

  @override
  String? get path => uri?.path ?? '/';

  @override
  Map<String, List<String>> get queryParamsAll => uri?.queryParametersAll ?? {};

  @override
  Map<String, String> get queryParams => uri?.queryParameters ?? {};

  @override
  String get fragment => uri?.fragment ?? '';
}

PageRouteBuilder<T> fadeInTransition<T>(
    Widget Function(
  BuildContext,
  ModularArguments,
)
        builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: transitionDuration,
      pageBuilder: (context, __, ___) {
        return builder(context, Modular.args!);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      });
}

PageRouteBuilder<T> noTransition<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageRouteBuilder(
      settings: settings,
      transitionDuration: transitionDuration,
      pageBuilder: (context, __, ___) {
        return builder(context, Modular.args!);
      });
}

PageRouteBuilder<T> rightToLeft<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.rightToLeft,
  );
}

PageRouteBuilder<T> leftToRight<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.leftToRight,
  );
}

PageRouteBuilder<T> upToDown<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.upToDown,
  );
}

PageRouteBuilder<T> downToUp<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.downToUp,
  );
}

PageRouteBuilder<T> scale<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.scale,
  );
}

PageRouteBuilder<T> rotate<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.rotate,
  );
}

PageRouteBuilder<T> size<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.size,
  );
}

PageRouteBuilder<T> rightToLeftWithFade<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.rightToLeftWithFade,
  );
}

PageRouteBuilder<T> leftToRightWithFade<T>(
    Widget Function(BuildContext, ModularArguments) builder,
    Duration transitionDuration,
    RouteSettings settings) {
  return PageTransition<T>(
    settings: settings,
    duration: transitionDuration,
    builder: (context) {
      return builder(context, Modular.args!);
    },
    type: PageTransitionType.leftToRightWithFade,
  );
}

enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}

class PageTransition<T> extends PageRouteBuilder<T> {
  final Widget Function(BuildContext context) builder;
  final PageTransitionType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    Key? key,
    required this.builder,
    required this.type,
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context);
          },
          transitionDuration: duration,
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (type) {
              case PageTransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case PageTransitionType.rightToLeft:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(-1.0, 0.0),
                    ).animate(CurvedAnimation(
                        parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );

              case PageTransitionType.leftToRight:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(1.0, 0.0),
                    ).animate(CurvedAnimation(
                        parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );
              case PageTransitionType.upToDown:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: Offset(0.0, -1.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(0.0, 1.0),
                    ).animate(CurvedAnimation(
                        parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );
              case PageTransitionType.downToUp:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(0.0, -1.0),
                    ).animate(CurvedAnimation(
                        parent: secondaryAnimation, curve: curve)),
                    child: child,
                  ),
                );
              case PageTransitionType.scale:
                return ScaleTransition(
                  alignment: alignment,
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.00,
                      0.50,
                      curve: curve,
                    ),
                  ),
                  child: child,
                );
              case PageTransitionType.rotate:
                return RotationTransition(
                  alignment: alignment,
                  turns: CurvedAnimation(parent: animation, curve: curve),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: CurvedAnimation(parent: animation, curve: curve),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              case PageTransitionType.size:
                return Align(
                  alignment: Alignment.center,
                  child: SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                    child: child,
                  ),
                );
              case PageTransitionType.rightToLeftWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: FadeTransition(
                    opacity: CurvedAnimation(parent: animation, curve: curve),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(-1.0, 0.0),
                      ).animate(CurvedAnimation(
                          parent: secondaryAnimation, curve: curve)),
                      child: child,
                    ),
                  ),
                );
              case PageTransitionType.leftToRightWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: FadeTransition(
                    opacity: CurvedAnimation(parent: animation, curve: curve),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(1.0, 0.0),
                      ).animate(CurvedAnimation(
                          parent: secondaryAnimation, curve: curve)),
                      child: child,
                    ),
                  ),
                );
              default:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
        );
}
