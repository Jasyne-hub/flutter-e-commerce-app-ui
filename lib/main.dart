import 'package:flutter/material.dart';
import 'product.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              primary: Color(0xFFDC143C),
              secondary: Colors.white
          )
      ),
      home: WelcomeScreen(),
      onGenerateRoute: (RouteSettings routeInfo) {
        switch(routeInfo.name){
          case '/':
            return MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
                settings: routeInfo
            );
          case '/itemScreen':
            return MaterialPageRoute(
                builder: (context) => ItemScreen(products: [ignis9pro, ignis9, ignis8pro, ignis8, ignis7pro, ignis7, ignis6pro, ignis6, ignis5pro, ignis5]),
                settings: routeInfo
            );
          case '/detailsScreen':
            return MaterialPageRoute(
                builder: (context) => DetailsScreen(),
                settings: routeInfo
            );
          default:
            return MaterialPageRoute(
                builder: (context) => UnknownScreen(),
                settings: routeInfo
            );
        }
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Center(child: Text('Welcome to Jasyne Inc'))
        ),
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Welcome to Jasyne Inc \n Click here to see our products', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.popAndPushNamed(
                              context,
                              '/itemScreen'
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            textStyle: TextStyle(fontSize: 20)
                        ),
                        child: Text('View Products', style: TextStyle(color: Theme.of(context).colorScheme.secondary))
                    )
                  ],
                )
            )
        )
    );
  }
}

class ItemScreen extends StatefulWidget {
  final List<Product>? products;
  const ItemScreen({super.key, this.products});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.products == null){
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Center(child: Text('Items',  style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                letterSpacing: 1.2,
              ),))
          ),
          body: Center(
              child: Text('We are currently \n Sold Out', style: TextStyle(fontSize: 24), textAlign: TextAlign.center,)
          )
      );
    }
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Center(child: Text('Items', style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              letterSpacing: 1.2,
            )))
        ),
        body: Center(
            child: Expanded(
                child: ListView.builder(
                  itemCount: widget.products?.length,
                  itemBuilder: (context, index){
                    if (widget.products != null){
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          title: Text(
                            widget.products![index].productName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            widget.products![index].isAvailable ? 'Available' : 'Out of Stock',
                            style: TextStyle(
                              color: widget.products![index].isAvailable ? Colors.green : Colors.red,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              String productName = widget.products![index].productName;
                              bool isAvailable = widget.products![index].isAvailable;
                              double productPrice = widget.products![index].productPrice;
                              List productDetails = [productName, isAvailable, productPrice];

                              Navigator.pushNamed(
                                context,
                                '/detailsScreen',
                                arguments: productDetails,
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                )
            )
        )
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List? productDetails = ModalRoute.of(context)?.settings.arguments as List?;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Center(child: Text('${productDetails![0]}          ', style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              letterSpacing: 1.2,
            )))
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.phone_android, size: 48, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 16),
                    Text(
                      productDetails[0], // Product Name
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Price: £${productDetails[2].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      productDetails[1] ? 'Available' : 'Out of Stock',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: productDetails[1] ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )

    );
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Center(child: Text('Unknown Screen', style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
              letterSpacing: 1.2,
            )))
        ),
        body: Center(
            child: Text('404 \n Unable to reach page', style: TextStyle(fontSize: 28), textAlign: TextAlign.center,)
        )
    );
  }
}