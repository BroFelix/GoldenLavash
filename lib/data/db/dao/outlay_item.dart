import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/outlay_item.dart';

@dao
abstract class OutlayItemDao {
  @Query('SELECT * FROM OutlayItem')
  Future<List<OutlayItem>> getAllOutlayItems();

  @Query('SELECT * FROM OutlayItem Where id = :id')
  Future<OutlayItem> getOutlayItem(int id);

  @Query('SELECT * FROM OutlayItem Where outlayCategory = :outlayCategory')
  Future<List<OutlayItem>> getOutlaysByCategory(int outlayCategory);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOutlayItem(OutlayItem item);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertAllOutlayItems(List<OutlayItem> items);

  @Query('DELETE FROM OutlayItem')
  Future<void> deleteAllOutlayItems();

  @transaction
  Future<void> replaceOutlayItems(List<OutlayItem> outlayItems) async {
    await deleteAllOutlayItems();
    await insertAllOutlayItems(outlayItems);
  }
}
