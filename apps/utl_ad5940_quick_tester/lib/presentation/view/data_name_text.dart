import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/buffer_and_download_file.dart';

class _ChangeNotifier extends ChangeNotifier {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class DataNameText extends StatelessWidget {
  const DataNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ChangeNotifier>(
      create: (_) => _ChangeNotifier(),
      builder: (context, _) {
        final app = context.read<BufferAndDownloadFile>();
        final notifier = context.read<_ChangeNotifier>();
        notifier.controller.text = app.dataName;
        return TextField(
          decoration: InputDecoration(hint: Text("Data Name")),
          controller: notifier.controller,
          onChanged: (str) => app.dataName = str,
        );
      },
    );
  }
}
