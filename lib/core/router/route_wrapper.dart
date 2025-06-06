import 'package:flutter/material.dart';

class RouteWrapper extends StatefulWidget {
  final Widget child;
  final void Function()? onInit;
  final void Function()? onDispose;
  const RouteWrapper({
    required this.child,
    this.onInit,
    this.onDispose,
    super.key,
  });

  @override
  State<RouteWrapper> createState() => _RouteWrapperState();
}

class _RouteWrapperState extends State<RouteWrapper> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) {
      widget.onInit!();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
