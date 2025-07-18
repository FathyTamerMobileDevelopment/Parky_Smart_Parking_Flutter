
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spot_state.dart';

class SpotCubit extends Cubit<SpotState> {
  SpotCubit() : super(SpotInitial());
}
