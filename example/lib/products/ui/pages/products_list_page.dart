import 'package:auto_route/auto_route.dart';
import 'package:example/cart_items/cart_item.model.dart';
import 'package:example/common/component/base_bloc.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/injection/injection.dart';
import 'package:example/common/isar/builders/custom_isar_filter_stream.builder.dart';
import 'package:example/common/navigation/navigation.dart';
import 'package:example/products/product.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ProductsListPage extends StatelessWidget with AutoRouteWrapper {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Services List"),
          actions: [
            CustomIsarFilterStreamBuilder(
                queryBuilder: (isar) => isar.cartItems.filter().idIsNotNull(),
                collection: (isar) => isar.cartItems,
                onData: (cartItems) {
                  return Chip(
                      label: Text(cartItems.stringifiedTotal,
                          style: const TextStyle(fontWeight: FontWeight.w900)));
                })
          ],
        ),
        body: BlocBuilder<BaseBloc<Product>, BaseState<Product>>(
          builder: (context, state) {
            if (state is LoadedState<Product>) {
              final products = state.data;
              return Stack(
                children: [
                  ProductsListViewWidget(products: products),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          // navigate to checkout page
                          context.router.push(const PaynowCheckoutRoute());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: context.heightDivideBy(10),
                          width: context.width,
                          color: Colors.green,
                          child: Text(
                            'CHECKOUT',
                            style: context.textTheme.displaySmall?.merge(
                                TextStyle(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white.withOpacity(.7))),
                          ),
                        ),
                      ))
                ],
              );
            }
            return Center(
              child: Text(state.toString()),
            );
          },
        )); // ProductsIsarBuilder());
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<BaseBloc<CartItem>>(),
        ),
        BlocProvider.value(
            value: getIt<BaseBloc<Product>>()..add(LoadEvent(parameters: {})))
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: this,
    );
  }
}

class ProductsListIsarBuilderWidget extends StatelessWidget {
  const ProductsListIsarBuilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIsarFilterStreamBuilder(
      collection: (isar) => isar.products,
      queryBuilder: (isar) => isar.products.filter().idIsNotNull(),
      onData: (products) {
        return ProductsListViewWidget(products: products);
      },
    );
  }
}

class ProductsListViewWidget extends StatelessWidget {
  final List<Product> products;
  const ProductsListViewWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            ...List.generate(products.length,
                (index) => ProductListTileWidget(product: products[index])),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 100),
              child: Center(child: Text('End of Shopping List')),
            )
          ],
        ),
      ],
    );
  }
}

class ProductListTileWidget extends StatelessWidget {
  const ProductListTileWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(product.imageUrl!))),
      height: context.height / 4,
      child: Stack(
        children: [
          Card(
            elevation: 5,
            color: Colors.blue.withOpacity(.6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: context.theme.textTheme.headlineSmall?.merge(
                                const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)),
                          ),
                          Text(
                            product.description,
                            style: context.theme.textTheme.labelSmall?.merge(
                                const TextStyle(fontWeight: FontWeight.w900)),
                          ),
                        ],
                      ),
                      CustomIsarFilterStreamBuilder(
                          queryBuilder: (isar) => isar.cartItems
                              .filter()
                              .product$idEqualTo(product.id!),
                          collection: (isar) => isar.cartItems,
                          onData: (cartItemMatches) {
                            if (cartItemMatches.isNotEmpty) {
                              final cartItem = cartItemMatches.first;
                              return Chip(
                                label: Text(
                                  'In Cart: ${cartItem.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                ),
                                avatar: const Icon(Icons.shopping_bag_outlined),
                              );
                            }
                            return const Chip(label: Text('Buy me 😃'));
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                          label: RichText(
                        text: TextSpan(
                            text: '${product.currency} ',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: '${product.price}',
                                  style: const TextStyle(color: Colors.blue))
                            ]),
                      )),
                      CustomIsarFilterStreamBuilder(
                          queryBuilder: (isar) => isar.cartItems
                              .filter()
                              .product$idEqualTo(product.id!),
                          collection: (isar) => isar.cartItems,
                          onData: (cartItemMatches) {
                            if (cartItemMatches.isEmpty) {
                              return ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.add_box_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // add item to cart
                                    // that means creating a cart record
                                    // so that means we just to create a new event record
                                    final cartItem = CartItem()
                                      ..id = const Uuid().v1()
                                      ..product$id = product.id!
                                      ..price = product.price
                                      ..quantity = 1
                                      ..currency = product.currency;
                                    context.read<BaseBloc<CartItem>>().add(
                                        CreateEvent<CartItem>(
                                            entity: cartItem));
                                  },
                                  label: const Text(
                                    'Add To Cart',
                                    style: TextStyle(color: Colors.white),
                                  ));
                            } else {
                              /// return buttons for adding quantity and decrease quantity
                              final cartItem = cartItemMatches.first;
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<BaseBloc<CartItem>>()
                                              .add(UpdateEvent(
                                                  id: cartItem.id!,
                                                  entity: cartItem
                                                    ..quantity += 1));
                                        },
                                        icon: const Icon(Icons.add)),
                                    IconButton(
                                        onPressed: () {
                                          if (cartItem.quantity == 1) {
                                            context
                                                .read<BaseBloc<CartItem>>()
                                                .add(DeleteEvent(
                                                  id: cartItem.id!,
                                                ));
                                          } else {
                                            context
                                                .read<BaseBloc<CartItem>>()
                                                .add(UpdateEvent(
                                                    id: cartItem.id!,
                                                    entity: cartItem
                                                      ..quantity -= 1));
                                          }
                                        },
                                        icon: const Icon(Icons.remove)),
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<BaseBloc<CartItem>>()
                                              .add(DeleteEvent(
                                                id: cartItem.id!,
                                              ));
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              );

                              /// on last item remove cartitem
                              ///
                            }
                          })
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: CustomIsarFilterStreamBuilder(
                collection: (isar) => isar.cartItems,
                queryBuilder: (isar) =>
                    isar.cartItems.filter().product$idEqualTo(product.id!),
                onData: (cartItemMatches) {
                  return Text(
                    cartItemMatches.stringifiedTotal,
                    style: context.textTheme.headlineLarge?.merge(
                        const TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.white)),
                  );
                },
              ))
        ],
      ),
    );
  }
}
