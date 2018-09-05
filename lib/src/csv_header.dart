import 'package:csv_parser/src/csv_row.dart';

class CSVHeader {
  final Set<String> _headers;

  CSVHeader(List<String> headerFields) : _headers = _fromList(headerFields);

  factory CSVHeader.fromString(String headerFieldsString) {
    return new CSVHeader(CSVRow.splitRow(headerFieldsString));
  }

  static Set<String> _fromList(List<String> headerFields) {
    Set<String> headers = new Set<String>();

    for (String header in headerFields) {
      if (headers.contains(header)) {
        throw new UnsupportedError(
            "Cannot have duplicate fields in header row");
      }

      headers.add(header);
    }

    return headers;
  }

  List<String> asList() => _headers.toList();

  Set<String> asSet() => new Set.from(_headers);

  String export() {
    return _headers.reduce((dynamic row, dynamic field) {
      if (field?.contains(',') == true) field = "\"${field}\"";
      if (row == null || row.isEmpty) {
        row = "${field}";
      } else {
        row = "${row},${field}";
      }

      return row;
    });
  }
}
