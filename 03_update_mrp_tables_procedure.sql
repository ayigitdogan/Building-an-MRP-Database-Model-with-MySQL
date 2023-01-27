DELIMITER $$
CREATE PROCEDURE UpdateMRPTables ()
    BEGIN
        DECLARE done_i INT DEFAULT 0;

        DECLARE var_i_id VARCHAR(16);
        
        DECLARE cursor_i CURSOR FOR
        SELECT item_id FROM item_period GROUP BY item_id;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_i = 1;

        OPEN cursor_i;
        
            item_loop: LOOP
                FETCH cursor_i INTO var_i_id;
                
                IF done_i = 1 THEN
                    LEAVE item_loop;
                END IF;

                itemwise_update_block: BEGIN

                    DECLARE done_j INT DEFAULT 0;

                    DECLARE var_j_period INT;
                    DECLARE var_j_gross INT;
                    DECLARE var_j_inventory INT;
                    DECLARE var_j_receipt INT;
                    DECLARE var_j_release INT;

                    DECLARE net_requirement INT;
                    DECLARE receipt_increment INT;

                    DECLARE cursor_j CURSOR FOR
                    SELECT  period_number, gross_requirement,
                            projected_inventory, planned_order_receipt,
                            planned_order_release
                    FROM item_period
                    WHERE   item_id = var_i_id AND
                            period_number <> 0;

                    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_j = 1;

                    OPEN cursor_j; 

                        period_loop: LOOP
                            FETCH cursor_j INTO var_j_period, var_j_gross,
                                                var_j_inventory, var_j_receipt, 
                                                var_j_release;

                            IF done_j = 1 THEN
                                LEAVE period_loop;
                            END IF;
                        
                            SET net_requirement =   var_j_gross - 
                                                    GetProjectedInventory(  var_i_id,
                                                                            var_j_period - 1);

                            
                            IF net_requirement > 0 THEN
                                SET receipt_increment = CEILING(net_requirement/
                                                                GetLotSize(var_i_id))*
                                                                GetLotSize(var_i_id);

                                UPDATE item_period
                                    SET planned_order_receipt = planned_order_receipt +
                                                                receipt_increment,
                                        projected_inventory =   projected_inventory +
                                                                receipt_increment -
                                                                gross_requirement
                                    WHERE   item_id = var_i_id AND
                                            period_number = var_j_period;

                                UPDATE item_period
                                    SET planned_order_release = planned_order_release +
                                                                receipt_increment
                                    WHERE   item_id = var_i_id AND
                                            period_number = var_j_period - GetLeadTime(var_i_id);

                            ELSE
                                UPDATE item_period
                                    SET projected_inventory = -net_requirement
                                    WHERE   item_id = var_i_id AND
                                            period_number = var_j_period;

                            END IF;
 
                        END LOOP period_loop;
                    CLOSE cursor_j;
                END itemwise_update_block;


            END LOOP item_loop;
        CLOSE cursor_i;
    END $$
DELIMITER;

