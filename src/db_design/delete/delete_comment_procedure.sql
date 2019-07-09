DELIMITER ##
drop procedure if exists delete_comment;
create procedure delete_comment(in mcomment_id integer)
deterministic
READS SQL DATA
begin
	delete from comment where comment_id = mcomment_id;
end ##
