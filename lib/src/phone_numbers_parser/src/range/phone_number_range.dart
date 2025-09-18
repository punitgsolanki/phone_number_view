import '../phone_number.dart';

/// Describes a contiguous range of phone numbers
class PhoneNumberRange {
  final PhoneNumber start;
  final PhoneNumber end;
  final String countryCode;

  PhoneNumberRange(
    this.start,
    this.end,
  )   : assert(start.isoCode == end.isoCode,
            'Cannot range with different iso codes'),
        countryCode = start.countryCode;

  @override
  String toString() => '${start.international} - ${end.international}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumberRange &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  /// Calculates the number of [PhoneNumber]s in the range (inclusive of start and end)
  /// where 'this' is the start of the range and [endOfRange] is the end of the range.
  int get count {
    final first = BigInt.parse(start.international);
    final last = BigInt.parse(end.international);

    final bigInterval = last - first;

    final interval = bigInterval.abs().toInt() + 1;

    return interval;
  }

  /// Returns a list of [PhoneNumber]s in the range
  /// [this] to [endOfRange] inclusive.
  List<PhoneNumber> expandRange() {
    final first = BigInt.parse(start.international);
    final last = BigInt.parse(end.international);

    final range = <PhoneNumber>[];
    for (var current = first; current <= last; current = current + BigInt.one) {
      final next = PhoneNumber(
        isoCode: start.isoCode,
        nsn: current.toString().substring(countryCode.length),
      );
      range.add(next);
    }

    return range;
  }
}
