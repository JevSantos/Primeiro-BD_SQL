Create database  if not exists Ecommerce;
use Ecommerce;
-- drop database Ecommerce;
-- criar tabela de clientes
-- drop table seller;
create table clients(
	idClient int auto_increment primary key,
    Fnome varchar(15) not null,
    Minit char(3),
    LName varchar(20) not null,
	CPF char(11) not null,
    Adress varchar(50) not null,
    constraint unique_cpf_client unique (CPF)
);

-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(30) not null,
    classfication_kids bool,
    category enum('eletrônico', 'vestuário', 'brinquedos', 'Alimentos') not null,
    rating float default 0,
    size varchar(10)
);
-- criar tabela pagamento
create table payments(
	idPayment int,
    idClient int,
    typePayment enum('Boleto', 'cartão', 'Dois cartões'),
    limitAvaliable float,
    primary key (idPayment, idClient)
);

-- criar tabela pedido
create table request(
	idRequest int auto_increment primary key,
    idClient int,
    status enum('Processando', 'cancelado', 'confirmado') default 'Processando',
    description varchar(255),
    freightage float default 10,
    paymentCash bool default false,
    idPayment int,
    constraint fk_request_client foreign key(idClient) references clients(idClient),
    constraint fk_request_Payment foreign key(idPayment, idClient) references payments(idPayment, idClient)
);

-- criar tabela estoque
create table productStorage(
	idProductStarage int primary key,
    location varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor
drop table Supplier;
create table Supplier(
	idSupplier int primary key,
    CNPJ char(15) not null,
    socialName varchar(255) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);
-- criar tabela vendedor
create table seller(
	idSeller int primary key,
    CNPJ char(15),
    CPF char(9),
    socialName varchar(255) not null,
    AbsName varchar(255),
    contact char(11) not null,
    Adress varchar(255),
    constraint unique_CPF_seller unique(CPF),
    constraint unique_CNPJ_seller unique(CNPJ)
);

-- criar relacionamento produto_vendedor

create table product_seller(
	idproduct int,
    idSeller int,
    quantity int default 1,
    primary key(idProduct, idSeller),
    constraint fk_product_seller foreign key(idSeller) references seller(idSeller),
    constraint fk_product_product foreign key(idProduct) references product(idProduct)
);

-- criar tabela de relacionamento produto_pedido
create table product_request(
	idProduct int,
    idRequest int,
    quantity int,
    status enum('Processando', 'cancelado', 'confirmado') default 'Processando',
    primary key(idProduct, idRequest),
    constraint fk_product_request foreign key(idProduct) references product(idProduct),
    constraint fk_request_product foreign key(idRequest) references request(idRequest)
);

-- criar tabela estoque
create table storage_location(
	idProduct int,
    idStorage int,
    location varchar(255) not null,
    primary key (idProduct, idStorage),
    constraint fk_storage_location_product foreign key(idProduct) references product(idProduct),
    constraint fk_storage_product foreign key(idStorage) references productStorage(idProductStarage)
);


-- criar tabela de relacionameto produto/fornecedor
create table productSupplier(
	idSupplier int,
    idProduct int,
    quantity int not null,
    primary key (idSupplier, idProduct),
    constraint fk_supplier_supplier foreign key(idSupplier) references Supplier(idSupplier),
    constraint fk_product_supplier foreign key(idProduct) references product(idProduct)
);

-- Populando tabela clients
INSERT INTO clients (Fnome, Minit, LName, CPF, Adress)
VALUES
    ('João', 'A', 'Silva', '11111111111', 'Rua dos Lírios, 123'),
    ('Maria', 'B', 'Santos', '22222222222', 'Avenida das Rosas, 456'),
    ('Pedro', 'C', 'Almeida', '33333333333', 'Travessa das Flores, 789'),
    ('Ana', 'D', 'Oliveira', '44444444444', 'Rua das Árvores, 321'),
    ('Lucas', 'E', 'Pereira', '55555555555', 'Avenida das Pedras, 654');
    
INSERT INTO product (Pname, classfication_kids, category, rating, size)
VALUES
    ('Smartphone', false, 'eletrônico', 4.5, 'Grande'),
    ('Camiseta', true, 'vestuário', 3.8, 'M'),
    ('Boneca', true, 'brinquedos', 4.2, 'Pequeno'),
    ('Notebook', false, 'eletrônico', 4.1, 'Médio'),
    ('Bola', true, 'brinquedos', 3.9, 'Único');

-- Populando tabela payments
INSERT INTO payments (idPayment, idClient, typePayment, limitAvaliable)
VALUES
    (1, 5, 'Boleto', 500),
    (2, 2, 'cartão', 1000),
    (3, 3, 'Dois cartões', 800),
    (4, 4, 'Boleto', 300),
    (5, 5, 'cartão', 750);

-- Populando tabela request
INSERT INTO request (idClient, status, description, freightage, paymentCash, idPayment)
VALUES
    (1, 'Processando', 'Pedido 1', 12.5, true, 1),
    (2, 'confirmado', 'Pedido 2', 8.0, false, 2),
    (3, 'cancelado', 'Pedido 3', 15.2, false, 3),
    (4, 'confirmado', 'Pedido 4', 10.0, true, 4),
    (5, 'Processando', 'Pedido 5', 20.0, false, 5);

-- Populando tabela productStorage
INSERT INTO productStorage (idProductStarage, location, quantity)
VALUES
    (1, 'Estoque 1', 100),
    (2, 'Estoque 2', 50),
    (3, 'Estoque 3', 200),
    (4, 'Estoque 4', 75),
    (5, 'Estoque 5', 300);

-- Populando tabela Supplier
INSERT INTO Supplier (idSupplier, CNPJ, socialName, contact)
VALUES
    (1, '11111111111111', 'Fornecedor 1 Ltda.', '11111111111'),
    (2, '22222222222222', 'Fornecedor 2 S/A', '22222222222'),
    (3, '33333333333333', 'Fornecedor 3 EIRELI', '33333333333'),
    (4, '44444444444444', 'Fornecedor 4 MEI', '44444444444'),
    (5, '55555555555555', 'Fornecedor 5 LTDA', '55555555555');

-- Populando tabela seller
INSERT INTO seller (idSeller, CNPJ, CPF, socialName, AbsName, contact, Adress)
VALUES
    (1, '111111111', '111111111', 'Vendedor 1', 'Vendedor A', '11111111111', 'Rua X, 789'),
    (2, '222222222', '222222222', 'Vendedor 2', 'Vendedor B', '22222222222', 'Avenida Y, 456'),
    (3, '333333333', '333333333', 'Vendedor 3', 'Vendedor C', '33333333333', 'Rua Z, 123'),
    (4, '444444444', '444444444', 'Vendedor 4', 'Vendedor D', '44444444444', 'Rua W, 987'),
    (5, '555555555', '555555555', 'Vendedor 5', 'Vendedor E', '55555555555', 'Avenida V, 654');

-- Populando tabela product_seller
INSERT INTO product_seller (idproduct, idSeller, quantity)
VALUES
    (1, 1, 10),
    (2, 1, 5),
    (3, 2, 8),
    (4, 2, 15),
    (5, 3, 3);

-- Populando tabela product_request
INSERT INTO product_request (idProduct, idRequest, quantity, status)
VALUES
    (1, 1, 2, 'confirmado'),
    (2, 1, 1, 'cancelado'),
    (3, 2, 3, 'confirmado'),
    (4, 2, 1, 'Processando'),
    (5, 3, 5, 'confirmado');

-- Populando tabela storage_location
INSERT INTO storage_location (idProduct, idStorage, location)
VALUES
    (1, 1, 'Estoque 1, Prateleira A'),
    (2, 2, 'Estoque 2, Prateleira B'),
    (3, 3, 'Estoque 3, Prateleira C'),
    (4, 4, 'Estoque 4, Prateleira D'),
    (5, 5, 'Estoque 5, Prateleira E');

-- Populando tabela productSupplier
INSERT INTO productSupplier (idSupplier, idProduct, quantity)
VALUES
    (1, 1, 50),
    (2, 1, 100),
    (3, 2, 30),
    (4, 3, 70),
    (5, 3, 40);


-- categoria do prods e a soma em estoque para por categoria
SELECT category, SUM(quantity) AS total_quantity
FROM productSupplier
INNER JOIN product ON productSupplier.idProduct = product.idProduct
GROUP BY category;


