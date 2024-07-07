# ALTER TABLE expenses_expense DROP CONSTRAINT expenses_expense_account_id_c68dc435_fk_core_account_id;
#
# ALTER TABLE expenses_expense DROP COLUMN account_id;
#
# ALTER TABLE expenses_expense ADD COLUMN user_id BIGINT NOT NULL DEFAULT -1;
#
# ALTER TABLE expenses_expense ADD CONSTRAINT expenses_expense_user_id_to_core_user_id FOREIGN KEY (user_id) REFERENCES core_user (id);
#
# #     TRANSACTION_FOR_CHOICES = (('EX', 'Expense'), ('RP', 'Recurring Payment'))
# #     TRANSACTION_TYPE_CHOICES = (('DB', 'Debit'), ('CD', 'Credit'))

ALTER TABLE expenses_transaction MODIFY COLUMN transaction_type ENUM('DB', 'CD') NOT NULL;

ALTER TABLE expenses_transaction MODIFY COLUMN transaction_for ENUM('EX', 'RP') NOT NULL;
