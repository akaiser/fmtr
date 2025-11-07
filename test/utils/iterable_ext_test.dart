import 'package:fmtr/utils/iterable_ext.dart';
import 'package:test/test.dart';

void main() {
  group('unmodifiable', () {
    test('creates list', () {
      final Iterable<int> iterable = [1, 2, 3];

      final tested = iterable.unmodifiable;

      expect(tested, isA<List<int>>());
    });

    test('equals', () {
      final Iterable<int> iterable = [1, 2, 3];

      final tested = iterable.unmodifiable;

      expect(tested, equals(iterable));
    });

    test('is not same', () {
      final Iterable<int> iterable = [1, 2, 3];

      final tested = iterable.unmodifiable;

      expect(tested, isNot(same(iterable)));
    });

    test('throws on modification', () {
      final tested = [1, 2, 3].unmodifiable;

      expect(() => tested[0] = 42, throwsUnsupportedError);
    });
  });

  group('separate', () {
    test('adds nothing if the list is empty', () {
      expect(const <int>[].separate(1), const <int>[]);
    });

    test('adds nothing if the list has only one element', () {
      expect(const [0].separate(1), const [0]);
    });

    test('adds separator between two items', () {
      expect(const [0, 0].separate(1), const [0, 1, 0]);
    });

    test('adds separator between three items', () {
      expect(const [0, 0, 0].separate(1), const [0, 1, 0, 1, 0]);
    });
  });

  group('append', () {
    test('appends appender to each element', () {
      expect(const [0, 0].append(1), const [0, 1, 0, 1]);
    });

    test('appends appender even to an empty list', () {
      expect(const <int>[].append(1), const [1]);
    });
  });

  group('mapIndexed', () {
    test('properly maps index and element', () {
      expect(Map.fromEntries(const [3, 4, 5].mapIndexed(MapEntry.new)), const {
        0: 3,
        1: 4,
        2: 5,
      });
    });
  });

  group('groupBy', () {
    test('properly groups', () {
      expect(const [0, 1, 2, 3, 4, 5].groupBy((e) => e.isEven), {
        true: const [0, 2, 4],
        false: const [1, 3, 5],
      });
    });
  });

  group('sort', () {
    test('sorts integers', () {
      const tested = {3, 1, 2};

      expect(tested.sort(), const {1, 2, 3});
    });

    test('sorts strings', () {
      const tested = {'banana', 'apple', 'cherry'};

      expect(tested.sort(), const ['apple', 'banana', 'cherry']);
    });

    test('sorts with custom comparator', () {
      const tested = {3, 1, 2};

      expect(tested.sort((a, b) => b.compareTo(a)), const [3, 2, 1]);
    });

    test('returns empty when sorting empty', () {
      const list = <String>{};

      expect(list.sort(), const <String>{});
    });
  });
}
