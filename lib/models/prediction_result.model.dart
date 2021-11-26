class PredictionResult {
  final String name;
  final double probability;

  PredictionResult(this.name, this.probability);

  factory PredictionResult.fromJSON(Map<String, dynamic> json) {
    return PredictionResult(json['name'], json['probability']);
  }
}
