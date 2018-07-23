import 'package:csv_parser/src/csv_header.dart';

class CSVRow {
  final List<String> _fields;
  final CSVHeader header;

  CSVRow(this.header, [this._fields]);

  CSVRow.fromString(this.header, String fields)
      : this._fields = fields.split(",");

  dynamic operator [](String fieldName) {
    int i = header.asList().indexOf(fieldName);
    if (i == -1) {
      throw new UnsupportedError("Header field \'${fieldName}\' not found");
    }

    return _fields[i];
  }

  void operator []=(String fieldName, dynamic value) {
    int i = header.asList().indexOf(fieldName);
    if (i == -1) {
      throw new UnsupportedError("Header field \'${fieldName}\' not found");
    }

    _fields[i] = value;
  }

  List<dynamic> asList() => _fields.toList();

  String export([int start = 0, int end]) {
    int _end = end ?? _fields.length;

    RangeError.checkValidRange(start, _end, _fields.length);

    return _fields.skip(start)
        .take(_end - start)
        .reduce((dynamic row, dynamic field) {
      String fieldString = field as String;
      if (fieldString?.contains(',') == true) fieldString = "\"${field}\"";
      if (row == null || row.isEmpty) {
        row = "${fieldString}";
      } else {
        row = "${row},${fieldString}";
      }

      return row;
    });
  }
}
