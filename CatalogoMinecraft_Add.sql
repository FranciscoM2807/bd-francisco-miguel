-- João V, Francisco, Ítalo, Jean

DROP DATABASE IF EXISTS CatalogoMinecraft;
CREATE DATABASE  CatalogoMinecraft;
USE CatalogoMinecraft;

CREATE TABLE Itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_item VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    empilhavel BOOLEAN NOT NULL,
    durabilidade INT, -- Se o item não tem durabilidade, pode ser NULL
    raridade ENUM('Comum', 'Raro', 'Épico', 'Lendário') NOT NULL,
    valor INT, -- Valor em unidades de esmeralda
    descricao TEXT
);

INSERT INTO Itens (nome_item, categoria, empilhavel, durabilidade, raridade, valor, descricao) VALUES
('Espada de Madeira', 'Arma', TRUE, 59, 'Comum', 1, 'Uma espada fraca, feita de madeira.'),
('Espada de Diamante', 'Arma', TRUE, 1561, 'Épico', 20, 'A mais poderosa espada disponível no jogo.'),
('Picareta de Ferro', 'Ferramenta', TRUE, 250, 'Comum', 5, 'Ferramenta básica para mineração de pedras e minérios.'),
('Arco', 'Arma', TRUE, 385, 'Comum', 3, 'Usado para atirar flechas à distância.'),
('Flecha', 'Munição', TRUE, NULL, 'Comum', 1, 'Municao básica para uso com arco.'),
('Diamante', 'Material', TRUE, NULL, 'Épico', 50, 'Raro e valioso, usado para criar equipamentos poderosos.'),
('Barra de Ferro', 'Material', TRUE, NULL, 'Comum', 10, 'Material usado para criar ferramentas e armaduras.'),
('Barra de Ouro', 'Material', TRUE, NULL, 'Raro', 15, 'Usado em criações e trocas com aldeões.'),
('Prancha de Madeira', 'Bloco', TRUE, NULL, 'Comum', 1, 'Bloco de construção básico feito de madeira.'),
('Pedregulho', 'Bloco', TRUE, NULL, 'Comum', 1, 'Bloco comum usado em construção e criação de fornalhas.'),
('Tocha', 'Fonte de Luz', TRUE, NULL, 'Comum', 1, 'Fornece iluminação para áreas escuras.'),
('Fornalha', 'Utilitário', FALSE, NULL, 'Comum', 8, 'Utilizado para cozinhar alimentos e fundir minérios.'),
('Mesa de Trabalho', 'Utilitário', FALSE, NULL, 'Comum', 4, 'Permite criar itens mais complexos.'),
('Baú', 'Utilitário', FALSE, NULL, 'Comum', 5, 'Armazena itens para o jogador.'),
('Mesa de Encantamento', 'Utilitário', FALSE, NULL, 'Raro', 30, 'Usado para encantar ferramentas e armaduras.'),
('Bigorna', 'Utilitário', FALSE, 250, 'Comum', 15, 'Utilizada para reparar e nomear itens.'),
('Balde', 'Ferramenta', FALSE, 64, 'Comum', 10, 'Ferramenta usada para transportar água, lava e outros líquidos.'),
('Balde de Água', 'Ferramenta', FALSE, 64, 'Comum', 11, 'Balde cheio de água, útil para irrigação e resgates.'),
('Balde de Lava', 'Ferramenta', FALSE, 64, 'Comum', 12, 'Balde cheio de lava, usado em fornalhas e armadilhas.'),
('Maçã', 'Alimento', TRUE, NULL, 'Comum', 2, 'Alimento básico que recupera vida.'),
('Maçã Dourada', 'Alimento', TRUE, NULL, 'Épico', 25, 'Restaura muita vida e concede bônus temporários.'),
('Pão', 'Alimento', TRUE, NULL, 'Comum', 3, 'Alimento básico feito de trigo.'),
('Carne Cozida', 'Alimento', TRUE, NULL, 'Comum', 5, 'Restaura bastante fome e vida.'),
('Costela de Porco Cozida', 'Alimento', TRUE, NULL, 'Comum', 6, 'Delicioso pedaço de carne que restaura bastante fome.'),
('Poção de Cura', 'Poção', FALSE, NULL, 'Raro', 10, 'Poção que restaura a vida do jogador.'),
('Poção de Força', 'Poção', FALSE, NULL, 'Raro', 12, 'Aumenta o dano causado por ataques físicos.'),
('Pérola do Ender', 'Ferramenta', TRUE, NULL, 'Raro', 15, 'Usada para teletransporte em curtas distâncias.'),
('Olho do Ender', 'Ferramenta', TRUE, NULL, 'Raro', 20, 'Usado para localizar fortalezas e ativar portais.'),
('TNT', 'Explosivo', TRUE, NULL, 'Comum', 7, 'Bloco explosivo que pode ser detonado.'),
('Redstone', 'Material', TRUE, NULL, 'Comum', 2, 'Usado em sistemas de redstone e engenharia complexa.'),
('Obsidiana', 'Bloco', TRUE, NULL, 'Raro', 25, 'Bloco extremamente resistente, usado para portais e defesas.');

CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(50) NOT NULL
);

CREATE TABLE Inventarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT, -- Une o inventário com o usuário
    id_item INT,    -- Relaciona o inventário com a tabela de itens
    quantidade INT NOT NULL CHECK (quantidade > 0 AND quantidade <= 64), -- minecraft
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    CONSTRAINT fk_item FOREIGN KEY (id_item) REFERENCES Itens(id)
);

INSERT INTO Usuarios (nome_usuario) VALUES 
('Jogador1'),
('Jogador2'),
('Jogador3');

-- Função pra adicionar um item no inv
DELIMITER //
CREATE PROCEDURE AdicionarItemInventario (
    IN p_id_usuario INT, 
    IN p_id_item INT, 
    IN p_quantidade INT
)
BEGIN
    -- Verifica se o caboclo não tem 9 itens já
    DECLARE total_itens INT;
    SELECT COUNT(*) INTO total_itens 
    FROM Inventarios 
    WHERE id_usuario = p_id_usuario;

    IF total_itens >= 9 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Inventário cheio! Máximo de 9 itens permitidos.';
    ELSE
        -- Insere o novo item no inv
        INSERT INTO Inventarios (id_usuario, id_item, quantidade) 
        VALUES (p_id_usuario, p_id_item, p_quantidade);
    END IF;
END //
DELIMITER ;

-- Exemplos de como adicionar, primeiro é o id do jogador, dps o item e dps a quantidade
CALL AdicionarItemInventario(1, 1, 3); 
CALL AdicionarItemInventario(1, 2, 1); 
CALL AdicionarItemInventario(1, 7, 10); 
CALL AdicionarItemInventario(1, 11, 16); 
CALL AdicionarItemInventario(1,3,1);

-- Verifica o inventário do jogador
SELECT u.nome_usuario, i.nome_item, inv.quantidade
FROM Inventarios inv
JOIN Usuarios u ON inv.id_usuario = u.id
JOIN Itens i ON inv.id_item = i.id
WHERE u.id = 1; -- Inv do Jogador1
