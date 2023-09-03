create database Oficina;
use Oficina;

-- criar tabela clientes
create table clientes(
	idCliente int auto_increment primary key,
    nomeCompleto varchar(45),
    contato varchar(15),
    tipo enum('PJ', 'PF') default 'PF',
    perfil enum('VIP', 'Padrão', 'Indicado') default 'Padrão'
);

-- criar tabela pedido
create table pedido(
	idPedido int auto_increment primary key,
    idCliente int,
    descricao varchar(255) not null,
    tipoPedido varchar(25) not null,
    prioridade enum('baixa', 'média', 'alta') default 'baixa',
    constraint fk_pedido_cliente foreign key(idCliente) references clientes(idCliente)
);

-- criar tabela responsavel
create table responsavel(
	idResponsavel int auto_increment primary key,
    setor varchar(45) not null,
    matricula varchar(15) not null,
    cargo varchar(45) not null
);

-- criação da tabela pedido gerado
create table pedido_gerado(
	idResponsavel int,
    idPedido int,
    setorResponsavel enum('help-desk', 'oficina Software', 'oficina Hardware', 'recepção', 'direção', 'administrativo') default 'help-desk',
    setorEncaminhado varchar(45) default null,
    dataCriacao datetime,
    primary key(idResponsavel, idPedido),
    constraint fk_pedido_gerado_responsavel 
		foreign key(idResponsavel) 
        references responsavel(idResponsavel),
	constraint fk_pedido_gerado_pedido
		foreign key(idPedido) 
        references pedido(idPedido)
);
-- criar tabela OS
create table OS(
    idResponsavel int,
    idPedido int,
    descricao varchar(255),
    prioridade enum('baixa', 'média', 'alta') default 'baixa',
    status enum('em andamento', 'recebido pelo setor técnico', 'aguardando peças', 'sem solução',
		'concluido com sucesso', 'entregue ao Cliente', 'finalizado'),
	primary key(idResponsavel, idPedido),
	constraint fk_pedido_gerado_OS
		foreign key(idResponsavel, idPedido) 
        references pedido_gerado(idResponsavel, idPedido)	
);

-- Populando tabela clientes
INSERT INTO clientes (nomeCompleto, contato, tipo, perfil)
VALUES
    ('João da Silva', '111111111', 'PF', 'VIP'),
    ('Maria Souza', '222222222', 'PF', 'Padrão'),
    ('Empresa ABC Ltda', '333333333', 'PJ', 'Padrão'),
    ('Fernando Oliveira', '444444444', 'PF', 'Indicado'),
    ('Ana Pereira', '555555555', 'PF', 'VIP'),
    ('Comércio XYZ Ltda', '666666666', 'PJ', 'VIP'),
    ('Lucas Santos', '777777777', 'PF', 'Padrão'),
    ('Marcos Mendes', '888888888', 'PF', 'Indicado'),
    ('Indústria 123 S/A', '999999999', 'PJ', 'Padrão'),
    ('Patricia Ribeiro', '101010101', 'PF', 'VIP'),
    ('Carlos Teixeira', '111111111', 'PF', 'Padrão'),
    ('Comércio 456 Ltda', '121212121', 'PJ', 'VIP'),
    ('Gustavo Ferreira', '131313131', 'PF', 'Indicado'),
    ('Paula Soares', '141414141', 'PF', 'Padrão'),
    ('Empresa 789 Ltda', '151515151', 'PJ', 'VIP');

-- Populando tabela pedido
INSERT INTO pedido (idCliente, descricao, tipoPedido, prioridade)
VALUES
    (1, 'Reparo no sistema operacional', 'Serviço', 'alta'),
    (2, 'Troca de tela quebrada', 'Produto', 'média'),
    (3, 'Atualização de software', 'Serviço', 'baixa'),
    (4, 'Reparo no hardware', 'Serviço', 'alta'),
    (5, 'Formatação do computador', 'Serviço', 'média'),
    (6, 'Compra de equipamentos', 'Produto', 'alta'),
    (7, 'Instalação de programas', 'Serviço', 'média'),
    (8, 'Limpeza interna do notebook', 'Serviço', 'baixa'),
    (9, 'Manutenção de impressora', 'Serviço', 'média'),
    (10, 'Venda de computador', 'Produto', 'alta'),
    (11, 'Reparo na placa-mãe', 'Serviço', 'alta'),
    (12, 'Substituição de peças', 'Serviço', 'média'),
    (13, 'Atualização de drivers', 'Serviço', 'baixa'),
    (14, 'Configuração de rede', 'Serviço', 'média'),
    (15, 'Troca de bateria', 'Produto', 'alta');

-- Populando tabela responsavel
INSERT INTO responsavel (setor, matricula, cargo)
VALUES
    ('Técnico', '12345', 'Técnico de Informática'),
    ('Administrativo', '54321', 'Assistente Administrativo'),
    ('Técnico', '67890', 'Técnico de Hardware'),
    ('Recepção', '09876', 'Recepcionista'),
    ('Direção', '45678', 'Diretor'),
    ('Help-Desk', '98765', 'Atendente Help-Desk'),
    ('Administrativo', '23456', 'Assistente Financeiro'),
    ('Técnico', '56789', 'Técnico de Software'),
    ('Help-Desk', '87654', 'Suporte Técnico'),
    ('Direção', '34567', 'Gerente'),
    ('Recepção', '65432', 'Auxiliar de Recepção'),
    ('Administrativo', '43210', 'Assistente RH'),
    ('Técnico', '89012', 'Técnico de Redes'),
    ('Help-Desk', '21098', 'Técnico de Suporte'),
    ('Recepção', '34567', 'Recepcionista');

-- Populando tabela pedido_gerado
INSERT INTO pedido_gerado (idResponsavel, idPedido, setorResponsavel, setorEncaminhado, dataCriacao)
VALUES
    (1, 1, 'help-desk', NULL, NOW()),
    (2, 2, 'oficina Software', NULL, NOW()),
    (3, 3, 'oficina Hardware', NULL, NOW()),
    (4, 4, 'recepção', NULL, NOW()),
    (5, 5, 'direção', NULL, NOW()),
    (6, 6, 'administrativo', NULL, NOW()),
    (7, 7, 'help-desk', NULL, NOW()),
    (8, 8, 'oficina Software', NULL, NOW()),
    (9, 9, 'oficina Hardware', NULL, NOW()),
    (10, 10, 'recepção', NULL, NOW()),
    (11, 11, 'direção', NULL, NOW()),
    (12, 12, 'administrativo', NULL, NOW()),
    (13, 13, 'help-desk', NULL, NOW()),
    (14, 14, 'oficina Software', NULL, NOW()),
    (15, 15, 'oficina Hardware', NULL, NOW());

-- Populando tabela OS
INSERT INTO OS (idResponsavel, idPedido, descricao, prioridade, status)
VALUES
    (1, 1, 'Problema no sistema operacional. Tela azul', 'alta', 'em andamento'),
    (2, 2, 'Tela do notebook quebrada. Necessita troca', 'média', 'recebido pelo setor técnico'),
    (3, 3, 'Atualização de software não está concluindo', 'baixa', 'aguardando peças'),
    (4, 4, 'Placa de vídeo apresenta defeito', 'alta', 'sem solução'),
    (5, 5, 'Computador com lentidão após atualização', 'média', 'concluido com sucesso'),
    (6, 6, 'Compra de 5 computadores modelo X', 'alta', 'entregue ao Cliente'),
    (7, 7, 'Instalação do pacote Office', 'média', 'finalizado'),
    (8, 8, 'Notebook aquecendo muito. Necessita limpeza', 'baixa', 'em andamento'),
    (9, 9, 'Impressora não está imprimindo', 'média', 'recebido pelo setor técnico'),
    (10, 10, 'Venda de 2 computadores modelo Y', 'alta', 'aguardando peças'),
    (11, 11, 'Reparo na placa-mãe não está concluindo', 'alta', 'sem solução'),
    (12, 12, 'Substituição de memória RAM', 'média', 'concluido com sucesso'),
    (13, 13, 'Problema de reconhecimento de dispositivo USB', 'baixa', 'entregue ao Cliente'),
    (14, 14, 'Configuração de rede para acesso à internet', 'média', 'finalizado'),
    (15, 15, 'Troca de bateria de celular', 'alta', 'aguardando peças');
    
    -- Ver todos os clientes
SELECT * FROM clientes;

-- Pedidos com prioridade alta
SELECT * FROM pedido WHERE prioridade = 'alta';

-- Responsáveis por matrícula e em ordem crescente
SELECT * FROM responsavel ORDER BY matricula ASC;

-- Pedidos e seus clientes associados
SELECT p.*, c.nomeCompleto AS nomeCliente FROM pedido p
JOIN clientes c ON p.idCliente = c.idCliente;

-- Contar o número de clientes do tipo Pessoa Jurídica (PJ)
SELECT COUNT(*) AS numeroClientesPJ FROM clientes WHERE tipo = 'PJ';

-- Contar o número de pedidos em cada prioridade
SELECT prioridade, COUNT(*) AS numeroPedidos FROM pedido GROUP BY prioridade;

-- Calcular o total de pedidos para cada cliente
SELECT c.nomeCompleto AS cliente, COUNT(p.idPedido) AS totalPedidos FROM clientes c
LEFT JOIN pedido p ON c.idCliente = p.idCliente
GROUP BY c.idCliente, c.nomeCompleto;

-- Selecionar os pedidos gerados por responsáveis do setor 'oficina Hardware'
SELECT pg.* FROM pedido_gerado pg
WHERE pg.idResponsavel IN (SELECT idResponsavel FROM responsavel WHERE setorResponsavel = 'oficina Hardware');
