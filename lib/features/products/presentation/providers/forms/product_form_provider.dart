import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/shared/shared.dart';


class ProductFormNotifier extends StateNotifier<ProductFormState>{

  final void Function( Map<String, dynamic> productLike )? onSubmitCallback;
  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }):super(
    ProductFormState(
      id:product.id,
      title: Title.dirty(product.title),
      slug: Slug.dirty(product.slug),
      price: Price.dirty(product.price),
      instock:Stock.dirty(product.stock),
      sizes: product.sizes,
      gender: product.gender,
      description:product.description,
      tags: product.tags.join(', '),
      images:product.images,
       
    )
  );

  void onTitleChanges(String value){
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug!.value),
        Price.dirty(state.price!.value),
        Stock.dirty(state.instock.value)
      ])
    );
  }
  void onSlugChanges(String value){
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title!.value),
        Slug.dirty(value),
        Price.dirty(state.price!.value),
        Stock.dirty(state.instock.value)
      ])
    );
  }
  void onPricesChanges(double value){
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title!.value),
        Slug.dirty(state.slug!.value),
        Price.dirty(value),
        Stock.dirty(state.instock.value)
      ])
    );
  }
  void onStockChanged(int value){
    state = state.copyWith(
      instock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title!.value),
        Slug.dirty(state.slug!.value),
        Price.dirty(state.price!.value),
        Stock.dirty(value)
      ])
    );
  }

}


class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title? title;
  final Slug? slug;
  final Price? price;
  final List<String> sizes;
  final String gender;
  final Stock instock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.instock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? instock,
    String? description,
    String? tags,
    List<String>? images,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        sizes: sizes ?? this.sizes,
        gender: gender ?? this.gender,
        instock: instock ?? this.instock,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}