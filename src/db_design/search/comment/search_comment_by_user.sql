DELIMITER &&
drop procedure if exists search_comment_by_user;
create procedure search_comment_by_user(in key_point varchar(50))
#deterministic
reads sql data
begin
    select comment_id, user_id, root_floor_id, content, comment_time from comment where nick_name = key_point and isdeleted;
end &&