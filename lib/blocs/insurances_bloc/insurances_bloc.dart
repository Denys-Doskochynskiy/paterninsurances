import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:paterninsurances/api/insurance/insurance_api.dart';
import 'package:paterninsurances/api/insurance/insurance_model.dart';

part 'insurances_event.dart';

part 'insurances_state.dart';

class InsurancesBloc extends Bloc<InsurancesEvent, InsurancesState> {
  final InsuranceApi _api = InsuranceApi();
  final _storage = const FlutterSecureStorage();
  late List<InsuranceModel> _listInsurances;
  final Map<String, dynamic> _input = {
    "country": "",
    "condition": "",
    "price": "",
    "is_available": "",
    "title": "",
    "reserved_by_user": "",
  };

  InsurancesBloc() : super(InsurancesInitial()) {
    on<LoadInsuranceList>((event, emit) async {
      _listInsurances = (await _api.getInsurances())!;
      emit(InsurancesLoaded(_listInsurances));
    });

    on<CreateInsurances>((event, emit) async {
      _input["reserved_by_user"] = await _storage.read(key: "email");
      _input["is_available"] = true;
      await _api.createInsurance(_input);
      _input.updateAll((key, value) => _input[key]='');
      _listInsurances = (await _api.getInsurances())!;
      emit(const SuccessCreatingInsurance());
      emit(InsurancesLoaded(_listInsurances));
    });
    on<UpdateInsurances>((event, emit) async {
      await _api.updateInsurance(_input,event.insuranceId);
      _listInsurances = (await _api.getInsurances())!;
      emit(const SuccessUpdatingInsurance());
      emit(InsurancesLoaded(_listInsurances));
    });
    on<DeleteInsurances>((event, emit) async {

      await _api.deleteInsurance(event.insuranceId);
      _listInsurances = (await _api.getInsurances())!;
      emit(InsurancesLoaded(_listInsurances));
    });

    on<HandleInsuranceInput>((event, emit) async {
      _input.update(event.inputName, (value) => event.input);
    });
  }
}
