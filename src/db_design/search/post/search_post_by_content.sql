DELIMITER &&
drop procedure if exists search_post_by_content;
create procedure search_post_by_content(in key_point varchar(80))
deterministic
reads sql data
begin
    select post_id, user_id, post_name, content from post where locate(key_point, content) > 0;
end &&
