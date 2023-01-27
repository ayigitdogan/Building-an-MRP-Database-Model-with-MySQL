SET GLOBAL log_bin_trust_function_creators = 1;

-- GET LEAD TIME

DELIMITER $$

CREATE FUNCTION GetLeadTime(required_item_id VARCHAR(16))
	RETURNS INT

	BEGIN

		DECLARE LT INT;

		SET LT = (	SELECT item.lead_time
					FROM item
					WHERE item.item_id = required_item_id);

		RETURN LT;

	END $$

DELIMITER;

-- GET LOT SIZE

DELIMITER $$

CREATE FUNCTION GetLotSize(required_item_id VARCHAR(16))
	RETURNS INT

	BEGIN

		DECLARE LS INT;

		SET LS = (	SELECT item.lot_size
					FROM item
					WHERE item.item_id = required_item_id);

		RETURN LS;

	END $$

DELIMITER;

-- GET PROJECTED INVENTORY

DELIMITER $$

CREATE FUNCTION GetProjectedInventory(  required_item_id VARCHAR(16),
                                        required_item_period INT)
	RETURNS INT

	BEGIN

		DECLARE PInv INT;

		SET PInv = (SELECT item_period.projected_inventory
					FROM item_period
					WHERE   item_period.item_id = required_item_id AND
							item_period.period_number = required_item_period);

		RETURN PInv;

	END $$

DELIMITER;