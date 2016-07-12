DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    TRIGGER `zdrns`.`nextId` AFTER INSERT
    ON `zdrns`.`dpa_det_old`
    FOR EACH ROW BEGIN
	UPDATE nextid SET id = id+1;
    END$$

DELIMITER ;