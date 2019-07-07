DELIMITER &&
drop procedure if exists search_user_by_id;
create procedure search_user_by_id(in key_point integer)
deterministic
reads sql data
begin
    select * from user natural join profile where id = key_point;
end &&