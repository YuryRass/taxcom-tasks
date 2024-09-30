-- Таблица контрагентов
DROP TABLE IF EXISTS Contractors;

CREATE TABLE IF NOT EXISTS Contractors (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(50),
    Email VARCHAR(100)
);

-- Таблица счетов
DROP TABLE IF EXISTS Invoices;

CREATE TABLE IF NOT EXISTS Invoices (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    ContractorID INT,
    InvoiceNumber VARCHAR(50),
    IssueDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(50), -- 'Оплачен', 'Не оплачен'
    FOREIGN KEY (ContractorID) REFERENCES Contractors(ID)
);

-- Таблица элементов счета

DROP TABLE IF EXISTS InvoiceItems;

CREATE TABLE IF NOT EXISTS InvoiceItems (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    InvoiceID INT,
    Description VARCHAR(255), -- Описание товара/услуги
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(ID)
);