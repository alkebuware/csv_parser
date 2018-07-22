import 'package:csv_parser/csv_parser.dart';
import 'package:test/test.dart';

void main() {
  String headerString;
  String headerStringDuplicate;
  List<String> headerList;

  String rowString;
  List<dynamic> rowList;
  CSVHeader header;

  List<CSVRow> rows;
  String rowsString;

  setUp(() {
    headerString = "header1,header2,header3";
    headerStringDuplicate = "header1,header1, header3";
    headerList = headerString.split(",");

    rowString = "field1, 1, 2, field4";
    rowList = rowString.split(",");
    header = new CSVHeader(headerList);

    rows = <CSVRow>[
      new CSVRow(header, rowList),
      new CSVRow(header, ["field2", "", "field3"]),
      new CSVRow(header, ["field2", "fidl42", "tariq"]),
    ];

    rowsString = header.export();
    for (CSVRow row in rows) {
      rowsString = "${rowsString}\n${row.export()}";
    }
  });

  group("CSVHeader", () {
    test("Default constructor", () {
      CSVHeader header = new CSVHeader(headerList);
      expect(header.asList(), equals(headerList));
    });

    test("fromString constructor", () {
      CSVHeader header = new CSVHeader.fromString(headerString);
      expect(header.asList(), equals(headerList));
    });

    test("Duplicate error", () {
      expect(() => new CSVHeader.fromString(headerStringDuplicate),
          throwsUnsupportedError);
    });

    test("export", () {
      CSVHeader header = new CSVHeader(headerList);
      expect(header.export(), equals(headerString));
    });
  });

  group("CSVRow", () {
    test("Default constructor", () {
      CSVRow row = new CSVRow(header, rowList);
      expect(row.asList(), equals(rowList));
    });

    test("fromString constructor", () {
      CSVRow row = new CSVRow.fromString(header, rowString);
      expect(row.asList(), equals(rowList));
    });

    test("[] operator", () {
      CSVRow row = new CSVRow(header, rowList);
      expect(row["header1"], equals("field1"));
    });

    test("[]= operator", () {
      CSVRow row = new CSVRow(header, rowList);
      row["header1"] = "csvTest";
      expect(row["header1"], equals("csvTest"));
    });

    test("export", () {
      CSVRow row = new CSVRow(header, rowList);
      expect(row.export(), equals(rowString));
    });
  });

  group("CSVFile", () {
    test("Default constructor", () {
      CSVFile file = new CSVFile(header, rows);
      expect(file[0], equals(rows[0]));
      expect(header.asList()[0], equals("header1"));
    });

    test("fromString constructor", () {
      CSVFile file = new CSVFile.fromString(rowsString);
      expect(file[1].asList(), equals(rows[1].asList()));
      expect(header.asList()[1], equals("header2"));
    });

    test("[] operator", () {
      CSVFile file = new CSVFile(header, rows);
      expect(file[2].asList(), equals(rows[2].asList()));
    });

    test("[]= operator", () {
      CSVFile file = new CSVFile(header, rows);
      CSVRow newRow = new CSVRow.fromString(header, "field,field5,field6");
      file[2] = newRow;
      expect(file[2].asList(), newRow.asList());
    });

    test("RangeError", () {
      CSVFile file = new CSVFile(header, rows);
      expect(() => file[5], throwsRangeError);
    });

    test("export", () {
      CSVFile file = new CSVFile(header, rows);
      String csvFileString = file.export();
      expect(csvFileString, equals(rowsString));
    });
  });
}
