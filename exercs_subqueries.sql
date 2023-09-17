-- 1) Liste os nomes dos funcionários cujos nomes de departamento contêm a palavra "Vendas".
SELECT nome_funcionario FROM funcionario 
WHERE sigla_depto IN 
(SELECT sigla_depto FROM departamento WHERE nome_depto LIKE 'Vendas');


-- 2) Liste os nomes dos funcionários que estão trabalhando em projetos do departamento 'MKT' ou 'RH'.
SELECT nome_funcionario, cargo, sigla_depto FROM funcionario 
WHERE codigo_funcionario IN 
(SELECT codigo_funcionario FROM projeto WHERE sigla_depto IN ('MKT', 'RH'));


-- 3) Liste os nomes dos departamentos e a soma dos salários de todos os funcionários em cada departamento
-- v1
SELECT nome_depto,  (SELECT SUM(salario) FROM funcionario 
WHERE funcionario.sigla_depto = departamento.sigla_depto) 
AS total_salarios FROM departamento;

-- v2
SELECT d.nome_depto, (SELECT SUM(f.salario) FROM funcionario AS f 
WHERE f.sigla_depto = d.sigla_depto) 
AS total_salarios FROM departamento AS d;


-- 4) Liste os nomes dos funcionários que trabalham em projetos do departamento 'TI' e que ganham mais do que a média salarial dos funcionários do departamento 'TI'.
SELECT nome_funcionario FROM funcionario
WHERE sigla_depto = 'TI'
AND salario > (SELECT AVG(salario) FROM funcionario WHERE sigla_depto = 'TI');


-- 5) Liste os nomes dos departamentos e a quantidade de funcionários em cada departamento.
-- v1
SELECT nome_depto, (SELECT COUNT(*) FROM funcionario 
WHERE funcionario.sigla_depto = departamento.sigla_depto) AS qtd_funcionarios
FROM departamento;

-- v2
SELECT d.nome_depto, (SELECT COUNT(*) FROM funcionario AS f 
WHERE f.sigla_depto = d.sigla_depto) AS qtd_funcionarios
FROM departamento AS d;


-- 6) Liste os nomes dos funcionários que estão trabalhando em projetos do departamento 'RH' e têm um salário superior à média dos salários do departamento 'RH'
SELECT nome_funcionario FROM funcionario 
WHERE sigla_depto = 'RH' AND 
salario > (SELECT AVG(salario) FROM funcionario WHERE sigla_depto = 'RH');


-- 7) Liste todos os departamentos e para cada departamento, liste os nomes dos funcionários separados por vírgula. (estude o operador GROUP_CONCAT).
SELECT d.nome_depto, 
       (SELECT GROUP_CONCAT(nome_funcionario SEPARATOR ', ')
        FROM funcionario AS f
        WHERE f.sigla_depto = d.sigla_depto) AS funcionarios_por_departamento
FROM departamento AS d;
