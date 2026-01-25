import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_screen_state.dart';

class ProductScreenCubit extends Cubit<ProductScreenState> {
  final String? productId;

  ProductScreenCubit({required this.productId})
    : super(const ProductScreenState());
}
