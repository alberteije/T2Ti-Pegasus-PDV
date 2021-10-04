import 'package:flutter_uikit/model/post.dart';

class PostViewModel {
  List<Post> postItems;

  PostViewModel({this.postItems});

  getPosts() => <Post>[
        Post(
            personName: "Financeiro",
            address: "Novo recurso no Contas a Pagar",
            likesCount: 100,
            commentsCount: 10,
            message:
                "A integração com o PayPal foi concluída e agora já é possível realizar pagamentos utilizando essa plataforma.",
            personImage:
                "http://t2ti.com/images/logo_t2ti.png",
            messageImage:
                "http://t2ti.com/images/erp3/paypal-banner.jpg",
            postTime: "Agora"),
        Post(
            personName: "Compras",
            address: "Compra Sugerida",
            likesCount: 123,
            commentsCount: 78,
            messageImage:
                "http://t2ti.com/images/erp3/banner-compras.jpg",
            message:
                "O módulo compras agora contém o recurso de compra sugerida por estoque mínimo.",
            personImage:
                "http://t2ti.com/images/logo_t2ti.png",
            postTime: "5h atrás"),
        Post(
            personName: "NF-e",
            address: "Atualização na NF-e",
            likesCount: 50,
            commentsCount: 5,
            messageImage:
                "http://t2ti.com/images/erp3/nfe-4.jpg",
            message:
                "Informamos que a NF-e foi atualizada para a versão 4.0. Siga as instruções enviadas por e-mail.",
            personImage:
                "http://t2ti.com/images/logo_t2ti.png",
            postTime: "2h atrás"),
        Post(
            personName: "T2Ti ERP 3.0",
            address: "Nova Versão do T2Ti ERP",
            likesCount: 23,
            commentsCount: 4,
            messageImage:
                "http://t2ti.com/images/erp/erp3-destaque.jpg",
            message:
                "Depois de meses de planejamento, ele chegou e é diferente de tudo aquilo que você imaginou.",
            personImage:
                "https://avatars1.githubusercontent.com/u/136610?s=460&v=4",
            postTime: "3h atrás"),
      ];
}
