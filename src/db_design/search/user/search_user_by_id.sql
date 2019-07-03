DELIMITER &&
drop procedure if exists search_user_by_id;
create procedure search_user_by_id(in key_point integer)
deterministic
reads sql data
begin
    select id, nickname, profile_photo_url, registered_date where id = key_point;
end &&