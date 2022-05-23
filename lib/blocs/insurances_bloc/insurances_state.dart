part of 'insurances_bloc.dart';

@immutable
abstract class InsurancesState {
  const InsurancesState();
}

class InsurancesInitial extends InsurancesState {}

class InsurancesLoaded extends InsurancesState {
  final List<InsuranceModel> insuranceList;

  const InsurancesLoaded(this.insuranceList);
}

class InsuranceCreated extends InsurancesState {
  const InsuranceCreated();
}

class SuccessCreatingInsurance extends InsurancesState {
  const SuccessCreatingInsurance();
}

class SuccessUpdatingInsurance extends InsurancesState {
  const SuccessUpdatingInsurance();
}

class ErrorInsurance extends InsurancesState {
  const ErrorInsurance();
}
