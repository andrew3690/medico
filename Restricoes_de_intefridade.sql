CREATE TABLE Cliente ( 
 codCliente integer,
 nome varchar(30),
 endereco varchar(50),
 idade integer,
 PRIMARY KEY(codCliente)
 );
 -- 8
 CREATE TABLE Tipo_Conta (
 numTipo integer,
 Tipo varchar(20) CHECK(Tipo = 'Corrente' OR Tipo = 'Poupanca' OR Tipo = 'Investimento'),
 PRIMARY KEY(numTipo)
 );
 -- 9 e 10
 CREATE TABLE Contas_Cliente(
 numConta integer,
 codCliente integer,
 numTipo integer,
 saldo float default 0.00,
 PRIMARY KEY(numConta),
 FOREIGN KEY(codCliente) references Cliente (codCliente) ON DELETE RESTRICT,
 FOREIGN KEY(numTipo) references Tipo_Conta(numTipo)
 );

-- 11
CREATE TABLE Emprestimo(
numEmprestimo integer,
numConta integer unique,
codCliente integer unique,
PRIMARY KEY(numEmprestimo),
FOREIGN KEY(numConta) references Emprestimo (numConta),
FOREIGN KEY(codCliente) references Cliente (codCliente)
);
-- Duvida
CREATE OR REPLACE FUNCTION emprestimo() RETURNS TRIGGER AS $emprestimo$
BEGIN
IF NEW.saldo < 0 THEN
INSERT INTO Emprestimo VALUES (NEW.numConta, -NEW.saldo, NEW.codCliente);
UPDATE ContasCliente SET saldo = 0 WHERE numeroconta = NEW.numeroconta;
END IF;
RETURN NEW;
END $emprestimo$
LANGUAGE plpgsql;

CREATE TRIGGER autoEmprestimo
AFTER UPDATE ON ContaCorrente FOR EACH ROW EXECUTE PROCEDURE emprestimo();
