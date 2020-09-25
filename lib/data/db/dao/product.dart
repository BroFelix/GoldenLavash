import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/product.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM Product')
  Future<List<Product>> getAllProducts();

  @Query('SELECT * FROM Product Where id = :id')
  Future<Product> getProduct(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertProduct(Product product);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertProducts(List<Product> products);

  @Query('DELETE FROM Product')
  Future<void> deleteAllProducts();

  @transaction
  Future<void> replaceProducts(List<Product> products) async {
    await deleteAllProducts();
    await insertProducts(products);
  }
}
