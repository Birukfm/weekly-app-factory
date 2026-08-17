import 'package:flutter/material.dart';

import '../data/scan_repository.dart';

class ScanScope extends InheritedNotifier<ScanRepository> {
  const ScanScope({
    super.key,
    required ScanRepository repository,
    required super.child,
  }) : super(notifier: repository);

  static ScanRepository of(BuildContext context) {
    final ScanScope? scope = context.dependOnInheritedWidgetOfExactType<ScanScope>();
    assert(scope != null, 'ScanScope is missing from the tree.');
    return scope!.notifier!;
  }
}
