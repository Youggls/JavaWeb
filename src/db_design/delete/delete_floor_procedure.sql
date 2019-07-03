DELIMITER ###
drop procedure if exists delete_floor;
create procedure delete_floor(in mFloor_id integer)
#deterministic
READS SQL DATA
begin
	delete from comment where root_floor_id = mFloor_id;
    delete from floor where floor_id = mFloor_id;
    
end ###
