import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/outlay_category.dart';

@dao
abstract class OutlayCategoryDao {
  @Query('SELECT * FROM OutlayCategory')
  Future<List<OutlayCategory>> getAllOutlayCategories();

  @Query('SELECT * FROM OutlayCategory Where id = :id')
  Future<OutlayCategory> getOutlayCategory(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOutlayCategory(OutlayCategory outlayCategory);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllOutlayCategories(
      List<OutlayCategory> outlayCategories);

  @Query('DELETE FROM OutlayCategory')
  Future<void> deleteAllOutlayCategories();

  @transaction
  Future<void> replaceOutlayCategories(List<OutlayCategory> outlayCategories) async {
    await deleteAllOutlayCategories();
    await insertAllOutlayCategories(outlayCategories);
  }
}
