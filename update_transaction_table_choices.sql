ALTER TABLE expenses_expense DROP CONSTRAINT expenses_expense_account_id_c68dc435_fk_core_account_id;

ALTER TABLE expenses_expense DROP COLUMN account_id;

#     TRANSACTION_FOR_CHOICES = (('EX', 'Expense'), ('RP', 'Recurring Payment'))
#     TRANSACTION_TYPE_CHOICES = (('DB', 'Debit'), ('CD', 'Credit'))

ALTER TABLE expenses_transaction MODIFY COLUMN transaction_type ENUM('DB', 'CD');

ALTER TABLE expenses_transaction MODIFY COLUMN transaction_for ENUM('EX', 'RP');