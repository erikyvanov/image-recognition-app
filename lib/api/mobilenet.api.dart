import 'dart:convert';
import 'dart:io';

import 'package:get_from_tensorflow_api/models/prediction_result.model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MobilenetApi {
  final String url = 'http://10.0.2.2:5000';

  Future<List<PredictionResult>> getPredictionResults(File image) async {
    final endpoint = Uri.parse('$url/mobilenet/multipart');
    final request = http.MultipartRequest(
      'POST',
      endpoint,
    );

    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: "filename",
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);

    final response = await request.send();
    final jsonString = String.fromCharCodes(await response.stream.toBytes());

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final List<dynamic> predictionResults = jsonMap['prediction_results'];

    return predictionResults
        .map((result) => PredictionResult.fromJSON(result))
        .toList();
  }
}
