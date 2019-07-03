DELIMITER &&
drop procedure if exists search_for_comment_by_user;
create procedure search_for_comment_by_user(in key_point integer, out mComment_id integer, out mFloor_id integer, out mContent text)
deterministic
reads sql data
begin
	declare Mi integer;
    declare Fi integer;
    declare Ct text;
	select comment_id from comment where user_id = key_point into Mi;
	select root_floor_id from comment where user_id = key_point into Fi;
	select content from comment where user_id = key_point into Ct;


    set mComment_id = Mi;
    set mFloor_id = Fi;
    set mContent = Ct;
end &&