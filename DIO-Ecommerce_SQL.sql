create database ecommerce;
use ecommerce;

-- tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;
alter table clients modify Address varchar(100);
alter table clients add idTipoCliente int;
alter table clients add constraint unique_tipo_cliente unique (idTipoCliente);
ALTER TABLE clients DROP INDEX unique_tipo_cliente;


desc clients;

-- tabela produto
create table product(
	idProduct int auto_increment primary key,
    Fname varchar(10) not null,
    classification_kids bool default false,
    category enum(Eletrônicos,Vestimentos,Brinquedos,Alimentos,Móveis) not null,
    avaliação float default 0,
    size varchar(10)
);

alter table product modify Fname varchar(50);

-- constraints relacionadas ao pagamento
create table payments(
	idclient int,
    idPayment int,
    typePayment enum(Boleto,Cartão,Dois cartões, Pix),
    limiteAvailable float,
    primary key(idClient, idPayment)
);


-- tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum(Cancelado,Confirmado,Em processamento) default Em processamento,
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false, 
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
				on update cascade
  );
 
 alter table orders modify orderStatus enum(Cancelado,Confirmado,Em processamento) default Em processamento;

  
desc orders;

-- tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

desc supplier;

-- tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255) not null,
    CNPJ char(15),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

alter table seller modify AbstName varchar(255);

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idseller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;

create table productOrder(
	idOProduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum(Disponível,Sem estoque) default Disponível,
    primary key (idOProduct, idPOorder),
    constraint fk_productorder_seller foreign key (idOProduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

desc productSupplier;


CREATE TABLE Pagamento (
  idPagamento INT NOT NULL AUTO_INCREMENT,
  Descrição VARCHAR(45) NOT NULL,
  PRIMARY KEY (idPagamento));

CREATE TABLE FormaPagamento (
  idFormaPagamento INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  DataDeValidade DATE NULL,
  NúmeroDoCartão VARCHAR(45) NULL,
  CódigoDeBarras VARCHAR(45) NULL,
  Agência VARCHAR(45) NULL,
  NúmeroDaConta VARCHAR(45) NULL,
  Pagamento_idPagamento INT NOT NULL,
  PRIMARY KEY (idFormaPagamento, Pagamento_idPagamento),
  CONSTRAINT fk_FormadePagamento_Pagamento1
    FOREIGN KEY (Pagamento_idPagamento)
    REFERENCES Pagamento (idPagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE TipoCliente (
  idTipoCliente INT NOT NULL AUTO_INCREMENT,
  Descrição ENUM('PJ', 'PF') NOT NULL,
  PRIMARY KEY (idTipoCliente));
  
desc clients;
desc orders;
desc TipoCliente;

CREATE TABLE Entrega (
  idEntrega INT NOT NULL AUTO_INCREMENT,
  Status_da_Entrega VARCHAR(45) NULL,
  Código_de_rastreio VARCHAR(45) NULL,
  idOrderEntrega INT NOT NULL,
  idClientEntrega INT NOT NULL,
  PRIMARY KEY (idEntrega, idOrderEntrega, idClientEntrega),
  CONSTRAINT fk_Entrega_Pedido1     FOREIGN KEY (idOrderEntrega)     REFERENCES orders(idOrder),
  CONSTRAINT fk_Entrega_Pedido2     FOREIGN KEY (idClientEntrega)     REFERENCES orders(idOrderClient)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

desc Entrega;

show databases;

use information_schema;
show tables;
desc REFERENTIAL_CONSTRAINTS;
select * from referential_constraints where constraint_schema = ecommerce;



