-- Индекс по дате выставления счета
CREATE INDEX idx_invoices_issue_date ON Invoices (IssueDate);

-- Индекс по номеру счета
CREATE INDEX idx_invoices_invoice_number ON Invoices (InvoiceNumber);

-- Индекс по контрагенту
CREATE INDEX idx_invoices_contractor ON Invoices (ContractorID);