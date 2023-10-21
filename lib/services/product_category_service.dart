import 'package:e_commerce/models/product_category_model.dart';
import 'package:e_commerce/utils/db_mock_util.dart';

class ProductCategoryService {
  static List<ProductCategory> getAllCategories() {
    return kProductCategoriesCollection;
  }

  static List<String> getAllCategoriesNames() {
    List<String> names = [];

    for (ProductCategory category in kProductCategoriesCollection) {
      names.add(category.name);
    }

    return names;
  }
}
