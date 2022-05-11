import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:places/domain/entity/location.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/maps_screen/widget/cached_tile_provider.dart';
import 'package:places/ui/screen/maps_screen/widget/circle_widget.dart';
import 'package:places/ui/screen/maps_screen/widget/map_helpers.dart';
import 'package:places/ui/widget/spacers.dart';

/// Пикер местоположения на карте.
class MapPicker extends StatefulWidget {
  final VoidCallback onCancel;
  final ValueChanged<Location> onDone;

  const MapPicker({
    Key? key,
    required this.onDone,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  LatLng? _position;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(55.5807481, 36.8251304),
              zoom: 8,
              minZoom: 4,
              maxZoom: 18,
              interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
              onTap: (_, pos) {
                setState(() {
                  _position = pos;
                });
              },
            ),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate: theme.colorScheme.isLight
                      ? MapHelpers.lightModeUrl
                      : MapHelpers.darkModeUrl,
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
                    if (_position != null)
                      Marker(
                        width: 24.0,
                        height: 24.0,
                        point: _position!,
                        builder: (ctx) => CircleWidget(
                          size: 24.0,
                          color: theme.colorScheme.green,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onCancel,
                  child: const Text(AppStrings.cancel),
                ),
              ),
              spacerW16,
              Expanded(
                child: ElevatedButton(
                  onPressed: _position != null
                      ? () => widget.onDone(_position!.asLocation)
                      : null,
                  child: const Text(AppStrings.choose),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
