-- 项目表增加公告待发送状态
ALTER TABLE t_b_tender_project ADD send_status_new VARCHAR(2) DEFAULT '00'  COMMENT '发送状态';

ALTER TABLE t_b_tender_bulletin ADD send_status_ceb_new varchar(2) DEFAULT '00' COMMENT '公告是否推送 00未发送，01已发送';

ALTER TABLE t_b_wait_for_send_record ADD send_type VARCHAR(20) COMMENT '发送方式 是老的还是新的 老的old  新的 new ';

-- 新增平台名称（平台名称待修改）
INSERT INTO t_b_system_config VALUES('ff80808155to8635015703ad7zh15lx5','url.tradePlatName','内蒙古电力集团电子商务系统','01','平台名称');

-- 定时任务
INSERT INTO t_s_timetask (`ID`, `CREATE_BY`, `CREATE_DATE`, `CREATE_NAME`, `CRON_EXPRESSION`, `IS_EFFECT`, `IS_START`, `TASK_DESCRIBE`, `TASK_ID`, `UPDATE_BY`, `UPDATE_DATE`, `UPDATE_NAME`) VALUES ('2c913b2861d6ef760161daf50cab062d', 'admin', '2018-02-28 13:49:08', '管理员', '0 0 0/4 * * ?', '1', '1', '定时获取同步到公共服务平台数据', 'waitForSendDataCronNewTrigger', 'admin', '2018-02-28 13:51:02', '管理员');
INSERT INTO t_s_timetask(`ID`, `CREATE_BY`, `CREATE_DATE`, `CREATE_NAME`, `CRON_EXPRESSION`, `IS_EFFECT`, `IS_START`, `TASK_DESCRIBE`, `TASK_ID`, `UPDATE_BY`, `UPDATE_DATE`, `UPDATE_NAME`) VALUES ('2c913b2861d6ef760161daf695800633', 'admin', '2018-02-28 13:50:49', '管理员', '0 0/3 * * * ?', '0', '1', '定时同步到公共服务平台数据', 'sendDataTaskCronNewTrigger', NULL, NULL, NULL);


公告项目涉及审核菜单
update t_b_send_config t set t.use_status='01' where t.config_node in ('ISAUDITNOTICE','ISAUDITCANDIDATEBULLETIN','ISAUDITRESULTBULLETIN');

INSERT INTO `t_b_send_config` (`id`, `config_node`, `config_desc`, `config_type`, `template_path`, `use_status`, `create_time`) 
VALUES ('changebulletinaudit201801301318', 'ISAUDITCHANGEBULLETIN', '是否审核变更公告 00-不需要审核 01-需要审核', 'AUDIT', '0', '01', NULL);

INSERT INTO `t_b_send_config` (`id`, `config_node`, `config_desc`, `config_type`, `template_path`, `use_status`, `create_time`) 
VALUES ('changebulletinaudit201801301451', 'ISAUDITTENDERPROJECT', '是否审核项目 00-不需要审核 01-需要审核', 'AUDIT', '0', '01', NULL);

INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) 
VALUES ('2c913b28612d476d0161314daeed01b1', NULL, '1', '变更公告审核', '18', 'changeBulletinController.do?changeBulletinAuditList', '2c9087e955b8935c0155b8a1d82b0022', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', 'admin', '管理员', NULL, NULL, '2017-02-09 11:34:57', NULL);

INSERT INTO `t_s_typegroup` (`ID`, `typegroupcode`, `typegroupname`) VALUES ('2c913b28612d476d0161314daeed01b1', 'relstatus', '公告发布状态');
INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) VALUES ('2c913b28612d476dwhz001', '00', '临时', NULL, '2c913b28612d476d0161314daeed01b1', '1');
INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) VALUES ('2c913b28612d476dwhz002', '01', '已发布', NULL, '2c913b28612d476d0161314daeed01b1', '2');
INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) VALUES ('2c913b28612d476dwhz003', '03', '待审核', NULL, '2c913b28612d476d0161314daeed01b1', '3');

INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) 
VALUES ('2c9087e9549dcb250154901301501', '03', '待审核', NULL, '2c9087e9549dcb2501549dd3d1e10006', '1');


INSERT INTO `t_s_function` (`ID`, `functioniframe`, `functionlevel`, `functionname`, `functionorder`, `functionurl`, `parentfunctionid`, `iconid`, `desk_iconid`, `functiontype`, `create_by`, `create_name`, `update_by`, `update_date`, `create_date`, `update_name`) 
VALUES ('2c913b28612d476d0161314fa0dc01d6', NULL, '1', '项目审核', '19', 'tBTenderProjectController.do?auditProjectList', '2c9087e955b8935c0155b8a1d82b0022', '8a8ab0b246dc81120146dc8180460000', '8a8ab0b246dc81120146dc8180dd001e', '0', 'admin', '管理员', NULL, NULL, '2017-02-09 11:34:57', NULL);


INSERT INTO `t_s_typegroup` (`ID`, `typegroupcode`, `typegroupname`) VALUES 
('2c90876d614a582801614b2afe6400b6', 'tenderAuditStatus', '审核状态');

INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) VALUES ('2c90876d613ff45101614009d5f60002', '00', '暂存', NULL, '2c90876d614a582801614b2afe6400b6', '1');
INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) VALUES ('2c90876d613ac98601613af74f250031', '01', '审核通过', NULL, '2c90876d614a582801614b2afe6400b6', '2');
INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) VALUES ('2c90876d613ac98601613ad3e52a0007', '02', '审核不通过', NULL, '2c90876d614a582801614b2afe6400b6', '3');
INSERT INTO `t_s_type` (`ID`, `typecode`, `typename`, `typepid`, `typegroupid`, `typesort`) VALUES ('2c90876d612b316501612b5cf9c1005a', '03', '待审核', NULL, '2c90876d614a582801614b2afe6400b6', '4');


INSERT INTO t_b_system_config(id,config_type,config_value,use_status,config_desc) VALUES('ff80808155to865dg25703ad7zh15lx5','industry_version','01','01','行业分类版本');

ALTER TABLE t_b_base_industry ADD industry_version VARCHAR(2) COMMENT '行业分类版本 00:旧版本 01:新版本'; 

UPDATE t_b_base_industry SET industry_version='00'; 

INSERT INTO t_b_base_industry(id,industry_memo,industry_name,INDUSTRY_SORT_NO,INDUSTRY_PARENT_ID,create_time,industry_code,IND_LEVEL,short_spell_name,industry_is_leaf,industry_version) 
VALUES
('G01','房屋建筑','房屋建筑',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G02','市政','市政',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G03','公路','公路',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G04','铁路','铁路',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G05','民航','民航',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G06','水运','水运',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G07','水利水电','水利水电',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G08','能源电力','能源电力',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G09','广电通信','广电通信',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G10','化学工业','化学工业',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G11','石油石化','石油石化',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G12','园林绿化','园林绿化',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G13','生物医药','生物医药',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G14','港口航道','港口航道',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G15','纺织轻工','纺织轻工',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G16','矿产冶金','矿产冶金',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G17','航空航天','航空航天',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G18','生态环保','生态环保',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G19','地球科学','地球科学',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G20','信息电子','信息电子',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G21','科教文卫','科教文卫',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G22','商业服务','商业服务',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G23','农林牧渔','农林牧渔',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G24','保险金融','保险金融',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G25','机械设备','机械设备',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01'),
('G99','其他','其他',1,NULL,'2018-03-04 00:00:00','A','1','NLMYY','0','01');
