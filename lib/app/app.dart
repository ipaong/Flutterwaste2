import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/waste_entry/presentation/pages/waste_entry_page.dart';
import 'mobile_layout_wrapper.dart';

class LabFlowApp extends StatelessWidget {
  const LabFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LabFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      builder: (context, child) {
        return MobileLayoutWrapper(child: child ?? const SizedBox.shrink());
      },
      home: const WasteEntryPage(),
    );
  }
}
