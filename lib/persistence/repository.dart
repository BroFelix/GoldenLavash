import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/models/expense.dart';
import 'package:golden_app/models/resource.dart';
import 'package:golden_app/services/api/api.dart';

class Repository {
  ApiService apiService = ApiService.getInstance();

  Future<EstimateResponse> fetchEstimate() => apiService.getEstimates();

  Future<ExpenseResponse> fetchExpense() => apiService.getExpenses();

  Future<ResourceResponse> fetchResource() => apiService.getResources();
}
