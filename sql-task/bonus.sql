---Для интеграции с внешней бухгалтерской системой,
-- можно добавить следующие поля в таблицу Invoices:
ALTER TABLE Invoices
ADD COLUMN PaymentStatus VARCHAR(50); -- Статус оплаты (полная/частичная)
ALTER TABLE Invoices
ADD COLUMN ShipmentStatus VARCHAR(50); -- Статус отгрузки

--- Запрос для выборок оплаченных, но не отгруженных счетов
SELECT *
FROM Invoices
WHERE PaymentStatus = 'Полная' AND ShipmentStatus != 'Отгружен';

--- Запрос для выборок отгруженных, но не оплаченных счетов
SELECT *
FROM Invoices
WHERE ShipmentStatus = 'Отгружен' AND PaymentStatus != 'Полная';

-- Индексы для синхронизации:
--- Индекс по статусу оплаты
CREATE INDEX idx_invoices_payment_status ON Invoices (PaymentStatus);

--- Индекс по статусу отгрузки
CREATE INDEX idx_invoices_shipment_status ON Invoices (ShipmentStatus);
