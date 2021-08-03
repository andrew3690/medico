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
CREATE TRIGGER saldo_negativo AFTER UPDATE ON Contas_Cliente
	IF c.saldo < 0 THEN
		INSERT INTO Emprestimo values (c.numConta,c.codCliente, -new c.saldo)
	 update Contas_Cliente l
	 set l.saldo = 0 where l.numConta = c.numConta;
