import 'package:flutter/material.dart';

Future<void> showUnderDevelopmentDialog(BuildContext context, String actionName) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('กำลังพัฒนา'),
        content: Text('ฟังก์ชัน "$actionName" จะเปิดใช้งานในเวอร์ชันถัดไป'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ตกลง'),
          ),
        ],
      );
    },
  );
}
