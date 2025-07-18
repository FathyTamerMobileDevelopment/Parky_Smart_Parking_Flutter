import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubit/home_cubit.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => CustomMapState();
}

class CustomMapState extends State<CustomMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialLocation;

  @override
  void initState() {
    super.initState();
    // initia cairo location
    initialLocation = const CameraPosition(
      target: LatLng(30.033333, 31.233334),
      zoom: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GoogleMap(
          markers: homeCubit.markers,
          circles: homeCubit.circles,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: initialLocation,
          onMapCreated: (controller) {
            _controller.complete(controller);
            homeCubit.getLocation(controller);
          },
        );
      },
    );
  }
}
