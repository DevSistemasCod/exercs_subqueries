-- 1) Liste os nomes dos funcionários cujos 
-- nomes de departamento contêm a palavra "Recursos Humanos".
SELECT nome_funcionario FROM funcionario 
WHERE sigla_depto IN 
(SELECT sigla_depto FROM departamento 
WHERE nome_depto LIKE 'Recursos Humanos');


-- 2) Liste os nomes dos funcionários que estão 
-- trabalhando em projetos do departamento 'MKT' ou 'RH'.
SELECT nome_funcionario, cargo, sigla_depto FROM funcionario 
WHERE codigo_funcionario IN 
(SELECT codigo_funcionario FROM projeto
 WHERE sigla_depto IN ('MKT', 'RH'));


-- 3) Liste os nomes dos departamentos e a soma 
dos salários de todos os funcionários em cada departamento
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
AND salario > (SELECT AVG(salario) 
FROM funcionario WHERE sigla_depto = 'TI');


-- 5) Liste os nomes dos departamentos e a quantidade de funcionários em cada departamento.
-- v1
SELECT nome_depto, (SELECT COUNT(*) FROM funcionario 
WHERE funcionario.sigla_depto = departamento.sigla_depto) 
AS qtd_funcionarios
FROM departamento;

-- v2
SELECT d.nome_depto, (SELECT COUNT(*) FROM funcionario f 
WHERE f.sigla_depto = d.sigla_depto) AS qtd_funcionarios
FROM departamento d;


-- 6 Liste os nomes dos funcionários que trabalham em
-- departamentos com mais de 3 funcionários 
SELECT nome_funcionario
FROM funcionario
WHERE sigla_depto IN (
    SELECT sigla_depto
    FROM funcionario
    GROUP BY sigla_depto
    HAVING COUNT(codigo_funcionario) > 3
);


-- 7) Liste os nomes dos funcionários que trabalham em departamentos que possuem mais de 10 funcionários e cuja média salarial é superior a 4000
-- v1
SELECT nome_funcionario, sigla_depto
FROM funcionario
WHERE sigla_depto IN (
      SELECT sigla_depto 
      FROM departamento 
      WHERE qtd_funcionarios_depto > 10
)
AND sigla_depto IN (
      SELECT sigla_depto
      FROM funcionario
      GROUP BY sigla_depto
      HAVING AVG(salario) > 4000
);
-- v2
SELECT nome_funcionario, sigla_depto
FROM funcionario
WHERE sigla_depto IN (
      SELECT sigla_depto
      FROM funcionario
      GROUP BY sigla_depto
      HAVING COUNT(codigo) > 3 AND AVG(salario) > 4000
);

-- 8) Liste os nomes dos funcionários que trabalham em 
-- departamentos onde o total dos salários (soma) ultrapassa 20.000 
SELECT nome_funcionario
FROM funcionario
WHERE sigla_depto IN (
    SELECT sigla_depto
    FROM funcionario
    GROUP BY sigla_depto
    HAVING SUM(salario) > 20000
);


-- 9) Liste os nomes dos funcionários cujo salário está entre o menor salário do departamento 'TI' e o maior salário do departamento 'VENDAS'.
SELECT nome_funcionario, salario, sigla_depto
FROM funcionario
WHERE salario BETWEEN
      (SELECT MIN(salario) FROM funcionario WHERE sigla_depto = 'TI')
      AND
      (SELECT MAX(salario) FROM funcionario WHERE sigla_depto = 'VENDAS');
