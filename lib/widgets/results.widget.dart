import 'package:flutter/material.dart';
import 'package:get_from_tensorflow_api/models/prediction_result.model.dart';

class Results extends StatelessWidget {
  const Results({Key? key, required this.results}) : super(key: key);

  final List<PredictionResult> results;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Resultados',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        const SizedBox(height: 15),
        ...results
            .map((result) =>
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(_capitalize(result.name)),
                  const SizedBox(width: 15),
                  Text(_formatProbability(result.probability) + ' %',
                      style: const TextStyle(fontWeight: FontWeight.bold))
                ]))
            .toList()
      ],
    );
  }

  String _formatProbability(double probability) {
    final double probability100 = probability * 100;
    return probability100.toStringAsFixed(2);
  }

  String _capitalize(String string) {
    return "${string[0].toUpperCase()}${string.substring(1)}";
  }
}
