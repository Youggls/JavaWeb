DELIMITER &&
drop procedure if exists search_for_user_by_id;
create procedure search_for_user_by_id(in key_point integer, out mNickname varchar(100), out mphoto varchar(100))
deterministic
reads sql data
begin
	declare Nn varchar(100);
    declare Mp varchar(100);
	select nickname from user where id = key_point into Nn;
	select profile_photo_url from user where id = key_point into Mp;


    set mNickname = Nn;
    set mPhoto = Mp;
end &&