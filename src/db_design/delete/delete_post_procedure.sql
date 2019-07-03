DELIMITER &&
drop procedure if exists delete_post;
create procedure delete_post(in mpost_id integer)
deterministic
reads sql data
begin
	declare myFloor_id integer;
	declare numOfFloor integer default 0;
    
    declare curForComment cursor for select floor_id from floor where parentPostId = mpost_id;
    declare continue handler for  SQLSTATE '02000' set myFLoor_id=0;
    
    select count(*) from floor where parentPostId = mpost_id into numOfFloor;
    open curForComment;
    fetch curForComment into myFloor_id;
    while(myFloor_id <> 0) Do 
		delete from comment where root_floor_id = myFloor_id;
        fetch curForComment into myFloor_id;
	end while;
    delete from floor where parentPostId = mpost_id;
    delete from post where post_id = mpost_id;
end &&
