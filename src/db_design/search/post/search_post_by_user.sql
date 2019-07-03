DELIMITER &&#
drop procedure if exists search_post_by_user;
create procedure search_post_by_user(in key_point integer)
deterministic
reads sql data
begin
    select post_id, user_id, post_name, content from post where key_point = user_id;
end &&#
