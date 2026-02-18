import 'package:flutter_test/flutter_test.dart';
import 'package:extension_utils/enum_utils.dart';

enum Status { active, inactive, pending, activeUser }

void main() {
  group('EnumUtils', () {
    group('when', () {
      test('calls correct branch', () {
        const status = Status.active;
        final result = status.when({
          Status.active: () => 'Active',
          Status.inactive: () => 'Inactive',
          Status.pending: () => 'Pending',
          Status.activeUser: () => 'Active User',
        });
        expect(result, 'Active');
      });

      test('throws when no case found', () {
        const status = Status.pending;
        expect(
          () => status.when({
            Status.active: () => 'Active',
          }),
          throwsArgumentError,
        );
      });
    });

    group('whenOrElse', () {
      test('calls matching branch', () {
        const status = Status.inactive;
        final result = status.whenOrElse(
          {Status.inactive: () => 'Inactive'},
          orElse: () => 'Unknown',
        );
        expect(result, 'Inactive');
      });

      test('calls orElse when no match', () {
        const status = Status.pending;
        final result = status.whenOrElse(
          {Status.active: () => 'Active'},
          orElse: () => 'Unknown',
        );
        expect(result, 'Unknown');
      });
    });

    group('label', () {
      test('simple name', () => expect(Status.active.label, 'Active'));
      test('camelCase split',
          () => expect(Status.activeUser.label, 'Active User'));
      test('inactive', () => expect(Status.inactive.label, 'Inactive'));
    });
  });
}
