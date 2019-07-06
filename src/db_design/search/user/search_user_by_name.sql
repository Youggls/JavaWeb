DELIMITER &&#
drop procedure if exists search_user_by_name;
create procedure search_user_by_name(in key_point varchar(100))
begin
    select * type from user natural join profile where nickname = key_point;
end &&#