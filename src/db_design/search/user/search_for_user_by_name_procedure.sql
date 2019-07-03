DELIMITER &&#
drop procedure if exists search_for_user_by_name;
create procedure search_for_user_by_name(in key_point varchar(100), out mid integer, out mphoto varchar(100))
deterministic
reads sql data
begin
	declare mi integer;
    declare Mp varchar(100);
	select id from user where locate(key_point, nickname)>0 into mi;
	select profile_photo_url from user where locate(key_point, nickname)>0 into Mp;


    set mid = mi;
    set mPhoto = Mp;
end &&#