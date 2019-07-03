DELIMITER &&#
drop procedure if exists search_floor_by_content;
create procedure search_floor_by_content(in key_point varchar(80))
deterministic
reads sql data
begin
    select floor_id, user_id, parent_post_id, floor_num, floor_content, floor_time where locate(key_point, floor_content)>0;
end &&#
