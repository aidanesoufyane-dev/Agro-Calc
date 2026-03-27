import 'package:flutter/material.dart';

class ChemText extends StatelessWidget {
  final String text;
  final String? subscript;
  final String? superscript;

  const ChemText({
    super.key,
    required this.text,
    this.subscript,
    this.superscript,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.white),
        children: [
          TextSpan(text: text),
          if (subscript != null)
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, 4),
                child: Text(
                  subscript!,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          if (superscript != null)
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, -6),
                child: Text(
                  superscript!,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ResultTable extends StatelessWidget {
  final String title;
  final Gradient gradient;
  final List<String> headers;
  final List<List<Widget>> rows;

  const ResultTable({
    super.key,
    required this.title,
    required this.gradient,
    required this.headers,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            color: Colors.white24,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: headers
                  .map((h) => Expanded(
                        child: Text(
                          h,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList(),
            ),
          ),
          ...rows.asMap().entries.map((entry) {
            int index = entry.key;
            List<Widget> rowCells = entry.value;
            return Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.black12,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: rowCells
                    .map((cell) => Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: cell,
                          ),
                        ))
                    .toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
