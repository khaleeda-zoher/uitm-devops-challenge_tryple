import 'package:flutter/material.dart';
import 'search_box_property.dart';

class TrustedSection extends StatelessWidget {
  const TrustedSection({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Trusted by Thousands of Tenants and Property Owners',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3,
            children: const [
              TrustedItem(icon: Icons.home, value: '10,000+', label: 'Listed properties'),
              TrustedItem(icon: Icons.location_on, value: '200+', label: 'Locations'),
              TrustedItem(icon: Icons.star, value: '98%', label: 'Satisfaction'),
              TrustedItem(icon: Icons.verified, value: '5,000+', label: 'Verified users'),
            ],
          ),
        ],
      ),
    );
  }
}

class TrustedItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const TrustedItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.grey.shade800),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}