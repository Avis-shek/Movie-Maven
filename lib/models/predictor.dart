// // ignore_for_file: unused_local_variable, depend_on_referenced_packages, implementation_imports, unused_import

// import 'dart:io';
// import 'dart:isolate';
// import 'package:flutter/services.dart';
// import 'package:ml_algo/ml_algo.dart';
// import 'package:ml_dataframe/ml_dataframe.dart';
// import 'package:ml_dataframe/src/data_frame/data_frame.dart';
// import 'package:ml_preprocessing/ml_preprocessing.dart';

// void predictormain() async {
//   // Load the data from a CSV file
//   // final file = File('your_file.csv');
//   // final dataFrame = await fromCs(file.readAsStringSync());

//      String csvData = await rootBundle.loadString('assets/images/updated_getfit_dataset.csv');
//       final dataFrame = DataFrame.fromRawCsv(csvData);
// final splitIndex = (dataFrame.rows.length * 0.8).round();
// final trainingData = DataFrame(dataFrame.rows.take(splitIndex).toList(), headerExists: false);
// final testingData = DataFrame(dataFrame.rows.skip(splitIndex).toList(), headerExists: false);


//   // Train the decision tree classifier
//   final classifier = DecisionTreeClassifier(
//     trainingData,
//     'col_6',
//     minError: 0.2,
//     maxDepth: 5,
//   );

//   // Evaluate the classifier on the testing data
//   final predictedLabels = classifier.predict(testingData);
//   final actualLabels = testingData['col_6'];
 
//   // Calculate accuracy
// double calculateAccuracy(List<dynamic> predictedLabels, List<dynamic> actualLabels) {
//   int correctCount = 0;
//   for (int i = 0; i < predictedLabels.length; i++) {
//     if (predictedLabels[i] == actualLabels[i]) {
//       correctCount++;
//     }
//   }
//   return correctCount / predictedLabels.length;
// }
//   final accuracy = calculateAccuracy(predictedLabels as List, actualLabels as List);
//   print('Accuracy: $accuracy');
// }