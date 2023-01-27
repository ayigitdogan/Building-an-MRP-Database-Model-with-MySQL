DELIMITER $$
CREATE TRIGGER after_order_insertion AFTER INSERT ON orders
    FOR EACH ROW
    BEGIN

        -- UPDATE GROSS REQUIREMENT

        CALL GetRequiredItemsCount(NEW.item_id, NEW.amount, NEW.period_number);

        UPDATE item_period
        INNER JOIN required_items ON    item_period.item_id = required_items.required_item AND
                                        item_period.period_number = required_items.due_period
        SET item_period.gross_requirement = item_period.gross_requirement +
                                            required_items.required_amount;

        -- UPDATE MRP TABLES BY PROCEDURE CALL

        CALL UpdateMRPTables();

    END $$
DELIMITER;

