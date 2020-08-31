import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/models/estimate_resource.dart';
import 'package:golden_app/models/outlay_category.dart';
import 'package:golden_app/models/outlay_item.dart';
import 'package:golden_app/services/api/api.dart';

class Repository {
  ApiService apiService = ApiService.getInstance();

  Future<EstimateResponse> fetchEstimate() => apiService.getEstimates();

  Future<OutlayItemResponse> fetchEstimateItem() => apiService.getOutlayItem();

  Future<OutlayCategoryResponse> fetchOutlayCategory() =>
      apiService.getOutlayCategory();

  Future<EstimateResourceResponse> fetchResource() =>
      apiService.getEstimateResources();

}
