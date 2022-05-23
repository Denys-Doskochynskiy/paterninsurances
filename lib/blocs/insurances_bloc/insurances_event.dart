part of 'insurances_bloc.dart';

@immutable
abstract class InsurancesEvent {
  const InsurancesEvent();
}

class LoadInsuranceList extends InsurancesEvent {
  const LoadInsuranceList();
}

class CreateInsurances extends InsurancesEvent {
  const CreateInsurances();
}

class UpdateInsurances extends InsurancesEvent {
  final String insuranceId;
  const UpdateInsurances(this.insuranceId);
}
class DeleteInsurances extends InsurancesEvent {
  final String insuranceId;
  const DeleteInsurances(this.insuranceId);
}

class HandleInsuranceInput extends InsurancesEvent {
  final String inputName;
  final String input;

  const HandleInsuranceInput({required this.inputName, required this.input});
}
