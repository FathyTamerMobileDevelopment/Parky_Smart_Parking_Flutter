import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:parky/config/routes/route_manager.dart';
import 'package:parky/core/utils/services/location_service.dart';
import 'package:parky/features/home/domain/usecases/get_parkings_use_case.dart';

import '../../../../config/themes/assets_manager.dart';
import '../../domain/entities/lat_long_entity.dart';
import '../widgets/custom_modal_sheet.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getParkingsUseCase) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  final GetParkingsUseCase _getParkingsUseCase;

  LocationData? locationData;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  List<LatLongEntity> parkings = [];

  // get current location
  Future<void> getLocation(GoogleMapController controller) async {
    locationData = await LocationService.instance.getCurrentLocation();

    if (locationData != null) {
      // markers.add(
      //   Marker(
      //     markerId: const MarkerId('1'),
      //     position: LatLng(locationData!.latitude!, locationData!.longitude!),
      //     infoWindow: const InfoWindow(title: 'Current Location'),
      //     icon: BitmapDescriptor.defaultMarker,
      //   ),
      // );

      circles.add(
        Circle(
          circleId: const CircleId('1'),
          center: LatLng(locationData!.latitude!, locationData!.longitude!),
          radius: 30,
          strokeWidth: 2,
          strokeColor: Colors.blueAccent,
          fillColor: Colors.blue.withOpacity(0.3),
        ),
      );
      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData!.latitude!, locationData!.longitude!),
        ),
      );

      // update parking
      getParkings();
      emit(LocationLoaded());
    }
  }

  // // get real time location
  // void getRealTimeLocation(GoogleMapController controller) {
  //   LocationService.instance.getRealTimeLocation(
  //     (updatedLocation) {
  //       locationData = updatedLocation;
  //       // update circle location
  //       circles.clear();
  //       circles.add(
  //         Circle(
  //           circleId: const CircleId('1'),
  //           center: LatLng(locationData!.latitude!, locationData!.longitude!),
  //           radius: 30,
  //           strokeWidth: 2,
  //           strokeColor: Colors.blueAccent,
  //           fillColor: Colors.blue.withOpacity(0.3),
  //         ),
  //       );
  //       controller.animateCamera(
  //         CameraUpdate.newLatLng(
  //           LatLng(locationData!.latitude!, locationData!.longitude!),
  //         ),
  //       );

  //       // update parking
  //       getParkings();
  //       // emit(LocationLoaded());
  //     },
  //   );
  // }

  // get parking
  Future<void> getParkings() async {
    emit(ParkingLoading());
    final result = await _getParkingsUseCase.execute(
        lat: locationData!.latitude!, long: locationData!.longitude!);
    result.fold((failure) => emit(ParkingError(failure.message)),
        (result) async {
      parkings = result;
      List<LatLongEntity> additionalParkings = [
        // modern academy
        LatLongEntity(
          id: -1,
          lat: 29.98234548340719,
          long: 31.329856233177455,
        ),
        // معهد العبور
        LatLongEntity(
          id: -2,
          lat: 30.27946229966729,
          long: 31.473262303928124,
        ),
      ];
      parkings.addAll(additionalParkings);
      markers.clear();
      final customIcon = await getCustomMarker();

      for (var parking in parkings) {
        markers.add(
          Marker(
            markerId: MarkerId(parking.id.toString()),
            position: LatLng(parking.lat, parking.long),
            infoWindow: InfoWindow(
              title: parking.id == -2
                  ? "معهد العبور"
                  : parking.id == -1
                      ? "Modern Academy"
                      : "Parking ${parking.id}",
            ),
            icon: customIcon,
            onTap: () {
              if (parking.id == -1) {
                showModalBottomSheet(
                  context: RouteManager.ctx!,
                  builder: (context) {
                    return const CustomModalSheet();
                  },
                );
              }
            },
          ),
        );
      }
      emit(ParkingSuccess());
    });
  }

  // get custom marker
  Future<BitmapDescriptor> getCustomMarker() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      AssetsManager.parkingIcon,
    );
  }
}
