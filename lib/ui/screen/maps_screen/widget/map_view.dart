import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/maps_screen/maps_screen_wm.dart';
import 'package:places/ui/screen/maps_screen/widget/cached_tile_provider.dart';
import 'package:places/ui/screen/maps_screen/widget/circle_widget.dart';
import 'package:places/ui/screen/maps_screen/widget/location_marker.dart';

/// Виджет карты.
class MapView extends StatelessWidget {
  final IMapsScreenWidgetModel wm;

  const MapView({Key? key, required this.wm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: wm.mapRebuild,
      builder: (_, __) {
        return FlutterMap(
          mapController: wm.mapController,
          options: MapOptions(
            center: wm.lastLocation?.asLatLng ?? LatLng(55.5807481, 36.8251304),
            zoom: 8,
            minZoom: 4,
            maxZoom: 18,
            interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
            onTap: (_, __) {
              wm.selectSight(null);
            },
          ),
          children: [
            TileLayerWidget(
              options: TileLayerOptions(
                urlTemplate: wm.mapUrl,
                subdomains: ['a', 'b', 'c'],
                tileProvider: const CachedTileProvider(),
                fastReplace: true,
                attributionBuilder: (_) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '© CartoDB, © OpenStreetMap contributors',
                      textAlign: TextAlign.end,
                    ),
                  );
                },
              ),
            ),
            MarkerLayerWidget(
              options: MarkerLayerOptions(
                markers: [
                  ...?wm.sightsState.value?.data?.map(
                    (sight) => Marker(
                      width: 24.0,
                      height: 24.0,
                      point: sight.location.asLatLng,
                      builder: (ctx) => wm.selectedSight.equalsById(sight)
                          ? CircleWidget(
                              size: 24.0,
                              color: wm.theme.colorScheme.green,
                            )
                          : IconButton(
                              onPressed: () => wm.selectSight(sight),
                              icon: CircleWidget(
                                size: 8.0,
                                color: wm.theme.colorScheme.onSurface,
                              ),
                            ),
                    ),
                  ),
                  if (wm.searchLocationState.value?.data != null)
                    Marker(
                      point: wm.searchLocationState.value!.data!.asLatLng,
                      width: 104.0,
                      height: 104.0,
                      builder: (_) => const LocationMarker(),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
