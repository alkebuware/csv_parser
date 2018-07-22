import 'package:csv_parser/csv_parser.dart';

main() {
  String csvContent = ""; // Typically read this from File
  CSVFile file = CSVFile.fromString(csvContent);
  print(file);
}
