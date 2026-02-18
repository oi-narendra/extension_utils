import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/bool_utils.dart';

void main() {
  group('BoolUtils', () {
    group('toggled', () {
      test('true.toggled is false', () => expect(true.toggled, isFalse));
      test('false.toggled is true', () => expect(false.toggled, isTrue));
    });

    group('toYesNo', () {
      test('true → Yes', () => expect(true.toYesNo(), 'Yes'));
      test('false → No', () => expect(false.toYesNo(), 'No'));
    });

    group('toOnOff', () {
      test('true → On', () => expect(true.toOnOff(), 'On'));
      test('false → Off', () => expect(false.toOnOff(), 'Off'));
    });

    group('toEnabledDisabled', () {
      test('true → Enabled', () => expect(true.toEnabledDisabled(), 'Enabled'));
      test('false → Disabled',
          () => expect(false.toEnabledDisabled(), 'Disabled'));
    });

    group('ifTrue', () {
      test('returns value when true',
          () => expect(true.ifTrue('admin'), 'admin'));
      test('returns null when false',
          () => expect(false.ifTrue('admin'), isNull));
    });

    group('ifFalse', () {
      test('returns value when false',
          () => expect(false.ifFalse('guest'), 'guest'));
      test('returns null when true',
          () => expect(true.ifFalse('guest'), isNull));
    });

    group('when', () {
      test('calls onTrue when true', () {
        final result = true.when(onTrue: () => 'yes', onFalse: () => 'no');
        expect(result, 'yes');
      });
      test('calls onFalse when false', () {
        final result = false.when(onTrue: () => 'yes', onFalse: () => 'no');
        expect(result, 'no');
      });
    });
  });
}
