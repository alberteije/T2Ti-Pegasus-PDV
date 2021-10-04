import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/product.dart';

class ProductViewModel {
  
  List<Product> productsItems;

  ProductViewModel({this.productsItems});

  getProducts() => <Product>[
        Product(
            brand: "T2Ti",
            description: "Sistema Teste",
            image:
                "http://t2tisistemas.com/img/services/news-desenvolvimento.jpg",
            name: "Sistema Teste",
            price: "111.11",
            rating: 4.8,
            colors: [
              ProductColor(
                color: Colors.red,
                colorName: "Verm",
              ),
              ProductColor(
                color: Colors.green,
                colorName: "Verd",
              ),
              ProductColor(
                color: Colors.blue,
                colorName: "Azul",
              ),
              ProductColor(
                color: Colors.cyan,
                colorName: "Cian",
              )
            ],
            quantity: 0,
            sizes: ["P", "M", "G", "XG"],
            totalReviews: 170),
        Product(
            brand: "T2Ti",
            description: "Ponto Delphi",
            image:
                "http://t2ti.com/images/capas/capa_erp2_delphi_ponto_250.jpg",
            name: "Ponto Delphi",
            price: "99.90",
            rating: 5.0,
            totalReviews: 10),
        Product(
            brand: "T2Ti",
            description: "Java Patrimônio",
            image:
                "http://t2ti.com/images/capas/capa_erp2_javaweb_patrimonio_250.jpg",
            name: "Patrimônio",
            price: "65.70",
            rating: 4.5,
            totalReviews: 0),
        Product(
            brand: "T2Ti",
            description: "SisCom Delphi",
            image:
                "http://t2ti.com/images/siscom-fmx/siscom-fmx-capa.png",
            name: "SisCom FMX",
            price: "90.00",
            rating: 4.0,
            totalReviews: 5),
        Product(
            brand: "T2Ti",
            description: "NF-e C#",
            image:
                "http://t2ti.com/images/capas/capa_erp2_c_nfesb01_250.jpg",
            name: "NF-e C#",
            price: "110.00",
            rating: 4.0,
            totalReviews: 12),
        Product(
            brand: "T2Ti",
            description: "Xamarin",
            image:
                "http://t2ti.com/images/logos_terceiros/ionic-cordova.png",
            name: "Xamarin",
            price: "83.99",
            rating: 4.2,
            totalReviews: 28),
        Product(
            brand: "T2Ti",
            description: "Ionic",
            image:
                "http://t2ti.com/images/logos_terceiros/android-studio.jpg",
            name: "Ionic",
            price: "11.99",
            rating: 4.7,
            totalReviews: 120),
        Product(
            brand: "T2Ti",
            description: "Java",
            image:
                "http://t2ti.com/images/3page_img1.jpg",
            name: "Java",
            price: "26.59",
            rating: 4.0,
            totalReviews: 33),
        Product(
            brand: "T2Ti",
            description: "Delphi",
            image:
                "http://t2ti.com/images/3page_img2.jpg",
            name: "Delphi",
            price: "25.59",
            rating: 4.4,
            totalReviews: 44),
        Product(
            brand: "T2Ti",
            description: "Database",
            image:
                "http://t2ti.com/images/3page_img3.jpg",
            name: "Database",
            price: "59.99",
            rating: 4.1,
            totalReviews: 22),
      ];
}
