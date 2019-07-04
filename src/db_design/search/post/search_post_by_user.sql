DELIMITER &&#
drop procedure if exists search_post_by_user;
create procedure search_post_by_user(in key_point varchar(50))
#deterministic
reads sql data
begin
    select post_id, user_id, post_name, content, post_time from post where key_point = nickname;
end &&#
