Create Database TarefaBD02_Mecanica_Ex2
go
Use TarefaBD02_Mecanica_Ex2
go
Create Table Cliente (
ID_cliente			int				not null	identity(3401, 15),
nome				varchar(100)	not null,
logradouro			varchar(200)	not null,
numero				int				not null	check(numero >= 0),
CEP					char(8)			not null	check(len(CEP) = 8),
complemento			varchar(250)	not null
Primary key (ID_cliente)
)
go
Create Table Categoria (
ID_categoria		int				not null	identity(1, 1),
categoria			varchar(10)		not null	check(categoria = 'Estagiario' or categoria = 'Nivel 1' or categoria = 'Nivel 2' or categoria = 'Nivel 3'),
valor_hora			decimal(4, 2)	not null	check((valor_hora >= 0) and ((categoria = 'Estagiario' and valor_hora > 15.00) or (categoria = 'Nivel 1' and valor_hora > 25.00) or (categoria = 'Nivel 2' and valor_hora > 35.00) or (categoria = 'Nivel 3' and valor_hora > 50.00))),
Primary key (ID_categoria)
)
go
Create Table Peca (
ID_peca				int				not null	identity(3411, 7),
nome				varchar(30)		not null	unique,
preco				decimal(4, 2)	not null	check(preco >= 0),
estoque				int				not null	check(estoque >= 10)
Primary key (ID_peca)
)
go
Create Table Veiculo (
placa				char(7)			not null	check(Len(placa) = 7),
marca				varchar(30)		not null,
modelo				varchar(30)		not null,
cor					varchar(15)		not null,
ano_fabricacao		int				not null	check(ano_fabricacao > 1997),
ano_modelo			int				not null	check((ano_modelo > 1997) and ((ano_modelo = ano_fabricacao) or (ano_modelo = (ano_fabricacao + 1)))),
data_aquisicao		date			not null,
ID_cliente			int				not null
Primary key (placa)
Foreign key (ID_cliente) references Cliente(ID_cliente)
)
go
Create Table Telefone_Cliente (
ID_cliente			int				not null,
telefone			varchar(11)		not null check(len(telefone) = 10 or len(telefone) = 11)
Primary key (ID_cliente, telefone)
Foreign key (ID_cliente) references Cliente(ID_cliente)
)
go
Create Table Funcionario (
ID_funcionario		int				not null	identity(101, 1),
nome				varchar(10)		not null,
logradouro			varchar(200)	not null,
numero				int				not null	check(numero >= 0),
telefone			char(11)		not null	check(len(telefone) = 10 or len(telefone) = 11),
cat_habilitacao		varchar(2)		not null	check(Upper(cat_habilitacao) = 'A' or Upper(cat_habilitacao) = 'B' or Upper(cat_habilitacao) = 'C' or Upper(cat_habilitacao) = 'D' or Upper(cat_habilitacao) = 'E',
ID_categoria		int				not null
Primary key (ID_funcionario)
Foreign key (ID_categoria) references Categoria(ID_categoria)
)
go
Create table Reparo (
placa				char(7)			not null,
ID_funcionario		int				not null,
ID_peca				int				not null,
data_reparo			int				not null	default('2023-10-18'),
custo_total			decimal(4, 2)	not null	check(custo_total >= 0),
tempo				int				not null	check(tempo >= 0)
Primary key (placa, ID_funcionario, ID_peca, data_reparo)
Foreign key	(placa) references Veiculo(placa),
Foreign key (ID_funcionario) references Funcionario(ID_funcionario),
Foreign key (ID_peca) references Peca(ID_peca)
)