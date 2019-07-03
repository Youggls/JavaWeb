DELIMITER &&
drop procedure if exists search_comment_by_content;
create procedure search_comment_by_content(in key_point varchar(100))
#deterministic
reads sql data
begin
    select comment_id, user_id, root_floor_id, content, comment_time from comment where locate(key_point, content) > 0;
end &&