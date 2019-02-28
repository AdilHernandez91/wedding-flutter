import 'package:scoped_model/scoped_model.dart';

import 'auth_model.dart';
import 'guest_model.dart';

class MainModel extends Model with AuthModel, GuestModel {}