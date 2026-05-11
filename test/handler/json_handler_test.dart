import 'package:fmtr/_option.dart';
import 'package:fmtr/handler/json_handler.dart';
import 'package:test/test.dart';

void main() {
  const handler = JsonHandler();

  test('prettify formats JSON with indentation', () {
    const input = '{"a":1,"b":"a b"}';

    final output = handler.handle(input, const {
      Option.prettify: true,
      Option.minify: false,
    });

    expect(output, '{\n  "a": 1,\n  "b": "a b"\n}');
  });

  test('minify preserves spaces inside string values', () {
    const input = '{"a": 1, "b": "a b", "c": ["x y"]}';

    final output = handler.handle(input, const {
      Option.prettify: false,
      Option.minify: true,
    });

    expect(output, '{"a":1,"b":"a b","c":["x y"]}');
  });

  test('defaults to prettify when minify is not enabled', () {
    const input = '{"b":2,"a":1}';

    final output = handler.handle(input, const {Option.prettify: true});

    expect(output, '{\n  "b": 2,\n  "a": 1\n}');
  });

  test('minify wins when both prettify and minify are enabled', () {
    const input = '{"a": 1, "b": 2}';

    final output = handler.handle(input, const {
      Option.prettify: true,
      Option.minify: true,
    });

    expect(output, '{"a":1,"b":2}');
  });

  test('supports primitive JSON values', () {
    const input = '"a b"';

    final output = handler.handle(input, const {
      Option.prettify: true,
      Option.minify: false,
    });

    expect(output, '"a b"');
  });

  test('throws on invalid JSON', () {
    const input = '{"a": 1';

    expect(
      () => handler.handle(input, const {Option.prettify: true}),
      throwsFormatException,
    );
  });
}
