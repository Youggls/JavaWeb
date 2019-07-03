DELIMITER ##
drop procedure if exists delete_comment;
create procedure delete_comment(in mcomment_id integer)
deterministic
READS SQL DATA
begin
	update comment set isdeleted = 1 where comment_id = mcomment_id;
    
end ##
