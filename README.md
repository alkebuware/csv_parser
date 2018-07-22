# csv_parser

A CSV parser library that can easily import and export CSVs.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

    import 'package:csv_parser/csv_parser.dart';

    main() {
        String csvContent = ""; // Typically read this from File
        CSVFile file = CSVFile.fromString(csvContent);
        print(file);
    }   


## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/alkebuware/csv_parser/issues

## Limitations

Library is reallly simple right now. Hoping to add more features in the near future

* It can only parse CSV's that are comma delimited.
* There is currently no way to escape comma's that are within fields.
