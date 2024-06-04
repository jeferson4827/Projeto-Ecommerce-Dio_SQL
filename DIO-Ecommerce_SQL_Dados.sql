use ecommerce;


desc clients;

show tables;

-- idClient, Fname, Minit, Lname, Address

insert into clients (Fname, Minit, Lname, CPF, Address)
		values('Leonida', 'M', 'Sabino', 12346789, 'R. Delta 236, Sao João - Jundiai' ), 
		    ('Sara', 'D', 'Sabino', 987654321, 'R.Frederico 46, Centro - Capivari' ), 
		    ('Alice', 'D', 'Sabino', 24682468, 'Av.01 401 , Centro - Itaqua' ), 
		    ('Raquel', 'L', 'Pucineli', 700123456, 'R.Ozanam 61, Residencial - Franco da rocha' ), 
		    ('Marcelo', 'G', 'Santos', 98777731, 'Av Martin 14, Centro - Caieiras' );


select * from clients;

desc product;
-- idProduct, Fname, classification_kids boolean, category('Eletrônicos', 'Vestimentos', 'Brinquedos', 'Alimentos','Móveis'), avaliação, size

INSERT INTO product (Fname, classification_kids, category, avaliação, size)
  VALUES ('Oleo de lavanda', false, 'Cosmeticos', 25, null),
  		('Camisa stich', true, 'Vestimentos', 20, null),
  		('Blusa skate', true, 'Vestimentos', 55, null),
  		('Smart Tv 42', false, 'Eletrônicos', 13, null),
  		('Cama box', false, 'Móveis', 1, '4x77x90'),
  		('Salgadinho Doritos', false, 'Alimentos', 15, null),
  		('Celular xiaomi', false, 'Eletrônicos', 6, null);

select * from product;

desc orders;

delete from orders where idOrderClient in (1,2,3,4);

INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES
			(1, default, 'compra via aplicativo', null, 1),
			(2, default, 'compra via aplicativo', 50, 0),
			(3, 'Confirmado', null, null, 1),
			(4, default, 'compra via web site', 150, 0);

select * from orders;

desc productOrder;

INSERT INTO productOrder (idOProduct, idPOorder, poQuantity, poStatus) VALUES
			(1,9,2,null),
			(2,9,1,null),
			(3,10,1,null);

select * from productOrder;


DESC productStorage;

INSERT INTO productStorage(storageLocation, quantity) VALUES
			('Niteroi', 1000),
			('Niteroi', 500),
			('Guarulhos', 10),
			('Guarulhos', 100),
			('Guarulhos', 10),
			('Goiania', 60);

SELECT * FROM productStorage;

INSERT INTO storageLocation (idlproduct, idLstorage, location) VALUES
			(1,2,'RJ'),
			(2,6,'GO');


SELECT * FROM storageLocation;

desc supplier;

INSERT INTO supplier (SocialName, CNPJ, contact) VALUES
			('Adahlia Brasil', 123456789123456, '33318999'),
			('G2W Comercio', 123456987654321, '333188888'),
			('BTJ Tecnologia', 98754321123456, '33318777');


SELECT * FROM supplier;

INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
			(1,1,500),
			(1,2,400),
			(2,4,633),
			(3,3,5),
			(2,5,10);

SELECT * FROM productSupplier;

desc seller;

INSERT INTO seller(SocialName, AbstName, CNPJ, CPF, location, contact) VALUES
			('Adahlia Brasil', null, 123456789123456, null, 'Guarulhos', 33318999),
			('G2W Comercio', null, 123456987654321, null, 'Niteroi', 333188888),
			('BTJ Tecnologia', null, 98754321123456, null, 'Goiania', 33318777);


desc productSeller;

INSERT INTO productSeller(idPseller, idPproduct, prodQuantity) VALUES
			(1,6,80),
			(2,7,10);

SELECT * FROM productSeller;

desc TipoCliente;

INSERT INTO TipoCliente (Descrição) VALUES
			('PJ'),
			('PF');

SELECT * from TipoCliente;			


desc Pagamento;

INSERT INTO Pagamento(Descrição) VALUES
			('Boleto'),
			('Cartão de Crédito'),
			('Pix'),
			('Débito em Conta');

SELECT * FROM Pagamento;

SELECT * FROM clients;

UPDATE clients SET idTipoCliente = 2 WHERE idClient = 1;
UPDATE clients SET idTipoCliente = 1 WHERE idClient = 2;
UPDATE clients SET idTipoCliente = 1 WHERE idClient = 3;


desc FormaPagamento;

INSERT INTO FormaPagamento (Nome)


desc clients;
desc orders;

-- Número de cliente
SELECT count(*) FROM clients;


-- Número de pedidos realizados
SELECT * FROM clients c, orders o WHERE c.idClient = idOrderClient;


-- Número de pedidos realizados e seus atributos
SELECT concat(Fname, ' ', Lname) as Client,
	idOrder as Request,
	orderStatus as Status
FROM clients c,
	orders o
WHERE c.idClient = idOrderClient;



INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES
			(2, default, 'compra via aplicativo', null, 1);


SELECT count(*)
FROM clients c,
	orders o
WHERE c.idClient = idOrderClient
GROUP BY idOrder;

-- Clientes que não fizeram pedido
SELECT * FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient;


-- Pedidos com produto associado
SELECT c.idClient,
	Fname,
	count(*) as Number_of_Orders
FROM clients c
	INNER JOIN orders o ON c.idClient = o.idOrderClient
	INNER JOIN productOrder p ON p.idPOorder = o.idOrder
GROUP BY c.idClient;




