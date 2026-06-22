import 'package:fmtr/_option.dart';
import 'package:fmtr/handler/list_handler.dart';
import 'package:test/test.dart';

void main() {
  const handler = ListHandler();

  group('line cleanup', () {
    test('trims each line and removes empty lines', () {
      const input = '  alpha  \n\n beta \n   \n\tgamma\t';

      final output = handler.handle(input, const {});

      expect(output, 'alpha\nbeta\ngamma');
    });

    test('standardize spacing collapses repeated whitespace inside a line', () {
      const input = 'alpha   beta\t gamma\n  delta\t\t epsilon  ';

      final output = handler.handle(input, const {
        Option.standardizeSpacing: true,
      });

      expect(output, 'alpha beta gamma\ndelta epsilon');
    });
  });

  group('case handling', () {
    test('lowercase transforms every line to lowercase', () {
      const input = 'AbC\nxYz';

      final output = handler.handle(input, const {
        Option.lowercase: true,
      });

      expect(output, 'abc\nxyz');
    });

    test('uppercase transforms every line to uppercase', () {
      const input = 'AbC\nxYz';

      final output = handler.handle(input, const {
        Option.uppercase: true,
      });

      expect(output, 'ABC\nXYZ');
    });

    test(
      'lowercase takes precedence when lowercase and uppercase are both true',
      () {
        const input = 'AbC';

        final output = handler.handle(input, const {
          Option.lowercase: true,
          Option.uppercase: true,
        });

        expect(output, 'abc');
      },
    );
  });

  group('deduplication', () {
    test(
      'remove duplicates keeps first occurrence with case-sensitive matching',
      () {
        const input = 'A\na\nA\nb\nb';

        final output = handler.handle(input, const {
          Option.removeDuplicates: true,
        });

        expect(output, 'A\na\nb');
      },
    );

    test('ignoreCase deduplicates values regardless of case', () {
      const input = 'A\na\nB\nb\na';

      final output = handler.handle(input, const {
        Option.removeDuplicates: true,
        Option.ignoreCase: true,
      });

      expect(output, 'A\nB');
    });
  });

  group('ordering', () {
    test('sort alphabetically uses case-sensitive order by default', () {
      const input = 'banana\nApple\ncherry';

      final output = handler.handle(input, const {
        Option.sortAlphabetically: true,
      });

      expect(output, 'Apple\nbanana\ncherry');
    });

    test(
      'ignoreCase sorting compares lowercase values '
      'but preserves original case',
      () {
        const input = 'Zoo\napple\nBanana';

        final output = handler.handle(input, const {
          Option.sortAlphabetically: true,
          Option.ignoreCase: true,
        });

        expect(output, 'apple\nBanana\nZoo');
      },
    );

    test('reverse order reverses the final list', () {
      const input = 'first\nsecond\nthird';

      final output = handler.handle(input, const {
        Option.reverseOrder: true,
      });

      expect(output, 'third\nsecond\nfirst');
    });
  });

  test('applies pipeline in expected order for combined options', () {
    const input = '  C item  \n a   item\nB\titem\nb item\nA item  ';

    final output = handler.handle(input, const {
      Option.standardizeSpacing: true,
      Option.lowercase: true,
      Option.removeDuplicates: true,
      Option.sortAlphabetically: true,
      Option.reverseOrder: true,
    });

    expect(output, 'c item\nb item\na item');
  });
}
