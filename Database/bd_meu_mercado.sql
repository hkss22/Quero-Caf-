-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: meu_mercado
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mercado`
--

DROP TABLE IF EXISTS `mercado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mercado` (
  `id_mercado` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `dt_cadastro` datetime DEFAULT NULL,
  `vl_entrega` decimal(5,2) DEFAULT NULL,
  `vl_compra_min` decimal(9,2) DEFAULT NULL,
  `ind_entrega` char(1) DEFAULT NULL,
  `ind_retira` char(1) DEFAULT NULL,
  PRIMARY KEY (`id_mercado`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mercado`
--

LOCK TABLES `mercado` WRITE;
/*!40000 ALTER TABLE `mercado` DISABLE KEYS */;
INSERT INTO `mercado` VALUES (8,'Quero Café - Interlagos','Av. Interlagos, 850','Interlagos','São Paulo','SP','04660-005','2024-05-15 21:33:04',10.00,30.00,'N','S'),(9,'Quero Café - Santa Cecília','Av. Duque de Caxias, 99','Santa Ifigênia','São Paulo','SP','01214-000','2024-05-15 21:37:08',10.00,30.00,'S','N'),(10,'Quero Café - Tatuapé','R. Tuiti, 1254','Tatuapé','São Paulo','SP','03081-000','2024-05-15 21:51:59',10.00,30.00,'S','S'),(11,'Quero Café - Jabaquara','Av. Jabaquara, 2143','Jabaquara','São Paulo','SP','04045-003','2024-05-15 21:58:38',15.00,35.00,'N','S'),(12,'Quero Café - Brás','R. Barão de Ladário, 208','Brás','São Paulo','SP','03010-000','2024-05-15 22:07:19',15.00,35.00,'S','N'),(13,'Quero Café - Penha','R. Dr. Suzano Brandão, 493','Vila Aricanduva','São Paulo','SP','03502-000','2024-05-15 22:10:06',15.00,35.00,'S','S');
/*!40000 ALTER TABLE `mercado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_mercado` int NOT NULL,
  `id_usuario` int NOT NULL,
  `dt_pedido` datetime DEFAULT NULL,
  `vl_subtotal` decimal(9,2) DEFAULT NULL,
  `vl_entrega` decimal(5,2) DEFAULT NULL,
  `vl_total` decimal(9,2) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_mercado` (`id_mercado`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_item`
--

DROP TABLE IF EXISTS `pedido_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_item` (
  `id_item` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_produto` int NOT NULL,
  `qtd` decimal(9,3) DEFAULT NULL,
  `vl_unitario` decimal(9,2) DEFAULT NULL,
  `vl_total` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`id_item`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `pedido_item_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `pedido_item_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_item`
--

LOCK TABLES `pedido_item` WRITE;
/*!40000 ALTER TABLE `pedido_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `id_categoria` int NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(1000) DEFAULT NULL,
  `unidade` varchar(20) DEFAULT NULL,
  `preco` decimal(9,2) DEFAULT NULL,
  `url_foto` varchar(1000) DEFAULT NULL,
  `id_mercado` int NOT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `id_mercado` (`id_mercado`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `produto_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `produto_categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (25,17,'Box Luxo - Café Gourmet','Kit ideal para presente. Conteúdo: 1 caixa branca com laço vermelho, 1 café baggio gourmet 250g, 1 caneca azul da marca Oxford 380ml, 1 colher dourada em inox e 4 unidades de bombom Ferrero Rocher.','1',180.90,'https://i.ibb.co/kDLm8BS/kit1.jpg',8),(26,17,'Box Luxo - Capuccino','Kit perfeito para qem ama cappucino. Conteúdo: 1 caixa branca com laço azul, 4 unidades de sachê Cappuccino Santa Mônica, 1 caneca azul da marca Oxford 380ml, 4 unidades de bombom Ferrero Rocher e 1 lata de biscoito típico holandês Stroopwafel.','1',175.90,'https://i.ibb.co/d7Nw0dh/kit2.jpg',8),(27,17,'Cesta Rústica - Vermelha','Linda cesta de café da manhã individual na caixa de madeira rústica. Conteúdo: 1 Caixa rústica de madeira, 1 Caneca da marca Oxford, 1 salgado Croissant (presunto e queijo ou frango Catupiry), 2 salgado Waffles, 1 Sachê de chá Twinnings, 2 Sachês de cappuccino Santa Mônica, 1 Queijo frescatino Polenghi, 1 Nutella 140g e 1 Porção de frutas.','1',227.90,'https://i.ibb.co/9ZxktJ4/kit3.jpg',9),(28,17,'Cesta Rústica - Azul','Linda cesta de café da manhã individual na caixa de madeira rústica. Conteúdo: 1 Caixa rústica de madeira, 1 Caneca Azul da marca Oxford, 1 Croissant (presunto e queijo ou frango Catupiry), 2 Waffles, 1 Sachê de chá Twinnings, 2 Sachês de cappuccino Santa Mônica, 1 Queijo frescatino Polenghi, 1 Nutella 140g e 1 Porção de frutas.','1',227.90,'https://i.ibb.co/7k8Y6dx/kit4.jpg',9),(29,17,'Cesta Com Flores - Azul','Linda cesta de café da manhã com arranjo de flores. Conteúdo: 1 Caixa cartonada na cor bege, 1 Buquê de flores de astromélias, 2 Croissants (presunto e queijo ou frango Catupiry), 2 Waffles, 1 Brownie de chocolate com castanhas, 1 Pacote de biscoitos amanteigados, 1 Suco integral da Natural one (300ml), 1 Sachê de chá Twinnings, 2 Sachês de cappuccino Santa Mônica, 1 Mini geleia francesa St Dalfour e 1 Queijo frescatino Polenghi.','1',312.90,'https://i.ibb.co/G2W4Sh2/kit5.jpg',10),(30,17,'Cesta Com Flores - Rosa','Linda cesta de café da manhã com arranjo de flores. Conteúdo: 1 Caixa cartonada na cor rosa, 1 Buquê de flores de astromélias, 2 Croissants (presunto e queijo ou frango Catupiry), 2 Waffles, 1 Brownie de chocolate com castanhas, 1 Pacote de biscoitos amanteigados, 1 Suco integral da Natural one (300ml), 1 Sachê de chá Twinnings, 2 Sachês de cappuccino Santa Mônica, 1 Mini geleia francesa St Dalfour e 1 Queijo frescatino Polenghi.','1',312.90,'https://i.ibb.co/YDcrJCS/kit6.jpg',10),(31,17,'Kit | 4 Cafés em Grãos - Arara + Fazendas','Sinta todo o sabor dos cafés em grãos conduzidos por aromas preservados para a moagem. Viva experiências sensoriais variadas e sinta as particularidades das notas sensoriais desse kit de café. Conteúdo: 4 pacotes de 250g cada, os cafés estão em grãos, ou seja, não estão moídos, permitindo que sejam moídos na hora do preparo para maior frescor e aroma.','1',98.99,'https://i.ibb.co/7r6Y2Fy/kit7.jpg',11),(32,17,'Kit Baggio Café Cápsulas + Porta Cápsulas','O kit perfeito para você que deseja ter todas as cápsulas à sua disposição. Aproveite toda a intensidade dos cafés gourmet e a cremosidade dos cafés aromatizados. Conteúdo: 10 Cápsulas Baggio Aromas Caramelo, 10 Cápsulas Baggio Aromas Chocolate com Menta, 10 Cápsulas Baggio Aromas Chocolate com Avelã, 10 Cápsulas Baggio Aromas Baunilha, 10 Cápsulas Baggio Aromas Amêndoas Torradas, 10 Cápsulas Baggio gourmet Extra Intenso, 10 Cápsulas Baggio gourmet Intenso, 10 Cápsulas Baggio Gourmet Clássico, 10 Cápsulas Baggio Espresso Lungo, 10 Cápsulas Baggio Ristretto e 1 unidade Porta Cápsulas Acrílico (AxLxC: 13cm x 13cm x 13cm)','1',289.90,'https://i.ibb.co/1bfyvgh/kit8.jpg',11),(33,17,'Kit Escritório Baggio Café 3Kg Moídos','Este kit é ideal para você ter em seu escritório e servir seus convidados com cafés que possuem notas gustativas marcantes, corpo delicado e sabores marcantes. Conteúdo: 1Kg Baggio Café Gourmet Espresso, 1Kg Baggio Café Gourmet Bourbon e 1Kg Baggio Café Premium Caffé.Com.','1',269.90,'https://i.ibb.co/Xj8RXzp/kit9.jpg',12),(34,17,'Kit Baggio Café Moídos Master','Aproveite toda a intensidade dos cafés gourmet e a cremosidade dos cafés aromatizados. Com moagem média, nossos cafés são perfeitos para diversos métodos de extração e te levam para uma experiência única. Conteúdo: 250g Baggio Aromas Chocolate Trufado, 250g Baggio Aromas Caramelo, 250g Baggio Aromas Chocolate com Menta, 250g Baggio Aromas Chocolate com Avelã, 250g Baggio Gourmet Espresso, 250g Baggio Gourmet Bourbon e 250g Baggio Premium Caffé.com.','1',173.90,'https://i.ibb.co/nsDZy5s/kit10.jpg',12),(35,17,'Kit Café Cruz Da Mata + Coador + Xícara + Coco Rock','Esse kit foi montado pra lhe dar a oportunidade de proporcionar a melhor experiência á quem é importante para você. Demonstre assim seu carinho, admiração e respeito, presenteando-o(a) com o que há de melhor. Conteúdo: 2 cafés arábica moído (250 g ), 1 Coco Rock / crispy de coco sabor café (85 g), 1 coador de pano, 1 suporte para coador, 1 xícara retrô e 1 caixa para presente.','1',165.90,'https://i.ibb.co/SNWcBqy/kit11.jpg',13),(36,17,'Kit Café Premium + 3 Xícaras + Café','Kit para quem não vive sem o bom e velho café da manhã/tarde/noite, ideal para todos os momentos. Conteúdo: 1 Cafeteira, 3 tampas de cafeteria que viram Xícaras, 1 Café Fort (500g) e 1 caixa para presente. ','1',127.90,'https://i.ibb.co/tYJGnnk/kit12.jpg',13),(37,16,'Chocolate Coffee Creations Hershey','Deliciosa barra de chocolate ao leite extra cremoso com pedaços de café sabor de Caramelo Macchiato, uma combinação encorpada do sabor de café com fundo amanteigado e caramelizado. O queridinho sabor de Cappuccino em uma deliciosa barra na combinação de chocolate mesclado (ao leite e branco) com pedaços de café. De sabor doce e lacteo, tem suaves notas de café e uma pitada de canela. Uma barra inédita que une o clássico sabor do café expresso em perfeito equilibrio com o chocolate meio amargo. Uma combinação sem forte amargor mas com predominância da torra do café, com sabor inigualável.','3 Barras (85g)',18.59,'https://i.ibb.co/Yd7px3s/chocolate1.png',8),(38,16,'Barra de Chocolate Cappuccino Coffee – 85g','Prepare-se para uma experiência de sabor incrível com a nossa Barra de Chocolate Cappuccino Hershey s Coffee Creations. Esta deliciosa barra é a combinação perfeita de chocolate mesclado, ao leite e branco, com pedaços de café que adicionam um toque mágico a cada mordida. O sabor é doce, com suaves notas de café e uma pitada de canela que irá conquistar seu paladar. Ideal para uma pausa para o coffee. Aproveite!','1 Barra (85g)',7.29,'https://i.ibb.co/BTHrg1s/chocolate2.jpg',8),(39,16,'Barra de Chocolate Espresso Coffee – 85g','Apresentamos a nossa Barra de Chocolate Espresso da Hershey s Coffee Creations, perfeito para uma pausa para o coffee! É a fusão perfeita entre o clássico sabor do café espresso e o chocolate meio amargo. Esta barra é a escolha ideal para os amantes de café que buscam uma experiência sensorial única. Você encontrará um equilíbrio notável entre o sabor do café e a riqueza do chocolate meio amargo. A predominância da torra do café oferece um toque inigualável de sabor. Aproveite!','1 Barra (85g)',7.29,'https://i.ibb.co/X8QkxVf/chocolate3.jpg',9),(40,16,'Barra de Chocolate Macchiato Coffee – 85g','Você merece um momento especial e nossa Barra de Chocolate Macchiato Hershey s Coffee Creations está aqui para torná-lo inesquecível. Esta deliciosa barra de chocolate ao leite oferece uma experiência única. Surpreenda-se com a textura extra cremosa e os pedaços de café que proporcionam uma explosão de sabor a cada mordida. Desfrute sozinho, em uma pausa pro coffee, ou compartilhe com amigos em uma ocasião descontraída.','1 Barra (85g)',7.29,'https://i.ibb.co/qNFSWsh/chocolate4.jpg',9),(41,16,'Chocolate Orgânico Qahwa 60% Cacau com Café 80g','Capaz de despertar a mais profunda sinestesia, o alimento para a alma, o nosso chocolate 60% cacau orgânico com café. Uma combinação explosiva de alcalóides harmônicos – cafeína e theobromina. Sabor de chocolate legítimo, com a força antioxidante do fruto. A justa recompensa de uma experiência ousada.','1 Barra (80g)',26.99,'https://i.ibb.co/7QsZ33w/chocolate5.jpg',10),(42,16,'Chocolate Orgânico 75% Cacau 80g','O nosso chocolate 75% cacau é um clássico! Ligeiramente cítrico e com um toque de cereja, suas nuances perduram por deliciosos minutos na boca.Utilizamos somente cacau orgânico plantado em cooperativas e assentamentos certificados, fortalecendo a cultura agroflorestal em todo o Brasil.','1 Barra (80g)',26.99,'https://i.ibb.co/kXrnNz5/chocolate6.jpg',10),(43,15,'Chá Viver Gourmet - Leve','Linha chá viver Composição com ervas, especiarias, frutas e flores de forma única e especial. A natureza em sua infinidade, traz uma riqueza de itens de diversas formas, e o Chá Viver os associa trazendo para você essa linha especial.','120g',64.00,'https://i.ibb.co/DRjRcpQ/cha1.jpg',11),(44,15,'Chá Desinchá Dia 60 Sachês 90g','O desinchá Chá 8 com Ingrediente é um chá misto composto por uma combinação de oito ingredientes naturais que promovem a desintoxicação e a redução do inchaço. A embalagem contém 60 sachês, cada um com uma porção de 1,5g, totalizando 90g de produto.O chá verde, carqueja, mate verde, hortelã, gengibre, guaraná, sálvia e alecrim são conhecidos por suas propriedades antioxidantes e diuréticas, ajudando a eliminar as toxinas e o excesso de líquidos do corpo. Além disso, o chá também pode ajudar a acelerar o metabolismo e a reduzir a sensação de fome, favorecendo a perda de peso.','90g',73.09,'https://i.ibb.co/gmfz6kJ/cha2.jpg',11),(45,15,'2 Cha Especiarias Orientais teekanne 40g','Deixe-se envolver pelos aromas exóticos e pela riqueza de sabores do Chá Especiarias com Laranja e Baunilha Teekanne 40g (20 saquinhos). Esta infusão única de especiarias, como canela, cardamomo e pimenta, combinada com o frescor da laranja e a suavidade da baunilha, transporta você para uma jornada sensorial pelo oriente.','40g',84.99,'https://i.ibb.co/XDDTNBw/cha3.jpg',12),(46,15,'Chá De Calunga - Aristolochia Cymbifera - 100G','Tem usos populares como tônica, estimulante antisséptica, sudorífica, diurética, anti-histérica, para febres graves, catarros crônicos, disenteria diarreia e contra veneno de cobra.\nAlém disso, o chá da raiz da planta é usado para aumentar a menstruação, como excitante e cicatrizante e contra úlceras crônicas, sarnas e caspas, o emprego popular da calunga também refere-se a asma, gota, convulsões, epilepsia, palpitações, flatulência, prurido (coceira), eczemas, anorexia, ansiedade, prisão de ventre e vermes intestinais.','100g',32.57,'https://i.ibb.co/kHj6b3d/cha4.jpg',12),(47,15,'Cuidatea Dia - Chá em Cápsulas','O chá perfeito para começar o seu dia. Além de ser energizante, seus componentes ajudam nos efeitos de emagrecimento e redução do stress.Chega de cansaço e tenha disposição para enfrentar todos os desafios do dia-a-dia.Ingredientes selecionados para trazer mais qualidade de vida e ajudar no excesso de peso, má digestão e estresse que são os maiores problemas de saúde segundo a OMS. Além disso, o formato de cápsulas compatíveis com o sistema Nespresso®, torna tudo mais rápido e prático.','30g',18.90,'https://i.ibb.co/yP4R7p3/cha5.jpg',13),(48,15,'Chá em Cápsulas Frtas Vermelhas','Com as Cápsulas Aroma Selezione Frutas Vermelhas - 10 unidades você terá sempre à sua disposição uma xícara de sofisticação com sabores incomparáveis. As cápsulas são compatíveis com Nespresso.','25g',13.90,'https://i.ibb.co/W28BftB/cha6.jpg',13),(49,14,'Café Gourmet Moído Baggio Chocolate com Menta 250g','Se você é fã de café com um toque de frescor, o café aromatizado Chocolate com Menta, com notas de chocolate ao leite e menta, pode ser uma excelente opção.Este café apresenta um sabor doce e fresco, com uma intensidade média e uma baixa acidez que realça seu corpo prolongado, oferecendo uma experiência sensorial única e deliciosa.','250g',24.49,'https://i.ibb.co/sqQ4RKW/Baggio.jpg',8),(50,14,'Café Gourmet Zimbro Cambraia 250g','Café Gourmet Zimbro Cambraia 250g','250g',25.49,'https://i.ibb.co/5RjV7S6/gourmet2.jpg',8),(51,14,'Orfeu Clássico - Café Moído, 250g','Orfeu Café Torrado e Moído Clássico 250g é um café especial 100% Arabica, equilibrado e com torra média. Com notas florais, frutadas e de caramelo, ele possui alta doçura, acidez equilibrada, corpo suave e aromas complexos, com um final persistente e agradável. Sua intensidade é equivalente a 6. Cultivado a uma altitude entre 1000 a 1400 metros, a colheita é feita de forma sustentável. Dada a grande preocupação e cuidado com a sustentabilidade, a Fazenda Sertãozinho tem vastas áreas de reserva, maior do que as exigências legais, e ainda planta cerca de duas mil árvores por ano, preservando a vegetação local. Além disso, as fazendas possuem certificação internacional UTZ, que compreende práticas agrícolas adequadas para a produção de café e o bem-estar dos trabalhadores, incluindo acesso à saúde e educação. Outros selos como Ecocert, Rainforest, ISO 9001:2015, USDA, Associação de Café Especial do Brasil (SCA)','250g',26.99,'https://i.ibb.co/3YGXf0F/gourmet3.jpg',9),(52,14,'Café Gourmet 3 Corações 250Gr Dark Roast','O blend do Gourmet Dark Roast 100% arábica é uma saborosa potência!\nCultivado nas nobres regiões do Sul de Minas Gerais e na Mogiana Paulista, este café possui uma torra intensa (Dark Roast) que resulta em uma bebida marcante e encorpada.\nCom notas de chocolate amargo, aroma adocicado, acidez cítrica e doçura alta este é o café perfeito para quem ama ser intenso.\n','250g',17.59,'https://i.ibb.co/jHVxzkL/gourmet4.png',9),(53,14,'Café Aviação Gourmet Torrado e Moído Pouch 500gr','Sabor intenso com notas de avelã e amêndoa, aroma frutas secas e corpo equilibrado.','250g',30.75,'https://i.ibb.co/CbTVGbQ/gourmet5.jpg',10),(54,14,'Café Gourmet Pacaembu - 500 Gramas','Ser gourmet é ser mais que especial. É combinar com perfeição grãos 100% arábica da mais alta qualidade com torra equilibrada e perfeita, proporcionando assim o prazer de degustar uma bebida exclusiva, de sabor refinado, aroma intenso e uma finalização agradável, com toque aveludado.','500g',28.90,'https://i.ibb.co/LQGsB9T/gourmet6.jpg',10),(55,13,'Café 3 Corações Torrado e Moído','Café 3 Corações torrado e moído embalado a vacuo','500g',18.99,'https://i.ibb.co/sb2xy5T/tradicional1.jpg',11),(56,13,'Café Mellita Tradicional','O Café Melitta Tradicional oferece uma combinação de grãos com ponto de torra clássica, resultando em um café balanceado com sabor forte e aroma encorpado. Grãos selecionados, torrados em suspensão e embalados a vácuo garantem sua qualidade e frescor. Ideal para todos os momentos do dia, proporciona uma experiência de café delicioso e revigorante.','500g',34.27,'https://i.ibb.co/CHmXBW6/tradicional2.jpg',11),(57,13,'Café Tradicional A Vácuo Pelé - 500g',' O Café Tradicional A Vácuo Pelé é uma escolha icônica para os amantes do café que valorizam o sabor autêntico e a qualidade superior. Produzido com grãos selecionados e cuidadosamente torrados, este café oferece uma experiência de degustação única que celebra a tradição e o sabor inconfundível do café brasileiro.','500g',15.21,'https://i.ibb.co/6Hmyt8Y/tradicional3.jpg',12),(58,13,'Café Caboclo Tradicional 500g','O Café Caboclo Tradicional 500g é uma verdadeira homenagem à rica cultura cafeeira do Brasil, trazendo consigo não apenas o aroma e o sabor inconfundíveis dos melhores grãos, mas também uma história de tradição e qualidade. Com este café, cada gole é uma jornada sensorial através das fazendas de café do país, proporcionando uma experiência autêntica e memorável a cada xícara.','500g',17.09,'https://i.ibb.co/Ry4ZZpR/tradicional4.jpg',12),(59,13,'Café Pilão Torrado E Moído Tradicional Almofada 500g','O café Pilão Tradicional torrado e moído, de intensidade 8, disponível na versão almofada de 500g, tem um ponto de torra acentuado e um processo de moagem fina e uniforme, que garantem e preservam seu sabor forte e encorpado. É perfeito para o seu dia a dia.\n','500g',24.18,'https://i.ibb.co/W6JtKth/tradicional5.jpg',13),(60,13,'Café Torrado e Moído Tradicional União 500g','O cuidado em cada detalhe é o segredo para que União traga até você um café de alta qualidade, feito com grãos selecionados e torrados uniformemente. O resultado é um café com aroma e sabor marcantes, capaz de transformar momentos em memórias inesquecíveis.\n','500g',21.33,'https://i.ibb.co/S34MZT2/tradicional6.jpg',13);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_categoria`
--

DROP TABLE IF EXISTS `produto_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) DEFAULT NULL,
  `ordem` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_categoria`
--

LOCK TABLES `produto_categoria` WRITE;
/*!40000 ALTER TABLE `produto_categoria` DISABLE KEYS */;
INSERT INTO `produto_categoria` VALUES (13,'Tradicionais',7),(14,'Gourmet',8),(15,'Chás',9),(16,'Chocolates',10),(17,'Kits',11);
/*!40000 ALTER TABLE `produto_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `dt_cadastro` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-03 16:12:03
