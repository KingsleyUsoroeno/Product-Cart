import 'package:flutter_course/scoped_models/product_model.dart';
import 'package:flutter_course/scoped_models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model with UserModel, ProductModel {}
