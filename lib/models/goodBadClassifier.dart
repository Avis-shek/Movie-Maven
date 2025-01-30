import 'dart:convert';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';

Future<String> predictedGoodBadAsync(String inputValues) async {
  return await predictGoodBad(inputValues);
}

Future<String> predictGoodBad(String inputValues) async {
  // Load the model
  Interpreter interpreter =
      await Interpreter.fromAsset('assets/images/sentimental_predictor.tflite');
      // Preprocess the review
   final tokens = inputValues.split(' ');
    final normalizedTokens = tokens.map((token) => token.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '')).toList();

      // Run the model
  final output = List.filled(1, List.filled(1, 0.0));
  interpreter.run(inputValues, output);

  // Interpret the output
  final prediction = output[0][0];
  if (prediction > 0.5) {
    return 'Good';
  } else {
    return 'Bad';
  }

  // var bytes =utf8.encode(inputValues);

  // //Conversion
  // Float32List inputBytes = Float32List.fromList(bytes.map((i) => i.toDouble()).toList());

  // // Create a buffer for the output values
  // var outputBuffer = List.generate(1, (i) => List<double>.filled(2, 0));

  // // Run inference on the input values
  // interpreter.run(inputBytes.buffer.asFloat32List(), outputBuffer);

  // // rounding up
  // int predictedClass =
  //     outputBuffer[0].indexOf(outputBuffer[0].reduce(math.max));

  // // Map the predicted class to a sentiment
  // List<String> sentiment = ['Bad','Good'];
  // String predictedSentiment = sentiment[predictedClass];

  // // Print the results
  // // print(outputBuffer);
  // print(predictedSentiment);
  // return predictedSentiment;
}