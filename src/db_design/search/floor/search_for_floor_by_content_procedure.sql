DELIMITER &&#
drop procedure if exists search_floor_by_content;
create procedure search_floor_by_content(in key_point varchar(80), out mFloor_id integer, out mFloor_num integer, 
												out mParent_postid integer, out mUser_id integer, out mContent text)
deterministic
reads sql data
begin
	#declare Fi integer;
    #declare Fn integer;
    #declare PP integer;
    #declare Ui integer;
    #declare Ct text;
	#select floor_id from floor where locate(key_point, floor_content)>0 into Fi;
	#select floor_num from floor where locate(key_point, floor_content)>0 into Fn;
	#select parent_post_id from floor where locate(key_point, floor_content)>0 into PP;
	#select user_id from floor where locate(key_point, floor_content)>0 into Ui;
	#select floor_content from floor where locate(key_point, floor_content)>0 into Ct;


    #set mFloor_id = Fi;
    #set mFloor_id = Fn;
    #set mParent_postid = PP;
    #set mUser_id = Ui;
    #set mContent = Ct;
    select floor_id, floor_num, parent_post_id, user_id, floor_content where locate(key_point, floor_content)>0;
end &&#
