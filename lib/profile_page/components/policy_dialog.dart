import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyDialog extends StatelessWidget {
  final double radius;
  final String mdFileName;

  PolicyDialog({super.key, this.radius = 8, required this.mdFileName})
      : assert(mdFileName.contains(".md"),
            "The file must contain the .md extension");

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
