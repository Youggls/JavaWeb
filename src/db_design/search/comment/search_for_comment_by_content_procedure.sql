DELIMITER &&
drop procedure if exists search_for_comment_by_content;
create procedure search_for_comment_by_content(in key_point varchar(100), out mComment_id integer, out mFloor_id integer, out mContent text)
deterministic
reads sql data
begin
	declare Mi integer;
    declare Fi integer;
    declare Ct text;
	select comment_id from comment where locate(key_point, content)>0 into Mi;
	select root_floor_id from comment where locate(key_point, content)>0 into Fi;
	select content from comment where locate(key_point, content)>0 into Ct;


    set mComment_id = Mi;
    set mFloor_id = Fi;
    set mContent = Ct;
end &&