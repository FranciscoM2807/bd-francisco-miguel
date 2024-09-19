DROP DATABASE IF EXISTS Restaurante;

CREATE DATABASE Restaurante;

USE Restaurante;

-- Filiais
CREATE TABLE IF NOT EXISTS Filiais(
    ID_filial int(3) AUTO_INCREMENT,
    Endereco varchar(255),
    Email varchar(255),
    Telefone varchar(12),
    Quant_mesas int(3),
    Avaliacao decimal(4,2),
    PRIMARY KEY (ID_filial)
);

-- Clientes
CREATE TABLE IF NOT EXISTS Clientes(
    ID_cliente int(8) AUTO_INCREMENT,
    CPF varchar(11) not null,
    Nome varchar(255),
    Username varchar(255) NOT NULL,
    Senha varchar(255) NOT NULL,
    Sexo varchar(255),
    Idade varchar(3),
    Endereco varchar(255),
    Email varchar(255),
    Telefone varchar(12),
    Data_cadastro datetime,
    ID_filial int(3),
    PRIMARY KEY (ID_cliente),
    FOREIGN KEY (ID_filial) REFERENCES Filiais(ID_filial)
);

-- Funcionários
CREATE TABLE IF NOT EXISTS Funcionarios(
    ID_func int(5) AUTO_INCREMENT,
    CPF varchar(11) not null,
    Nome varchar(255),
    Sexo varchar(255),
    Idade varchar(3),
    Endereco varchar(255),
    Email varchar(255),
    Telefone varchar(12),
    ID_filial int(3),
    Cargo varchar(255),
    Data_contatacao datetime,
    PRIMARY KEY (ID_func),
    FOREIGN KEY (ID_filial) REFERENCES Filiais(ID_filial)
);

-- Reservas
CREATE TABLE IF NOT EXISTS Reservas(
    ID_reserva int(5) AUTO_INCREMENT not null,
    Data_reserva datetime,
    ID_cliente int(8),
    Mesa varchar(5),
    ID_filial int(3),
    Capacidade varchar(2),
    PRIMARY KEY (ID_reserva),
    FOREIGN KEY (ID_cliente) REFERENCES Clientes(ID_cliente),
    FOREIGN KEY (ID_filial) REFERENCES Filiais(ID_filial)
);

-- Fornecedores
CREATE TABLE IF NOT EXISTS Fornecedores(
    Nome varchar(255),
    ID_fornecedor int(5) AUTO_INCREMENT,
    CNPJ varchar(14),
    Tipo_material varchar(255),
    Email varchar(255),
    Telefone varchar(12),
    Valor_material decimal(8,2),
    PRIMARY KEY (ID_fornecedor)
);

-- Estoque
CREATE TABLE IF NOT EXISTS Estoque(
    ID_fornecedor int(5),
    ID_materia int(6) AUTO_INCREMENT,
    Quantidade int(5),
    ID_filial int(3),
    PRIMARY KEY (ID_materia),
    FOREIGN KEY (ID_fornecedor) REFERENCES Fornecedores(ID_fornecedor),
    FOREIGN KEY (ID_filial) REFERENCES Filiais(ID_filial)
);

-- Pratos
CREATE TABLE IF NOT EXISTS Pratos(
    ID_prato int(3) AUTO_INCREMENT,
    Nome varchar(255),
    Descricao varchar(255),
    Valor decimal(5,2),
    PRIMARY KEY (ID_prato)
);

-- Bebidas
CREATE TABLE IF NOT EXISTS Bebidas(
    ID_bebida int(3) AUTO_INCREMENT,
    Nome varchar(255),
    Descricao varchar(255),
    Valor decimal (4,2),
    PRIMARY KEY (ID_bebida)
);

-- Ingredientes
CREATE TABLE IF NOT EXISTS Ingredientes(
    ID_ingrediente int(3) AUTO_INCREMENT,
    Nome varchar(255),
    Unidade_medida varchar(255),
    ID_prato int(3),
    ID_bebida int(3),
    PRIMARY KEY (ID_ingrediente),
    FOREIGN KEY (ID_prato) REFERENCES Pratos(ID_prato),
    FOREIGN KEY (ID_bebida) REFERENCES Bebidas(ID_bebida)
);

-- Pedidos
CREATE TABLE IF NOT EXISTS Pedidos(
    ID_pedido int(8) AUTO_INCREMENT,
    ID_cliente int(8),
    ID_prato int(2),
    ID_bebida int(3),
    Valor decimal(4,2),
    Tipo_pagamento varchar(255),
    Endereco varchar(255),
    Data_pedido datetime,
    PRIMARY KEY (ID_pedido),
    FOREIGN KEY (ID_cliente) REFERENCES Clientes(ID_cliente),
    FOREIGN KEY (ID_prato) REFERENCES Pratos(ID_prato),
    FOREIGN KEY (ID_bebida) REFERENCES Bebidas(ID_bebida)
);

-- Entregas
CREATE TABLE IF NOT EXISTS Entregas(
    ID_entrega int(5) AUTO_INCREMENT,
    Endereco varchar(255),
    ID_pedido int(8),
    Data_entrega datetime,
    PRIMARY KEY (ID_entrega),
    FOREIGN KEY (ID_pedido) REFERENCES Pedidos(ID_pedido)
);

-- Inserir dados em tabela Filiais
INSERT INTO Filiais (Endereco, Email, Telefone, Quant_mesas, Avaliacao) VALUES
('Rua K, 123', 'filial1@restaurante.com', '1111111111', 10, 4.5),
('Rua L, 456', 'filial2@restaurante.com', '2222222222', 20, 4.0),
('Rua M, 789', 'filial3@restaurante.com', '3333333333', 15, 4.2),
('Rua N, 101', 'filial4@restaurante.com', '4444444444', 12, 4.7),
('Rua O, 202', 'filial5@restaurante.com', '5555555555', 18, 4.3);

-- Inserir dados em tabela Clientes
INSERT INTO Clientes (CPF, Nome, Username, Senha, Sexo, Idade, Endereco, Email, Telefone, Data_cadastro, ID_filial) VALUES 
('12345678901', 'Maria Silva', 'mariasilva', 'senha123', 'Feminino', '25', 'Rua A, 123', 'maria.silva@gmail.com', '9876543210', '2023-01-01 10:00:00', 1),
('23456789012', 'João Souza', 'joaosouza', 'senha234', 'Masculino', '30', 'Rua B, 456', 'joao.souza@gmail.com', '9876543211', '2023-01-02 11:00:00', 2),
('34567890123', 'Ana Pereira', 'anapereira', 'senha345', 'Feminino', '22', 'Rua C, 789', 'ana.pereira@gmail.com', '9876543212', '2023-01-03 12:00:00', 3),
('45678901234', 'Carlos Santos', 'carlossantos', 'senha456', 'Masculino', '28', 'Rua D, 101', 'carlos.santos@gmail.com', '9876543213', '2023-01-04 13:00:00', 4),
('56789012345', 'Julia Oliveira', 'juliaoliveira', 'senha567', 'Feminino', '26', 'Rua E, 202', 'julia.oliveira@gmail.com', '9876543214', '2023-01-05 14:00:00', 5),
('67890123456', 'Pedro Lima', 'pedrolima', 'senha678', 'Masculino', '29', 'Rua F, 303', 'pedro.lima@gmail.com', '9876543215', '2023-01-06 15:00:00', 1),
('78901234567', 'Mariana Costa', 'marianacosta', 'senha789', 'Feminino', '27', 'Rua G, 404', 'mariana.costa@gmail.com', '9876543216', '2023-01-07 16:00:00', 2),
('89012345678', 'Lucas Almeida', 'lucasalmeida', 'senha890', 'Masculino', '24', 'Rua H, 505', 'lucas.almeida@gmail.com', '9876543217', '2023-01-08 17:00:00', 3),
('90123456789', 'Larissa Carvalho', 'larissacarvalho', 'senha901', 'Feminino', '23', 'Rua I, 606', 'larissa.carvalho@gmail.com', '9876543218', '2023-01-09 18:00:00', 4),
('01234567890', 'Ricardo Araújo', 'ricardoaraujo', 'senha012', 'Masculino', '31', 'Rua J, 707', 'ricardo.araujo@gmail.com', '9876543219', '2023-01-10 19:00:00', 5);

-- Inserir dados em tabela Funcionarios
INSERT INTO Funcionarios (CPF, Nome, Sexo, Idade, Endereco, Email, Telefone, ID_filial, Cargo, Data_contatacao) VALUES
('11111111111', 'José da Silva', 'Masculino', '35', 'Rua U, 808', 'jose.silva@gmail.com', '1212121212', 1, 'Garçom', '2023-02-01 10:00:00'),
('22222222222', 'Ana de Souza', 'Feminino', '28', 'Rua V, 909', 'ana.souza@gmail.com', '1313131313', 2, 'Cozinheira', '2023-02-02 11:00:00'),
('33333333333', 'Pedro Ferreira', 'Masculino', '30', 'Rua W, 101', 'pedro.ferreira@gmail.com', '1414141414', 3, 'Gerente', '2023-02-03 12:00:00'),
('44444444444', 'Mariana Costa', 'Feminino', '26', 'Rua X, 202', 'mariana.costa@gmail.com', '1515151515', 4, 'Atendente', '2023-02-04 13:00:00'),
('55555555555', 'Lucas Pereira', 'Masculino', '32', 'Rua Y, 303', 'lucas.pereira@gmail.com', '1616161616', 5, 'Chef', '2023-02-05 14:00:00'),
('66666666666', 'Larissa Almeida', 'Feminino', '29', 'Rua Z, 404', 'larissa.almeida@gmail.com', '1717171717', 1, 'Auxiliar de Cozinha', '2023-02-06 15:00:00'),
('77777777777', 'Ricardo Gomes', 'Masculino', '34', 'Rua AA, 505', 'ricardo.gomes@gmail.com', '1818181818', 2, 'Gerente', '2023-02-07 16:00:00'),
('88888888888', 'Fernanda Santos', 'Feminino', '27', 'Rua BB, 606', 'fernanda.santos@gmail.com', '1919191919', 3, 'Cozinheira', '2023-02-08 17:00:00'),
('99999999999', 'Carlos Oliveira', 'Masculino', '31', 'Rua CC, 707', 'carlos.oliveira@gmail.com', '2020202020', 4, 'Garçom', '2023-02-09 18:00:00'),
('00000000000', 'Julia Araújo', 'Feminino', '33', 'Rua DD, 808', 'julia.araujo@gmail.com', '2121212121', 5, 'Atendente', '2023-02-10 19:00:00');

-- Inserir dados em tabela Reservas
INSERT INTO Reservas (Data_reserva, ID_cliente, Mesa, ID_filial, Capacidade) VALUES
('2023-03-01 19:00:00', 1, 'M1', 1, '4'),
('2023-03-02 20:00:00', 2, 'M2', 2, '2'),
('2023-03-03 21:00:00', 3, 'M3', 3, '6'),
('2023-03-04 18:00:00', 4, 'M4', 4, '8'),
('2023-03-05 19:30:00', 5, 'M5', 5, '4'),
('2023-03-06 20:30:00', 6, 'M6', 1, '2'),
('2023-03-07 21:30:00', 7, 'M7', 2, '6'),
('2023-03-08 18:30:00', 8, 'M8', 3, '8'),
('2023-03-09 19:00:00', 9, 'M9', 4, '4'),
('2023-03-10 20:00:00', 10, 'M10', 5, '2');

-- Inserir dados em tabela Fornecedores
INSERT INTO Fornecedores (Nome, CNPJ, Tipo_material, Email, Telefone, Valor_material) VALUES
('Fornecedor 1', '11111111111111', 'Carne', 'fornecedor1@fornecedor.com', '1234567890', 500.00),
('Fornecedor 2', '22222222222222', 'Vegetais', 'fornecedor2@fornecedor.com', '2234567890', 300.00),
('Fornecedor 3', '33333333333333', 'Frutas', 'fornecedor3@fornecedor.com', '3234567890', 200.00),
('Fornecedor 4', '44444444444444', 'Laticínios', 'fornecedor4@fornecedor.com', '4234567890', 400.00),
('Fornecedor 5', '55555555555555', 'Bebidas', 'fornecedor5@fornecedor.com', '5234567890', 350.00),
('Fornecedor 6', '66666666666666', 'Condimentos', 'fornecedor6@fornecedor.com', '6234567890', 150.00),
('Fornecedor 7', '77777777777777', 'Cereais', 'fornecedor7@fornecedor.com', '7234567890', 250.00),
('Fornecedor 8', '88888888888888', 'Legumes', 'fornecedor8@fornecedor.com', '8234567890', 100.00),
('Fornecedor 9', '99999999999999', 'Pães', 'fornecedor9@fornecedor.com', '9234567890', 450.00),
('Fornecedor 10', '00000000000000', 'Doces', 'fornecedor10@fornecedor.com', '0234567890', 550.00);

-- Inserir dados em tabela Estoque
INSERT INTO Estoque (ID_fornecedor, Quantidade, ID_filial) VALUES
(1, 100, 1),
(2, 200, 2),
(3, 150, 3),
(4, 250, 4),
(5, 300, 5),
(6, 350, 1),
(7, 400, 2),
(8, 450, 3),
(9, 500, 4),
(10, 550, 5);

-- Inserir dados em tabela Pratos
INSERT INTO Pratos (Nome, Descricao, Valor) VALUES
('Bife à Parmegiana', 'Bife empanado com molho de tomate e queijo', 25.90),
('Lasanha de Frango', 'Lasanha recheada com frango desfiado', 22.50),
('Spaghetti Carbonara', 'Macarrão com molho à base de ovos e bacon', 20.00),
('Salmão Grelhado', 'Filé de salmão grelhado com ervas', 30.90),
('Frango à Milanesa', 'Filé de frango empanado e frito', 18.90),
('Feijoada', 'Prato típico brasileiro com feijão preto e carnes', 35.00),
('Arroz de Polvo', 'Arroz com pedaços de polvo e temperos', 28.50),
('Risoto de Camarão', 'Risoto cremoso com camarão', 32.00),
('Filé Mignon', 'Filé de carne bovina grelhado', 40.00),
('Moqueca de Peixe', 'Peixe cozido com leite de coco e dendê', 27.50);

-- Inserir dados em tabela Bebidas
INSERT INTO Bebidas (Nome, Descricao, Valor) VALUES
('Refrigerante', 'Bebida gaseificada', 5.00),
('Suco de Laranja', 'Suco natural de laranja', 7.00),
('Água Mineral', 'Água engarrafada sem gás', 3.00),
('Cerveja', 'Bebida alcoólica fermentada', 8.00),
('Vinho Tinto', 'Vinho produzido a partir de uvas tintas', 20.00),
('Caipirinha', 'Coquetel de cachaça com limão', 15.00),
('Whisky', 'Bebida alcoólica destilada de grãos', 25.00),
('Café Expresso', 'Café feito sob pressão', 4.00),
('Chá Gelado', 'Bebida refrescante de chá', 6.00),
('Milkshake', 'Bebida gelada à base de sorvete', 10.00);

-- Inserir dados em tabela Ingredientes
INSERT INTO Ingredientes (Nome, Unidade_medida, ID_prato, ID_bebida) VALUES
('Tomate', 'Kg', 1, NULL),
('Frango', 'Kg', 2, NULL),
('Bacon', 'Kg', 3, NULL),
('Salmão', 'Kg', 4, NULL),
('Farinha de Rosca', 'Kg', 5, NULL),
('Feijão Preto', 'Kg', 6, NULL),
('Polvo', 'Kg', 7, NULL),
('Camarão', 'Kg', 8, NULL),
('Carne Bovina', 'Kg', 9, NULL),
('Peixe', 'Kg', 10, NULL),
('Gás Carbônico', 'L', NULL, 1),
('Laranja', 'Unidade', NULL, 2),
('Água', 'L', NULL, 3),
('Malte', 'Kg', NULL, 4),
('Uva', 'Kg', NULL, 5),
('Cachaça', 'L', NULL, 6),
('Cevada', 'Kg', NULL, 7),
('Café', 'Kg', NULL, 8),
('Chá', 'Kg', NULL, 9),
('Sorvete', 'L', NULL, 10);

-- Inserir dados em tabela Pedidos
INSERT INTO Pedidos (ID_cliente, ID_prato, ID_bebida, Valor, Tipo_pagamento, Endereco, Data_pedido) VALUES
(1, 1, 1, 31.00, 'Cartão', 'Rua A, 123', '2023-04-01 12:00:00'),
(2, 2, 2, 36.00, 'Dinheiro', 'Rua B, 456', '2023-04-02 13:00:00'),
(3, 3, 3, 24.50, 'Cartão', 'Rua C, 789', '2023-04-03 14:00:00'),
(4, 4, 4, 22.00, 'Cartão', 'Rua D, 101', '2023-04-04 15:00:00'),
(5, 5, 5, 27.50, 'Dinheiro', 'Rua E, 202', '2023-04-05 16:00:00'),
(6, 6, 6, 24.50, 'Cartão', 'Rua F, 303', '2023-04-06 17:00:00'),
(7, 7, 7, 31.50, 'Dinheiro', 'Rua G, 404', '2023-04-07 18:00:00'),
(8, 8, 8, 39.50, 'Cartão', 'Rua H, 505', '2023-04-08 19:00:00'),
(9, 9, 9, 24.50, 'Dinheiro', 'Rua I, 606', '2023-04-09 20:00:00'),
(10, 10, 10, 27.00, 'Cartão', 'Rua J, 707', '2023-04-10 21:00:00');

-- Inserir dados em tabela Entregas
INSERT INTO Entregas (Endereco, ID_pedido, Data_entrega) VALUES
('Rua A, 123', 1, '2023-04-01 13:00:00'),
('Rua B, 456', 2, '2023-04-02 14:00:00'),
('Rua C, 789', 3, '2023-04-03 15:00:00'),
('Rua D, 101', 4, '2023-04-04 16:00:00'),
('Rua E, 202', 5, '2023-04-05 17:00:00'),
('Rua F, 303', 6, '2023-04-06 18:00:00'),
('Rua G, 404', 7, '2023-04-07 19:00:00'),
('Rua H, 505', 8, '2023-04-08 20:00:00'),
('Rua I, 606', 9, '2023-04-09 21:00:00'),
('Rua J, 707', 10, '2023-04-10 22:00:00');


-- INNER JOIN : recupera registros que possuem valores iguais em ambas as tabelas.

SELECT ingredientes.nome, ingredientes.ID_prato, ingredientes.ID_bebida
FROM Ingredientes
INNER JOIN Pedidos
ON ingredientes.ID_prato = pedidos.ID_prato;

--  retorna os nomes, ID_pratoe ID_bebidada Ingredientestabela para os quais há uma correspondência na Pedidostabela com base em ID_prato.

-- LEFT JOIN recupera todos os registros da tabela da esquerda ( Ingredientes) e os registros correspondentes da tabela da direita ( Pedidos). Se não houver correspondência, o resultado será NULL da tabela da direita.

SELECT ingredientes.nome, ingredientes.ID_prato, ingredientes.ID_bebida
FROM Ingredientes
LEFT JOIN Pedidos
ON ingredientes.ID_prato = pedidos.ID_prato;

-- Explicação retorna todas as linhas de Ingredientese as linhas correspondentes de Pedidos. Se não houver correspondência em Pedidos, o resultado incluirá valores NULL para colunas de Pedidos.


-- RIGHT JOIN recupera todos os registros da tabela da direita ( Pedidos) e os registros correspondentes da tabela da esquerda ( Ingredientes). Se não houver correspondência, o resultado será NULL da tabela da esquerda.

SELECT ingredientes.nome, ingredientes.ID_prato, ingredientes.ID_bebida
FROM Ingredientes
RIGHT JOIN Pedidos
ON ingredientes.ID_prato = pedidos.ID_prato;

-- Explicação :retorna todas as linhas de Pedidose as linhas correspondentes de Ingredientes. Se não houver correspondência em Ingredientes, o resultado incluirá valores NULL para colunas de Ingredientes.

-- CROSS JOIN  retorna o produto cartesiano de ambas as tabelas, o que significa que retorna todas as combinações possíveis de linhas de Ingredientese Pedidos.

SELECT ingredientes.nome, ingredientes.ID_prato, ingredientes.ID_bebida
FROM Ingredientes
CROSS JOIN Pedidos
WHERE Ingredientes.ID_prato = Pedidos.ID_prato;

-- Explicação produz um conjunto de resultados que é a combinação de cada linha em Ingredientescom cada linha em Pedidos. Ela não requer uma condição para unir as tabelas.

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
GRANT PROXY ON ''@'%' TO 'root'@'localhost' WITH GRANT OPTION;