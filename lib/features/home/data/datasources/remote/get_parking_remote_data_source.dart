import 'package:parky/core/api/dio_consumer.dart';
import 'package:parky/features/home/domain/entities/lat_long_entity.dart';

class GetParkingRemoteDataSource {
  final DioConsumer _dioConsumer;

  GetParkingRemoteDataSource(this._dioConsumer);

  Future<List<LatLongEntity>> getParking(
      {required double lat, required double long}) async {
    var response = await _dioConsumer.get(
        path:
            'https://overpass-api.de/api/interpreter?data=[out:json];node["amenity"="parking"](around:10000,$lat,$long);out;');
    List<LatLongEntity> latLongList = [];
    for (var element in response['elements']) {
      latLongList.add(LatLongEntity.fromJson(element));
    }
    return latLongList;
  }
}
