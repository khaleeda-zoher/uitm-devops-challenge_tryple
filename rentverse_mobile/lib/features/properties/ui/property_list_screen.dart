import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentverse_mobile/features/properties/data/map_data.dart' as map_data;

import '../logic/property_provider.dart';
import '../data/property_models.dart';
import '../../../shared/widgets/property_card.dart';
import '../../../shared/widgets/pagination.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({Key? key}) : super(key: key);

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  bool isMapView = false;

  @override
  void initState() {
    super.initState();
    // Load initial properties
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PropertyProvider>(context, listen: false);
      provider.loadProperties(page: 1);
    });
  }

  void toggleView() {
    setState(() {
      isMapView = !isMapView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PropertyProvider>(context);
    final properties = provider.properties;
    final mapData = provider.mapData;

    final mapCenter = LatLng(
      mapData?.latMean ?? 40.7128,
      mapData?.longMean ?? -74.006,
    );
    final mapZoom = mapData?.depth?.toDouble() ?? 12.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('${properties.length} homes within map area'),
        backgroundColor: Colors.teal,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  // Wide screens: side by side
                  return Row(
                    children: [
                      Expanded(child: _buildPropertyList(provider, columns: 2)),
                      Expanded(child: _buildMap(provider, mapCenter, mapZoom)),
                    ],
                  );
                } else {
                  // Mobile/Tablet: toggle view
                  return Stack(
                    children: [
                      Offstage(
                        offstage: isMapView,
                        child: _buildPropertyList(provider, columns: 1),
                      ),
                      Offstage(
                        offstage: !isMapView,
                        child: _buildMap(provider, mapCenter, mapZoom),
                      ),
                    ],
                  );
                }
              },
            ),
      floatingActionButton: MediaQuery.of(context).size.width <= 768
          ? FloatingActionButton(
              onPressed: toggleView,
              child: Icon(isMapView ? Icons.list : Icons.map),
              backgroundColor: Colors.teal,
            )
          : null,
    );
  }

  Widget _buildPropertyList(PropertyProvider provider, {int columns = 1}) {
    final properties = provider.properties;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 2,
              ),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return PropertyCard(property: property);
              },
            ),
          ),
          Pagination(
            currentPage: provider.currentPage,
            totalPages: provider.totalPages,
            onPageChange: (page) {
              provider.loadProperties(page: page);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMap(PropertyProvider provider, LatLng center, double zoom) {
    final properties = provider.properties;

    return FlutterMap(
  options: MapOptions(
    initialCenter: center, // <-- use initialCenter
    initialZoom: zoom,     // <-- use initialZoom
  ),
  children: [
    TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c'],
    ),
    MarkerLayer(
      markers: properties.map((property) {
        final lat = property.latitude ?? center.latitude;
        final lng = property.longitude ?? center.longitude;

        return Marker(
          point: LatLng(lat, lng),
          width: 40,
          height: 40,
          child: const Icon(
            Icons.location_on,
            color: Colors.teal,
            size: 36,
          ), // <-- child instead of builder
        );
      }).toList(),
    ),
  ] 
  );
}
}