# JavaWeb项目作业

## 项目：简易论坛

## TODO
- [ ] 注册用户名已经被使用时实时刷新页面状态（后端已完成，前端RaymondY待完成）
- [ ] 判断密码字符合法（注册时，大小写英文字母，特殊符号，数字，RaymondY）
- [ ] TextView，用来浏览帖子的视图（前端，RaymondY）
- [ ] 用来浏览posts的图，类似知乎热榜
- [ ] 做个首页的图（RaymodY）
- [ ] 修改一下登录注册时按钮长度（前端，RaymondY）
- [x] ~~**文本编辑， 紧急**（前端，DoubleClass）~~
- [ ] 锁死前端的显示，取消自适应，类似知乎
- [ ] 发帖单独做一个按钮，放在搜索框右边，类似知乎
- [x] ~~**前端在各个页面根据本地cookie读取用户id从而初始化页面上用户信息**（前端，RaymondY）~~
- [x] ~~配置通过URL获取图片的Servlet（后端，DoubleClass）~~
- [x] ~~上传文件等到服务器（后端，DoubleClass）~~
- [ ] 配置用户头像（后端，Youggls，和前端RaymondY）
- [x] 配置详细的用户信息（后端，Youggls）
- [ ] 配置详细的用户信息（和前端RaymondY）
- [x] 关注功能（后端，Youggls）
- [ ] 关注功能（前端RaymondY）
- [x] ~~**发帖功能（后端，Youggs）**~~
- [x] ~~**发帖功能（前端，DoubleClass，大概框架搭了，半完成）**~~
- [ ] 发帖页面的美化
- [x] ~~**楼层功能（后端，Youggls）**~~
- [ ] **楼层功能（前端）**
- [ ] **回复楼层功能（前端）**
- [x] ~~**回复楼层功能（后端，DoubleClass）**~~
- [x] ~~删除功能，后端~~
- [ ] 删除功能，前端
- [x] ~~rank功能，后端由DoubleClass已完成~~
- [x] ~~登录~~
- [x] ~~注册主要功能~~
- [x] ~~登出~~

## 成员

姓名|学号|分工
---|---|---
李沛尧|1712901|后端、数据库设计，协助开发前端|
杨添凯|1712950|前端设计|
曹续生|1712872|后端、数据库设计，协助开发前端|

## 项目注意事项

* `Eclipse`新建项目时，勾选`Dynamic Web`项目，项目名称为`JavaWeb`，项目路径选中该文件上层目录，next两下后，还会有一个`Content directory`的名称要填，默认是WebContent，**改成web**，之后Finish就完事了。
* `Jetbrains`新建项目时，大概和上边一样，另外需要针对servlet项目配置，[见连接](https://blog.csdn.net/yhao2014/article/details/45740111)

最好大家都用JetBrains吧，不然容易出问题是真的。。。

## 项目应实现功能

### 必要功能：

1. 用户组支持

   * `visitor`访客级别：只能够查看、搜索帖子和回复，不能发表帖子，不能回复其他用户
   * `user`普通用户级别：拥有上一级用户所有权限，且可以发表帖子，可以回复其他用户，可以删除自己发表的帖子、回复
   * `operator`普通管理员级别：拥有上一级用户所有权限，且可以删除`user`用户及自己发表的帖子、回复，可以封禁用户
   * `admin`网站管理员级别：只能由一个用户，拥有上一级用户所有权限，且可以删除所有用户的帖子和回复，可以发放剥夺普通管理员身份

2. 发帖、回复

    * `user`及以上权限的用户可以发帖，帖子信息应该有以下基本信息：

        * 发布者id
        * 发布日期
        * 帖子标题
        * 主题内容（类似百度贴吧，标题下有描述）
    
    * `user`及以上权限的用户可以回复其他用户的主题贴，也可以回复其他用户的回复，回复内容应该包含以下基本信息

        * 发布者id
        * 发布日期
        * 具体内容

3. 搜索功能

    * 按照用户名、用户id搜索内容：搜索用户名或id后可以跳转到个人主页。
    * 按照关键字搜索：可以返回一个带有文本关键字内容信息的列表（类似知乎手机端搜索）

4. 删除功能

    * 帖子删除：直接级联删除所有信息，直接不可见
    * 回复删除：普通用户仅删除该回复，不做级联删除。管理员可以级联删除。

5. 个人中心功能（前端部分）

    * 要显示个人用户信息，时间线（类似知乎）

6. 排行榜功能（该部分主要参考[北邮人](https://bt.byr.cn/topten.php)的设计）

    * 发帖总数统计
    * 注册用户总数统计
    * 注册时间统计
    * 单个用户的发帖数排行
    * 单个用户的回复数排行
    * 单个用户的注册时间排行

### 次要功能（可支持）

1. 回复内容的富文本标记（好像有现成的富文本模块）：emoji、图片、格式

2. 用户社交丰富化：好友功能、关注功能、关注用户的时间线实现

## 数据库设计

### 数据库实体定义

* `user`表定义，用户基本信息

|字段|类型|描述|默认值|是否主键|外键约束|非空约束|
|:----:|:---:|:----:|:------:|:--------:|:---:|:--:|
|`id`|`INT`|用户UID，自增长字段|无默认值|是|无|`not null`|
|`nickname`|`VARCHAR(45)`|用户昵称|`null`|否|无||
|`password`|`VARCHAR(50)`|用户密码|无默认值|否|无|`not null`|
|`profile_photo_url`|`VARCHAR(50)`|用户头像url|`null`|否|无|
|`registered_date`|`TIMESTAMP`|用户注册时间|无|否|无|`not null`|
|`type`|`VARCHAR(10)`|用户组类型|"user"|否|无|`not null`|

* `post`表定义，帖子基本信息

|字段|类型|描述|默认值|是否主键|外键约束|非空约束|
|:----:|:---:|:----:|:------:|:--------:|:---:|:--:|
|`post_id`|`INT`|帖子UID，自增长|无|是|无|`not null`|
|`user_id`|`INT`|发帖人id|无|否|`user.id`|`not null`|
|`post_name`|`VARCHAR(100)`|帖子title|无|否|无|`not null`|
|`content`|`TEXT`|帖子描述|无|否|无|`not null`|
|`post_time`|`TIMESTAMP`|发帖时间|无|否|无|`not null`|

* `floor`表定义，直接回复`post`的楼层

|字段|类型|描述|默认值|是否主键|外键约束|非空约束|
|:----:|:---:|:----:|:------:|:--------:|:---:|:--:|
|`floor_id`|`INT`|楼层唯一UID，自增长|无|是|无|`not null`|
|`floor_num`|`INT`|楼层号|无|否|无|`not null`|
|`parent_post_id`|`INT`|父级帖子id|无|否|`post.post_id`|`not null`|
|`user_id`|`INT`|楼层发表人id|无|否|`user.user_id`|`not null`|
|`floor_contnet`|`TEXT`|楼层内容|无|否|无|`not null`|
|`floor_time`|`TIMESTAMP`|楼层创建时间|无|否|无|`not null`|

* `comment`表定义，回复`floor`的评论

|字段|类型|描述|默认值|是否主键|外键约束|非空约束|
|:----:|:---:|:----:|:------:|:--------:|:---:|:--:|
|`comment_id`|`INT`|评论唯一表示UID，自增长|无|是|无|`not null`|
|`user_id`|`INT`|评论发布者id|无|否|`user.user_id`|`not null`|
|`root_floor_id`|`INT`|根楼层UID，因为一个评论可以回复其他评论，那么应该表示出它的楼层UID|无|否|`floor.floor_id`|`not null`|
|`pre_comment_id`|`INT`|回复上一级回复的id，如果直接回复`floor`则为-1|`-1`|否|无|not null|
|`content`|`TEXT`|回复内容|无|否|无|`not null`|
|`comment_time`|`TIMESTAMP`|评论时间|无|否|无|`not null`|
|`isdeleted`|`TINYINT`|是否删除|`1`|否|无|`not null`|

### 数据库存储过程设计

|存储过程名|功能描述|`IN`参数|`OUT`参数|返回表|
|:-------:|:-----:|:------:|:-------:|:---:|
|`delete_comment_procedure`|删除commnet|`INT`|无|无|
|`delete_floor_procedure`|删除floor，并且级联删除回复|`INT`|无|无|
|`delete_post_procedure`|删除帖子，级联删除floor和comment|`INT`|无|无|
|`find_max_floor`|找到帖子的最大楼层|`INT`|`num`|无|
|`search_comment_by_user`|根据用户id查找comment|`INT`|无|字段是`comment_id`, `user_id`, `root_floor_id`, `content`, `comment_time`|
|`search_comment_by_content`|根据内容查找comment|`VARCHAR`|无|字段是`comment_id`, `user_id`, `root_floor_id`, `content`, `comment_time`|
|`serch_floor_by_content`|根据内容查找floor|`VARCHAR`|无|字段是`floor_id`, `user_id`, `parent_post_id`, `floor_num`, `floor_content`, `floor_time`|
|`serch_floor_by_user`|根据用户id查找floor|`INT`|无|字段是`floor_id`, `user_id`, `parent_post_id`, `floor_num`, `floor_content`, `floor_time`|
|`search_post_by_content`|根据内容查找post|`VARCHAR`|无|字段是`post_id`, `user_id`, `post_name`, `content`, `post_time`|
|`search_post_by_postname`|根据postname查找post|`VARCHAR`|无|字段是`post_id`, `user_id`, `post_name`, `content`, `post_time`|
|`search_post_by_user`|根据user_id查找post|`VARCHAR`|无|字段是`post_id`, `user_id`, `post_name`, `content`, `post_time`|
|`search_user_by_id`|根据id查找user|`INT`|无|字段是`post_id`, `user_id`, `post_name`, `content`, `registered_time`|
|`search_user_by_name`|根据用户名查找user|`VARCHAR`|无|字段是`post_id`, `user_id`, `post_name`, `content`, `registered_time`|
## 参考的项目及使用的开源项目

1. [`boostrap`项目](https://github.com/twbs/bootstrap)，是一个前端常用的库，我们使用了该项目的css文件。该项目开源协议为MIT协议。
