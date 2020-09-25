import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/estimate_item.dart';

@dao
abstract class EstimateItemDao {
  @Query('SELECT * FROM EstimateItem')
  Future<List<EstimateItem>> getAllEstimateItems();

  @Query('SELECT * FROM EstimateItem Where id = :id')
  Future<EstimateItem> getEstimateItem(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertEstimateItem(EstimateItem estimateItem);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertEstimateItems(List<EstimateItem> estimateItems);

  @Query('DELETE FROM EstimateItem')
  Future<void> deleteAllEstimateItems();

  @transaction
  Future<void> replaceEstimateItems(List<EstimateItem> estimateItems) async {
    await deleteAllEstimateItems();
    await insertEstimateItems(estimateItems);
  }
}
