set @now = now();
update doc set createTime =ifnull(@now,createTime),lastUpdateTime = ifnull(@now,lastUpdateTime) where createTime is null or lastUpdateTime is null;
ALTER TABLE `doc`
  MODIFY COLUMN `sort` int(11) NOT NULL DEFAULT 100 AFTER `name`,
  MODIFY COLUMN `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容' AFTER `type`,
  MODIFY COLUMN `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `content`,
  MODIFY COLUMN `lastUpdateTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) AFTER `createTime`,
  MODIFY COLUMN `parentId` char(12) NOT NULL DEFAULT 0 AFTER `lastUpdateTime`,
  ADD COLUMN `status` int(1) NOT NULL DEFAULT 1 COMMENT '状态；1：有效；0：已删除' AFTER `projectId`,
  COMMENT = '文档表';



update project_user set status = case
                                 when status='PENDING' then 1
                                 when status='ACCEPTED' then 2
                                 else 3
                                 end ,
  editable =  case
              when editable='YES' then 1
              else 0
              end ,
  commonlyUsed=
  case
  when commonlyUsed = 'YES' then 1
  else 0
  end               ;

ALTER TABLE project_user
  MODIFY COLUMN `createTime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `userId`,
  MODIFY COLUMN `status` int(0) NULL DEFAULT 1 COMMENT '1: 待接收；2：已接受；3：已拒绝' AFTER `createTime`,
  MODIFY COLUMN `editable` int(1) NULL DEFAULT 1 COMMENT '是否可编辑；1：是；0：否' AFTER `status`,
  MODIFY COLUMN `commonlyUsed` integer(3) NULL DEFAULT 0 COMMENT '是否是常用；1：是；0：否' AFTER `editable`;




update project set status =  case
                             when status='VALID' then 1
                             when status='INVALID' then 2
                             when status='DELETED' then 3
                             else 4
                             end,
  permission = case
               when permission = 'PUBLIC' then 1
               else 0
               end;

ALTER TABLE `project`
  DROP COLUMN `teamId`,
  MODIFY COLUMN `name` varchar(50) CHARACTER SET utf8mb4 NULL DEFAULT NULL AFTER `id`,
  MODIFY COLUMN `description` varchar(300) CHARACTER SET utf8mb4 NULL DEFAULT NULL COMMENT '描述' AFTER `name`,
  MODIFY COLUMN `createTime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'CURRENT_TIMESTAMP' AFTER `description`,
  MODIFY COLUMN `userId` char(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL AFTER `createTime`,
  MODIFY COLUMN `status` int(1) NOT NULL DEFAULT 1 COMMENT ' 状态 ;1:有效;2:无效;3:已删除;4:已存档\n' AFTER `userId`,
  MODIFY COLUMN `permission` integer(1) NOT NULL DEFAULT 1 COMMENT ' 权限 1:公开;0:私有' AFTER `status`,
  MODIFY COLUMN `lastUpdateTime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT 'CURRENT_TIMESTAMP' AFTER `details`,
  COMMENT = '项目表';


update share set shareAll = if(shareAll='YES',1,0);
ALTER TABLE `share`
  DROP COLUMN `moduleIds`,
  MODIFY COLUMN `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分享名称' AFTER `id`,
  MODIFY COLUMN `createTime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `name`,
  MODIFY COLUMN `userId` char(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '用户id' AFTER `createTime`,
  MODIFY COLUMN `shareAll` integer(1) NULL DEFAULT NULL COMMENT '是否分享全部；1：是；0：否' AFTER `userId`,
  MODIFY COLUMN `projectId` char(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL AFTER `password`;



update user set status = if(status='VALID',1,0);
ALTER TABLE `user`
  MODIFY COLUMN `createtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间' AFTER `email`,
  MODIFY COLUMN `status` int(1) NOT NULL DEFAULT 1 COMMENT '状态；1：有效；0：无效' AFTER `avatar`;


ALTER TABLE `user_third`
  CHANGE COLUMN `id` `thirdId` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方主键' FIRST,
  MODIFY COLUMN `userid` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id' AFTER `thirdId`,
  MODIFY COLUMN `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方类型' AFTER `userid`,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (`thirdId`) USING BTREE,
  COMMENT = '第三方关联表';

ALTER TABLE `user_third`
  ADD COLUMN `id` int(0) NOT NULL AUTO_INCREMENT FIRST,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (`id`) USING BTREE,
  DROP INDEX `userId`,
  ADD UNIQUE INDEX `userId`(`userid`, `type`, `thirdId`) USING BTREE;

ALTER TABLE `user_third`
  CHANGE COLUMN `userid` `userId` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id' AFTER `thirdId`;

ALTER TABLE `attach`
  MODIFY COLUMN `id` char(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '主键id' FIRST,
  MODIFY COLUMN `url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'url' AFTER `id`,
  MODIFY COLUMN `type` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'FILE' COMMENT '文件类型' AFTER `url`,
  MODIFY COLUMN `sort` int(11) NOT NULL DEFAULT 10 COMMENT '排序' AFTER `type`,
  MODIFY COLUMN `relatedId` char(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '关联id' AFTER `sort`,
  MODIFY COLUMN `fileName` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称' AFTER `relatedId`,
  MODIFY COLUMN `createTime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'c创建时间' AFTER `fileName`,
  MODIFY COLUMN `projectId` char(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '项目id' AFTER `createTime`,
  COMMENT = '文档附件表';

alter table attach rename to doc_attachment;
ALTER TABLE `doc_attachment`
  DROP COLUMN `id`;

ALTER TABLE `doc_attachment`
  ADD COLUMN `id` int(0) NOT NULL AUTO_INCREMENT FIRST,
  ADD PRIMARY KEY (`id`);