DELIMITER &&#
drop procedure if exists search_for_post_by_postname;
create procedure search_for_post_by_postname(in key_point varchar(80), out mPost_name varchar(100), out mPost_Id integer, out mUser_id integer, out mContent text)
deterministic
reads sql data
begin
	declare Pn varchar(100);
    declare Pi integer;
    declare Ui integer;
    declare Mt text;
	select post_name from post where locate(key_point, post_name)>0 into Pn;
	select post_id from post where locate(key_point, post_name)>0 into Pi;
	select user_id from post where locate(key_point, post_name)>0 into Ui;
	select content from post where locate(key_point, post_name)>0 into Mt;

    set mPost_name = Pn;
    set mPost_Id = Pi;
    set mUser_id = Ui;
    set mContent = Mt;
end &&#
