use javaweb;
insert into user values( 230, "asshole", "123", null, curtime(), 'admin');
insert into post values(1,230,"南开军理课","石瑶老师好厉害呀",curtime());
insert into post values(2,230,"南开思政课","李洁老师真漂亮",curtime());
insert into post values(3,231,"南开辅导员","王真老师真的是又漂亮又有能力呢",curtime());
insert into user values(231, "lpy", "123", null, curtime(), "admin");
insert into floor values(1, 1, 1, 231, "舔狗！", curtime());
insert into user values(232, "cxs", "123", null, curtime(), "admin");
insert into  floor values(2, 2, 1, 232, "真他吗恶心", curtime());
insert into comment values(1, 232, 1, -1, "对，就他妈一个舔狗", curtime(), 0);
insert into comment values(2, 231, 1, 1, "天天就知道添，添nmn", curtime(), 0);



