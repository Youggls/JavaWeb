DELIMITER &&$
drop procedure if exists search_floor_by_user;
create procedure search_floor_by_user(in key_point integer)
#deterministic
reads sql data
begin
    select floor_id, user_id, parent_post_id, floor_num, floor_content, floor_time from floor where user_id = key_point;
end &&$