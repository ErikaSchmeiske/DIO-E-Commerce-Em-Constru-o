/* criando a tabalea cliente */

create table clients (
idClient int auto_increment primary key,
Fname varchar(15),
Mname varchar(10),
Lnome varchar(20),
CPF char(11) not null,
Address varchar(30),
constraint unique_cpf_client unique (CPF)
);
/*alter table clients auto_increment =1;
alter table clients Address varchar(255);*/
desc clients;

/* criando a tabela produto 
size = *dimensão do produto */
create table product (
idProduct int auto_increment primary key,
Pname varchar (15),
classification_kids bool default false,
category enum ("Eletronico", "Vestimenta", "Brinquedo", "Alimento", "Moveis") not null,
avaliacao float default 0,
size varchar(10)
);
alter table product auto_increment =1;

desc product;
/* criando a tabela pagamentos */
/* terminar de implementar a tabela com as conexões necessárias. Refletir no esquema de diagramas (relacional) */
/* criar as constraints relacionadas ao pagamento */

/*create table  payments(
idClient int primary key,
idPayment int,
typePayment enum ("Boleto", "Dinheiro", "Cartão Debito", "Cartao Credito"),
limitAvailable float,
dateValid date,
primary key (idClient, idPayment)
);    */

/*criando a tabela pedido */

create table orders(
 idOrders int auto_increment primary key,
 idOrderClient int,
 OrderStatus enum("Cancelado", "Confirmado", "Em Processamento") default "Em Processamento",
 Orderdescription varchar(255),
 ShippingValue float default 10,
 paymentCash bool default false,
 constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
		/*on update cascade */
        /* on delete set null -o quer seria esse comando? exclui uma linha */
);

alter table orders auto_increment =1;
desc orders;

/*criando a tabela Estoque */

drop table productStorage; 

create table productStorage(
idProductStorage int auto_increment primary key,
storagelocation varchar(255),
storageQty int default 0
);
alter table productStorage auto_increment =1;
/*crianado a tabela Fornecedor */

create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar(30)  not null,
CNPJ char(15) not null,
contact char(11) not null,
constraint unique_supplier unique(CNPJ)
);
alter table supplier auto_increment =1;
desc supplier;

/*criando a tabela vendedor */
create table vendor(
idVendor int auto_increment primary key,
SocialName varchar(30)  not null,
FantasyName varchar(255),
CNPJ char(15),
CPF char(11),
location varchar(255),
contact char(11) not null,
constraint unique_cnpj_vendor unique(CNPJ),
constraint unique_cpf_vendor unique(CPF)
);
alter table vendor auto_increment =1;

create table productSeller(
idPseller int,
idProduct int,
prodQuantity int default 1,
primary key (idPseller, idProduct),
constraint fk_product_seller foreign key (idPseller) references vendor(idVendor),
constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

desc productSeller;


create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum("Em Estoque","Indisponivel") default "Em Estoque",
primary key (idPOproduct, idPOorder),
constraint fk_productorder_vendor foreign key (idPOproduct) references product(idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrders)
);

create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255),
primary key (idLproduct, idLstorage),
constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
);

desc storageLocation;


create table productSupplier(
idPsupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
/*show tables;

show schemas;

use information_schema;
show tables;

desc referential_constraints;

select * from referential_constraints where constraint_schema = "ecommerce";

use ecommerce; */

/* INSERINDO VALORES NAS TABELAS */

insert into clients (Fname, Mname, Lnome, CPF, Address)
	values 	("João", "S", "Silva", 12345677788, "Rua X,23 Curitiba"),
			("Mateus", "O", "Oliveira", 45678933366, "Rua Y Bairro Laranja - Curitiba/PR");

insert into product (Pname, classification_kids, category, avaliacao, size)
	values 	("Fone de Ouvido", false, "Eletronico", 4, null),
			("Barbie", true, "Brinquedo", 1, null);
desc orders;

insert into orders (idOrderClient, OrderStatus, Orderdescription, ShippingValue, paymentCash)
	values	(1, default, "via aplicativo", 50, 0),
			(2, "Confirmado", null, null, 1);

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select Fname, Lnome,idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname, " ", Lnome) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

select * from clients c, orders o 
	where c.idClient = idOrderClient
    group by idOrder;

select * from clients left
	outer join on c.idClient = idOrderClient
    inner join product on ;