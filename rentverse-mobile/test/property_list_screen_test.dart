import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:rentverse_mobile/shared/widgets/property_card.dart';
import 'package:rentverse_mobile/features/properties/logic/property_provider.dart';
import 'package:rentverse_mobile/features/properties/ui/property_list_screen.dart';
import 'package:rentverse_mobile/features/properties/data/property_repository.dart';

void main() {
  testWidgets('PropertyListScreen renders properties', (WidgetTester tester) async {
    // Provide a fake PropertyProvider
    final fakeProvider = PropertyProvider(
      PropertyRepository(baseUrl: 'http://localhost:3000/api'),
    );

    // Inject provider into the widget tree
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<PropertyProvider>.value(value: fakeProvider),
        ],
        child: const MaterialApp(
          home: PropertyListScreen(),
        ),
      ),
    );

    // Trigger a frame
    await tester.pump();

    // Check if the "Loading" spinner shows initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate provider has loaded properties (you can mock the data)
    fakeProvider.loadProperties(page: 1);
    await tester.pumpAndSettle();

    // Now you can check for property cards
    expect(find.byType(PropertyCard), findsWidgets);

    // Optional: tap on a property card
    await tester.tap(find.byType(PropertyCard).first);
    await tester.pumpAndSettle();
  });
}