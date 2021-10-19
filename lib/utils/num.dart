import 'package:intl/intl.dart';

extension NumWithThousandSeparators on num {
  String toStringWithThousandSeparators() {
    var formatter = NumberFormat('#,##0.00', 'uk');
    return formatter.format(this);
  }

  String toStringFixedWithThousandSeparators() {
    var formatter = NumberFormat('#,##0', 'uk');
    return formatter.format(this);
  }
}
