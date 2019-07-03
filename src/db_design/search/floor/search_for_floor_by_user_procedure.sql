DELIMITER &&$
drop procedure if exists search_for_floor_by_user;
create procedure search_for_floor_by_user(in key_point integer, out mFloor_id integer, out mFloor_num integer, 
												out mParent_postid integer, out mUser_id integer, out mContent text)
deterministic
reads sql data
begin
	declare Fi integer;
    declare Fn integer;
    declare PP integer;
    declare Ui integer;
    declare Ct text;
	select floor_id from floor where user_id = key_point into Fi;
	select floor_num from floor where user_id = key_point into Fn;
	select parent_post_id from floor where user_id = key_point into PP;
	select user_id from floor where user_id = key_point into Ui;
	select floor_content from floor where user_id = key_point into Ct;


    set mFloor_id = Fi;
    set mFloor_id = Fn;
    set mParent_postid = PP;
    set mUser_id = Ui;
    set mContent = Ct;
end &&$