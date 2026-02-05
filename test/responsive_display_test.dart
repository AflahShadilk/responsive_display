import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_display/responsiveDisplay.dart';

void main() {
  group('DeviceType Logic', () {
    testWidgets('Detects xsmall', (tester) async {
       // Mock screen size via MediaQuery
       await tester.pumpWidget(
         MediaQuery(
           data: const MediaQueryData(size: Size(300, 600)),
           child: Builder(
             builder: (context) {
               expect(responsiveDisplay.deviceType(context), DeviceType.xsmall);
               expect(responsiveDisplay.isPhone(context), true);
               return const SizedBox();
             },
           ),
         )
       );
    });

    testWidgets('Detects medium (tablet)', (tester) async {
       await tester.pumpWidget(
         MediaQuery(
           data: const MediaQueryData(size: Size(700, 1000)),
           child: Builder(
             builder: (context) {
               expect(responsiveDisplay.deviceType(context), DeviceType.medium);
               expect(responsiveDisplay.isTablet(context), true);
               return const SizedBox();
             },
           ),
         )
       );
    });
  });

  group('ResponsiveValue', () {
    testWidgets('Resolves exact match', (tester) async {
      await tester.pumpWidget(
         MediaQuery(
           data: const MediaQueryData(size: Size(400, 800)), // Small
           child: Builder(
             builder: (context) {
               final val = ResponsiveValue<String>(
                 context,
                 small: 'small',
                 medium: 'medium',
               ).value;
               expect(val, 'small');
               return const SizedBox();
             },
           ),
         )
       );
    });

    testWidgets('Falls back correctly', (tester) async {
      await tester.pumpWidget(
         MediaQuery(
           data: const MediaQueryData(size: Size(1000, 800)), // Large
           child: Builder(
             builder: (context) {
               // No large provided, should fall back to medium
               final val = ResponsiveValue<String>(
                 context,
                 medium: 'medium',
                 small: 'small',
               ).value;
               expect(val, 'medium');
               return const SizedBox();
             },
           ),
         )
       );
    });
  });

  group('ResponsiveConfig', () {
    testWidgets('Overrides breakpoints', (tester) async {
      await tester.pumpWidget(
         ResponsiveConfig(
           breakpoints: const Breakpoints(xsmall: 200, small: 400),
           child: MediaQuery(
             data: const MediaQueryData(size: Size(300, 600)),
             child: Builder(
               builder: (context) {
                 // 300 is > xsmall(200) but <= small(400), so should be Small
                 // Default xsmall is 359, so normally 300 would be xsmall.
                 expect(responsiveDisplay.deviceType(context), DeviceType.small);
                 return const SizedBox();
               },
             ),
           ),
         )
       );
    });
  });
}
