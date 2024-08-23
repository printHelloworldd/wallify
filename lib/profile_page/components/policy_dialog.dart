import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:wallify/theme/theme_provider.dart';

class PolicyDialog extends StatelessWidget {
  final double radius;
  final String mdFileName;

  PolicyDialog({super.key, this.radius = 8, required this.mdFileName})
      : assert(mdFileName.contains(".md"),
            "The file must contain the .md extension");

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context).currentTheme;

    return Dialog(
      backgroundColor: themeData.dialogTheme.backgroundColor,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: Future.delayed(const Duration(milliseconds: 150))
                    .then((value) {
                  return rootBundle.loadString("assets/$mdFileName");
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                      data: snapshot.data.toString(),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
