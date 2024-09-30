--- Получить последние 20 счетов менеджера
SELECT *
FROM Invoices
ORDER BY IssueDate DESC
LIMIT 20;


-- Найти счета за прошлую неделю
SELECT *
FROM Invoices
WHERE IssueDate >= DATETIME('now', '-7 days');


--- Найти счета за прошлый месяц
SELECT *
FROM Invoices
WHERE IssueDate >= DATE('now', '-1 month');


--- Найти счета за прошлый год
SELECT *
FROM Invoices
WHERE IssueDate >= DATE('now', '-1 year');

--- Найти все счета по контрагенту
SELECT *
FROM Invoices
WHERE ContractorID = ?; -- Заменить ? на необходимый ID контрагента

--- Найти счет по номеру
SELECT *
FROM Invoices
WHERE InvoiceNumber = ?; -- Заменить ? на номер счета


--- Получить содержимое счета (элементы счета)
SELECT *
FROM InvoiceItems
WHERE InvoiceID = ?; -- Заменить ? на ID счета