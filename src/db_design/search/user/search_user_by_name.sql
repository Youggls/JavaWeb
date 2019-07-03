DELIMITER &&#
drop procedure if exists search_user_by_name;
create procedure search_user_by_name(in key_point varchar(100))
deterministic
reads sql data
begin
    select id, nickname, profile_photo_url, registered_date from user where nickname = key_point;
end &&#