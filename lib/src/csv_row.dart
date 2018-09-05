import 'package:csv_parser/src/csv_header.dart';

class CSVRow {
  final List<String> _fields;
  final CSVHeader header;

  CSVRow(this.header, [this._fields]);

  CSVRow.fromString(this.header, String fields)
      : this._fields = splitRow(fields);

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

  String export() {
    return _fields.reduce((dynamic row, dynamic field) {
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

  static List<String> splitRow(String row) {
    List<String> fields = new List<String>();

    int index = 0;
    while (index < row?.length) {
      String character = row[index];
      String field = "";
      bool inQuote = false;

      if (character == "\"") {
        inQuote = true;
        character = row[++index];
      }

      while ((index < row.length) && (character != "," || inQuote == true)) {
        character = row[index++];
        if (character == "\"" && inQuote == false) {
          throw new FormatException("Field contains unclosed quote.");
        } else if (character == "\"" && inQuote == true) {
          inQuote = false;
        } else if (character == "," && inQuote == false) {
          break;
        } else {
          field += character;
        }
      }

      fields.add(field);
    }

    return fields;
  }
}
