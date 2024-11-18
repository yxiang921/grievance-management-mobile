import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grievance_mobile/providers/location_provider.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:latlong2/latlong.dart' as coordinates;
import 'package:provider/provider.dart';

typedef Location = List<double> Function(dynamic data);

class LocationPicker extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;
  final double zoomLevel;
  final bool displayOnly;
  final Color appBarColor;
  final Color markerColor;
  final Color appBarTextColor;
  final String appBarTitle;

  const LocationPicker({
    super.key,
    this.initialLatitude = 1.5336486914588254,
    this.initialLongitude = 103.68175560084585,
    this.zoomLevel = 17.65,
    this.displayOnly = false,
    this.appBarColor = Colors.blueAccent,
    this.appBarTextColor = Colors.white,
    this.appBarTitle = "Select Location",
    this.markerColor = Colors.blueAccent,
  });

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late SimpleLocationResult _selectedLocation;

  @override
  void initState() {
    super.initState();
    _selectedLocation =
        SimpleLocationResult(widget.initialLatitude, widget.initialLongitude);
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    void setLocation() {
      double latitude = _selectedLocation.latitude;
      double longitude = _selectedLocation.longitude;
      locationProvider.setLocation(latitude, longitude);
      print("Set location called");
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 500,
          width: double.infinity,
          child: _osmWidget(setLocation),
        ),
      ],
    );
  }

  Widget _osmWidget(setLocation) {
    return FlutterMap(
      options: MapOptions(
          initialCenter: _selectedLocation.getLatLng(),
          initialZoom: widget.zoomLevel,
          onTap: (tapLoc, position) {
            if (!widget.displayOnly) {
              setState(() {
                _selectedLocation =
                    SimpleLocationResult(position.latitude, position.longitude);
              });
              setLocation();
            }
          },
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
          )),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        MarkerLayer(markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: _selectedLocation.getLatLng(),
            child: const Icon(
              Icons.location_on_sharp,
              color: AppColors.primaryColor,
            ),
          ),
        ])
      ],
    );
  }
}

class SimpleLocationResult {
  final double latitude;

  final double longitude;

  SimpleLocationResult(this.latitude, this.longitude);

  getLatLng() => coordinates.LatLng(latitude, longitude);
}
