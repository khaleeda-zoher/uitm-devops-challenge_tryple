import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentverse_mobile_admin/providers/search_box_provider.dart';

class SearchBoxProperty extends StatelessWidget {
  const SearchBoxProperty({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchBoxProvider>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _WhereSection(state),
          _Divider(),
          _DurationSection(state),
          _Divider(),
          _TypeSection(state),
          _SearchButton(),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: Colors.grey.shade300,
    );
  }
}

class _WhereSection extends StatelessWidget {
  final SearchBoxProvider state;
  const _WhereSection(this.state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Where', style: TextStyle(fontSize: 12)),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search destinations',
              border: InputBorder.none,
            ),
            onChanged: state.setWhere,
          ),
        ],
      ),
    );
  }
}

class _DurationSection extends StatelessWidget {
  final SearchBoxProvider state;
  const _DurationSection(this.state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {}, // open bottom sheet later
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Duration', style: TextStyle(fontSize: 12)),
            Text(state.durationText),
          ],
        ),
      ),
    );
  }
}

class _TypeSection extends StatelessWidget {
  final SearchBoxProvider state;
  const _TypeSection(this.state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {}, // open bottom sheet later
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Type', style: TextStyle(fontSize: 12)),
            Text(state.typeText),
          ],
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 4),
      child: InkWell(
        onTap: () {
          // trigger search + navigation
        },
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Colors.teal,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }
}