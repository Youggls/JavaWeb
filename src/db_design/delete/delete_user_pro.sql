DELIMITER $$
drop procedure if exists delete_user;
create procedure delete_user(in InUser_id integer)
begin
	delete from follow where follower_id = InUser_id or followed_id = InUser_id;
    delete from user where id = InUser_id;
end $$