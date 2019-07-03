DELIMITER %%
drop procedure if exists find_max_floor;
create procedure find_max_floor(in mPost_id integer, out num integer)
deterministic
reads sql data
begin
	declare s integer default 0;
	select max(floor_num) from floor where parentPostId = mPost_id into s;
    set num = s;
end %%