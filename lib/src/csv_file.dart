import 'dart:convert';

import 'package:csv_parser/csv_parser.dart';

class CSVFile {
  final CSVHeader header;
  final List<CSVRow> rows;

  CSVFile(this.header, this.rows);

  factory CSVFile.fromString(String stringCSVFile) {
    LineSplitter splitter = const LineSplitter();
    List<String> lines = splitter.convert(stringCSVFile);

    CSVHeader header = new CSVHeader.fromString(lines[0]);

    List<CSVRow> rows = lines
        .skip(1)
        .map((String row) => new CSVRow.fromString(header, row))
        .toList();

    return new CSVFile(header, rows);
  }

  CSVRow operator [](int row) {
    RangeError.checkValidIndex(row, rows);
    return rows[row];
  }

  void operator []=(int row, CSVRow csvRow) {
    RangeError.checkValidIndex(row, rows);
    rows[row] = csvRow;
  }

  String export() {
    String csvString = header.export();

    for (CSVRow row in rows) {
      csvString += "\n${row.export()}";
    }

    return csvString;
  }
}
