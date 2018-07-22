import 'dart:convert';

import 'package:csv_parser/csv_parser.dart';

class CSVFile {
  final CSVHeader header;
  List<CSVRow> _rows;

  List<CSVRow> get rows => _rows;

  CSVFile(this.header, [this._rows]);

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

    if (rows != null) {
      for (CSVRow row in rows) {
        csvString += "\n${row.export()}";
      }
    }

    return csvString;
  }

  void add(CSVRow newRow) {
    _initRows();
    rows.add(newRow);
  }

  void _initRows() {
    if (rows == null) {
      _rows = new List<CSVRow>();
    }
  }
}
