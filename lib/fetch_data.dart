import 'package:flutter/material.dart';
import 'package:flutter_api/detail_screen.dart';
import 'package:flutter_api/models/product_model.dart';
import 'package:flutter_api/reposrtiry/fetch_product_repo.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

//2
class _FetchDataState extends State<FetchData> {
  
  late Future<List<Products>> futureProducts;

  //1
  @override
  void initState() {
    super.initState();
    //3
    futureProducts = ProductRepo().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Ecommce Products',
            style: TextStyle(color: Colors.amber),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  //4

                  ProductRepo().addProduct(
                    title: 'MRF bat',
                    price: 6000.00,
                    decrption: 'one of the most famous bat in cricket hisrtory',
                    catagries: 'Cricket kits',
                    image:
                        'ttps://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                    rating: {'rate': 4.0, 'count': 120},
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ))
          ],
        ),
        //4
        body: FutureBuilder<List<Products>>(
            //5
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var productData = snapshot.data!;

                return Card(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 350,
                            childAspectRatio: 2 / 2),
                    itemCount: productData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        //1
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //2
                            Container(
                              child: Center(
                                child: Image.network(
                                  productData[index].image!,
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //3
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(productData[index].title!),
                                  //4
                                  Row(
                                    children: [
                                      // ignore: prefer_const_constructors

                                      //5
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      //6
                                      Text(productData[index]
                                          .rating!
                                          .rate
                                          .toString())
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            ProductRepo().updateProduct(
                                                id: productData[index]
                                                    .id
                                                    .toString(),
                                                title: productData[index].title,
                                                price:
                                                    productData[index].price);
                                          },
                                          child: const Text('Update')),
                                      TextButton(
                                          onPressed: () {
                                            ProductRepo().deleteProduct(
                                                id: productData[index]
                                                    .id
                                                    .toString());
                                          },
                                          child: const Text('Delete'))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                          // return ListTile(
                          //   title: Image.network(productData[index].image!),
                          //   subtitle: Text(productData[index].title!),
                          // );
                          ;
                    },
                  ),
                );
              } else {
                // return Center(child: CircularProgressIndicator());
                return const CircularProgressIndicator();
              }
            }));
  }
}
