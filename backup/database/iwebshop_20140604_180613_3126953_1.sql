DROP TABLE IF EXISTS `w_account_log`;
 CREATE TABLE `w_account_log` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`admin_id` int(11) unsigned NOT NULL  COMMENT '管理员ID',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户id',
`type` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0增加,1减少',
`event` tinyint(3) NOT NULL  COMMENT '操作类型，意义请看accountLog类',
`time` datetime NOT NULL  COMMENT '发生时间',
`amount` decimal(15,2) NOT NULL  COMMENT '金额',
`amount_log` decimal(15,2) NOT NULL  COMMENT '每次增减后面的金额记录',
`note` text NULL  DEFAULT NULL  COMMENT '备注'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='账户余额日志表' AUTO_INCREMENT=4;

INSERT INTO `w_account_log` VALUES( '1','1','1','0','1','2014-06-04 11:13:04','1000.00','1000.00','管理员[1]给用户[1]klchan充值，金额：1000.00元' ); 
INSERT INTO `w_account_log` VALUES( '2','1','1','1','2','2014-06-04 11:14:31','-1000.00','0.00','管理员[1]给用户[1]klchan提现，金额：-1000.00元' ); 
INSERT INTO `w_account_log` VALUES( '3','1','1','0','1','2014-06-04 11:24:49','5000.00','5000.00','管理员[1]给用户[1]klchan充值，金额：5000.00元' ); 
DROP TABLE IF EXISTS `w_ad_manage`;
 CREATE TABLE `w_ad_manage` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '广告ID',
`name` varchar(50) NOT NULL  COMMENT '广告名称',
`type` tinyint(1) NOT NULL  COMMENT '广告类型 1:img 2:flash 3:code 4:文字',
`position_id` int(11) unsigned NOT NULL  COMMENT '广告位ID',
`link` varchar(255) NULL  DEFAULT NULL  COMMENT '链接地址',
`order` smallint(5) NOT NULL  DEFAULT 0 COMMENT '排列顺序',
`width` smallint(5) NOT NULL  COMMENT '广告宽度',
`height` smallint(5) NOT NULL  COMMENT '广告高度',
`start_time` date NULL  DEFAULT NULL  COMMENT '开始时间',
`end_time` date NULL  DEFAULT NULL  COMMENT '结束时间',
`content` text NULL  DEFAULT NULL  COMMENT '图片、flash路径，文字，code等',
`description` varchar(255) NULL  DEFAULT NULL  COMMENT '描述'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='广告记录表' AUTO_INCREMENT=25;

INSERT INTO `w_ad_manage` VALUES( '16','首页左上方广告','1','5','http://www.baidu.com','99','0','0','2011-05-01','2011-08-05','upload/2011/06/07/20110607105359556.png','首页左上方广告' ); 
INSERT INTO `w_ad_manage` VALUES( '23','首页中部通栏广告','1','6','http://www.google.com','99','0','0','2011-05-03','2015-06-11','upload/2011/06/07/20110607105518688.png','首页中部通栏广告' ); 
INSERT INTO `w_ad_manage` VALUES( '18','首页右上方','1','7','http://www.facebook.com','99','0','0','2011-05-02','2015-06-30','upload/2011/06/07/20110607105608864.png','首页右上方' ); 
INSERT INTO `w_ad_manage` VALUES( '19','商品搜索结果页198*120','1','8','http://www.163.com','99','198','120','2011-05-05','2015-06-10','upload/2011/06/07/20110607105655941.png','1' ); 
INSERT INTO `w_ad_manage` VALUES( '22','文章公告内容页左侧','1','10','http://www.jooyea.cn','99','0','0','2011-05-02','2015-12-10','upload/2011/06/07/20110607105620728.png','1' ); 
INSERT INTO `w_ad_manage` VALUES( '24','首页中部通栏广告','1','6','http://www.google.com','99','0','0','2011-05-03','2015-06-11','upload/2011/06/07/20110607105547573.png','首页中部通栏广告' ); 
DROP TABLE IF EXISTS `w_ad_position`;
 CREATE TABLE `w_ad_position` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '广告位ID',
`name` varchar(50) NOT NULL  COMMENT '广告位名称',
`width` smallint(5) NOT NULL  COMMENT '广告位宽度',
`height` smallint(5) NOT NULL  COMMENT '广告位高度',
`type` tinyint(1) NOT NULL  COMMENT '1:img; 2:flash; 3:文字; 4:code; 5:幻灯片',
`fashion` tinyint(1) NOT NULL  COMMENT '1:轮显;2:随即',
`status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '1:开启; 0: 关闭',
`ad_nums` int(11) NOT NULL  COMMENT '广告显示数量'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='广告位记录表' AUTO_INCREMENT=11;

INSERT INTO `w_ad_position` VALUES( '1','页面顶部通栏广告条','0','0','0','1','0','3' ); 
INSERT INTO `w_ad_position` VALUES( '5','首页左上方748*299','748','299','0','1','1','1' ); 
INSERT INTO `w_ad_position` VALUES( '6','首页中部通栏','0','0','0','1','1','1' ); 
INSERT INTO `w_ad_position` VALUES( '7','首页又上方198*104','198','104','0','1','1','1' ); 
INSERT INTO `w_ad_position` VALUES( '8','商品搜索结果页左侧','198','120','0','1','1','1' ); 
INSERT INTO `w_ad_position` VALUES( '10','文章-公告内容页左册','0','0','0','1','1','1' ); 
DROP TABLE IF EXISTS `w_address`;
 CREATE TABLE `w_address` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`accept_name` varchar(20) NOT NULL  COMMENT '收货人姓名',
`zip` varchar(6) NULL  DEFAULT NULL  COMMENT '邮编',
`telphone` varchar(20) NULL  DEFAULT NULL  COMMENT '联系电话',
`country` int(11) unsigned NULL  DEFAULT NULL  COMMENT '国ID',
`province` int(11) unsigned NOT NULL  COMMENT '省ID',
`city` int(11) unsigned NOT NULL  COMMENT '市ID',
`area` int(11) unsigned NOT NULL  COMMENT '区ID',
`address` varchar(250) NOT NULL  COMMENT '收货地址',
`mobile` varchar(20) NULL  DEFAULT NULL  COMMENT '手机',
`default` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否默认,0:为非默认,1:默认'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='收货信息表' AUTO_INCREMENT=2;

INSERT INTO `w_address` VALUES( '1','1','陈家龙','518000','','','440000','440100','440114','龙岗区布吉','15817487535','1' ); 
DROP TABLE IF EXISTS `w_admin`;
 CREATE TABLE `w_admin` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '管理员ID',
`admin_name` varchar(20) NOT NULL  COMMENT '用户名',
`password` varchar(32) NOT NULL  COMMENT '密码',
`role_id` int(11) unsigned NOT NULL  COMMENT '角色ID',
`create_time` datetime NULL  DEFAULT NULL  COMMENT '创建时间',
`email` varchar(255) NULL  DEFAULT NULL  COMMENT 'Email',
`last_ip` varchar(30) NULL  DEFAULT NULL  COMMENT '最后登录IP',
`last_time` datetime NULL  DEFAULT NULL  COMMENT '最后登录时间',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '删除状态 1删除,0正常'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='管理员用户表' AUTO_INCREMENT=3;

INSERT INTO `w_admin` VALUES( '1','admin','7fef6171469e80d32c0559f88b377245','0','2014-06-03 06:35:15','','127.0.0.1','2014-06-04 14:06:18','0' ); 
INSERT INTO `w_admin` VALUES( '2','kefu001','e10adc3949ba59abbe56e057f20f883e','2','2014-06-04 10:49:11','517315432@qq.com','127.0.0.1','2014-06-04 10:51:17','0' ); 
DROP TABLE IF EXISTS `w_admin_role`;
 CREATE TABLE `w_admin_role` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(20) NOT NULL  COMMENT '角色名称',
`rights` text NULL  DEFAULT NULL  COMMENT '权限',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '删除状态 1删除,0正常'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='后台角色分组表' AUTO_INCREMENT=3;

INSERT INTO `w_admin_role` VALUES( '1','客服部主管',',goods@goods_list,goods@goods_stats,goods@goods_img_upload,goods@goods_edit,goods@goods_update,goods@member_price,goods@model_init,goods@attribute_init,goods@search_spec,goods@select_spec,goods@csvImport,goods@importCsvFile,goods@goods_del,goods@goods_recycle_del,goods@goods_recycle_restore,goods@goods_recycle_list,goods@category_list,goods@category_sort,goods@category_edit,goods@category_save,goods@category_del,brand@brand_list,goods@brand_sort,brand@brand_save,brand@brand_edit,brand@brand_del,brand@category_list,brand@category_save,brand@category_edit,brand@category_del,goods@model_list,goods@search_spec,goods@model_update,goods@model_edit,goods@model_del,goods@spec_list,goods@spec_edit,goods@spec_update,goods@spec_del,goods@spec_photo,goods@spec_photo_del,goods@spec_recycle_list,goods@spec_recycle_restore,goods@spec_recycle_del,goods@spec_del,member@member_list,member@member_edit,member@member_save,member@member_reclaim,member@member_del,member@member_restore,member@recycling,member@member_recharge,member@group_list,member@group_edit,member@group_save,member@group_del,member@withdraw_list,member@withdraw_del,member@withdraw_update,member@withdraw_recycle,member@withdraw_status,member@withdraw_detail,comment@suggestion_list,comment@suggestion_edit,comment@suggestion_edit_act,comment@suggestion_del,comment@refer_list,comment@refer_edit,comment@refer_reply,comment@refer_del,comment@discussion_list,comment@discussion_edit,comment@discussion_del,comment@comment_list,comment@comment_edit,comment@comment_del,comment@message_list,comment@message_send,comment@message_del,message@notify_list,message@notify_filter,message@notify_del,message@notify_send,message@notify_export,message@tpl_list,message@registry_list,message@registry_message_send,message@registry_del,message@registry_export,message@tpl_edit,message@tpl_save,order@order_list,order@order_note,order@order_update,order@order_edit,order@gePay_fee,order@order_pri_num,order@order_pri_num_del,order@order_note,order@order_update,order@order_edit,order@order_message,order@order_show,order@order_recycle_restore,order@order_recycle_del,order@order_recycle_list,order@merge_template,order@pick_template,order@shop_template,order@template,order@print_template_update,order@print_template,order@order_del,order@order_delivery_doc,order@order_collection_doc,order@order_complete,order@order_refundment,order@order_collection,order@order_deliver,order@order_collection_list,order@order_collection,order@collection_show,order@collection_del,order@collection_recycle_restore,order@collection_recycle_del,order@collection_recycle_list,order@order_refundment_list,order@order_refundment_del,order@refundment_recycle_list,order@refundment_recycle_restore,order@refundment_recycle_del,order@refundment_show,order@order_refundment,order@order_delivery_list,order@delivery_del,order@delivery_recycle_list,order@delivery_recycle_restore,order@delivery_recycle_del,order@refundment_list,order@refundment_doc_show,order@refundment_doc_del,order@refundment_doc_show_save,order@expresswaybill_edit,order@expresswaybill_edit_act,order@expresswaybill_upload,order@expresswaybill_template,order@expresswaybill_del,order@order_refundment_doc,order@delivery_show,','0' ); 
INSERT INTO `w_admin_role` VALUES( '2','客服部员工',',member@member_list,member@member_edit,member@member_save,member@member_reclaim,member@member_del,member@member_restore,member@recycling,member@member_recharge,member@group_list,member@group_edit,member@group_save,member@group_del,member@withdraw_list,member@withdraw_del,member@withdraw_update,member@withdraw_recycle,member@withdraw_status,member@withdraw_detail,comment@suggestion_list,comment@suggestion_edit,comment@suggestion_edit_act,comment@suggestion_del,comment@refer_list,comment@refer_edit,comment@refer_reply,comment@refer_del,comment@discussion_list,comment@discussion_edit,comment@discussion_del,comment@comment_list,comment@comment_edit,comment@comment_del,comment@message_list,comment@message_send,comment@message_del,message@notify_list,message@notify_filter,message@notify_del,message@notify_send,message@notify_export,message@tpl_list,message@registry_list,message@registry_message_send,message@registry_del,message@registry_export,message@tpl_edit,message@tpl_save,order@order_list,order@order_note,order@order_update,order@order_edit,order@gePay_fee,order@order_pri_num,order@order_pri_num_del,order@order_note,order@order_update,order@order_edit,order@order_message,order@order_show,order@order_recycle_restore,order@order_recycle_del,order@order_recycle_list,order@merge_template,order@pick_template,order@shop_template,order@template,order@print_template_update,order@print_template,order@order_del,order@order_delivery_doc,order@order_collection_doc,order@order_complete,order@order_refundment,order@order_collection,order@order_deliver,order@order_collection_list,order@order_collection,order@collection_show,order@collection_del,order@collection_recycle_restore,order@collection_recycle_del,order@collection_recycle_list,order@order_refundment_list,order@order_refundment_del,order@refundment_recycle_list,order@refundment_recycle_restore,order@refundment_recycle_del,order@refundment_show,order@order_refundment,order@order_delivery_list,order@delivery_del,order@delivery_recycle_list,order@delivery_recycle_restore,order@delivery_recycle_del,order@refundment_list,order@refundment_doc_show,order@refundment_doc_del,order@refundment_doc_show_save,order@expresswaybill_edit,order@expresswaybill_edit_act,order@expresswaybill_upload,order@expresswaybill_template,order@expresswaybill_del,order@order_refundment_doc,order@delivery_show,','0' ); 
DROP TABLE IF EXISTS `w_announcement`;
 CREATE TABLE `w_announcement` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`title` varchar(250) NOT NULL  COMMENT '公告标题',
`content` text NULL  DEFAULT NULL  COMMENT '公告内容',
`time` datetime NOT NULL  COMMENT '发布时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='公告消息表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_areas`;
 CREATE TABLE `w_areas` (
`area_id` int(10) unsigned NOT NULL  PRIMARY KEY auto_increment,
`parent_id` int(10) unsigned NOT NULL  COMMENT '上一级的id值',
`area_name` varchar(50) NOT NULL  COMMENT '地区名称',
`sort` mediumint(8) unsigned NOT NULL  DEFAULT 99 COMMENT '排序'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='地区信息' AUTO_INCREMENT=659005;

INSERT INTO `w_areas` VALUES( '110000','0','北京市','99' ); 
INSERT INTO `w_areas` VALUES( '120000','0','天津市','99' ); 
INSERT INTO `w_areas` VALUES( '130000','0','河北省','99' ); 
INSERT INTO `w_areas` VALUES( '140000','0','山西省','99' ); 
INSERT INTO `w_areas` VALUES( '150000','0','内蒙古自治区','99' ); 
INSERT INTO `w_areas` VALUES( '210000','0','辽宁省','99' ); 
INSERT INTO `w_areas` VALUES( '220000','0','吉林省','99' ); 
INSERT INTO `w_areas` VALUES( '230000','0','黑龙江省','99' ); 
INSERT INTO `w_areas` VALUES( '310000','0','上海市','99' ); 
INSERT INTO `w_areas` VALUES( '320000','0','江苏省','99' ); 
INSERT INTO `w_areas` VALUES( '330000','0','浙江省','99' ); 
INSERT INTO `w_areas` VALUES( '340000','0','安徽省','99' ); 
INSERT INTO `w_areas` VALUES( '350000','0','福建省','99' ); 
INSERT INTO `w_areas` VALUES( '360000','0','江西省','99' ); 
INSERT INTO `w_areas` VALUES( '370000','0','山东省','99' ); 
INSERT INTO `w_areas` VALUES( '410000','0','河南省','99' ); 
INSERT INTO `w_areas` VALUES( '420000','0','湖北省','99' ); 
INSERT INTO `w_areas` VALUES( '430000','0','湖南省','99' ); 
INSERT INTO `w_areas` VALUES( '440000','0','广东省','99' ); 
INSERT INTO `w_areas` VALUES( '450000','0','广西壮族自治区','99' ); 
INSERT INTO `w_areas` VALUES( '460000','0','海南省','99' ); 
INSERT INTO `w_areas` VALUES( '500000','0','重庆市','99' ); 
INSERT INTO `w_areas` VALUES( '510000','0','四川省','99' ); 
INSERT INTO `w_areas` VALUES( '520000','0','贵州省','99' ); 
INSERT INTO `w_areas` VALUES( '530000','0','云南省','99' ); 
INSERT INTO `w_areas` VALUES( '540000','0','西藏自治区','99' ); 
INSERT INTO `w_areas` VALUES( '610000','0','陕西省','99' ); 
INSERT INTO `w_areas` VALUES( '620000','0','甘肃省','99' ); 
INSERT INTO `w_areas` VALUES( '630000','0','青海省','99' ); 
INSERT INTO `w_areas` VALUES( '640000','0','宁夏回族自治区','99' ); 
INSERT INTO `w_areas` VALUES( '650000','0','新疆维吾尔自治区','99' ); 
INSERT INTO `w_areas` VALUES( '110100','110000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '110200','110000','县','99' ); 
INSERT INTO `w_areas` VALUES( '120100','120000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '120200','120000','县','99' ); 
INSERT INTO `w_areas` VALUES( '130100','130000','石家庄市','99' ); 
INSERT INTO `w_areas` VALUES( '130200','130000','唐山市','99' ); 
INSERT INTO `w_areas` VALUES( '130300','130000','秦皇岛市','99' ); 
INSERT INTO `w_areas` VALUES( '130400','130000','邯郸市','99' ); 
INSERT INTO `w_areas` VALUES( '130500','130000','邢台市','99' ); 
INSERT INTO `w_areas` VALUES( '130600','130000','保定市','99' ); 
INSERT INTO `w_areas` VALUES( '130700','130000','张家口市','99' ); 
INSERT INTO `w_areas` VALUES( '130800','130000','承德市','99' ); 
INSERT INTO `w_areas` VALUES( '130900','130000','沧州市','99' ); 
INSERT INTO `w_areas` VALUES( '131000','130000','廊坊市','99' ); 
INSERT INTO `w_areas` VALUES( '131100','130000','衡水市','99' ); 
INSERT INTO `w_areas` VALUES( '140100','140000','太原市','99' ); 
INSERT INTO `w_areas` VALUES( '140200','140000','大同市','99' ); 
INSERT INTO `w_areas` VALUES( '140300','140000','阳泉市','99' ); 
INSERT INTO `w_areas` VALUES( '140400','140000','长治市','99' ); 
INSERT INTO `w_areas` VALUES( '140500','140000','晋城市','99' ); 
INSERT INTO `w_areas` VALUES( '140600','140000','朔州市','99' ); 
INSERT INTO `w_areas` VALUES( '140700','140000','晋中市','99' ); 
INSERT INTO `w_areas` VALUES( '140800','140000','运城市','99' ); 
INSERT INTO `w_areas` VALUES( '140900','140000','忻州市','99' ); 
INSERT INTO `w_areas` VALUES( '141000','140000','临汾市','99' ); 
INSERT INTO `w_areas` VALUES( '141100','140000','吕梁市','99' ); 
INSERT INTO `w_areas` VALUES( '150100','150000','呼和浩特市','99' ); 
INSERT INTO `w_areas` VALUES( '150200','150000','包头市','99' ); 
INSERT INTO `w_areas` VALUES( '150300','150000','乌海市','99' ); 
INSERT INTO `w_areas` VALUES( '150400','150000','赤峰市','99' ); 
INSERT INTO `w_areas` VALUES( '150500','150000','通辽市','99' ); 
INSERT INTO `w_areas` VALUES( '150600','150000','鄂尔多斯市','99' ); 
INSERT INTO `w_areas` VALUES( '150700','150000','呼伦贝尔市','99' ); 
INSERT INTO `w_areas` VALUES( '150800','150000','巴彦淖尔市','99' ); 
INSERT INTO `w_areas` VALUES( '150900','150000','乌兰察布市','99' ); 
INSERT INTO `w_areas` VALUES( '152200','150000','兴安盟','99' ); 
INSERT INTO `w_areas` VALUES( '152500','150000','锡林郭勒盟','99' ); 
INSERT INTO `w_areas` VALUES( '152900','150000','阿拉善盟','99' ); 
INSERT INTO `w_areas` VALUES( '210100','210000','沈阳市','99' ); 
INSERT INTO `w_areas` VALUES( '210200','210000','大连市','99' ); 
INSERT INTO `w_areas` VALUES( '210300','210000','鞍山市','99' ); 
INSERT INTO `w_areas` VALUES( '210400','210000','抚顺市','99' ); 
INSERT INTO `w_areas` VALUES( '210500','210000','本溪市','99' ); 
INSERT INTO `w_areas` VALUES( '210600','210000','丹东市','99' ); 
INSERT INTO `w_areas` VALUES( '210700','210000','锦州市','99' ); 
INSERT INTO `w_areas` VALUES( '210800','210000','营口市','99' ); 
INSERT INTO `w_areas` VALUES( '210900','210000','阜新市','99' ); 
INSERT INTO `w_areas` VALUES( '211000','210000','辽阳市','99' ); 
INSERT INTO `w_areas` VALUES( '211100','210000','盘锦市','99' ); 
INSERT INTO `w_areas` VALUES( '211200','210000','铁岭市','99' ); 
INSERT INTO `w_areas` VALUES( '211300','210000','朝阳市','99' ); 
INSERT INTO `w_areas` VALUES( '211400','210000','葫芦岛市','99' ); 
INSERT INTO `w_areas` VALUES( '220100','220000','长春市','99' ); 
INSERT INTO `w_areas` VALUES( '220200','220000','吉林市','99' ); 
INSERT INTO `w_areas` VALUES( '220300','220000','四平市','99' ); 
INSERT INTO `w_areas` VALUES( '220400','220000','辽源市','99' ); 
INSERT INTO `w_areas` VALUES( '220500','220000','通化市','99' ); 
INSERT INTO `w_areas` VALUES( '220600','220000','白山市','99' ); 
INSERT INTO `w_areas` VALUES( '220700','220000','松原市','99' ); 
INSERT INTO `w_areas` VALUES( '220800','220000','白城市','99' ); 
INSERT INTO `w_areas` VALUES( '222400','220000','延边朝鲜族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '230100','230000','哈尔滨市','99' ); 
INSERT INTO `w_areas` VALUES( '230200','230000','齐齐哈尔市','99' ); 
INSERT INTO `w_areas` VALUES( '230300','230000','鸡西市','99' ); 
INSERT INTO `w_areas` VALUES( '230400','230000','鹤岗市','99' ); 
INSERT INTO `w_areas` VALUES( '230500','230000','双鸭山市','99' ); 
INSERT INTO `w_areas` VALUES( '230600','230000','大庆市','99' ); 
INSERT INTO `w_areas` VALUES( '230700','230000','伊春市','99' ); 
INSERT INTO `w_areas` VALUES( '230800','230000','佳木斯市','99' ); 
INSERT INTO `w_areas` VALUES( '230900','230000','七台河市','99' ); 
INSERT INTO `w_areas` VALUES( '231000','230000','牡丹江市','99' ); 
INSERT INTO `w_areas` VALUES( '231100','230000','黑河市','99' ); 
INSERT INTO `w_areas` VALUES( '231200','230000','绥化市','99' ); 
INSERT INTO `w_areas` VALUES( '232700','230000','大兴安岭地区','99' ); 
INSERT INTO `w_areas` VALUES( '310100','310000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '310200','310000','县','99' ); 
INSERT INTO `w_areas` VALUES( '320100','320000','南京市','99' ); 
INSERT INTO `w_areas` VALUES( '320200','320000','无锡市','99' ); 
INSERT INTO `w_areas` VALUES( '320300','320000','徐州市','99' ); 
INSERT INTO `w_areas` VALUES( '320400','320000','常州市','99' ); 
INSERT INTO `w_areas` VALUES( '320500','320000','苏州市','99' ); 
INSERT INTO `w_areas` VALUES( '320600','320000','南通市','99' ); 
INSERT INTO `w_areas` VALUES( '320700','320000','连云港市','99' ); 
INSERT INTO `w_areas` VALUES( '320800','320000','淮安市','99' ); 
INSERT INTO `w_areas` VALUES( '320900','320000','盐城市','99' ); 
INSERT INTO `w_areas` VALUES( '321000','320000','扬州市','99' ); 
INSERT INTO `w_areas` VALUES( '321100','320000','镇江市','99' ); 
INSERT INTO `w_areas` VALUES( '321200','320000','泰州市','99' ); 
INSERT INTO `w_areas` VALUES( '321300','320000','宿迁市','99' ); 
INSERT INTO `w_areas` VALUES( '330100','330000','杭州市','99' ); 
INSERT INTO `w_areas` VALUES( '330200','330000','宁波市','99' ); 
INSERT INTO `w_areas` VALUES( '330300','330000','温州市','99' ); 
INSERT INTO `w_areas` VALUES( '330400','330000','嘉兴市','99' ); 
INSERT INTO `w_areas` VALUES( '330500','330000','湖州市','99' ); 
INSERT INTO `w_areas` VALUES( '330600','330000','绍兴市','99' ); 
INSERT INTO `w_areas` VALUES( '330700','330000','金华市','99' ); 
INSERT INTO `w_areas` VALUES( '330800','330000','衢州市','99' ); 
INSERT INTO `w_areas` VALUES( '330900','330000','舟山市','99' ); 
INSERT INTO `w_areas` VALUES( '331000','330000','台州市','99' ); 
INSERT INTO `w_areas` VALUES( '331100','330000','丽水市','99' ); 
INSERT INTO `w_areas` VALUES( '340100','340000','合肥市','99' ); 
INSERT INTO `w_areas` VALUES( '340200','340000','芜湖市','99' ); 
INSERT INTO `w_areas` VALUES( '340300','340000','蚌埠市','99' ); 
INSERT INTO `w_areas` VALUES( '340400','340000','淮南市','99' ); 
INSERT INTO `w_areas` VALUES( '340500','340000','马鞍山市','99' ); 
INSERT INTO `w_areas` VALUES( '340600','340000','淮北市','99' ); 
INSERT INTO `w_areas` VALUES( '340700','340000','铜陵市','99' ); 
INSERT INTO `w_areas` VALUES( '340800','340000','安庆市','99' ); 
INSERT INTO `w_areas` VALUES( '341000','340000','黄山市','99' ); 
INSERT INTO `w_areas` VALUES( '341100','340000','滁州市','99' ); 
INSERT INTO `w_areas` VALUES( '341200','340000','阜阳市','99' ); 
INSERT INTO `w_areas` VALUES( '341300','340000','宿州市','99' ); 
INSERT INTO `w_areas` VALUES( '341500','340000','六安市','99' ); 
INSERT INTO `w_areas` VALUES( '341600','340000','亳州市','99' ); 
INSERT INTO `w_areas` VALUES( '341700','340000','池州市','99' ); 
INSERT INTO `w_areas` VALUES( '341800','340000','宣城市','99' ); 
INSERT INTO `w_areas` VALUES( '350100','350000','福州市','99' ); 
INSERT INTO `w_areas` VALUES( '350200','350000','厦门市','99' ); 
INSERT INTO `w_areas` VALUES( '350300','350000','莆田市','99' ); 
INSERT INTO `w_areas` VALUES( '350400','350000','三明市','99' ); 
INSERT INTO `w_areas` VALUES( '350500','350000','泉州市','99' ); 
INSERT INTO `w_areas` VALUES( '350600','350000','漳州市','99' ); 
INSERT INTO `w_areas` VALUES( '350700','350000','南平市','99' ); 
INSERT INTO `w_areas` VALUES( '350800','350000','龙岩市','99' ); 
INSERT INTO `w_areas` VALUES( '350900','350000','宁德市','99' ); 
INSERT INTO `w_areas` VALUES( '360100','360000','南昌市','99' ); 
INSERT INTO `w_areas` VALUES( '360200','360000','景德镇市','99' ); 
INSERT INTO `w_areas` VALUES( '360300','360000','萍乡市','99' ); 
INSERT INTO `w_areas` VALUES( '360400','360000','九江市','99' ); 
INSERT INTO `w_areas` VALUES( '360500','360000','新余市','99' ); 
INSERT INTO `w_areas` VALUES( '360600','360000','鹰潭市','99' ); 
INSERT INTO `w_areas` VALUES( '360700','360000','赣州市','99' ); 
INSERT INTO `w_areas` VALUES( '360800','360000','吉安市','99' ); 
INSERT INTO `w_areas` VALUES( '360900','360000','宜春市','99' ); 
INSERT INTO `w_areas` VALUES( '361000','360000','抚州市','99' ); 
INSERT INTO `w_areas` VALUES( '361100','360000','上饶市','99' ); 
INSERT INTO `w_areas` VALUES( '370100','370000','济南市','99' ); 
INSERT INTO `w_areas` VALUES( '370200','370000','青岛市','99' ); 
INSERT INTO `w_areas` VALUES( '370300','370000','淄博市','99' ); 
INSERT INTO `w_areas` VALUES( '370400','370000','枣庄市','99' ); 
INSERT INTO `w_areas` VALUES( '370500','370000','东营市','99' ); 
INSERT INTO `w_areas` VALUES( '370600','370000','烟台市','99' ); 
INSERT INTO `w_areas` VALUES( '370700','370000','潍坊市','99' ); 
INSERT INTO `w_areas` VALUES( '370800','370000','济宁市','99' ); 
INSERT INTO `w_areas` VALUES( '370900','370000','泰安市','99' ); 
INSERT INTO `w_areas` VALUES( '371000','370000','威海市','99' ); 
INSERT INTO `w_areas` VALUES( '371100','370000','日照市','99' ); 
INSERT INTO `w_areas` VALUES( '371200','370000','莱芜市','99' ); 
INSERT INTO `w_areas` VALUES( '371300','370000','临沂市','99' ); 
INSERT INTO `w_areas` VALUES( '371400','370000','德州市','99' ); 
INSERT INTO `w_areas` VALUES( '371500','370000','聊城市','99' ); 
INSERT INTO `w_areas` VALUES( '371600','370000','滨州市','99' ); 
INSERT INTO `w_areas` VALUES( '371700','370000','菏泽市','99' ); 
INSERT INTO `w_areas` VALUES( '410100','410000','郑州市','99' ); 
INSERT INTO `w_areas` VALUES( '410200','410000','开封市','99' ); 
INSERT INTO `w_areas` VALUES( '410300','410000','洛阳市','99' ); 
INSERT INTO `w_areas` VALUES( '410400','410000','平顶山市','99' ); 
INSERT INTO `w_areas` VALUES( '410500','410000','安阳市','99' ); 
INSERT INTO `w_areas` VALUES( '410600','410000','鹤壁市','99' ); 
INSERT INTO `w_areas` VALUES( '410700','410000','新乡市','99' ); 
INSERT INTO `w_areas` VALUES( '410800','410000','焦作市','99' ); 
INSERT INTO `w_areas` VALUES( '410900','410000','濮阳市','99' ); 
INSERT INTO `w_areas` VALUES( '411000','410000','许昌市','99' ); 
INSERT INTO `w_areas` VALUES( '411100','410000','漯河市','99' ); 
INSERT INTO `w_areas` VALUES( '411200','410000','三门峡市','99' ); 
INSERT INTO `w_areas` VALUES( '411300','410000','南阳市','99' ); 
INSERT INTO `w_areas` VALUES( '411400','410000','商丘市','99' ); 
INSERT INTO `w_areas` VALUES( '411500','410000','信阳市','99' ); 
INSERT INTO `w_areas` VALUES( '411600','410000','周口市','99' ); 
INSERT INTO `w_areas` VALUES( '411700','410000','驻马店市','99' ); 
INSERT INTO `w_areas` VALUES( '419000','410000','省直辖县级行政区划','99' ); 
INSERT INTO `w_areas` VALUES( '420100','420000','武汉市','99' ); 
INSERT INTO `w_areas` VALUES( '420200','420000','黄石市','99' ); 
INSERT INTO `w_areas` VALUES( '420300','420000','十堰市','99' ); 
INSERT INTO `w_areas` VALUES( '420500','420000','宜昌市','99' ); 
INSERT INTO `w_areas` VALUES( '420600','420000','襄阳市','99' ); 
INSERT INTO `w_areas` VALUES( '420700','420000','鄂州市','99' ); 
INSERT INTO `w_areas` VALUES( '420800','420000','荆门市','99' ); 
INSERT INTO `w_areas` VALUES( '420900','420000','孝感市','99' ); 
INSERT INTO `w_areas` VALUES( '421000','420000','荆州市','99' ); 
INSERT INTO `w_areas` VALUES( '421100','420000','黄冈市','99' ); 
INSERT INTO `w_areas` VALUES( '421200','420000','咸宁市','99' ); 
INSERT INTO `w_areas` VALUES( '421300','420000','随州市','99' ); 
INSERT INTO `w_areas` VALUES( '422800','420000','恩施土家族苗族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '429000','420000','省直辖县级行政区划','99' ); 
INSERT INTO `w_areas` VALUES( '430100','430000','长沙市','99' ); 
INSERT INTO `w_areas` VALUES( '430200','430000','株洲市','99' ); 
INSERT INTO `w_areas` VALUES( '430300','430000','湘潭市','99' ); 
INSERT INTO `w_areas` VALUES( '430400','430000','衡阳市','99' ); 
INSERT INTO `w_areas` VALUES( '430500','430000','邵阳市','99' ); 
INSERT INTO `w_areas` VALUES( '430600','430000','岳阳市','99' ); 
INSERT INTO `w_areas` VALUES( '430700','430000','常德市','99' ); 
INSERT INTO `w_areas` VALUES( '430800','430000','张家界市','99' ); 
INSERT INTO `w_areas` VALUES( '430900','430000','益阳市','99' ); 
INSERT INTO `w_areas` VALUES( '431000','430000','郴州市','99' ); 
INSERT INTO `w_areas` VALUES( '431100','430000','永州市','99' ); 
INSERT INTO `w_areas` VALUES( '431200','430000','怀化市','99' ); 
INSERT INTO `w_areas` VALUES( '431300','430000','娄底市','99' ); 
INSERT INTO `w_areas` VALUES( '433100','430000','湘西土家族苗族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '440100','440000','广州市','99' ); 
INSERT INTO `w_areas` VALUES( '440200','440000','韶关市','99' ); 
INSERT INTO `w_areas` VALUES( '440300','440000','深圳市','99' ); 
INSERT INTO `w_areas` VALUES( '440400','440000','珠海市','99' ); 
INSERT INTO `w_areas` VALUES( '440500','440000','汕头市','99' ); 
INSERT INTO `w_areas` VALUES( '440600','440000','佛山市','99' ); 
INSERT INTO `w_areas` VALUES( '440700','440000','江门市','99' ); 
INSERT INTO `w_areas` VALUES( '440800','440000','湛江市','99' ); 
INSERT INTO `w_areas` VALUES( '440900','440000','茂名市','99' ); 
INSERT INTO `w_areas` VALUES( '441200','440000','肇庆市','99' ); 
INSERT INTO `w_areas` VALUES( '441300','440000','惠州市','99' ); 
INSERT INTO `w_areas` VALUES( '441400','440000','梅州市','99' ); 
INSERT INTO `w_areas` VALUES( '441500','440000','汕尾市','99' ); 
INSERT INTO `w_areas` VALUES( '441600','440000','河源市','99' ); 
INSERT INTO `w_areas` VALUES( '441700','440000','阳江市','99' ); 
INSERT INTO `w_areas` VALUES( '441800','440000','清远市','99' ); 
INSERT INTO `w_areas` VALUES( '441900','440000','东莞市','99' ); 
INSERT INTO `w_areas` VALUES( '442000','440000','中山市','99' ); 
INSERT INTO `w_areas` VALUES( '445100','440000','潮州市','99' ); 
INSERT INTO `w_areas` VALUES( '445200','440000','揭阳市','99' ); 
INSERT INTO `w_areas` VALUES( '445300','440000','云浮市','99' ); 
INSERT INTO `w_areas` VALUES( '450100','450000','南宁市','99' ); 
INSERT INTO `w_areas` VALUES( '450200','450000','柳州市','99' ); 
INSERT INTO `w_areas` VALUES( '450300','450000','桂林市','99' ); 
INSERT INTO `w_areas` VALUES( '450400','450000','梧州市','99' ); 
INSERT INTO `w_areas` VALUES( '450500','450000','北海市','99' ); 
INSERT INTO `w_areas` VALUES( '450600','450000','防城港市','99' ); 
INSERT INTO `w_areas` VALUES( '450700','450000','钦州市','99' ); 
INSERT INTO `w_areas` VALUES( '450800','450000','贵港市','99' ); 
INSERT INTO `w_areas` VALUES( '450900','450000','玉林市','99' ); 
INSERT INTO `w_areas` VALUES( '451000','450000','百色市','99' ); 
INSERT INTO `w_areas` VALUES( '451100','450000','贺州市','99' ); 
INSERT INTO `w_areas` VALUES( '451200','450000','河池市','99' ); 
INSERT INTO `w_areas` VALUES( '451300','450000','来宾市','99' ); 
INSERT INTO `w_areas` VALUES( '451400','450000','崇左市','99' ); 
INSERT INTO `w_areas` VALUES( '460100','460000','海口市','99' ); 
INSERT INTO `w_areas` VALUES( '460200','460000','三亚市','99' ); 
INSERT INTO `w_areas` VALUES( '460300','460000','三沙市','99' ); 
INSERT INTO `w_areas` VALUES( '469000','460000','省直辖县级行政区划','99' ); 
INSERT INTO `w_areas` VALUES( '500100','500000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '500200','500000','县','99' ); 
INSERT INTO `w_areas` VALUES( '510100','510000','成都市','99' ); 
INSERT INTO `w_areas` VALUES( '510300','510000','自贡市','99' ); 
INSERT INTO `w_areas` VALUES( '510400','510000','攀枝花市','99' ); 
INSERT INTO `w_areas` VALUES( '510500','510000','泸州市','99' ); 
INSERT INTO `w_areas` VALUES( '510600','510000','德阳市','99' ); 
INSERT INTO `w_areas` VALUES( '510700','510000','绵阳市','99' ); 
INSERT INTO `w_areas` VALUES( '510800','510000','广元市','99' ); 
INSERT INTO `w_areas` VALUES( '510900','510000','遂宁市','99' ); 
INSERT INTO `w_areas` VALUES( '511000','510000','内江市','99' ); 
INSERT INTO `w_areas` VALUES( '511100','510000','乐山市','99' ); 
INSERT INTO `w_areas` VALUES( '511300','510000','南充市','99' ); 
INSERT INTO `w_areas` VALUES( '511400','510000','眉山市','99' ); 
INSERT INTO `w_areas` VALUES( '511500','510000','宜宾市','99' ); 
INSERT INTO `w_areas` VALUES( '511600','510000','广安市','99' ); 
INSERT INTO `w_areas` VALUES( '511700','510000','达州市','99' ); 
INSERT INTO `w_areas` VALUES( '511800','510000','雅安市','99' ); 
INSERT INTO `w_areas` VALUES( '511900','510000','巴中市','99' ); 
INSERT INTO `w_areas` VALUES( '512000','510000','资阳市','99' ); 
INSERT INTO `w_areas` VALUES( '513200','510000','阿坝藏族羌族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '513300','510000','甘孜藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '513400','510000','凉山彝族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '520100','520000','贵阳市','99' ); 
INSERT INTO `w_areas` VALUES( '520200','520000','六盘水市','99' ); 
INSERT INTO `w_areas` VALUES( '520300','520000','遵义市','99' ); 
INSERT INTO `w_areas` VALUES( '520400','520000','安顺市','99' ); 
INSERT INTO `w_areas` VALUES( '520500','520000','毕节市','99' ); 
INSERT INTO `w_areas` VALUES( '520600','520000','铜仁市','99' ); 
INSERT INTO `w_areas` VALUES( '522300','520000','黔西南布依族苗族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '522600','520000','黔东南苗族侗族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '522700','520000','黔南布依族苗族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '530100','530000','昆明市','99' ); 
INSERT INTO `w_areas` VALUES( '530300','530000','曲靖市','99' ); 
INSERT INTO `w_areas` VALUES( '530400','530000','玉溪市','99' ); 
INSERT INTO `w_areas` VALUES( '530500','530000','保山市','99' ); 
INSERT INTO `w_areas` VALUES( '530600','530000','昭通市','99' ); 
INSERT INTO `w_areas` VALUES( '530700','530000','丽江市','99' ); 
INSERT INTO `w_areas` VALUES( '530800','530000','普洱市','99' ); 
INSERT INTO `w_areas` VALUES( '530900','530000','临沧市','99' ); 
INSERT INTO `w_areas` VALUES( '532300','530000','楚雄彝族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '532500','530000','红河哈尼族彝族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '532600','530000','文山壮族苗族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '532800','530000','西双版纳傣族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '532900','530000','大理白族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '533100','530000','德宏傣族景颇族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '533300','530000','怒江傈僳族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '533400','530000','迪庆藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '540100','540000','拉萨市','99' ); 
INSERT INTO `w_areas` VALUES( '542100','540000','昌都地区','99' ); 
INSERT INTO `w_areas` VALUES( '542200','540000','山南地区','99' ); 
INSERT INTO `w_areas` VALUES( '542300','540000','日喀则地区','99' ); 
INSERT INTO `w_areas` VALUES( '542400','540000','那曲地区','99' ); 
INSERT INTO `w_areas` VALUES( '542500','540000','阿里地区','99' ); 
INSERT INTO `w_areas` VALUES( '542600','540000','林芝地区','99' ); 
INSERT INTO `w_areas` VALUES( '610100','610000','西安市','99' ); 
INSERT INTO `w_areas` VALUES( '610200','610000','铜川市','99' ); 
INSERT INTO `w_areas` VALUES( '610300','610000','宝鸡市','99' ); 
INSERT INTO `w_areas` VALUES( '610400','610000','咸阳市','99' ); 
INSERT INTO `w_areas` VALUES( '610500','610000','渭南市','99' ); 
INSERT INTO `w_areas` VALUES( '610600','610000','延安市','99' ); 
INSERT INTO `w_areas` VALUES( '610700','610000','汉中市','99' ); 
INSERT INTO `w_areas` VALUES( '610800','610000','榆林市','99' ); 
INSERT INTO `w_areas` VALUES( '610900','610000','安康市','99' ); 
INSERT INTO `w_areas` VALUES( '611000','610000','商洛市','99' ); 
INSERT INTO `w_areas` VALUES( '620100','620000','兰州市','99' ); 
INSERT INTO `w_areas` VALUES( '620200','620000','嘉峪关市','99' ); 
INSERT INTO `w_areas` VALUES( '620300','620000','金昌市','99' ); 
INSERT INTO `w_areas` VALUES( '620400','620000','白银市','99' ); 
INSERT INTO `w_areas` VALUES( '620500','620000','天水市','99' ); 
INSERT INTO `w_areas` VALUES( '620600','620000','武威市','99' ); 
INSERT INTO `w_areas` VALUES( '620700','620000','张掖市','99' ); 
INSERT INTO `w_areas` VALUES( '620800','620000','平凉市','99' ); 
INSERT INTO `w_areas` VALUES( '620900','620000','酒泉市','99' ); 
INSERT INTO `w_areas` VALUES( '621000','620000','庆阳市','99' ); 
INSERT INTO `w_areas` VALUES( '621100','620000','定西市','99' ); 
INSERT INTO `w_areas` VALUES( '621200','620000','陇南市','99' ); 
INSERT INTO `w_areas` VALUES( '622900','620000','临夏回族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '623000','620000','甘南藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '630100','630000','西宁市','99' ); 
INSERT INTO `w_areas` VALUES( '632100','630000','海东地区','99' ); 
INSERT INTO `w_areas` VALUES( '632200','630000','海北藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '632300','630000','黄南藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '632500','630000','海南藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '632600','630000','果洛藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '632700','630000','玉树藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '632800','630000','海西蒙古族藏族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '640100','640000','银川市','99' ); 
INSERT INTO `w_areas` VALUES( '640200','640000','石嘴山市','99' ); 
INSERT INTO `w_areas` VALUES( '640300','640000','吴忠市','99' ); 
INSERT INTO `w_areas` VALUES( '640400','640000','固原市','99' ); 
INSERT INTO `w_areas` VALUES( '640500','640000','中卫市','99' ); 
INSERT INTO `w_areas` VALUES( '650100','650000','乌鲁木齐市','99' ); 
INSERT INTO `w_areas` VALUES( '650200','650000','克拉玛依市','99' ); 
INSERT INTO `w_areas` VALUES( '652100','650000','吐鲁番地区','99' ); 
INSERT INTO `w_areas` VALUES( '652200','650000','哈密地区','99' ); 
INSERT INTO `w_areas` VALUES( '652300','650000','昌吉回族自治州','99' ); 
INSERT INTO `w_areas` VALUES( '652700','650000','博尔塔拉蒙古自治州','99' ); 
INSERT INTO `w_areas` VALUES( '652800','650000','巴音郭楞蒙古自治州','99' ); 
INSERT INTO `w_areas` VALUES( '652900','650000','阿克苏地区','99' ); 
INSERT INTO `w_areas` VALUES( '653000','650000','克孜勒苏柯尔克孜自治州','99' ); 
INSERT INTO `w_areas` VALUES( '653100','650000','喀什地区','99' ); 
INSERT INTO `w_areas` VALUES( '653200','650000','和田地区','99' ); 
INSERT INTO `w_areas` VALUES( '654000','650000','伊犁哈萨克自治州','99' ); 
INSERT INTO `w_areas` VALUES( '654200','650000','塔城地区','99' ); 
INSERT INTO `w_areas` VALUES( '654300','650000','阿勒泰地区','99' ); 
INSERT INTO `w_areas` VALUES( '659000','650000','自治区直辖县级行政区划','99' ); 
INSERT INTO `w_areas` VALUES( '110101','110100','东城区','99' ); 
INSERT INTO `w_areas` VALUES( '110102','110100','西城区','99' ); 
INSERT INTO `w_areas` VALUES( '110105','110100','朝阳区','99' ); 
INSERT INTO `w_areas` VALUES( '110106','110100','丰台区','99' ); 
INSERT INTO `w_areas` VALUES( '110107','110100','石景山区','99' ); 
INSERT INTO `w_areas` VALUES( '110108','110100','海淀区','99' ); 
INSERT INTO `w_areas` VALUES( '110109','110100','门头沟区','99' ); 
INSERT INTO `w_areas` VALUES( '110111','110100','房山区','99' ); 
INSERT INTO `w_areas` VALUES( '110112','110100','通州区','99' ); 
INSERT INTO `w_areas` VALUES( '110113','110100','顺义区','99' ); 
INSERT INTO `w_areas` VALUES( '110114','110100','昌平区','99' ); 
INSERT INTO `w_areas` VALUES( '110115','110100','大兴区','99' ); 
INSERT INTO `w_areas` VALUES( '110116','110100','怀柔区','99' ); 
INSERT INTO `w_areas` VALUES( '110117','110100','平谷区','99' ); 
INSERT INTO `w_areas` VALUES( '110228','110200','密云县','99' ); 
INSERT INTO `w_areas` VALUES( '110229','110200','延庆县','99' ); 
INSERT INTO `w_areas` VALUES( '120101','120100','和平区','99' ); 
INSERT INTO `w_areas` VALUES( '120102','120100','河东区','99' ); 
INSERT INTO `w_areas` VALUES( '120103','120100','河西区','99' ); 
INSERT INTO `w_areas` VALUES( '120104','120100','南开区','99' ); 
INSERT INTO `w_areas` VALUES( '120105','120100','河北区','99' ); 
INSERT INTO `w_areas` VALUES( '120106','120100','红桥区','99' ); 
INSERT INTO `w_areas` VALUES( '120110','120100','东丽区','99' ); 
INSERT INTO `w_areas` VALUES( '120111','120100','西青区','99' ); 
INSERT INTO `w_areas` VALUES( '120112','120100','津南区','99' ); 
INSERT INTO `w_areas` VALUES( '120113','120100','北辰区','99' ); 
INSERT INTO `w_areas` VALUES( '120114','120100','武清区','99' ); 
INSERT INTO `w_areas` VALUES( '120115','120100','宝坻区','99' ); 
INSERT INTO `w_areas` VALUES( '120116','120100','滨海新区','99' ); 
INSERT INTO `w_areas` VALUES( '120221','120200','宁河县','99' ); 
INSERT INTO `w_areas` VALUES( '120223','120200','静海县','99' ); 
INSERT INTO `w_areas` VALUES( '120225','120200','蓟县','99' ); 
INSERT INTO `w_areas` VALUES( '130101','130100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130102','130100','长安区','99' ); 
INSERT INTO `w_areas` VALUES( '130103','130100','桥东区','99' ); 
INSERT INTO `w_areas` VALUES( '130104','130100','桥西区','99' ); 
INSERT INTO `w_areas` VALUES( '130105','130100','新华区','99' ); 
INSERT INTO `w_areas` VALUES( '130107','130100','井陉矿区','99' ); 
INSERT INTO `w_areas` VALUES( '130108','130100','裕华区','99' ); 
INSERT INTO `w_areas` VALUES( '130121','130100','井陉县','99' ); 
INSERT INTO `w_areas` VALUES( '130123','130100','正定县','99' ); 
INSERT INTO `w_areas` VALUES( '130124','130100','栾城县','99' ); 
INSERT INTO `w_areas` VALUES( '130125','130100','行唐县','99' ); 
INSERT INTO `w_areas` VALUES( '130126','130100','灵寿县','99' ); 
INSERT INTO `w_areas` VALUES( '130127','130100','高邑县','99' ); 
INSERT INTO `w_areas` VALUES( '130128','130100','深泽县','99' ); 
INSERT INTO `w_areas` VALUES( '130129','130100','赞皇县','99' ); 
INSERT INTO `w_areas` VALUES( '130130','130100','无极县','99' ); 
INSERT INTO `w_areas` VALUES( '130131','130100','平山县','99' ); 
INSERT INTO `w_areas` VALUES( '130132','130100','元氏县','99' ); 
INSERT INTO `w_areas` VALUES( '130133','130100','赵县','99' ); 
INSERT INTO `w_areas` VALUES( '130181','130100','辛集市','99' ); 
INSERT INTO `w_areas` VALUES( '130182','130100','藁城市','99' ); 
INSERT INTO `w_areas` VALUES( '130183','130100','晋州市','99' ); 
INSERT INTO `w_areas` VALUES( '130184','130100','新乐市','99' ); 
INSERT INTO `w_areas` VALUES( '130185','130100','鹿泉市','99' ); 
INSERT INTO `w_areas` VALUES( '130201','130200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130202','130200','路南区','99' ); 
INSERT INTO `w_areas` VALUES( '130203','130200','路北区','99' ); 
INSERT INTO `w_areas` VALUES( '130204','130200','古冶区','99' ); 
INSERT INTO `w_areas` VALUES( '130205','130200','开平区','99' ); 
INSERT INTO `w_areas` VALUES( '130207','130200','丰南区','99' ); 
INSERT INTO `w_areas` VALUES( '130208','130200','丰润区','99' ); 
INSERT INTO `w_areas` VALUES( '130209','130200','曹妃甸区','99' ); 
INSERT INTO `w_areas` VALUES( '130223','130200','滦县','99' ); 
INSERT INTO `w_areas` VALUES( '130224','130200','滦南县','99' ); 
INSERT INTO `w_areas` VALUES( '130225','130200','乐亭县','99' ); 
INSERT INTO `w_areas` VALUES( '130227','130200','迁西县','99' ); 
INSERT INTO `w_areas` VALUES( '130229','130200','玉田县','99' ); 
INSERT INTO `w_areas` VALUES( '130281','130200','遵化市','99' ); 
INSERT INTO `w_areas` VALUES( '130283','130200','迁安市','99' ); 
INSERT INTO `w_areas` VALUES( '130301','130300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130302','130300','海港区','99' ); 
INSERT INTO `w_areas` VALUES( '130303','130300','山海关区','99' ); 
INSERT INTO `w_areas` VALUES( '130304','130300','北戴河区','99' ); 
INSERT INTO `w_areas` VALUES( '130321','130300','青龙满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '130322','130300','昌黎县','99' ); 
INSERT INTO `w_areas` VALUES( '130323','130300','抚宁县','99' ); 
INSERT INTO `w_areas` VALUES( '130324','130300','卢龙县','99' ); 
INSERT INTO `w_areas` VALUES( '130401','130400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130402','130400','邯山区','99' ); 
INSERT INTO `w_areas` VALUES( '130403','130400','丛台区','99' ); 
INSERT INTO `w_areas` VALUES( '130404','130400','复兴区','99' ); 
INSERT INTO `w_areas` VALUES( '130406','130400','峰峰矿区','99' ); 
INSERT INTO `w_areas` VALUES( '130421','130400','邯郸县','99' ); 
INSERT INTO `w_areas` VALUES( '130423','130400','临漳县','99' ); 
INSERT INTO `w_areas` VALUES( '130424','130400','成安县','99' ); 
INSERT INTO `w_areas` VALUES( '130425','130400','大名县','99' ); 
INSERT INTO `w_areas` VALUES( '130426','130400','涉县','99' ); 
INSERT INTO `w_areas` VALUES( '130427','130400','磁县','99' ); 
INSERT INTO `w_areas` VALUES( '130428','130400','肥乡县','99' ); 
INSERT INTO `w_areas` VALUES( '130429','130400','永年县','99' ); 
INSERT INTO `w_areas` VALUES( '130430','130400','邱县','99' ); 
INSERT INTO `w_areas` VALUES( '130431','130400','鸡泽县','99' ); 
INSERT INTO `w_areas` VALUES( '130432','130400','广平县','99' ); 
INSERT INTO `w_areas` VALUES( '130433','130400','馆陶县','99' ); 
INSERT INTO `w_areas` VALUES( '130434','130400','魏县','99' ); 
INSERT INTO `w_areas` VALUES( '130435','130400','曲周县','99' ); 
INSERT INTO `w_areas` VALUES( '130481','130400','武安市','99' ); 
INSERT INTO `w_areas` VALUES( '130501','130500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130502','130500','桥东区','99' ); 
INSERT INTO `w_areas` VALUES( '130503','130500','桥西区','99' ); 
INSERT INTO `w_areas` VALUES( '130521','130500','邢台县','99' ); 
INSERT INTO `w_areas` VALUES( '130522','130500','临城县','99' ); 
INSERT INTO `w_areas` VALUES( '130523','130500','内丘县','99' ); 
INSERT INTO `w_areas` VALUES( '130524','130500','柏乡县','99' ); 
INSERT INTO `w_areas` VALUES( '130525','130500','隆尧县','99' ); 
INSERT INTO `w_areas` VALUES( '130526','130500','任县','99' ); 
INSERT INTO `w_areas` VALUES( '130527','130500','南和县','99' ); 
INSERT INTO `w_areas` VALUES( '130528','130500','宁晋县','99' ); 
INSERT INTO `w_areas` VALUES( '130529','130500','巨鹿县','99' ); 
INSERT INTO `w_areas` VALUES( '130530','130500','新河县','99' ); 
INSERT INTO `w_areas` VALUES( '130531','130500','广宗县','99' ); 
INSERT INTO `w_areas` VALUES( '130532','130500','平乡县','99' ); 
INSERT INTO `w_areas` VALUES( '130533','130500','威县','99' ); 
INSERT INTO `w_areas` VALUES( '130534','130500','清河县','99' ); 
INSERT INTO `w_areas` VALUES( '130535','130500','临西县','99' ); 
INSERT INTO `w_areas` VALUES( '130581','130500','南宫市','99' ); 
INSERT INTO `w_areas` VALUES( '130582','130500','沙河市','99' ); 
INSERT INTO `w_areas` VALUES( '130601','130600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130602','130600','新市区','99' ); 
INSERT INTO `w_areas` VALUES( '130603','130600','北市区','99' ); 
INSERT INTO `w_areas` VALUES( '130604','130600','南市区','99' ); 
INSERT INTO `w_areas` VALUES( '130621','130600','满城县','99' ); 
INSERT INTO `w_areas` VALUES( '130622','130600','清苑县','99' ); 
INSERT INTO `w_areas` VALUES( '130623','130600','涞水县','99' ); 
INSERT INTO `w_areas` VALUES( '130624','130600','阜平县','99' ); 
INSERT INTO `w_areas` VALUES( '130625','130600','徐水县','99' ); 
INSERT INTO `w_areas` VALUES( '130626','130600','定兴县','99' ); 
INSERT INTO `w_areas` VALUES( '130627','130600','唐县','99' ); 
INSERT INTO `w_areas` VALUES( '130628','130600','高阳县','99' ); 
INSERT INTO `w_areas` VALUES( '130629','130600','容城县','99' ); 
INSERT INTO `w_areas` VALUES( '130630','130600','涞源县','99' ); 
INSERT INTO `w_areas` VALUES( '130631','130600','望都县','99' ); 
INSERT INTO `w_areas` VALUES( '130632','130600','安新县','99' ); 
INSERT INTO `w_areas` VALUES( '130633','130600','易县','99' ); 
INSERT INTO `w_areas` VALUES( '130634','130600','曲阳县','99' ); 
INSERT INTO `w_areas` VALUES( '130635','130600','蠡县','99' ); 
INSERT INTO `w_areas` VALUES( '130636','130600','顺平县','99' ); 
INSERT INTO `w_areas` VALUES( '130637','130600','博野县','99' ); 
INSERT INTO `w_areas` VALUES( '130638','130600','雄县','99' ); 
INSERT INTO `w_areas` VALUES( '130681','130600','涿州市','99' ); 
INSERT INTO `w_areas` VALUES( '130682','130600','定州市','99' ); 
INSERT INTO `w_areas` VALUES( '130683','130600','安国市','99' ); 
INSERT INTO `w_areas` VALUES( '130684','130600','高碑店市','99' ); 
INSERT INTO `w_areas` VALUES( '130701','130700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130702','130700','桥东区','99' ); 
INSERT INTO `w_areas` VALUES( '130703','130700','桥西区','99' ); 
INSERT INTO `w_areas` VALUES( '130705','130700','宣化区','99' ); 
INSERT INTO `w_areas` VALUES( '130706','130700','下花园区','99' ); 
INSERT INTO `w_areas` VALUES( '130721','130700','宣化县','99' ); 
INSERT INTO `w_areas` VALUES( '130722','130700','张北县','99' ); 
INSERT INTO `w_areas` VALUES( '130723','130700','康保县','99' ); 
INSERT INTO `w_areas` VALUES( '130724','130700','沽源县','99' ); 
INSERT INTO `w_areas` VALUES( '130725','130700','尚义县','99' ); 
INSERT INTO `w_areas` VALUES( '130726','130700','蔚县','99' ); 
INSERT INTO `w_areas` VALUES( '130727','130700','阳原县','99' ); 
INSERT INTO `w_areas` VALUES( '130728','130700','怀安县','99' ); 
INSERT INTO `w_areas` VALUES( '130729','130700','万全县','99' ); 
INSERT INTO `w_areas` VALUES( '130730','130700','怀来县','99' ); 
INSERT INTO `w_areas` VALUES( '130731','130700','涿鹿县','99' ); 
INSERT INTO `w_areas` VALUES( '130732','130700','赤城县','99' ); 
INSERT INTO `w_areas` VALUES( '130733','130700','崇礼县','99' ); 
INSERT INTO `w_areas` VALUES( '130801','130800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130802','130800','双桥区','99' ); 
INSERT INTO `w_areas` VALUES( '130803','130800','双滦区','99' ); 
INSERT INTO `w_areas` VALUES( '130804','130800','鹰手营子矿区','99' ); 
INSERT INTO `w_areas` VALUES( '130821','130800','承德县','99' ); 
INSERT INTO `w_areas` VALUES( '130822','130800','兴隆县','99' ); 
INSERT INTO `w_areas` VALUES( '130823','130800','平泉县','99' ); 
INSERT INTO `w_areas` VALUES( '130824','130800','滦平县','99' ); 
INSERT INTO `w_areas` VALUES( '130825','130800','隆化县','99' ); 
INSERT INTO `w_areas` VALUES( '130826','130800','丰宁满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '130827','130800','宽城满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '130828','130800','围场满族蒙古族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '130901','130900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '130902','130900','新华区','99' ); 
INSERT INTO `w_areas` VALUES( '130903','130900','运河区','99' ); 
INSERT INTO `w_areas` VALUES( '130921','130900','沧县','99' ); 
INSERT INTO `w_areas` VALUES( '130922','130900','青县','99' ); 
INSERT INTO `w_areas` VALUES( '130923','130900','东光县','99' ); 
INSERT INTO `w_areas` VALUES( '130924','130900','海兴县','99' ); 
INSERT INTO `w_areas` VALUES( '130925','130900','盐山县','99' ); 
INSERT INTO `w_areas` VALUES( '130926','130900','肃宁县','99' ); 
INSERT INTO `w_areas` VALUES( '130927','130900','南皮县','99' ); 
INSERT INTO `w_areas` VALUES( '130928','130900','吴桥县','99' ); 
INSERT INTO `w_areas` VALUES( '130929','130900','献县','99' ); 
INSERT INTO `w_areas` VALUES( '130930','130900','孟村回族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '130981','130900','泊头市','99' ); 
INSERT INTO `w_areas` VALUES( '130982','130900','任丘市','99' ); 
INSERT INTO `w_areas` VALUES( '130983','130900','黄骅市','99' ); 
INSERT INTO `w_areas` VALUES( '130984','130900','河间市','99' ); 
INSERT INTO `w_areas` VALUES( '131001','131000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '131002','131000','安次区','99' ); 
INSERT INTO `w_areas` VALUES( '131003','131000','广阳区','99' ); 
INSERT INTO `w_areas` VALUES( '131022','131000','固安县','99' ); 
INSERT INTO `w_areas` VALUES( '131023','131000','永清县','99' ); 
INSERT INTO `w_areas` VALUES( '131024','131000','香河县','99' ); 
INSERT INTO `w_areas` VALUES( '131025','131000','大城县','99' ); 
INSERT INTO `w_areas` VALUES( '131026','131000','文安县','99' ); 
INSERT INTO `w_areas` VALUES( '131028','131000','大厂回族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '131081','131000','霸州市','99' ); 
INSERT INTO `w_areas` VALUES( '131082','131000','三河市','99' ); 
INSERT INTO `w_areas` VALUES( '131101','131100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '131102','131100','桃城区','99' ); 
INSERT INTO `w_areas` VALUES( '131121','131100','枣强县','99' ); 
INSERT INTO `w_areas` VALUES( '131122','131100','武邑县','99' ); 
INSERT INTO `w_areas` VALUES( '131123','131100','武强县','99' ); 
INSERT INTO `w_areas` VALUES( '131124','131100','饶阳县','99' ); 
INSERT INTO `w_areas` VALUES( '131125','131100','安平县','99' ); 
INSERT INTO `w_areas` VALUES( '131126','131100','故城县','99' ); 
INSERT INTO `w_areas` VALUES( '131127','131100','景县','99' ); 
INSERT INTO `w_areas` VALUES( '131128','131100','阜城县','99' ); 
INSERT INTO `w_areas` VALUES( '131181','131100','冀州市','99' ); 
INSERT INTO `w_areas` VALUES( '131182','131100','深州市','99' ); 
INSERT INTO `w_areas` VALUES( '140101','140100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140105','140100','小店区','99' ); 
INSERT INTO `w_areas` VALUES( '140106','140100','迎泽区','99' ); 
INSERT INTO `w_areas` VALUES( '140107','140100','杏花岭区','99' ); 
INSERT INTO `w_areas` VALUES( '140108','140100','尖草坪区','99' ); 
INSERT INTO `w_areas` VALUES( '140109','140100','万柏林区','99' ); 
INSERT INTO `w_areas` VALUES( '140110','140100','晋源区','99' ); 
INSERT INTO `w_areas` VALUES( '140121','140100','清徐县','99' ); 
INSERT INTO `w_areas` VALUES( '140122','140100','阳曲县','99' ); 
INSERT INTO `w_areas` VALUES( '140123','140100','娄烦县','99' ); 
INSERT INTO `w_areas` VALUES( '140181','140100','古交市','99' ); 
INSERT INTO `w_areas` VALUES( '140201','140200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140202','140200','城区','99' ); 
INSERT INTO `w_areas` VALUES( '140203','140200','矿区','99' ); 
INSERT INTO `w_areas` VALUES( '140211','140200','南郊区','99' ); 
INSERT INTO `w_areas` VALUES( '140212','140200','新荣区','99' ); 
INSERT INTO `w_areas` VALUES( '140221','140200','阳高县','99' ); 
INSERT INTO `w_areas` VALUES( '140222','140200','天镇县','99' ); 
INSERT INTO `w_areas` VALUES( '140223','140200','广灵县','99' ); 
INSERT INTO `w_areas` VALUES( '140224','140200','灵丘县','99' ); 
INSERT INTO `w_areas` VALUES( '140225','140200','浑源县','99' ); 
INSERT INTO `w_areas` VALUES( '140226','140200','左云县','99' ); 
INSERT INTO `w_areas` VALUES( '140227','140200','大同县','99' ); 
INSERT INTO `w_areas` VALUES( '140301','140300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140302','140300','城区','99' ); 
INSERT INTO `w_areas` VALUES( '140303','140300','矿区','99' ); 
INSERT INTO `w_areas` VALUES( '140311','140300','郊区','99' ); 
INSERT INTO `w_areas` VALUES( '140321','140300','平定县','99' ); 
INSERT INTO `w_areas` VALUES( '140322','140300','盂县','99' ); 
INSERT INTO `w_areas` VALUES( '140401','140400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140402','140400','城区','99' ); 
INSERT INTO `w_areas` VALUES( '140411','140400','郊区','99' ); 
INSERT INTO `w_areas` VALUES( '140421','140400','长治县','99' ); 
INSERT INTO `w_areas` VALUES( '140423','140400','襄垣县','99' ); 
INSERT INTO `w_areas` VALUES( '140424','140400','屯留县','99' ); 
INSERT INTO `w_areas` VALUES( '140425','140400','平顺县','99' ); 
INSERT INTO `w_areas` VALUES( '140426','140400','黎城县','99' ); 
INSERT INTO `w_areas` VALUES( '140427','140400','壶关县','99' ); 
INSERT INTO `w_areas` VALUES( '140428','140400','长子县','99' ); 
INSERT INTO `w_areas` VALUES( '140429','140400','武乡县','99' ); 
INSERT INTO `w_areas` VALUES( '140430','140400','沁县','99' ); 
INSERT INTO `w_areas` VALUES( '140431','140400','沁源县','99' ); 
INSERT INTO `w_areas` VALUES( '140481','140400','潞城市','99' ); 
INSERT INTO `w_areas` VALUES( '140501','140500','晋城市市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140502','140500','城区','99' ); 
INSERT INTO `w_areas` VALUES( '140521','140500','沁水县','99' ); 
INSERT INTO `w_areas` VALUES( '140522','140500','阳城县','99' ); 
INSERT INTO `w_areas` VALUES( '140524','140500','陵川县','99' ); 
INSERT INTO `w_areas` VALUES( '140525','140500','泽州县','99' ); 
INSERT INTO `w_areas` VALUES( '140581','140500','高平市','99' ); 
INSERT INTO `w_areas` VALUES( '140601','140600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140602','140600','朔城区','99' ); 
INSERT INTO `w_areas` VALUES( '140603','140600','平鲁区','99' ); 
INSERT INTO `w_areas` VALUES( '140621','140600','山阴县','99' ); 
INSERT INTO `w_areas` VALUES( '140622','140600','应县','99' ); 
INSERT INTO `w_areas` VALUES( '140623','140600','右玉县','99' ); 
INSERT INTO `w_areas` VALUES( '140624','140600','怀仁县','99' ); 
INSERT INTO `w_areas` VALUES( '140701','140700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140702','140700','榆次区','99' ); 
INSERT INTO `w_areas` VALUES( '140721','140700','榆社县','99' ); 
INSERT INTO `w_areas` VALUES( '140722','140700','左权县','99' ); 
INSERT INTO `w_areas` VALUES( '140723','140700','和顺县','99' ); 
INSERT INTO `w_areas` VALUES( '140724','140700','昔阳县','99' ); 
INSERT INTO `w_areas` VALUES( '140725','140700','寿阳县','99' ); 
INSERT INTO `w_areas` VALUES( '140726','140700','太谷县','99' ); 
INSERT INTO `w_areas` VALUES( '140727','140700','祁县','99' ); 
INSERT INTO `w_areas` VALUES( '140728','140700','平遥县','99' ); 
INSERT INTO `w_areas` VALUES( '140729','140700','灵石县','99' ); 
INSERT INTO `w_areas` VALUES( '140781','140700','介休市','99' ); 
INSERT INTO `w_areas` VALUES( '140801','140800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140802','140800','盐湖区','99' ); 
INSERT INTO `w_areas` VALUES( '140821','140800','临猗县','99' ); 
INSERT INTO `w_areas` VALUES( '140822','140800','万荣县','99' ); 
INSERT INTO `w_areas` VALUES( '140823','140800','闻喜县','99' ); 
INSERT INTO `w_areas` VALUES( '140824','140800','稷山县','99' ); 
INSERT INTO `w_areas` VALUES( '140825','140800','新绛县','99' ); 
INSERT INTO `w_areas` VALUES( '140826','140800','绛县','99' ); 
INSERT INTO `w_areas` VALUES( '140827','140800','垣曲县','99' ); 
INSERT INTO `w_areas` VALUES( '140828','140800','夏县','99' ); 
INSERT INTO `w_areas` VALUES( '140829','140800','平陆县','99' ); 
INSERT INTO `w_areas` VALUES( '140830','140800','芮城县','99' ); 
INSERT INTO `w_areas` VALUES( '140881','140800','永济市','99' ); 
INSERT INTO `w_areas` VALUES( '140882','140800','河津市','99' ); 
INSERT INTO `w_areas` VALUES( '140901','140900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '140902','140900','忻府区','99' ); 
INSERT INTO `w_areas` VALUES( '140921','140900','定襄县','99' ); 
INSERT INTO `w_areas` VALUES( '140922','140900','五台县','99' ); 
INSERT INTO `w_areas` VALUES( '140923','140900','代县','99' ); 
INSERT INTO `w_areas` VALUES( '140924','140900','繁峙县','99' ); 
INSERT INTO `w_areas` VALUES( '140925','140900','宁武县','99' ); 
INSERT INTO `w_areas` VALUES( '140926','140900','静乐县','99' ); 
INSERT INTO `w_areas` VALUES( '140927','140900','神池县','99' ); 
INSERT INTO `w_areas` VALUES( '140928','140900','五寨县','99' ); 
INSERT INTO `w_areas` VALUES( '140929','140900','岢岚县','99' ); 
INSERT INTO `w_areas` VALUES( '140930','140900','河曲县','99' ); 
INSERT INTO `w_areas` VALUES( '140931','140900','保德县','99' ); 
INSERT INTO `w_areas` VALUES( '140932','140900','偏关县','99' ); 
INSERT INTO `w_areas` VALUES( '140981','140900','原平市','99' ); 
INSERT INTO `w_areas` VALUES( '141001','141000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '141002','141000','尧都区','99' ); 
INSERT INTO `w_areas` VALUES( '141021','141000','曲沃县','99' ); 
INSERT INTO `w_areas` VALUES( '141022','141000','翼城县','99' ); 
INSERT INTO `w_areas` VALUES( '141023','141000','襄汾县','99' ); 
INSERT INTO `w_areas` VALUES( '141024','141000','洪洞县','99' ); 
INSERT INTO `w_areas` VALUES( '141025','141000','古县','99' ); 
INSERT INTO `w_areas` VALUES( '141026','141000','安泽县','99' ); 
INSERT INTO `w_areas` VALUES( '141027','141000','浮山县','99' ); 
INSERT INTO `w_areas` VALUES( '141028','141000','吉县','99' ); 
INSERT INTO `w_areas` VALUES( '141029','141000','乡宁县','99' ); 
INSERT INTO `w_areas` VALUES( '141030','141000','大宁县','99' ); 
INSERT INTO `w_areas` VALUES( '141031','141000','隰县','99' ); 
INSERT INTO `w_areas` VALUES( '141032','141000','永和县','99' ); 
INSERT INTO `w_areas` VALUES( '141033','141000','蒲县','99' ); 
INSERT INTO `w_areas` VALUES( '141034','141000','汾西县','99' ); 
INSERT INTO `w_areas` VALUES( '141081','141000','侯马市','99' ); 
INSERT INTO `w_areas` VALUES( '141082','141000','霍州市','99' ); 
INSERT INTO `w_areas` VALUES( '141101','141100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '141102','141100','离石区','99' ); 
INSERT INTO `w_areas` VALUES( '141121','141100','文水县','99' ); 
INSERT INTO `w_areas` VALUES( '141122','141100','交城县','99' ); 
INSERT INTO `w_areas` VALUES( '141123','141100','兴县','99' ); 
INSERT INTO `w_areas` VALUES( '141124','141100','临县','99' ); 
INSERT INTO `w_areas` VALUES( '141125','141100','柳林县','99' ); 
INSERT INTO `w_areas` VALUES( '141126','141100','石楼县','99' ); 
INSERT INTO `w_areas` VALUES( '141127','141100','岚县','99' ); 
INSERT INTO `w_areas` VALUES( '141128','141100','方山县','99' ); 
INSERT INTO `w_areas` VALUES( '141129','141100','中阳县','99' ); 
INSERT INTO `w_areas` VALUES( '141130','141100','交口县','99' ); 
INSERT INTO `w_areas` VALUES( '141181','141100','孝义市','99' ); 
INSERT INTO `w_areas` VALUES( '141182','141100','汾阳市','99' ); 
INSERT INTO `w_areas` VALUES( '150101','150100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150102','150100','新城区','99' ); 
INSERT INTO `w_areas` VALUES( '150103','150100','回民区','99' ); 
INSERT INTO `w_areas` VALUES( '150104','150100','玉泉区','99' ); 
INSERT INTO `w_areas` VALUES( '150105','150100','赛罕区','99' ); 
INSERT INTO `w_areas` VALUES( '150121','150100','土默特左旗','99' ); 
INSERT INTO `w_areas` VALUES( '150122','150100','托克托县','99' ); 
INSERT INTO `w_areas` VALUES( '150123','150100','和林格尔县','99' ); 
INSERT INTO `w_areas` VALUES( '150124','150100','清水河县','99' ); 
INSERT INTO `w_areas` VALUES( '150125','150100','武川县','99' ); 
INSERT INTO `w_areas` VALUES( '150201','150200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150202','150200','东河区','99' ); 
INSERT INTO `w_areas` VALUES( '150203','150200','昆都仑区','99' ); 
INSERT INTO `w_areas` VALUES( '150204','150200','青山区','99' ); 
INSERT INTO `w_areas` VALUES( '150205','150200','石拐区','99' ); 
INSERT INTO `w_areas` VALUES( '150206','150200','白云鄂博矿区','99' ); 
INSERT INTO `w_areas` VALUES( '150207','150200','九原区','99' ); 
INSERT INTO `w_areas` VALUES( '150221','150200','土默特右旗','99' ); 
INSERT INTO `w_areas` VALUES( '150222','150200','固阳县','99' ); 
INSERT INTO `w_areas` VALUES( '150223','150200','达尔罕茂明安联合旗','99' ); 
INSERT INTO `w_areas` VALUES( '150301','150300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150302','150300','海勃湾区','99' ); 
INSERT INTO `w_areas` VALUES( '150303','150300','海南区','99' ); 
INSERT INTO `w_areas` VALUES( '150304','150300','乌达区','99' ); 
INSERT INTO `w_areas` VALUES( '150401','150400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150402','150400','红山区','99' ); 
INSERT INTO `w_areas` VALUES( '150403','150400','元宝山区','99' ); 
INSERT INTO `w_areas` VALUES( '150404','150400','松山区','99' ); 
INSERT INTO `w_areas` VALUES( '150421','150400','阿鲁科尔沁旗','99' ); 
INSERT INTO `w_areas` VALUES( '150422','150400','巴林左旗','99' ); 
INSERT INTO `w_areas` VALUES( '150423','150400','巴林右旗','99' ); 
INSERT INTO `w_areas` VALUES( '150424','150400','林西县','99' ); 
INSERT INTO `w_areas` VALUES( '150425','150400','克什克腾旗','99' ); 
INSERT INTO `w_areas` VALUES( '150426','150400','翁牛特旗','99' ); 
INSERT INTO `w_areas` VALUES( '150428','150400','喀喇沁旗','99' ); 
INSERT INTO `w_areas` VALUES( '150429','150400','宁城县','99' ); 
INSERT INTO `w_areas` VALUES( '150430','150400','敖汉旗','99' ); 
INSERT INTO `w_areas` VALUES( '150501','150500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150502','150500','科尔沁区','99' ); 
INSERT INTO `w_areas` VALUES( '150521','150500','科尔沁左翼中旗','99' ); 
INSERT INTO `w_areas` VALUES( '150522','150500','科尔沁左翼后旗','99' ); 
INSERT INTO `w_areas` VALUES( '150523','150500','开鲁县','99' ); 
INSERT INTO `w_areas` VALUES( '150524','150500','库伦旗','99' ); 
INSERT INTO `w_areas` VALUES( '150525','150500','奈曼旗','99' ); 
INSERT INTO `w_areas` VALUES( '150526','150500','扎鲁特旗','99' ); 
INSERT INTO `w_areas` VALUES( '150581','150500','霍林郭勒市','99' ); 
INSERT INTO `w_areas` VALUES( '150601','150600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150602','150600','东胜区','99' ); 
INSERT INTO `w_areas` VALUES( '150621','150600','达拉特旗','99' ); 
INSERT INTO `w_areas` VALUES( '150622','150600','准格尔旗','99' ); 
INSERT INTO `w_areas` VALUES( '150623','150600','鄂托克前旗','99' ); 
INSERT INTO `w_areas` VALUES( '150624','150600','鄂托克旗','99' ); 
INSERT INTO `w_areas` VALUES( '150625','150600','杭锦旗','99' ); 
INSERT INTO `w_areas` VALUES( '150626','150600','乌审旗','99' ); 
INSERT INTO `w_areas` VALUES( '150627','150600','伊金霍洛旗','99' ); 
INSERT INTO `w_areas` VALUES( '150701','150700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150702','150700','海拉尔区','99' ); 
INSERT INTO `w_areas` VALUES( '150721','150700','阿荣旗','99' ); 
INSERT INTO `w_areas` VALUES( '150722','150700','莫力达瓦达斡尔族自治旗','99' ); 
INSERT INTO `w_areas` VALUES( '150723','150700','鄂伦春自治旗','99' ); 
INSERT INTO `w_areas` VALUES( '150724','150700','鄂温克族自治旗','99' ); 
INSERT INTO `w_areas` VALUES( '150725','150700','陈巴尔虎旗','99' ); 
INSERT INTO `w_areas` VALUES( '150726','150700','新巴尔虎左旗','99' ); 
INSERT INTO `w_areas` VALUES( '150727','150700','新巴尔虎右旗','99' ); 
INSERT INTO `w_areas` VALUES( '150781','150700','满洲里市','99' ); 
INSERT INTO `w_areas` VALUES( '150782','150700','牙克石市','99' ); 
INSERT INTO `w_areas` VALUES( '150783','150700','扎兰屯市','99' ); 
INSERT INTO `w_areas` VALUES( '150784','150700','额尔古纳市','99' ); 
INSERT INTO `w_areas` VALUES( '150785','150700','根河市','99' ); 
INSERT INTO `w_areas` VALUES( '150801','150800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150802','150800','临河区','99' ); 
INSERT INTO `w_areas` VALUES( '150821','150800','五原县','99' ); 
INSERT INTO `w_areas` VALUES( '150822','150800','磴口县','99' ); 
INSERT INTO `w_areas` VALUES( '150823','150800','乌拉特前旗','99' ); 
INSERT INTO `w_areas` VALUES( '150824','150800','乌拉特中旗','99' ); 
INSERT INTO `w_areas` VALUES( '150825','150800','乌拉特后旗','99' ); 
INSERT INTO `w_areas` VALUES( '150826','150800','杭锦后旗','99' ); 
INSERT INTO `w_areas` VALUES( '150901','150900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '150902','150900','集宁区','99' ); 
INSERT INTO `w_areas` VALUES( '150921','150900','卓资县','99' ); 
INSERT INTO `w_areas` VALUES( '150922','150900','化德县','99' ); 
INSERT INTO `w_areas` VALUES( '150923','150900','商都县','99' ); 
INSERT INTO `w_areas` VALUES( '150924','150900','兴和县','99' ); 
INSERT INTO `w_areas` VALUES( '150925','150900','凉城县','99' ); 
INSERT INTO `w_areas` VALUES( '150926','150900','察哈尔右翼前旗','99' ); 
INSERT INTO `w_areas` VALUES( '150927','150900','察哈尔右翼中旗','99' ); 
INSERT INTO `w_areas` VALUES( '150928','150900','察哈尔右翼后旗','99' ); 
INSERT INTO `w_areas` VALUES( '150929','150900','四子王旗','99' ); 
INSERT INTO `w_areas` VALUES( '150981','150900','丰镇市','99' ); 
INSERT INTO `w_areas` VALUES( '152201','152200','乌兰浩特市','99' ); 
INSERT INTO `w_areas` VALUES( '152202','152200','阿尔山市','99' ); 
INSERT INTO `w_areas` VALUES( '152221','152200','科尔沁右翼前旗','99' ); 
INSERT INTO `w_areas` VALUES( '152222','152200','科尔沁右翼中旗','99' ); 
INSERT INTO `w_areas` VALUES( '152223','152200','扎赉特旗','99' ); 
INSERT INTO `w_areas` VALUES( '152224','152200','突泉县','99' ); 
INSERT INTO `w_areas` VALUES( '152501','152500','二连浩特市','99' ); 
INSERT INTO `w_areas` VALUES( '152502','152500','锡林浩特市','99' ); 
INSERT INTO `w_areas` VALUES( '152522','152500','阿巴嘎旗','99' ); 
INSERT INTO `w_areas` VALUES( '152523','152500','苏尼特左旗','99' ); 
INSERT INTO `w_areas` VALUES( '152524','152500','苏尼特右旗','99' ); 
INSERT INTO `w_areas` VALUES( '152525','152500','东乌珠穆沁旗','99' ); 
INSERT INTO `w_areas` VALUES( '152526','152500','西乌珠穆沁旗','99' ); 
INSERT INTO `w_areas` VALUES( '152527','152500','太仆寺旗','99' ); 
INSERT INTO `w_areas` VALUES( '152528','152500','镶黄旗','99' ); 
INSERT INTO `w_areas` VALUES( '152529','152500','正镶白旗','99' ); 
INSERT INTO `w_areas` VALUES( '152530','152500','正蓝旗','99' ); 
INSERT INTO `w_areas` VALUES( '152531','152500','多伦县','99' ); 
INSERT INTO `w_areas` VALUES( '152921','152900','阿拉善左旗','99' ); 
INSERT INTO `w_areas` VALUES( '152922','152900','阿拉善右旗','99' ); 
INSERT INTO `w_areas` VALUES( '152923','152900','额济纳旗','99' ); 
INSERT INTO `w_areas` VALUES( '210101','210100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210102','210100','和平区','99' ); 
INSERT INTO `w_areas` VALUES( '210103','210100','沈河区','99' ); 
INSERT INTO `w_areas` VALUES( '210104','210100','大东区','99' ); 
INSERT INTO `w_areas` VALUES( '210105','210100','皇姑区','99' ); 
INSERT INTO `w_areas` VALUES( '210106','210100','铁西区','99' ); 
INSERT INTO `w_areas` VALUES( '210111','210100','苏家屯区','99' ); 
INSERT INTO `w_areas` VALUES( '210112','210100','东陵区','99' ); 
INSERT INTO `w_areas` VALUES( '210113','210100','沈北新区','99' ); 
INSERT INTO `w_areas` VALUES( '210114','210100','于洪区','99' ); 
INSERT INTO `w_areas` VALUES( '210122','210100','辽中县','99' ); 
INSERT INTO `w_areas` VALUES( '210123','210100','康平县','99' ); 
INSERT INTO `w_areas` VALUES( '210124','210100','法库县','99' ); 
INSERT INTO `w_areas` VALUES( '210181','210100','新民市','99' ); 
INSERT INTO `w_areas` VALUES( '210201','210200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210202','210200','中山区','99' ); 
INSERT INTO `w_areas` VALUES( '210203','210200','西岗区','99' ); 
INSERT INTO `w_areas` VALUES( '210204','210200','沙河口区','99' ); 
INSERT INTO `w_areas` VALUES( '210211','210200','甘井子区','99' ); 
INSERT INTO `w_areas` VALUES( '210212','210200','旅顺口区','99' ); 
INSERT INTO `w_areas` VALUES( '210213','210200','金州区','99' ); 
INSERT INTO `w_areas` VALUES( '210224','210200','长海县','99' ); 
INSERT INTO `w_areas` VALUES( '210281','210200','瓦房店市','99' ); 
INSERT INTO `w_areas` VALUES( '210282','210200','普兰店市','99' ); 
INSERT INTO `w_areas` VALUES( '210283','210200','庄河市','99' ); 
INSERT INTO `w_areas` VALUES( '210301','210300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210302','210300','铁东区','99' ); 
INSERT INTO `w_areas` VALUES( '210303','210300','铁西区','99' ); 
INSERT INTO `w_areas` VALUES( '210304','210300','立山区','99' ); 
INSERT INTO `w_areas` VALUES( '210311','210300','千山区','99' ); 
INSERT INTO `w_areas` VALUES( '210321','210300','台安县','99' ); 
INSERT INTO `w_areas` VALUES( '210323','210300','岫岩满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '210381','210300','海城市','99' ); 
INSERT INTO `w_areas` VALUES( '210401','210400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210402','210400','新抚区','99' ); 
INSERT INTO `w_areas` VALUES( '210403','210400','东洲区','99' ); 
INSERT INTO `w_areas` VALUES( '210404','210400','望花区','99' ); 
INSERT INTO `w_areas` VALUES( '210411','210400','顺城区','99' ); 
INSERT INTO `w_areas` VALUES( '210421','210400','抚顺县','99' ); 
INSERT INTO `w_areas` VALUES( '210422','210400','新宾满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '210423','210400','清原满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '210501','210500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210502','210500','平山区','99' ); 
INSERT INTO `w_areas` VALUES( '210503','210500','溪湖区','99' ); 
INSERT INTO `w_areas` VALUES( '210504','210500','明山区','99' ); 
INSERT INTO `w_areas` VALUES( '210505','210500','南芬区','99' ); 
INSERT INTO `w_areas` VALUES( '210521','210500','本溪满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '210522','210500','桓仁满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '210601','210600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210602','210600','元宝区','99' ); 
INSERT INTO `w_areas` VALUES( '210603','210600','振兴区','99' ); 
INSERT INTO `w_areas` VALUES( '210604','210600','振安区','99' ); 
INSERT INTO `w_areas` VALUES( '210624','210600','宽甸满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '210681','210600','东港市','99' ); 
INSERT INTO `w_areas` VALUES( '210682','210600','凤城市','99' ); 
INSERT INTO `w_areas` VALUES( '210701','210700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210702','210700','古塔区','99' ); 
INSERT INTO `w_areas` VALUES( '210703','210700','凌河区','99' ); 
INSERT INTO `w_areas` VALUES( '210711','210700','太和区','99' ); 
INSERT INTO `w_areas` VALUES( '210726','210700','黑山县','99' ); 
INSERT INTO `w_areas` VALUES( '210727','210700','义县','99' ); 
INSERT INTO `w_areas` VALUES( '210781','210700','凌海市','99' ); 
INSERT INTO `w_areas` VALUES( '210782','210700','北镇市','99' ); 
INSERT INTO `w_areas` VALUES( '210801','210800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210802','210800','站前区','99' ); 
INSERT INTO `w_areas` VALUES( '210803','210800','西市区','99' ); 
INSERT INTO `w_areas` VALUES( '210804','210800','鲅鱼圈区','99' ); 
INSERT INTO `w_areas` VALUES( '210811','210800','老边区','99' ); 
INSERT INTO `w_areas` VALUES( '210881','210800','盖州市','99' ); 
INSERT INTO `w_areas` VALUES( '210882','210800','大石桥市','99' ); 
INSERT INTO `w_areas` VALUES( '210901','210900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '210902','210900','海州区','99' ); 
INSERT INTO `w_areas` VALUES( '210903','210900','新邱区','99' ); 
INSERT INTO `w_areas` VALUES( '210904','210900','太平区','99' ); 
INSERT INTO `w_areas` VALUES( '210905','210900','清河门区','99' ); 
INSERT INTO `w_areas` VALUES( '210911','210900','细河区','99' ); 
INSERT INTO `w_areas` VALUES( '210921','210900','阜新蒙古族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '210922','210900','彰武县','99' ); 
INSERT INTO `w_areas` VALUES( '211001','211000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '211002','211000','白塔区','99' ); 
INSERT INTO `w_areas` VALUES( '211003','211000','文圣区','99' ); 
INSERT INTO `w_areas` VALUES( '211004','211000','宏伟区','99' ); 
INSERT INTO `w_areas` VALUES( '211005','211000','弓长岭区','99' ); 
INSERT INTO `w_areas` VALUES( '211011','211000','太子河区','99' ); 
INSERT INTO `w_areas` VALUES( '211021','211000','辽阳县','99' ); 
INSERT INTO `w_areas` VALUES( '211081','211000','灯塔市','99' ); 
INSERT INTO `w_areas` VALUES( '211101','211100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '211102','211100','双台子区','99' ); 
INSERT INTO `w_areas` VALUES( '211103','211100','兴隆台区','99' ); 
INSERT INTO `w_areas` VALUES( '211121','211100','大洼县','99' ); 
INSERT INTO `w_areas` VALUES( '211122','211100','盘山县','99' ); 
INSERT INTO `w_areas` VALUES( '211201','211200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '211202','211200','银州区','99' ); 
INSERT INTO `w_areas` VALUES( '211204','211200','清河区','99' ); 
INSERT INTO `w_areas` VALUES( '211221','211200','铁岭县','99' ); 
INSERT INTO `w_areas` VALUES( '211223','211200','西丰县','99' ); 
INSERT INTO `w_areas` VALUES( '211224','211200','昌图县','99' ); 
INSERT INTO `w_areas` VALUES( '211281','211200','调兵山市','99' ); 
INSERT INTO `w_areas` VALUES( '211282','211200','开原市','99' ); 
INSERT INTO `w_areas` VALUES( '211301','211300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '211302','211300','双塔区','99' ); 
INSERT INTO `w_areas` VALUES( '211303','211300','龙城区','99' ); 
INSERT INTO `w_areas` VALUES( '211321','211300','朝阳县','99' ); 
INSERT INTO `w_areas` VALUES( '211322','211300','建平县','99' ); 
INSERT INTO `w_areas` VALUES( '211324','211300','喀喇沁左翼蒙古族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '211381','211300','北票市','99' ); 
INSERT INTO `w_areas` VALUES( '211382','211300','凌源市','99' ); 
INSERT INTO `w_areas` VALUES( '211401','211400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '211402','211400','连山区','99' ); 
INSERT INTO `w_areas` VALUES( '211403','211400','龙港区','99' ); 
INSERT INTO `w_areas` VALUES( '211404','211400','南票区','99' ); 
INSERT INTO `w_areas` VALUES( '211421','211400','绥中县','99' ); 
INSERT INTO `w_areas` VALUES( '211422','211400','建昌县','99' ); 
INSERT INTO `w_areas` VALUES( '211481','211400','兴城市','99' ); 
INSERT INTO `w_areas` VALUES( '220101','220100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220102','220100','南关区','99' ); 
INSERT INTO `w_areas` VALUES( '220103','220100','宽城区','99' ); 
INSERT INTO `w_areas` VALUES( '220104','220100','朝阳区','99' ); 
INSERT INTO `w_areas` VALUES( '220105','220100','二道区','99' ); 
INSERT INTO `w_areas` VALUES( '220106','220100','绿园区','99' ); 
INSERT INTO `w_areas` VALUES( '220112','220100','双阳区','99' ); 
INSERT INTO `w_areas` VALUES( '220122','220100','农安县','99' ); 
INSERT INTO `w_areas` VALUES( '220181','220100','九台市','99' ); 
INSERT INTO `w_areas` VALUES( '220182','220100','榆树市','99' ); 
INSERT INTO `w_areas` VALUES( '220183','220100','德惠市','99' ); 
INSERT INTO `w_areas` VALUES( '220201','220200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220202','220200','昌邑区','99' ); 
INSERT INTO `w_areas` VALUES( '220203','220200','龙潭区','99' ); 
INSERT INTO `w_areas` VALUES( '220204','220200','船营区','99' ); 
INSERT INTO `w_areas` VALUES( '220211','220200','丰满区','99' ); 
INSERT INTO `w_areas` VALUES( '220221','220200','永吉县','99' ); 
INSERT INTO `w_areas` VALUES( '220281','220200','蛟河市','99' ); 
INSERT INTO `w_areas` VALUES( '220282','220200','桦甸市','99' ); 
INSERT INTO `w_areas` VALUES( '220283','220200','舒兰市','99' ); 
INSERT INTO `w_areas` VALUES( '220284','220200','磐石市','99' ); 
INSERT INTO `w_areas` VALUES( '220301','220300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220302','220300','铁西区','99' ); 
INSERT INTO `w_areas` VALUES( '220303','220300','铁东区','99' ); 
INSERT INTO `w_areas` VALUES( '220322','220300','梨树县','99' ); 
INSERT INTO `w_areas` VALUES( '220323','220300','伊通满族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '220381','220300','公主岭市','99' ); 
INSERT INTO `w_areas` VALUES( '220382','220300','双辽市','99' ); 
INSERT INTO `w_areas` VALUES( '220401','220400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220402','220400','龙山区','99' ); 
INSERT INTO `w_areas` VALUES( '220403','220400','西安区','99' ); 
INSERT INTO `w_areas` VALUES( '220421','220400','东丰县','99' ); 
INSERT INTO `w_areas` VALUES( '220422','220400','东辽县','99' ); 
INSERT INTO `w_areas` VALUES( '220501','220500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220502','220500','东昌区','99' ); 
INSERT INTO `w_areas` VALUES( '220503','220500','二道江区','99' ); 
INSERT INTO `w_areas` VALUES( '220521','220500','通化县','99' ); 
INSERT INTO `w_areas` VALUES( '220523','220500','辉南县','99' ); 
INSERT INTO `w_areas` VALUES( '220524','220500','柳河县','99' ); 
INSERT INTO `w_areas` VALUES( '220581','220500','梅河口市','99' ); 
INSERT INTO `w_areas` VALUES( '220582','220500','集安市','99' ); 
INSERT INTO `w_areas` VALUES( '220601','220600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220602','220600','浑江区','99' ); 
INSERT INTO `w_areas` VALUES( '220605','220600','江源区','99' ); 
INSERT INTO `w_areas` VALUES( '220621','220600','抚松县','99' ); 
INSERT INTO `w_areas` VALUES( '220622','220600','靖宇县','99' ); 
INSERT INTO `w_areas` VALUES( '220623','220600','长白朝鲜族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '220681','220600','临江市','99' ); 
INSERT INTO `w_areas` VALUES( '220701','220700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220702','220700','宁江区','99' ); 
INSERT INTO `w_areas` VALUES( '220721','220700','前郭尔罗斯蒙古族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '220722','220700','长岭县','99' ); 
INSERT INTO `w_areas` VALUES( '220723','220700','乾安县','99' ); 
INSERT INTO `w_areas` VALUES( '220724','220700','扶余县','99' ); 
INSERT INTO `w_areas` VALUES( '220801','220800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '220802','220800','洮北区','99' ); 
INSERT INTO `w_areas` VALUES( '220821','220800','镇赉县','99' ); 
INSERT INTO `w_areas` VALUES( '220822','220800','通榆县','99' ); 
INSERT INTO `w_areas` VALUES( '220881','220800','洮南市','99' ); 
INSERT INTO `w_areas` VALUES( '220882','220800','大安市','99' ); 
INSERT INTO `w_areas` VALUES( '222401','222400','延吉市','99' ); 
INSERT INTO `w_areas` VALUES( '222402','222400','图们市','99' ); 
INSERT INTO `w_areas` VALUES( '222403','222400','敦化市','99' ); 
INSERT INTO `w_areas` VALUES( '222404','222400','珲春市','99' ); 
INSERT INTO `w_areas` VALUES( '222405','222400','龙井市','99' ); 
INSERT INTO `w_areas` VALUES( '222406','222400','和龙市','99' ); 
INSERT INTO `w_areas` VALUES( '222424','222400','汪清县','99' ); 
INSERT INTO `w_areas` VALUES( '222426','222400','安图县','99' ); 
INSERT INTO `w_areas` VALUES( '230101','230100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230102','230100','道里区','99' ); 
INSERT INTO `w_areas` VALUES( '230103','230100','南岗区','99' ); 
INSERT INTO `w_areas` VALUES( '230104','230100','道外区','99' ); 
INSERT INTO `w_areas` VALUES( '230108','230100','平房区','99' ); 
INSERT INTO `w_areas` VALUES( '230109','230100','松北区','99' ); 
INSERT INTO `w_areas` VALUES( '230110','230100','香坊区','99' ); 
INSERT INTO `w_areas` VALUES( '230111','230100','呼兰区','99' ); 
INSERT INTO `w_areas` VALUES( '230112','230100','阿城区','99' ); 
INSERT INTO `w_areas` VALUES( '230123','230100','依兰县','99' ); 
INSERT INTO `w_areas` VALUES( '230124','230100','方正县','99' ); 
INSERT INTO `w_areas` VALUES( '230125','230100','宾县','99' ); 
INSERT INTO `w_areas` VALUES( '230126','230100','巴彦县','99' ); 
INSERT INTO `w_areas` VALUES( '230127','230100','木兰县','99' ); 
INSERT INTO `w_areas` VALUES( '230128','230100','通河县','99' ); 
INSERT INTO `w_areas` VALUES( '230129','230100','延寿县','99' ); 
INSERT INTO `w_areas` VALUES( '230182','230100','双城市','99' ); 
INSERT INTO `w_areas` VALUES( '230183','230100','尚志市','99' ); 
INSERT INTO `w_areas` VALUES( '230184','230100','五常市','99' ); 
INSERT INTO `w_areas` VALUES( '230201','230200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230202','230200','龙沙区','99' ); 
INSERT INTO `w_areas` VALUES( '230203','230200','建华区','99' ); 
INSERT INTO `w_areas` VALUES( '230204','230200','铁锋区','99' ); 
INSERT INTO `w_areas` VALUES( '230205','230200','昂昂溪区','99' ); 
INSERT INTO `w_areas` VALUES( '230206','230200','富拉尔基区','99' ); 
INSERT INTO `w_areas` VALUES( '230207','230200','碾子山区','99' ); 
INSERT INTO `w_areas` VALUES( '230208','230200','梅里斯达斡尔族区','99' ); 
INSERT INTO `w_areas` VALUES( '230221','230200','龙江县','99' ); 
INSERT INTO `w_areas` VALUES( '230223','230200','依安县','99' ); 
INSERT INTO `w_areas` VALUES( '230224','230200','泰来县','99' ); 
INSERT INTO `w_areas` VALUES( '230225','230200','甘南县','99' ); 
INSERT INTO `w_areas` VALUES( '230227','230200','富裕县','99' ); 
INSERT INTO `w_areas` VALUES( '230229','230200','克山县','99' ); 
INSERT INTO `w_areas` VALUES( '230230','230200','克东县','99' ); 
INSERT INTO `w_areas` VALUES( '230231','230200','拜泉县','99' ); 
INSERT INTO `w_areas` VALUES( '230281','230200','讷河市','99' ); 
INSERT INTO `w_areas` VALUES( '230301','230300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230302','230300','鸡冠区','99' ); 
INSERT INTO `w_areas` VALUES( '230303','230300','恒山区','99' ); 
INSERT INTO `w_areas` VALUES( '230304','230300','滴道区','99' ); 
INSERT INTO `w_areas` VALUES( '230305','230300','梨树区','99' ); 
INSERT INTO `w_areas` VALUES( '230306','230300','城子河区','99' ); 
INSERT INTO `w_areas` VALUES( '230307','230300','麻山区','99' ); 
INSERT INTO `w_areas` VALUES( '230321','230300','鸡东县','99' ); 
INSERT INTO `w_areas` VALUES( '230381','230300','虎林市','99' ); 
INSERT INTO `w_areas` VALUES( '230382','230300','密山市','99' ); 
INSERT INTO `w_areas` VALUES( '230401','230400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230402','230400','向阳区','99' ); 
INSERT INTO `w_areas` VALUES( '230403','230400','工农区','99' ); 
INSERT INTO `w_areas` VALUES( '230404','230400','南山区','99' ); 
INSERT INTO `w_areas` VALUES( '230405','230400','兴安区','99' ); 
INSERT INTO `w_areas` VALUES( '230406','230400','东山区','99' ); 
INSERT INTO `w_areas` VALUES( '230407','230400','兴山区','99' ); 
INSERT INTO `w_areas` VALUES( '230421','230400','萝北县','99' ); 
INSERT INTO `w_areas` VALUES( '230422','230400','绥滨县','99' ); 
INSERT INTO `w_areas` VALUES( '230501','230500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230502','230500','尖山区','99' ); 
INSERT INTO `w_areas` VALUES( '230503','230500','岭东区','99' ); 
INSERT INTO `w_areas` VALUES( '230505','230500','四方台区','99' ); 
INSERT INTO `w_areas` VALUES( '230506','230500','宝山区','99' ); 
INSERT INTO `w_areas` VALUES( '230521','230500','集贤县','99' ); 
INSERT INTO `w_areas` VALUES( '230522','230500','友谊县','99' ); 
INSERT INTO `w_areas` VALUES( '230523','230500','宝清县','99' ); 
INSERT INTO `w_areas` VALUES( '230524','230500','饶河县','99' ); 
INSERT INTO `w_areas` VALUES( '230601','230600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230602','230600','萨尔图区','99' ); 
INSERT INTO `w_areas` VALUES( '230603','230600','龙凤区','99' ); 
INSERT INTO `w_areas` VALUES( '230604','230600','让胡路区','99' ); 
INSERT INTO `w_areas` VALUES( '230605','230600','红岗区','99' ); 
INSERT INTO `w_areas` VALUES( '230606','230600','大同区','99' ); 
INSERT INTO `w_areas` VALUES( '230621','230600','肇州县','99' ); 
INSERT INTO `w_areas` VALUES( '230622','230600','肇源县','99' ); 
INSERT INTO `w_areas` VALUES( '230623','230600','林甸县','99' ); 
INSERT INTO `w_areas` VALUES( '230624','230600','杜尔伯特蒙古族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '230701','230700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230702','230700','伊春区','99' ); 
INSERT INTO `w_areas` VALUES( '230703','230700','南岔区','99' ); 
INSERT INTO `w_areas` VALUES( '230704','230700','友好区','99' ); 
INSERT INTO `w_areas` VALUES( '230705','230700','西林区','99' ); 
INSERT INTO `w_areas` VALUES( '230706','230700','翠峦区','99' ); 
INSERT INTO `w_areas` VALUES( '230707','230700','新青区','99' ); 
INSERT INTO `w_areas` VALUES( '230708','230700','美溪区','99' ); 
INSERT INTO `w_areas` VALUES( '230709','230700','金山屯区','99' ); 
INSERT INTO `w_areas` VALUES( '230710','230700','五营区','99' ); 
INSERT INTO `w_areas` VALUES( '230711','230700','乌马河区','99' ); 
INSERT INTO `w_areas` VALUES( '230712','230700','汤旺河区','99' ); 
INSERT INTO `w_areas` VALUES( '230713','230700','带岭区','99' ); 
INSERT INTO `w_areas` VALUES( '230714','230700','乌伊岭区','99' ); 
INSERT INTO `w_areas` VALUES( '230715','230700','红星区','99' ); 
INSERT INTO `w_areas` VALUES( '230716','230700','上甘岭区','99' ); 
INSERT INTO `w_areas` VALUES( '230722','230700','嘉荫县','99' ); 
INSERT INTO `w_areas` VALUES( '230781','230700','铁力市','99' ); 
INSERT INTO `w_areas` VALUES( '230801','230800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230803','230800','向阳区','99' ); 
INSERT INTO `w_areas` VALUES( '230804','230800','前进区','99' ); 
INSERT INTO `w_areas` VALUES( '230805','230800','东风区','99' ); 
INSERT INTO `w_areas` VALUES( '230811','230800','郊区','99' ); 
INSERT INTO `w_areas` VALUES( '230822','230800','桦南县','99' ); 
INSERT INTO `w_areas` VALUES( '230826','230800','桦川县','99' ); 
INSERT INTO `w_areas` VALUES( '230828','230800','汤原县','99' ); 
INSERT INTO `w_areas` VALUES( '230833','230800','抚远县','99' ); 
INSERT INTO `w_areas` VALUES( '230881','230800','同江市','99' ); 
INSERT INTO `w_areas` VALUES( '230882','230800','富锦市','99' ); 
INSERT INTO `w_areas` VALUES( '230901','230900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '230902','230900','新兴区','99' ); 
INSERT INTO `w_areas` VALUES( '230903','230900','桃山区','99' ); 
INSERT INTO `w_areas` VALUES( '230904','230900','茄子河区','99' ); 
INSERT INTO `w_areas` VALUES( '230921','230900','勃利县','99' ); 
INSERT INTO `w_areas` VALUES( '231001','231000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '231002','231000','东安区','99' ); 
INSERT INTO `w_areas` VALUES( '231003','231000','阳明区','99' ); 
INSERT INTO `w_areas` VALUES( '231004','231000','爱民区','99' ); 
INSERT INTO `w_areas` VALUES( '231005','231000','西安区','99' ); 
INSERT INTO `w_areas` VALUES( '231024','231000','东宁县','99' ); 
INSERT INTO `w_areas` VALUES( '231025','231000','林口县','99' ); 
INSERT INTO `w_areas` VALUES( '231081','231000','绥芬河市','99' ); 
INSERT INTO `w_areas` VALUES( '231083','231000','海林市','99' ); 
INSERT INTO `w_areas` VALUES( '231084','231000','宁安市','99' ); 
INSERT INTO `w_areas` VALUES( '231085','231000','穆棱市','99' ); 
INSERT INTO `w_areas` VALUES( '231101','231100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '231102','231100','爱辉区','99' ); 
INSERT INTO `w_areas` VALUES( '231121','231100','嫩江县','99' ); 
INSERT INTO `w_areas` VALUES( '231123','231100','逊克县','99' ); 
INSERT INTO `w_areas` VALUES( '231124','231100','孙吴县','99' ); 
INSERT INTO `w_areas` VALUES( '231181','231100','北安市','99' ); 
INSERT INTO `w_areas` VALUES( '231182','231100','五大连池市','99' ); 
INSERT INTO `w_areas` VALUES( '231201','231200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '231202','231200','北林区','99' ); 
INSERT INTO `w_areas` VALUES( '231221','231200','望奎县','99' ); 
INSERT INTO `w_areas` VALUES( '231222','231200','兰西县','99' ); 
INSERT INTO `w_areas` VALUES( '231223','231200','青冈县','99' ); 
INSERT INTO `w_areas` VALUES( '231224','231200','庆安县','99' ); 
INSERT INTO `w_areas` VALUES( '231225','231200','明水县','99' ); 
INSERT INTO `w_areas` VALUES( '231226','231200','绥棱县','99' ); 
INSERT INTO `w_areas` VALUES( '231281','231200','安达市','99' ); 
INSERT INTO `w_areas` VALUES( '231282','231200','肇东市','99' ); 
INSERT INTO `w_areas` VALUES( '231283','231200','海伦市','99' ); 
INSERT INTO `w_areas` VALUES( '232721','232700','呼玛县','99' ); 
INSERT INTO `w_areas` VALUES( '232722','232700','塔河县','99' ); 
INSERT INTO `w_areas` VALUES( '232723','232700','漠河县','99' ); 
INSERT INTO `w_areas` VALUES( '310101','310100','黄浦区','99' ); 
INSERT INTO `w_areas` VALUES( '310104','310100','徐汇区','99' ); 
INSERT INTO `w_areas` VALUES( '310105','310100','长宁区','99' ); 
INSERT INTO `w_areas` VALUES( '310106','310100','静安区','99' ); 
INSERT INTO `w_areas` VALUES( '310107','310100','普陀区','99' ); 
INSERT INTO `w_areas` VALUES( '310108','310100','闸北区','99' ); 
INSERT INTO `w_areas` VALUES( '310109','310100','虹口区','99' ); 
INSERT INTO `w_areas` VALUES( '310110','310100','杨浦区','99' ); 
INSERT INTO `w_areas` VALUES( '310112','310100','闵行区','99' ); 
INSERT INTO `w_areas` VALUES( '310113','310100','宝山区','99' ); 
INSERT INTO `w_areas` VALUES( '310114','310100','嘉定区','99' ); 
INSERT INTO `w_areas` VALUES( '310115','310100','浦东新区','99' ); 
INSERT INTO `w_areas` VALUES( '310116','310100','金山区','99' ); 
INSERT INTO `w_areas` VALUES( '310117','310100','松江区','99' ); 
INSERT INTO `w_areas` VALUES( '310118','310100','青浦区','99' ); 
INSERT INTO `w_areas` VALUES( '310120','310100','奉贤区','99' ); 
INSERT INTO `w_areas` VALUES( '310230','310200','崇明县','99' ); 
INSERT INTO `w_areas` VALUES( '320101','320100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320102','320100','玄武区','99' ); 
INSERT INTO `w_areas` VALUES( '320103','320100','白下区','99' ); 
INSERT INTO `w_areas` VALUES( '320104','320100','秦淮区','99' ); 
INSERT INTO `w_areas` VALUES( '320105','320100','建邺区','99' ); 
INSERT INTO `w_areas` VALUES( '320106','320100','鼓楼区','99' ); 
INSERT INTO `w_areas` VALUES( '320107','320100','下关区','99' ); 
INSERT INTO `w_areas` VALUES( '320111','320100','浦口区','99' ); 
INSERT INTO `w_areas` VALUES( '320113','320100','栖霞区','99' ); 
INSERT INTO `w_areas` VALUES( '320114','320100','雨花台区','99' ); 
INSERT INTO `w_areas` VALUES( '320115','320100','江宁区','99' ); 
INSERT INTO `w_areas` VALUES( '320116','320100','六合区','99' ); 
INSERT INTO `w_areas` VALUES( '320124','320100','溧水县','99' ); 
INSERT INTO `w_areas` VALUES( '320125','320100','高淳县','99' ); 
INSERT INTO `w_areas` VALUES( '320201','320200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320202','320200','崇安区','99' ); 
INSERT INTO `w_areas` VALUES( '320203','320200','南长区','99' ); 
INSERT INTO `w_areas` VALUES( '320204','320200','北塘区','99' ); 
INSERT INTO `w_areas` VALUES( '320205','320200','锡山区','99' ); 
INSERT INTO `w_areas` VALUES( '320206','320200','惠山区','99' ); 
INSERT INTO `w_areas` VALUES( '320211','320200','滨湖区','99' ); 
INSERT INTO `w_areas` VALUES( '320281','320200','江阴市','99' ); 
INSERT INTO `w_areas` VALUES( '320282','320200','宜兴市','99' ); 
INSERT INTO `w_areas` VALUES( '320301','320300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320302','320300','鼓楼区','99' ); 
INSERT INTO `w_areas` VALUES( '320303','320300','云龙区','99' ); 
INSERT INTO `w_areas` VALUES( '320305','320300','贾汪区','99' ); 
INSERT INTO `w_areas` VALUES( '320311','320300','泉山区','99' ); 
INSERT INTO `w_areas` VALUES( '320312','320300','铜山区','99' ); 
INSERT INTO `w_areas` VALUES( '320321','320300','丰县','99' ); 
INSERT INTO `w_areas` VALUES( '320322','320300','沛县','99' ); 
INSERT INTO `w_areas` VALUES( '320324','320300','睢宁县','99' ); 
INSERT INTO `w_areas` VALUES( '320381','320300','新沂市','99' ); 
INSERT INTO `w_areas` VALUES( '320382','320300','邳州市','99' ); 
INSERT INTO `w_areas` VALUES( '320401','320400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320402','320400','天宁区','99' ); 
INSERT INTO `w_areas` VALUES( '320404','320400','钟楼区','99' ); 
INSERT INTO `w_areas` VALUES( '320405','320400','戚墅堰区','99' ); 
INSERT INTO `w_areas` VALUES( '320411','320400','新北区','99' ); 
INSERT INTO `w_areas` VALUES( '320412','320400','武进区','99' ); 
INSERT INTO `w_areas` VALUES( '320481','320400','溧阳市','99' ); 
INSERT INTO `w_areas` VALUES( '320482','320400','金坛市','99' ); 
INSERT INTO `w_areas` VALUES( '320501','320500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320505','320500','虎丘区','99' ); 
INSERT INTO `w_areas` VALUES( '320506','320500','吴中区','99' ); 
INSERT INTO `w_areas` VALUES( '320507','320500','相城区','99' ); 
INSERT INTO `w_areas` VALUES( '320508','320500','姑苏区','99' ); 
INSERT INTO `w_areas` VALUES( '320509','320500','吴江区','99' ); 
INSERT INTO `w_areas` VALUES( '320581','320500','常熟市','99' ); 
INSERT INTO `w_areas` VALUES( '320582','320500','张家港市','99' ); 
INSERT INTO `w_areas` VALUES( '320583','320500','昆山市','99' ); 
INSERT INTO `w_areas` VALUES( '320585','320500','太仓市','99' ); 
INSERT INTO `w_areas` VALUES( '320601','320600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320602','320600','崇川区','99' ); 
INSERT INTO `w_areas` VALUES( '320611','320600','港闸区','99' ); 
INSERT INTO `w_areas` VALUES( '320612','320600','通州区','99' ); 
INSERT INTO `w_areas` VALUES( '320621','320600','海安县','99' ); 
INSERT INTO `w_areas` VALUES( '320623','320600','如东县','99' ); 
INSERT INTO `w_areas` VALUES( '320681','320600','启东市','99' ); 
INSERT INTO `w_areas` VALUES( '320682','320600','如皋市','99' ); 
INSERT INTO `w_areas` VALUES( '320684','320600','海门市','99' ); 
INSERT INTO `w_areas` VALUES( '320701','320700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320703','320700','连云区','99' ); 
INSERT INTO `w_areas` VALUES( '320705','320700','新浦区','99' ); 
INSERT INTO `w_areas` VALUES( '320706','320700','海州区','99' ); 
INSERT INTO `w_areas` VALUES( '320721','320700','赣榆县','99' ); 
INSERT INTO `w_areas` VALUES( '320722','320700','东海县','99' ); 
INSERT INTO `w_areas` VALUES( '320723','320700','灌云县','99' ); 
INSERT INTO `w_areas` VALUES( '320724','320700','灌南县','99' ); 
INSERT INTO `w_areas` VALUES( '320801','320800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320802','320800','清河区','99' ); 
INSERT INTO `w_areas` VALUES( '320803','320800','淮安区','99' ); 
INSERT INTO `w_areas` VALUES( '320804','320800','淮阴区','99' ); 
INSERT INTO `w_areas` VALUES( '320811','320800','清浦区','99' ); 
INSERT INTO `w_areas` VALUES( '320826','320800','涟水县','99' ); 
INSERT INTO `w_areas` VALUES( '320829','320800','洪泽县','99' ); 
INSERT INTO `w_areas` VALUES( '320830','320800','盱眙县','99' ); 
INSERT INTO `w_areas` VALUES( '320831','320800','金湖县','99' ); 
INSERT INTO `w_areas` VALUES( '320901','320900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '320902','320900','亭湖区','99' ); 
INSERT INTO `w_areas` VALUES( '320903','320900','盐都区','99' ); 
INSERT INTO `w_areas` VALUES( '320921','320900','响水县','99' ); 
INSERT INTO `w_areas` VALUES( '320922','320900','滨海县','99' ); 
INSERT INTO `w_areas` VALUES( '320923','320900','阜宁县','99' ); 
INSERT INTO `w_areas` VALUES( '320924','320900','射阳县','99' ); 
INSERT INTO `w_areas` VALUES( '320925','320900','建湖县','99' ); 
INSERT INTO `w_areas` VALUES( '320981','320900','东台市','99' ); 
INSERT INTO `w_areas` VALUES( '320982','320900','大丰市','99' ); 
INSERT INTO `w_areas` VALUES( '321001','321000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '321002','321000','广陵区','99' ); 
INSERT INTO `w_areas` VALUES( '321003','321000','邗江区','99' ); 
INSERT INTO `w_areas` VALUES( '321012','321000','江都区','99' ); 
INSERT INTO `w_areas` VALUES( '321023','321000','宝应县','99' ); 
INSERT INTO `w_areas` VALUES( '321081','321000','仪征市','99' ); 
INSERT INTO `w_areas` VALUES( '321084','321000','高邮市','99' ); 
INSERT INTO `w_areas` VALUES( '321101','321100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '321102','321100','京口区','99' ); 
INSERT INTO `w_areas` VALUES( '321111','321100','润州区','99' ); 
INSERT INTO `w_areas` VALUES( '321112','321100','丹徒区','99' ); 
INSERT INTO `w_areas` VALUES( '321181','321100','丹阳市','99' ); 
INSERT INTO `w_areas` VALUES( '321182','321100','扬中市','99' ); 
INSERT INTO `w_areas` VALUES( '321183','321100','句容市','99' ); 
INSERT INTO `w_areas` VALUES( '321201','321200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '321202','321200','海陵区','99' ); 
INSERT INTO `w_areas` VALUES( '321203','321200','高港区','99' ); 
INSERT INTO `w_areas` VALUES( '321281','321200','兴化市','99' ); 
INSERT INTO `w_areas` VALUES( '321282','321200','靖江市','99' ); 
INSERT INTO `w_areas` VALUES( '321283','321200','泰兴市','99' ); 
INSERT INTO `w_areas` VALUES( '321284','321200','姜堰市','99' ); 
INSERT INTO `w_areas` VALUES( '321301','321300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '321302','321300','宿城区','99' ); 
INSERT INTO `w_areas` VALUES( '321311','321300','宿豫区','99' ); 
INSERT INTO `w_areas` VALUES( '321322','321300','沭阳县','99' ); 
INSERT INTO `w_areas` VALUES( '321323','321300','泗阳县','99' ); 
INSERT INTO `w_areas` VALUES( '321324','321300','泗洪县','99' ); 
INSERT INTO `w_areas` VALUES( '330101','330100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330102','330100','上城区','99' ); 
INSERT INTO `w_areas` VALUES( '330103','330100','下城区','99' ); 
INSERT INTO `w_areas` VALUES( '330104','330100','江干区','99' ); 
INSERT INTO `w_areas` VALUES( '330105','330100','拱墅区','99' ); 
INSERT INTO `w_areas` VALUES( '330106','330100','西湖区','99' ); 
INSERT INTO `w_areas` VALUES( '330108','330100','滨江区','99' ); 
INSERT INTO `w_areas` VALUES( '330109','330100','萧山区','99' ); 
INSERT INTO `w_areas` VALUES( '330110','330100','余杭区','99' ); 
INSERT INTO `w_areas` VALUES( '330122','330100','桐庐县','99' ); 
INSERT INTO `w_areas` VALUES( '330127','330100','淳安县','99' ); 
INSERT INTO `w_areas` VALUES( '330182','330100','建德市','99' ); 
INSERT INTO `w_areas` VALUES( '330183','330100','富阳市','99' ); 
INSERT INTO `w_areas` VALUES( '330185','330100','临安市','99' ); 
INSERT INTO `w_areas` VALUES( '330201','330200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330203','330200','海曙区','99' ); 
INSERT INTO `w_areas` VALUES( '330204','330200','江东区','99' ); 
INSERT INTO `w_areas` VALUES( '330205','330200','江北区','99' ); 
INSERT INTO `w_areas` VALUES( '330206','330200','北仑区','99' ); 
INSERT INTO `w_areas` VALUES( '330211','330200','镇海区','99' ); 
INSERT INTO `w_areas` VALUES( '330212','330200','鄞州区','99' ); 
INSERT INTO `w_areas` VALUES( '330225','330200','象山县','99' ); 
INSERT INTO `w_areas` VALUES( '330226','330200','宁海县','99' ); 
INSERT INTO `w_areas` VALUES( '330281','330200','余姚市','99' ); 
INSERT INTO `w_areas` VALUES( '330282','330200','慈溪市','99' ); 
INSERT INTO `w_areas` VALUES( '330283','330200','奉化市','99' ); 
INSERT INTO `w_areas` VALUES( '330301','330300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330302','330300','鹿城区','99' ); 
INSERT INTO `w_areas` VALUES( '330303','330300','龙湾区','99' ); 
INSERT INTO `w_areas` VALUES( '330304','330300','瓯海区','99' ); 
INSERT INTO `w_areas` VALUES( '330322','330300','洞头县','99' ); 
INSERT INTO `w_areas` VALUES( '330324','330300','永嘉县','99' ); 
INSERT INTO `w_areas` VALUES( '330326','330300','平阳县','99' ); 
INSERT INTO `w_areas` VALUES( '330327','330300','苍南县','99' ); 
INSERT INTO `w_areas` VALUES( '330328','330300','文成县','99' ); 
INSERT INTO `w_areas` VALUES( '330329','330300','泰顺县','99' ); 
INSERT INTO `w_areas` VALUES( '330381','330300','瑞安市','99' ); 
INSERT INTO `w_areas` VALUES( '330382','330300','乐清市','99' ); 
INSERT INTO `w_areas` VALUES( '330401','330400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330402','330400','南湖区','99' ); 
INSERT INTO `w_areas` VALUES( '330411','330400','秀洲区','99' ); 
INSERT INTO `w_areas` VALUES( '330421','330400','嘉善县','99' ); 
INSERT INTO `w_areas` VALUES( '330424','330400','海盐县','99' ); 
INSERT INTO `w_areas` VALUES( '330481','330400','海宁市','99' ); 
INSERT INTO `w_areas` VALUES( '330482','330400','平湖市','99' ); 
INSERT INTO `w_areas` VALUES( '330483','330400','桐乡市','99' ); 
INSERT INTO `w_areas` VALUES( '330501','330500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330502','330500','吴兴区','99' ); 
INSERT INTO `w_areas` VALUES( '330503','330500','南浔区','99' ); 
INSERT INTO `w_areas` VALUES( '330521','330500','德清县','99' ); 
INSERT INTO `w_areas` VALUES( '330522','330500','长兴县','99' ); 
INSERT INTO `w_areas` VALUES( '330523','330500','安吉县','99' ); 
INSERT INTO `w_areas` VALUES( '330601','330600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330602','330600','越城区','99' ); 
INSERT INTO `w_areas` VALUES( '330621','330600','绍兴县','99' ); 
INSERT INTO `w_areas` VALUES( '330624','330600','新昌县','99' ); 
INSERT INTO `w_areas` VALUES( '330681','330600','诸暨市','99' ); 
INSERT INTO `w_areas` VALUES( '330682','330600','上虞市','99' ); 
INSERT INTO `w_areas` VALUES( '330683','330600','嵊州市','99' ); 
INSERT INTO `w_areas` VALUES( '330701','330700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330702','330700','婺城区','99' ); 
INSERT INTO `w_areas` VALUES( '330703','330700','金东区','99' ); 
INSERT INTO `w_areas` VALUES( '330723','330700','武义县','99' ); 
INSERT INTO `w_areas` VALUES( '330726','330700','浦江县','99' ); 
INSERT INTO `w_areas` VALUES( '330727','330700','磐安县','99' ); 
INSERT INTO `w_areas` VALUES( '330781','330700','兰溪市','99' ); 
INSERT INTO `w_areas` VALUES( '330782','330700','义乌市','99' ); 
INSERT INTO `w_areas` VALUES( '330783','330700','东阳市','99' ); 
INSERT INTO `w_areas` VALUES( '330784','330700','永康市','99' ); 
INSERT INTO `w_areas` VALUES( '330801','330800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330802','330800','柯城区','99' ); 
INSERT INTO `w_areas` VALUES( '330803','330800','衢江区','99' ); 
INSERT INTO `w_areas` VALUES( '330822','330800','常山县','99' ); 
INSERT INTO `w_areas` VALUES( '330824','330800','开化县','99' ); 
INSERT INTO `w_areas` VALUES( '330825','330800','龙游县','99' ); 
INSERT INTO `w_areas` VALUES( '330881','330800','江山市','99' ); 
INSERT INTO `w_areas` VALUES( '330901','330900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '330902','330900','定海区','99' ); 
INSERT INTO `w_areas` VALUES( '330903','330900','普陀区','99' ); 
INSERT INTO `w_areas` VALUES( '330921','330900','岱山县','99' ); 
INSERT INTO `w_areas` VALUES( '330922','330900','嵊泗县','99' ); 
INSERT INTO `w_areas` VALUES( '331001','331000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '331002','331000','椒江区','99' ); 
INSERT INTO `w_areas` VALUES( '331003','331000','黄岩区','99' ); 
INSERT INTO `w_areas` VALUES( '331004','331000','路桥区','99' ); 
INSERT INTO `w_areas` VALUES( '331021','331000','玉环县','99' ); 
INSERT INTO `w_areas` VALUES( '331022','331000','三门县','99' ); 
INSERT INTO `w_areas` VALUES( '331023','331000','天台县','99' ); 
INSERT INTO `w_areas` VALUES( '331024','331000','仙居县','99' ); 
INSERT INTO `w_areas` VALUES( '331081','331000','温岭市','99' ); 
INSERT INTO `w_areas` VALUES( '331082','331000','临海市','99' ); 
INSERT INTO `w_areas` VALUES( '331101','331100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '331102','331100','莲都区','99' ); 
INSERT INTO `w_areas` VALUES( '331121','331100','青田县','99' ); 
INSERT INTO `w_areas` VALUES( '331122','331100','缙云县','99' ); 
INSERT INTO `w_areas` VALUES( '331123','331100','遂昌县','99' ); 
INSERT INTO `w_areas` VALUES( '331124','331100','松阳县','99' ); 
INSERT INTO `w_areas` VALUES( '331125','331100','云和县','99' ); 
INSERT INTO `w_areas` VALUES( '331126','331100','庆元县','99' ); 
INSERT INTO `w_areas` VALUES( '331127','331100','景宁畲族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '331181','331100','龙泉市','99' ); 
INSERT INTO `w_areas` VALUES( '340101','340100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340102','340100','瑶海区','99' ); 
INSERT INTO `w_areas` VALUES( '340103','340100','庐阳区','99' ); 
INSERT INTO `w_areas` VALUES( '340104','340100','蜀山区','99' ); 
INSERT INTO `w_areas` VALUES( '340111','340100','包河区','99' ); 
INSERT INTO `w_areas` VALUES( '340121','340100','长丰县','99' ); 
INSERT INTO `w_areas` VALUES( '340122','340100','肥东县','99' ); 
INSERT INTO `w_areas` VALUES( '340123','340100','肥西县','99' ); 
INSERT INTO `w_areas` VALUES( '340124','340100','庐江县','99' ); 
INSERT INTO `w_areas` VALUES( '340181','340100','巢湖市','99' ); 
INSERT INTO `w_areas` VALUES( '340201','340200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340202','340200','镜湖区','99' ); 
INSERT INTO `w_areas` VALUES( '340203','340200','弋江区','99' ); 
INSERT INTO `w_areas` VALUES( '340207','340200','鸠江区','99' ); 
INSERT INTO `w_areas` VALUES( '340208','340200','三山区','99' ); 
INSERT INTO `w_areas` VALUES( '340221','340200','芜湖县','99' ); 
INSERT INTO `w_areas` VALUES( '340222','340200','繁昌县','99' ); 
INSERT INTO `w_areas` VALUES( '340223','340200','南陵县','99' ); 
INSERT INTO `w_areas` VALUES( '340225','340200','无为县','99' ); 
INSERT INTO `w_areas` VALUES( '340301','340300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340302','340300','龙子湖区','99' ); 
INSERT INTO `w_areas` VALUES( '340303','340300','蚌山区','99' ); 
INSERT INTO `w_areas` VALUES( '340304','340300','禹会区','99' ); 
INSERT INTO `w_areas` VALUES( '340311','340300','淮上区','99' ); 
INSERT INTO `w_areas` VALUES( '340321','340300','怀远县','99' ); 
INSERT INTO `w_areas` VALUES( '340322','340300','五河县','99' ); 
INSERT INTO `w_areas` VALUES( '340323','340300','固镇县','99' ); 
INSERT INTO `w_areas` VALUES( '340401','340400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340402','340400','大通区','99' ); 
INSERT INTO `w_areas` VALUES( '340403','340400','田家庵区','99' ); 
INSERT INTO `w_areas` VALUES( '340404','340400','谢家集区','99' ); 
INSERT INTO `w_areas` VALUES( '340405','340400','八公山区','99' ); 
INSERT INTO `w_areas` VALUES( '340406','340400','潘集区','99' ); 
INSERT INTO `w_areas` VALUES( '340421','340400','凤台县','99' ); 
INSERT INTO `w_areas` VALUES( '340501','340500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340503','340500','花山区','99' ); 
INSERT INTO `w_areas` VALUES( '340504','340500','雨山区','99' ); 
INSERT INTO `w_areas` VALUES( '340506','340500','博望区','99' ); 
INSERT INTO `w_areas` VALUES( '340521','340500','当涂县','99' ); 
INSERT INTO `w_areas` VALUES( '340522','340500','含山县','99' ); 
INSERT INTO `w_areas` VALUES( '340523','340500','和县','99' ); 
INSERT INTO `w_areas` VALUES( '340601','340600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340602','340600','杜集区','99' ); 
INSERT INTO `w_areas` VALUES( '340603','340600','相山区','99' ); 
INSERT INTO `w_areas` VALUES( '340604','340600','烈山区','99' ); 
INSERT INTO `w_areas` VALUES( '340621','340600','濉溪县','99' ); 
INSERT INTO `w_areas` VALUES( '340701','340700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340702','340700','铜官山区','99' ); 
INSERT INTO `w_areas` VALUES( '340703','340700','狮子山区','99' ); 
INSERT INTO `w_areas` VALUES( '340711','340700','郊区','99' ); 
INSERT INTO `w_areas` VALUES( '340721','340700','铜陵县','99' ); 
INSERT INTO `w_areas` VALUES( '340801','340800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '340802','340800','迎江区','99' ); 
INSERT INTO `w_areas` VALUES( '340803','340800','大观区','99' ); 
INSERT INTO `w_areas` VALUES( '340811','340800','宜秀区','99' ); 
INSERT INTO `w_areas` VALUES( '340822','340800','怀宁县','99' ); 
INSERT INTO `w_areas` VALUES( '340823','340800','枞阳县','99' ); 
INSERT INTO `w_areas` VALUES( '340824','340800','潜山县','99' ); 
INSERT INTO `w_areas` VALUES( '340825','340800','太湖县','99' ); 
INSERT INTO `w_areas` VALUES( '340826','340800','宿松县','99' ); 
INSERT INTO `w_areas` VALUES( '340827','340800','望江县','99' ); 
INSERT INTO `w_areas` VALUES( '340828','340800','岳西县','99' ); 
INSERT INTO `w_areas` VALUES( '340881','340800','桐城市','99' ); 
INSERT INTO `w_areas` VALUES( '341001','341000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341002','341000','屯溪区','99' ); 
INSERT INTO `w_areas` VALUES( '341003','341000','黄山区','99' ); 
INSERT INTO `w_areas` VALUES( '341004','341000','徽州区','99' ); 
INSERT INTO `w_areas` VALUES( '341021','341000','歙县','99' ); 
INSERT INTO `w_areas` VALUES( '341022','341000','休宁县','99' ); 
INSERT INTO `w_areas` VALUES( '341023','341000','黟县','99' ); 
INSERT INTO `w_areas` VALUES( '341024','341000','祁门县','99' ); 
INSERT INTO `w_areas` VALUES( '341101','341100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341102','341100','琅琊区','99' ); 
INSERT INTO `w_areas` VALUES( '341103','341100','南谯区','99' ); 
INSERT INTO `w_areas` VALUES( '341122','341100','来安县','99' ); 
INSERT INTO `w_areas` VALUES( '341124','341100','全椒县','99' ); 
INSERT INTO `w_areas` VALUES( '341125','341100','定远县','99' ); 
INSERT INTO `w_areas` VALUES( '341126','341100','凤阳县','99' ); 
INSERT INTO `w_areas` VALUES( '341181','341100','天长市','99' ); 
INSERT INTO `w_areas` VALUES( '341182','341100','明光市','99' ); 
INSERT INTO `w_areas` VALUES( '341201','341200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341202','341200','颍州区','99' ); 
INSERT INTO `w_areas` VALUES( '341203','341200','颍东区','99' ); 
INSERT INTO `w_areas` VALUES( '341204','341200','颍泉区','99' ); 
INSERT INTO `w_areas` VALUES( '341221','341200','临泉县','99' ); 
INSERT INTO `w_areas` VALUES( '341222','341200','太和县','99' ); 
INSERT INTO `w_areas` VALUES( '341225','341200','阜南县','99' ); 
INSERT INTO `w_areas` VALUES( '341226','341200','颍上县','99' ); 
INSERT INTO `w_areas` VALUES( '341282','341200','界首市','99' ); 
INSERT INTO `w_areas` VALUES( '341301','341300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341302','341300','埇桥区','99' ); 
INSERT INTO `w_areas` VALUES( '341321','341300','砀山县','99' ); 
INSERT INTO `w_areas` VALUES( '341322','341300','萧县','99' ); 
INSERT INTO `w_areas` VALUES( '341323','341300','灵璧县','99' ); 
INSERT INTO `w_areas` VALUES( '341324','341300','泗县','99' ); 
INSERT INTO `w_areas` VALUES( '341501','341500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341502','341500','金安区','99' ); 
INSERT INTO `w_areas` VALUES( '341503','341500','裕安区','99' ); 
INSERT INTO `w_areas` VALUES( '341521','341500','寿县','99' ); 
INSERT INTO `w_areas` VALUES( '341522','341500','霍邱县','99' ); 
INSERT INTO `w_areas` VALUES( '341523','341500','舒城县','99' ); 
INSERT INTO `w_areas` VALUES( '341524','341500','金寨县','99' ); 
INSERT INTO `w_areas` VALUES( '341525','341500','霍山县','99' ); 
INSERT INTO `w_areas` VALUES( '341601','341600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341602','341600','谯城区','99' ); 
INSERT INTO `w_areas` VALUES( '341621','341600','涡阳县','99' ); 
INSERT INTO `w_areas` VALUES( '341622','341600','蒙城县','99' ); 
INSERT INTO `w_areas` VALUES( '341623','341600','利辛县','99' ); 
INSERT INTO `w_areas` VALUES( '341701','341700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341702','341700','贵池区','99' ); 
INSERT INTO `w_areas` VALUES( '341721','341700','东至县','99' ); 
INSERT INTO `w_areas` VALUES( '341722','341700','石台县','99' ); 
INSERT INTO `w_areas` VALUES( '341723','341700','青阳县','99' ); 
INSERT INTO `w_areas` VALUES( '341801','341800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '341802','341800','宣州区','99' ); 
INSERT INTO `w_areas` VALUES( '341821','341800','郎溪县','99' ); 
INSERT INTO `w_areas` VALUES( '341822','341800','广德县','99' ); 
INSERT INTO `w_areas` VALUES( '341823','341800','泾县','99' ); 
INSERT INTO `w_areas` VALUES( '341824','341800','绩溪县','99' ); 
INSERT INTO `w_areas` VALUES( '341825','341800','旌德县','99' ); 
INSERT INTO `w_areas` VALUES( '341881','341800','宁国市','99' ); 
INSERT INTO `w_areas` VALUES( '350101','350100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350102','350100','鼓楼区','99' ); 
INSERT INTO `w_areas` VALUES( '350103','350100','台江区','99' ); 
INSERT INTO `w_areas` VALUES( '350104','350100','仓山区','99' ); 
INSERT INTO `w_areas` VALUES( '350105','350100','马尾区','99' ); 
INSERT INTO `w_areas` VALUES( '350111','350100','晋安区','99' ); 
INSERT INTO `w_areas` VALUES( '350121','350100','闽侯县','99' ); 
INSERT INTO `w_areas` VALUES( '350122','350100','连江县','99' ); 
INSERT INTO `w_areas` VALUES( '350123','350100','罗源县','99' ); 
INSERT INTO `w_areas` VALUES( '350124','350100','闽清县','99' ); 
INSERT INTO `w_areas` VALUES( '350125','350100','永泰县','99' ); 
INSERT INTO `w_areas` VALUES( '350128','350100','平潭县','99' ); 
INSERT INTO `w_areas` VALUES( '350181','350100','福清市','99' ); 
INSERT INTO `w_areas` VALUES( '350182','350100','长乐市','99' ); 
INSERT INTO `w_areas` VALUES( '350201','350200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350203','350200','思明区','99' ); 
INSERT INTO `w_areas` VALUES( '350205','350200','海沧区','99' ); 
INSERT INTO `w_areas` VALUES( '350206','350200','湖里区','99' ); 
INSERT INTO `w_areas` VALUES( '350211','350200','集美区','99' ); 
INSERT INTO `w_areas` VALUES( '350212','350200','同安区','99' ); 
INSERT INTO `w_areas` VALUES( '350213','350200','翔安区','99' ); 
INSERT INTO `w_areas` VALUES( '350301','350300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350302','350300','城厢区','99' ); 
INSERT INTO `w_areas` VALUES( '350303','350300','涵江区','99' ); 
INSERT INTO `w_areas` VALUES( '350304','350300','荔城区','99' ); 
INSERT INTO `w_areas` VALUES( '350305','350300','秀屿区','99' ); 
INSERT INTO `w_areas` VALUES( '350322','350300','仙游县','99' ); 
INSERT INTO `w_areas` VALUES( '350401','350400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350402','350400','梅列区','99' ); 
INSERT INTO `w_areas` VALUES( '350403','350400','三元区','99' ); 
INSERT INTO `w_areas` VALUES( '350421','350400','明溪县','99' ); 
INSERT INTO `w_areas` VALUES( '350423','350400','清流县','99' ); 
INSERT INTO `w_areas` VALUES( '350424','350400','宁化县','99' ); 
INSERT INTO `w_areas` VALUES( '350425','350400','大田县','99' ); 
INSERT INTO `w_areas` VALUES( '350426','350400','尤溪县','99' ); 
INSERT INTO `w_areas` VALUES( '350427','350400','沙县','99' ); 
INSERT INTO `w_areas` VALUES( '350428','350400','将乐县','99' ); 
INSERT INTO `w_areas` VALUES( '350429','350400','泰宁县','99' ); 
INSERT INTO `w_areas` VALUES( '350430','350400','建宁县','99' ); 
INSERT INTO `w_areas` VALUES( '350481','350400','永安市','99' ); 
INSERT INTO `w_areas` VALUES( '350501','350500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350502','350500','鲤城区','99' ); 
INSERT INTO `w_areas` VALUES( '350503','350500','丰泽区','99' ); 
INSERT INTO `w_areas` VALUES( '350504','350500','洛江区','99' ); 
INSERT INTO `w_areas` VALUES( '350505','350500','泉港区','99' ); 
INSERT INTO `w_areas` VALUES( '350521','350500','惠安县','99' ); 
INSERT INTO `w_areas` VALUES( '350524','350500','安溪县','99' ); 
INSERT INTO `w_areas` VALUES( '350525','350500','永春县','99' ); 
INSERT INTO `w_areas` VALUES( '350526','350500','德化县','99' ); 
INSERT INTO `w_areas` VALUES( '350527','350500','金门县','99' ); 
INSERT INTO `w_areas` VALUES( '350581','350500','石狮市','99' ); 
INSERT INTO `w_areas` VALUES( '350582','350500','晋江市','99' ); 
INSERT INTO `w_areas` VALUES( '350583','350500','南安市','99' ); 
INSERT INTO `w_areas` VALUES( '350601','350600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350602','350600','芗城区','99' ); 
INSERT INTO `w_areas` VALUES( '350603','350600','龙文区','99' ); 
INSERT INTO `w_areas` VALUES( '350622','350600','云霄县','99' ); 
INSERT INTO `w_areas` VALUES( '350623','350600','漳浦县','99' ); 
INSERT INTO `w_areas` VALUES( '350624','350600','诏安县','99' ); 
INSERT INTO `w_areas` VALUES( '350625','350600','长泰县','99' ); 
INSERT INTO `w_areas` VALUES( '350626','350600','东山县','99' ); 
INSERT INTO `w_areas` VALUES( '350627','350600','南靖县','99' ); 
INSERT INTO `w_areas` VALUES( '350628','350600','平和县','99' ); 
INSERT INTO `w_areas` VALUES( '350629','350600','华安县','99' ); 
INSERT INTO `w_areas` VALUES( '350681','350600','龙海市','99' ); 
INSERT INTO `w_areas` VALUES( '350701','350700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350702','350700','延平区','99' ); 
INSERT INTO `w_areas` VALUES( '350721','350700','顺昌县','99' ); 
INSERT INTO `w_areas` VALUES( '350722','350700','浦城县','99' ); 
INSERT INTO `w_areas` VALUES( '350723','350700','光泽县','99' ); 
INSERT INTO `w_areas` VALUES( '350724','350700','松溪县','99' ); 
INSERT INTO `w_areas` VALUES( '350725','350700','政和县','99' ); 
INSERT INTO `w_areas` VALUES( '350781','350700','邵武市','99' ); 
INSERT INTO `w_areas` VALUES( '350782','350700','武夷山市','99' ); 
INSERT INTO `w_areas` VALUES( '350783','350700','建瓯市','99' ); 
INSERT INTO `w_areas` VALUES( '350784','350700','建阳市','99' ); 
INSERT INTO `w_areas` VALUES( '350801','350800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350802','350800','新罗区','99' ); 
INSERT INTO `w_areas` VALUES( '350821','350800','长汀县','99' ); 
INSERT INTO `w_areas` VALUES( '350822','350800','永定县','99' ); 
INSERT INTO `w_areas` VALUES( '350823','350800','上杭县','99' ); 
INSERT INTO `w_areas` VALUES( '350824','350800','武平县','99' ); 
INSERT INTO `w_areas` VALUES( '350825','350800','连城县','99' ); 
INSERT INTO `w_areas` VALUES( '350881','350800','漳平市','99' ); 
INSERT INTO `w_areas` VALUES( '350901','350900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '350902','350900','蕉城区','99' ); 
INSERT INTO `w_areas` VALUES( '350921','350900','霞浦县','99' ); 
INSERT INTO `w_areas` VALUES( '350922','350900','古田县','99' ); 
INSERT INTO `w_areas` VALUES( '350923','350900','屏南县','99' ); 
INSERT INTO `w_areas` VALUES( '350924','350900','寿宁县','99' ); 
INSERT INTO `w_areas` VALUES( '350925','350900','周宁县','99' ); 
INSERT INTO `w_areas` VALUES( '350926','350900','柘荣县','99' ); 
INSERT INTO `w_areas` VALUES( '350981','350900','福安市','99' ); 
INSERT INTO `w_areas` VALUES( '350982','350900','福鼎市','99' ); 
INSERT INTO `w_areas` VALUES( '360101','360100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360102','360100','东湖区','99' ); 
INSERT INTO `w_areas` VALUES( '360103','360100','西湖区','99' ); 
INSERT INTO `w_areas` VALUES( '360104','360100','青云谱区','99' ); 
INSERT INTO `w_areas` VALUES( '360105','360100','湾里区','99' ); 
INSERT INTO `w_areas` VALUES( '360111','360100','青山湖区','99' ); 
INSERT INTO `w_areas` VALUES( '360121','360100','南昌县','99' ); 
INSERT INTO `w_areas` VALUES( '360122','360100','新建县','99' ); 
INSERT INTO `w_areas` VALUES( '360123','360100','安义县','99' ); 
INSERT INTO `w_areas` VALUES( '360124','360100','进贤县','99' ); 
INSERT INTO `w_areas` VALUES( '360201','360200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360202','360200','昌江区','99' ); 
INSERT INTO `w_areas` VALUES( '360203','360200','珠山区','99' ); 
INSERT INTO `w_areas` VALUES( '360222','360200','浮梁县','99' ); 
INSERT INTO `w_areas` VALUES( '360281','360200','乐平市','99' ); 
INSERT INTO `w_areas` VALUES( '360301','360300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360302','360300','安源区','99' ); 
INSERT INTO `w_areas` VALUES( '360313','360300','湘东区','99' ); 
INSERT INTO `w_areas` VALUES( '360321','360300','莲花县','99' ); 
INSERT INTO `w_areas` VALUES( '360322','360300','上栗县','99' ); 
INSERT INTO `w_areas` VALUES( '360323','360300','芦溪县','99' ); 
INSERT INTO `w_areas` VALUES( '360401','360400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360402','360400','庐山区','99' ); 
INSERT INTO `w_areas` VALUES( '360403','360400','浔阳区','99' ); 
INSERT INTO `w_areas` VALUES( '360421','360400','九江县','99' ); 
INSERT INTO `w_areas` VALUES( '360423','360400','武宁县','99' ); 
INSERT INTO `w_areas` VALUES( '360424','360400','修水县','99' ); 
INSERT INTO `w_areas` VALUES( '360425','360400','永修县','99' ); 
INSERT INTO `w_areas` VALUES( '360426','360400','德安县','99' ); 
INSERT INTO `w_areas` VALUES( '360427','360400','星子县','99' ); 
INSERT INTO `w_areas` VALUES( '360428','360400','都昌县','99' ); 
INSERT INTO `w_areas` VALUES( '360429','360400','湖口县','99' ); 
INSERT INTO `w_areas` VALUES( '360430','360400','彭泽县','99' ); 
INSERT INTO `w_areas` VALUES( '360481','360400','瑞昌市','99' ); 
INSERT INTO `w_areas` VALUES( '360482','360400','共青城市','99' ); 
INSERT INTO `w_areas` VALUES( '360501','360500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360502','360500','渝水区','99' ); 
INSERT INTO `w_areas` VALUES( '360521','360500','分宜县','99' ); 
INSERT INTO `w_areas` VALUES( '360601','360600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360602','360600','月湖区','99' ); 
INSERT INTO `w_areas` VALUES( '360622','360600','余江县','99' ); 
INSERT INTO `w_areas` VALUES( '360681','360600','贵溪市','99' ); 
INSERT INTO `w_areas` VALUES( '360701','360700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360702','360700','章贡区','99' ); 
INSERT INTO `w_areas` VALUES( '360721','360700','赣县','99' ); 
INSERT INTO `w_areas` VALUES( '360722','360700','信丰县','99' ); 
INSERT INTO `w_areas` VALUES( '360723','360700','大余县','99' ); 
INSERT INTO `w_areas` VALUES( '360724','360700','上犹县','99' ); 
INSERT INTO `w_areas` VALUES( '360725','360700','崇义县','99' ); 
INSERT INTO `w_areas` VALUES( '360726','360700','安远县','99' ); 
INSERT INTO `w_areas` VALUES( '360727','360700','龙南县','99' ); 
INSERT INTO `w_areas` VALUES( '360728','360700','定南县','99' ); 
INSERT INTO `w_areas` VALUES( '360729','360700','全南县','99' ); 
INSERT INTO `w_areas` VALUES( '360730','360700','宁都县','99' ); 
INSERT INTO `w_areas` VALUES( '360731','360700','于都县','99' ); 
INSERT INTO `w_areas` VALUES( '360732','360700','兴国县','99' ); 
INSERT INTO `w_areas` VALUES( '360733','360700','会昌县','99' ); 
INSERT INTO `w_areas` VALUES( '360734','360700','寻乌县','99' ); 
INSERT INTO `w_areas` VALUES( '360735','360700','石城县','99' ); 
INSERT INTO `w_areas` VALUES( '360781','360700','瑞金市','99' ); 
INSERT INTO `w_areas` VALUES( '360782','360700','南康市','99' ); 
INSERT INTO `w_areas` VALUES( '360801','360800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360802','360800','吉州区','99' ); 
INSERT INTO `w_areas` VALUES( '360803','360800','青原区','99' ); 
INSERT INTO `w_areas` VALUES( '360821','360800','吉安县','99' ); 
INSERT INTO `w_areas` VALUES( '360822','360800','吉水县','99' ); 
INSERT INTO `w_areas` VALUES( '360823','360800','峡江县','99' ); 
INSERT INTO `w_areas` VALUES( '360824','360800','新干县','99' ); 
INSERT INTO `w_areas` VALUES( '360825','360800','永丰县','99' ); 
INSERT INTO `w_areas` VALUES( '360826','360800','泰和县','99' ); 
INSERT INTO `w_areas` VALUES( '360827','360800','遂川县','99' ); 
INSERT INTO `w_areas` VALUES( '360828','360800','万安县','99' ); 
INSERT INTO `w_areas` VALUES( '360829','360800','安福县','99' ); 
INSERT INTO `w_areas` VALUES( '360830','360800','永新县','99' ); 
INSERT INTO `w_areas` VALUES( '360881','360800','井冈山市','99' ); 
INSERT INTO `w_areas` VALUES( '360901','360900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '360902','360900','袁州区','99' ); 
INSERT INTO `w_areas` VALUES( '360921','360900','奉新县','99' ); 
INSERT INTO `w_areas` VALUES( '360922','360900','万载县','99' ); 
INSERT INTO `w_areas` VALUES( '360923','360900','上高县','99' ); 
INSERT INTO `w_areas` VALUES( '360924','360900','宜丰县','99' ); 
INSERT INTO `w_areas` VALUES( '360925','360900','靖安县','99' ); 
INSERT INTO `w_areas` VALUES( '360926','360900','铜鼓县','99' ); 
INSERT INTO `w_areas` VALUES( '360981','360900','丰城市','99' ); 
INSERT INTO `w_areas` VALUES( '360982','360900','樟树市','99' ); 
INSERT INTO `w_areas` VALUES( '360983','360900','高安市','99' ); 
INSERT INTO `w_areas` VALUES( '361001','361000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '361002','361000','临川区','99' ); 
INSERT INTO `w_areas` VALUES( '361021','361000','南城县','99' ); 
INSERT INTO `w_areas` VALUES( '361022','361000','黎川县','99' ); 
INSERT INTO `w_areas` VALUES( '361023','361000','南丰县','99' ); 
INSERT INTO `w_areas` VALUES( '361024','361000','崇仁县','99' ); 
INSERT INTO `w_areas` VALUES( '361025','361000','乐安县','99' ); 
INSERT INTO `w_areas` VALUES( '361026','361000','宜黄县','99' ); 
INSERT INTO `w_areas` VALUES( '361027','361000','金溪县','99' ); 
INSERT INTO `w_areas` VALUES( '361028','361000','资溪县','99' ); 
INSERT INTO `w_areas` VALUES( '361029','361000','东乡县','99' ); 
INSERT INTO `w_areas` VALUES( '361030','361000','广昌县','99' ); 
INSERT INTO `w_areas` VALUES( '361101','361100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '361102','361100','信州区','99' ); 
INSERT INTO `w_areas` VALUES( '361121','361100','上饶县','99' ); 
INSERT INTO `w_areas` VALUES( '361122','361100','广丰县','99' ); 
INSERT INTO `w_areas` VALUES( '361123','361100','玉山县','99' ); 
INSERT INTO `w_areas` VALUES( '361124','361100','铅山县','99' ); 
INSERT INTO `w_areas` VALUES( '361125','361100','横峰县','99' ); 
INSERT INTO `w_areas` VALUES( '361126','361100','弋阳县','99' ); 
INSERT INTO `w_areas` VALUES( '361127','361100','余干县','99' ); 
INSERT INTO `w_areas` VALUES( '361128','361100','鄱阳县','99' ); 
INSERT INTO `w_areas` VALUES( '361129','361100','万年县','99' ); 
INSERT INTO `w_areas` VALUES( '361130','361100','婺源县','99' ); 
INSERT INTO `w_areas` VALUES( '361181','361100','德兴市','99' ); 
INSERT INTO `w_areas` VALUES( '370101','370100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370102','370100','历下区','99' ); 
INSERT INTO `w_areas` VALUES( '370103','370100','市中区','99' ); 
INSERT INTO `w_areas` VALUES( '370104','370100','槐荫区','99' ); 
INSERT INTO `w_areas` VALUES( '370105','370100','天桥区','99' ); 
INSERT INTO `w_areas` VALUES( '370112','370100','历城区','99' ); 
INSERT INTO `w_areas` VALUES( '370113','370100','长清区','99' ); 
INSERT INTO `w_areas` VALUES( '370124','370100','平阴县','99' ); 
INSERT INTO `w_areas` VALUES( '370125','370100','济阳县','99' ); 
INSERT INTO `w_areas` VALUES( '370126','370100','商河县','99' ); 
INSERT INTO `w_areas` VALUES( '370181','370100','章丘市','99' ); 
INSERT INTO `w_areas` VALUES( '370201','370200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370202','370200','市南区','99' ); 
INSERT INTO `w_areas` VALUES( '370203','370200','市北区','99' ); 
INSERT INTO `w_areas` VALUES( '370205','370200','四方区','99' ); 
INSERT INTO `w_areas` VALUES( '370211','370200','黄岛区','99' ); 
INSERT INTO `w_areas` VALUES( '370212','370200','崂山区','99' ); 
INSERT INTO `w_areas` VALUES( '370213','370200','李沧区','99' ); 
INSERT INTO `w_areas` VALUES( '370214','370200','城阳区','99' ); 
INSERT INTO `w_areas` VALUES( '370281','370200','胶州市','99' ); 
INSERT INTO `w_areas` VALUES( '370282','370200','即墨市','99' ); 
INSERT INTO `w_areas` VALUES( '370283','370200','平度市','99' ); 
INSERT INTO `w_areas` VALUES( '370284','370200','胶南市','99' ); 
INSERT INTO `w_areas` VALUES( '370285','370200','莱西市','99' ); 
INSERT INTO `w_areas` VALUES( '370301','370300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370302','370300','淄川区','99' ); 
INSERT INTO `w_areas` VALUES( '370303','370300','张店区','99' ); 
INSERT INTO `w_areas` VALUES( '370304','370300','博山区','99' ); 
INSERT INTO `w_areas` VALUES( '370305','370300','临淄区','99' ); 
INSERT INTO `w_areas` VALUES( '370306','370300','周村区','99' ); 
INSERT INTO `w_areas` VALUES( '370321','370300','桓台县','99' ); 
INSERT INTO `w_areas` VALUES( '370322','370300','高青县','99' ); 
INSERT INTO `w_areas` VALUES( '370323','370300','沂源县','99' ); 
INSERT INTO `w_areas` VALUES( '370401','370400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370402','370400','市中区','99' ); 
INSERT INTO `w_areas` VALUES( '370403','370400','薛城区','99' ); 
INSERT INTO `w_areas` VALUES( '370404','370400','峄城区','99' ); 
INSERT INTO `w_areas` VALUES( '370405','370400','台儿庄区','99' ); 
INSERT INTO `w_areas` VALUES( '370406','370400','山亭区','99' ); 
INSERT INTO `w_areas` VALUES( '370481','370400','滕州市','99' ); 
INSERT INTO `w_areas` VALUES( '370501','370500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370502','370500','东营区','99' ); 
INSERT INTO `w_areas` VALUES( '370503','370500','河口区','99' ); 
INSERT INTO `w_areas` VALUES( '370521','370500','垦利县','99' ); 
INSERT INTO `w_areas` VALUES( '370522','370500','利津县','99' ); 
INSERT INTO `w_areas` VALUES( '370523','370500','广饶县','99' ); 
INSERT INTO `w_areas` VALUES( '370601','370600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370602','370600','芝罘区','99' ); 
INSERT INTO `w_areas` VALUES( '370611','370600','福山区','99' ); 
INSERT INTO `w_areas` VALUES( '370612','370600','牟平区','99' ); 
INSERT INTO `w_areas` VALUES( '370613','370600','莱山区','99' ); 
INSERT INTO `w_areas` VALUES( '370634','370600','长岛县','99' ); 
INSERT INTO `w_areas` VALUES( '370681','370600','龙口市','99' ); 
INSERT INTO `w_areas` VALUES( '370682','370600','莱阳市','99' ); 
INSERT INTO `w_areas` VALUES( '370683','370600','莱州市','99' ); 
INSERT INTO `w_areas` VALUES( '370684','370600','蓬莱市','99' ); 
INSERT INTO `w_areas` VALUES( '370685','370600','招远市','99' ); 
INSERT INTO `w_areas` VALUES( '370686','370600','栖霞市','99' ); 
INSERT INTO `w_areas` VALUES( '370687','370600','海阳市','99' ); 
INSERT INTO `w_areas` VALUES( '370701','370700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370702','370700','潍城区','99' ); 
INSERT INTO `w_areas` VALUES( '370703','370700','寒亭区','99' ); 
INSERT INTO `w_areas` VALUES( '370704','370700','坊子区','99' ); 
INSERT INTO `w_areas` VALUES( '370705','370700','奎文区','99' ); 
INSERT INTO `w_areas` VALUES( '370724','370700','临朐县','99' ); 
INSERT INTO `w_areas` VALUES( '370725','370700','昌乐县','99' ); 
INSERT INTO `w_areas` VALUES( '370781','370700','青州市','99' ); 
INSERT INTO `w_areas` VALUES( '370782','370700','诸城市','99' ); 
INSERT INTO `w_areas` VALUES( '370783','370700','寿光市','99' ); 
INSERT INTO `w_areas` VALUES( '370784','370700','安丘市','99' ); 
INSERT INTO `w_areas` VALUES( '370785','370700','高密市','99' ); 
INSERT INTO `w_areas` VALUES( '370786','370700','昌邑市','99' ); 
INSERT INTO `w_areas` VALUES( '370801','370800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370802','370800','市中区','99' ); 
INSERT INTO `w_areas` VALUES( '370811','370800','任城区','99' ); 
INSERT INTO `w_areas` VALUES( '370826','370800','微山县','99' ); 
INSERT INTO `w_areas` VALUES( '370827','370800','鱼台县','99' ); 
INSERT INTO `w_areas` VALUES( '370828','370800','金乡县','99' ); 
INSERT INTO `w_areas` VALUES( '370829','370800','嘉祥县','99' ); 
INSERT INTO `w_areas` VALUES( '370830','370800','汶上县','99' ); 
INSERT INTO `w_areas` VALUES( '370831','370800','泗水县','99' ); 
INSERT INTO `w_areas` VALUES( '370832','370800','梁山县','99' ); 
INSERT INTO `w_areas` VALUES( '370881','370800','曲阜市','99' ); 
INSERT INTO `w_areas` VALUES( '370882','370800','兖州市','99' ); 
INSERT INTO `w_areas` VALUES( '370883','370800','邹城市','99' ); 
INSERT INTO `w_areas` VALUES( '370901','370900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '370902','370900','泰山区','99' ); 
INSERT INTO `w_areas` VALUES( '370911','370900','岱岳区','99' ); 
INSERT INTO `w_areas` VALUES( '370921','370900','宁阳县','99' ); 
INSERT INTO `w_areas` VALUES( '370923','370900','东平县','99' ); 
INSERT INTO `w_areas` VALUES( '370982','370900','新泰市','99' ); 
INSERT INTO `w_areas` VALUES( '370983','370900','肥城市','99' ); 
INSERT INTO `w_areas` VALUES( '371001','371000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371002','371000','环翠区','99' ); 
INSERT INTO `w_areas` VALUES( '371081','371000','文登市','99' ); 
INSERT INTO `w_areas` VALUES( '371082','371000','荣成市','99' ); 
INSERT INTO `w_areas` VALUES( '371083','371000','乳山市','99' ); 
INSERT INTO `w_areas` VALUES( '371101','371100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371102','371100','东港区','99' ); 
INSERT INTO `w_areas` VALUES( '371103','371100','岚山区','99' ); 
INSERT INTO `w_areas` VALUES( '371121','371100','五莲县','99' ); 
INSERT INTO `w_areas` VALUES( '371122','371100','莒县','99' ); 
INSERT INTO `w_areas` VALUES( '371201','371200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371202','371200','莱城区','99' ); 
INSERT INTO `w_areas` VALUES( '371203','371200','钢城区','99' ); 
INSERT INTO `w_areas` VALUES( '371301','371300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371302','371300','兰山区','99' ); 
INSERT INTO `w_areas` VALUES( '371311','371300','罗庄区','99' ); 
INSERT INTO `w_areas` VALUES( '371312','371300','河东区','99' ); 
INSERT INTO `w_areas` VALUES( '371321','371300','沂南县','99' ); 
INSERT INTO `w_areas` VALUES( '371322','371300','郯城县','99' ); 
INSERT INTO `w_areas` VALUES( '371323','371300','沂水县','99' ); 
INSERT INTO `w_areas` VALUES( '371324','371300','苍山县','99' ); 
INSERT INTO `w_areas` VALUES( '371325','371300','费县','99' ); 
INSERT INTO `w_areas` VALUES( '371326','371300','平邑县','99' ); 
INSERT INTO `w_areas` VALUES( '371327','371300','莒南县','99' ); 
INSERT INTO `w_areas` VALUES( '371328','371300','蒙阴县','99' ); 
INSERT INTO `w_areas` VALUES( '371329','371300','临沭县','99' ); 
INSERT INTO `w_areas` VALUES( '371401','371400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371402','371400','德城区','99' ); 
INSERT INTO `w_areas` VALUES( '371421','371400','陵县','99' ); 
INSERT INTO `w_areas` VALUES( '371422','371400','宁津县','99' ); 
INSERT INTO `w_areas` VALUES( '371423','371400','庆云县','99' ); 
INSERT INTO `w_areas` VALUES( '371424','371400','临邑县','99' ); 
INSERT INTO `w_areas` VALUES( '371425','371400','齐河县','99' ); 
INSERT INTO `w_areas` VALUES( '371426','371400','平原县','99' ); 
INSERT INTO `w_areas` VALUES( '371427','371400','夏津县','99' ); 
INSERT INTO `w_areas` VALUES( '371428','371400','武城县','99' ); 
INSERT INTO `w_areas` VALUES( '371481','371400','乐陵市','99' ); 
INSERT INTO `w_areas` VALUES( '371482','371400','禹城市','99' ); 
INSERT INTO `w_areas` VALUES( '371501','371500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371502','371500','东昌府区','99' ); 
INSERT INTO `w_areas` VALUES( '371521','371500','阳谷县','99' ); 
INSERT INTO `w_areas` VALUES( '371522','371500','莘县','99' ); 
INSERT INTO `w_areas` VALUES( '371523','371500','茌平县','99' ); 
INSERT INTO `w_areas` VALUES( '371524','371500','东阿县','99' ); 
INSERT INTO `w_areas` VALUES( '371525','371500','冠县','99' ); 
INSERT INTO `w_areas` VALUES( '371526','371500','高唐县','99' ); 
INSERT INTO `w_areas` VALUES( '371581','371500','临清市','99' ); 
INSERT INTO `w_areas` VALUES( '371601','371600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371602','371600','滨城区','99' ); 
INSERT INTO `w_areas` VALUES( '371621','371600','惠民县','99' ); 
INSERT INTO `w_areas` VALUES( '371622','371600','阳信县','99' ); 
INSERT INTO `w_areas` VALUES( '371623','371600','无棣县','99' ); 
INSERT INTO `w_areas` VALUES( '371624','371600','沾化县','99' ); 
INSERT INTO `w_areas` VALUES( '371625','371600','博兴县','99' ); 
INSERT INTO `w_areas` VALUES( '371626','371600','邹平县','99' ); 
INSERT INTO `w_areas` VALUES( '371701','371700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '371702','371700','牡丹区','99' ); 
INSERT INTO `w_areas` VALUES( '371721','371700','曹县','99' ); 
INSERT INTO `w_areas` VALUES( '371722','371700','单县','99' ); 
INSERT INTO `w_areas` VALUES( '371723','371700','成武县','99' ); 
INSERT INTO `w_areas` VALUES( '371724','371700','巨野县','99' ); 
INSERT INTO `w_areas` VALUES( '371725','371700','郓城县','99' ); 
INSERT INTO `w_areas` VALUES( '371726','371700','鄄城县','99' ); 
INSERT INTO `w_areas` VALUES( '371727','371700','定陶县','99' ); 
INSERT INTO `w_areas` VALUES( '371728','371700','东明县','99' ); 
INSERT INTO `w_areas` VALUES( '410101','410100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410102','410100','中原区','99' ); 
INSERT INTO `w_areas` VALUES( '410103','410100','二七区','99' ); 
INSERT INTO `w_areas` VALUES( '410104','410100','管城回族区','99' ); 
INSERT INTO `w_areas` VALUES( '410105','410100','金水区','99' ); 
INSERT INTO `w_areas` VALUES( '410106','410100','上街区','99' ); 
INSERT INTO `w_areas` VALUES( '410108','410100','惠济区','99' ); 
INSERT INTO `w_areas` VALUES( '410122','410100','中牟县','99' ); 
INSERT INTO `w_areas` VALUES( '410181','410100','巩义市','99' ); 
INSERT INTO `w_areas` VALUES( '410182','410100','荥阳市','99' ); 
INSERT INTO `w_areas` VALUES( '410183','410100','新密市','99' ); 
INSERT INTO `w_areas` VALUES( '410184','410100','新郑市','99' ); 
INSERT INTO `w_areas` VALUES( '410185','410100','登封市','99' ); 
INSERT INTO `w_areas` VALUES( '410201','410200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410202','410200','龙亭区','99' ); 
INSERT INTO `w_areas` VALUES( '410203','410200','顺河回族区','99' ); 
INSERT INTO `w_areas` VALUES( '410204','410200','鼓楼区','99' ); 
INSERT INTO `w_areas` VALUES( '410205','410200','禹王台区','99' ); 
INSERT INTO `w_areas` VALUES( '410211','410200','金明区','99' ); 
INSERT INTO `w_areas` VALUES( '410221','410200','杞县','99' ); 
INSERT INTO `w_areas` VALUES( '410222','410200','通许县','99' ); 
INSERT INTO `w_areas` VALUES( '410223','410200','尉氏县','99' ); 
INSERT INTO `w_areas` VALUES( '410224','410200','开封县','99' ); 
INSERT INTO `w_areas` VALUES( '410225','410200','兰考县','99' ); 
INSERT INTO `w_areas` VALUES( '410301','410300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410302','410300','老城区','99' ); 
INSERT INTO `w_areas` VALUES( '410303','410300','西工区','99' ); 
INSERT INTO `w_areas` VALUES( '410304','410300','瀍河回族区','99' ); 
INSERT INTO `w_areas` VALUES( '410305','410300','涧西区','99' ); 
INSERT INTO `w_areas` VALUES( '410306','410300','吉利区','99' ); 
INSERT INTO `w_areas` VALUES( '410311','410300','洛龙区','99' ); 
INSERT INTO `w_areas` VALUES( '410322','410300','孟津县','99' ); 
INSERT INTO `w_areas` VALUES( '410323','410300','新安县','99' ); 
INSERT INTO `w_areas` VALUES( '410324','410300','栾川县','99' ); 
INSERT INTO `w_areas` VALUES( '410325','410300','嵩县','99' ); 
INSERT INTO `w_areas` VALUES( '410326','410300','汝阳县','99' ); 
INSERT INTO `w_areas` VALUES( '410327','410300','宜阳县','99' ); 
INSERT INTO `w_areas` VALUES( '410328','410300','洛宁县','99' ); 
INSERT INTO `w_areas` VALUES( '410329','410300','伊川县','99' ); 
INSERT INTO `w_areas` VALUES( '410381','410300','偃师市','99' ); 
INSERT INTO `w_areas` VALUES( '410401','410400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410402','410400','新华区','99' ); 
INSERT INTO `w_areas` VALUES( '410403','410400','卫东区','99' ); 
INSERT INTO `w_areas` VALUES( '410404','410400','石龙区','99' ); 
INSERT INTO `w_areas` VALUES( '410411','410400','湛河区','99' ); 
INSERT INTO `w_areas` VALUES( '410421','410400','宝丰县','99' ); 
INSERT INTO `w_areas` VALUES( '410422','410400','叶县','99' ); 
INSERT INTO `w_areas` VALUES( '410423','410400','鲁山县','99' ); 
INSERT INTO `w_areas` VALUES( '410425','410400','郏县','99' ); 
INSERT INTO `w_areas` VALUES( '410481','410400','舞钢市','99' ); 
INSERT INTO `w_areas` VALUES( '410482','410400','汝州市','99' ); 
INSERT INTO `w_areas` VALUES( '410501','410500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410502','410500','文峰区','99' ); 
INSERT INTO `w_areas` VALUES( '410503','410500','北关区','99' ); 
INSERT INTO `w_areas` VALUES( '410505','410500','殷都区','99' ); 
INSERT INTO `w_areas` VALUES( '410506','410500','龙安区','99' ); 
INSERT INTO `w_areas` VALUES( '410522','410500','安阳县','99' ); 
INSERT INTO `w_areas` VALUES( '410523','410500','汤阴县','99' ); 
INSERT INTO `w_areas` VALUES( '410526','410500','滑县','99' ); 
INSERT INTO `w_areas` VALUES( '410527','410500','内黄县','99' ); 
INSERT INTO `w_areas` VALUES( '410581','410500','林州市','99' ); 
INSERT INTO `w_areas` VALUES( '410601','410600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410602','410600','鹤山区','99' ); 
INSERT INTO `w_areas` VALUES( '410603','410600','山城区','99' ); 
INSERT INTO `w_areas` VALUES( '410611','410600','淇滨区','99' ); 
INSERT INTO `w_areas` VALUES( '410621','410600','浚县','99' ); 
INSERT INTO `w_areas` VALUES( '410622','410600','淇县','99' ); 
INSERT INTO `w_areas` VALUES( '410701','410700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410702','410700','红旗区','99' ); 
INSERT INTO `w_areas` VALUES( '410703','410700','卫滨区','99' ); 
INSERT INTO `w_areas` VALUES( '410704','410700','凤泉区','99' ); 
INSERT INTO `w_areas` VALUES( '410711','410700','牧野区','99' ); 
INSERT INTO `w_areas` VALUES( '410721','410700','新乡县','99' ); 
INSERT INTO `w_areas` VALUES( '410724','410700','获嘉县','99' ); 
INSERT INTO `w_areas` VALUES( '410725','410700','原阳县','99' ); 
INSERT INTO `w_areas` VALUES( '410726','410700','延津县','99' ); 
INSERT INTO `w_areas` VALUES( '410727','410700','封丘县','99' ); 
INSERT INTO `w_areas` VALUES( '410728','410700','长垣县','99' ); 
INSERT INTO `w_areas` VALUES( '410781','410700','卫辉市','99' ); 
INSERT INTO `w_areas` VALUES( '410782','410700','辉县市','99' ); 
INSERT INTO `w_areas` VALUES( '410801','410800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410802','410800','解放区','99' ); 
INSERT INTO `w_areas` VALUES( '410803','410800','中站区','99' ); 
INSERT INTO `w_areas` VALUES( '410804','410800','马村区','99' ); 
INSERT INTO `w_areas` VALUES( '410811','410800','山阳区','99' ); 
INSERT INTO `w_areas` VALUES( '410821','410800','修武县','99' ); 
INSERT INTO `w_areas` VALUES( '410822','410800','博爱县','99' ); 
INSERT INTO `w_areas` VALUES( '410823','410800','武陟县','99' ); 
INSERT INTO `w_areas` VALUES( '410825','410800','温县','99' ); 
INSERT INTO `w_areas` VALUES( '410882','410800','沁阳市','99' ); 
INSERT INTO `w_areas` VALUES( '410883','410800','孟州市','99' ); 
INSERT INTO `w_areas` VALUES( '410901','410900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '410902','410900','华龙区','99' ); 
INSERT INTO `w_areas` VALUES( '410922','410900','清丰县','99' ); 
INSERT INTO `w_areas` VALUES( '410923','410900','南乐县','99' ); 
INSERT INTO `w_areas` VALUES( '410926','410900','范县','99' ); 
INSERT INTO `w_areas` VALUES( '410927','410900','台前县','99' ); 
INSERT INTO `w_areas` VALUES( '410928','410900','濮阳县','99' ); 
INSERT INTO `w_areas` VALUES( '411001','411000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411002','411000','魏都区','99' ); 
INSERT INTO `w_areas` VALUES( '411023','411000','许昌县','99' ); 
INSERT INTO `w_areas` VALUES( '411024','411000','鄢陵县','99' ); 
INSERT INTO `w_areas` VALUES( '411025','411000','襄城县','99' ); 
INSERT INTO `w_areas` VALUES( '411081','411000','禹州市','99' ); 
INSERT INTO `w_areas` VALUES( '411082','411000','长葛市','99' ); 
INSERT INTO `w_areas` VALUES( '411101','411100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411102','411100','源汇区','99' ); 
INSERT INTO `w_areas` VALUES( '411103','411100','郾城区','99' ); 
INSERT INTO `w_areas` VALUES( '411104','411100','召陵区','99' ); 
INSERT INTO `w_areas` VALUES( '411121','411100','舞阳县','99' ); 
INSERT INTO `w_areas` VALUES( '411122','411100','临颍县','99' ); 
INSERT INTO `w_areas` VALUES( '411201','411200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411202','411200','湖滨区','99' ); 
INSERT INTO `w_areas` VALUES( '411221','411200','渑池县','99' ); 
INSERT INTO `w_areas` VALUES( '411222','411200','陕县','99' ); 
INSERT INTO `w_areas` VALUES( '411224','411200','卢氏县','99' ); 
INSERT INTO `w_areas` VALUES( '411281','411200','义马市','99' ); 
INSERT INTO `w_areas` VALUES( '411282','411200','灵宝市','99' ); 
INSERT INTO `w_areas` VALUES( '411301','411300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411302','411300','宛城区','99' ); 
INSERT INTO `w_areas` VALUES( '411303','411300','卧龙区','99' ); 
INSERT INTO `w_areas` VALUES( '411321','411300','南召县','99' ); 
INSERT INTO `w_areas` VALUES( '411322','411300','方城县','99' ); 
INSERT INTO `w_areas` VALUES( '411323','411300','西峡县','99' ); 
INSERT INTO `w_areas` VALUES( '411324','411300','镇平县','99' ); 
INSERT INTO `w_areas` VALUES( '411325','411300','内乡县','99' ); 
INSERT INTO `w_areas` VALUES( '411326','411300','淅川县','99' ); 
INSERT INTO `w_areas` VALUES( '411327','411300','社旗县','99' ); 
INSERT INTO `w_areas` VALUES( '411328','411300','唐河县','99' ); 
INSERT INTO `w_areas` VALUES( '411329','411300','新野县','99' ); 
INSERT INTO `w_areas` VALUES( '411330','411300','桐柏县','99' ); 
INSERT INTO `w_areas` VALUES( '411381','411300','邓州市','99' ); 
INSERT INTO `w_areas` VALUES( '411401','411400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411402','411400','梁园区','99' ); 
INSERT INTO `w_areas` VALUES( '411403','411400','睢阳区','99' ); 
INSERT INTO `w_areas` VALUES( '411421','411400','民权县','99' ); 
INSERT INTO `w_areas` VALUES( '411422','411400','睢县','99' ); 
INSERT INTO `w_areas` VALUES( '411423','411400','宁陵县','99' ); 
INSERT INTO `w_areas` VALUES( '411424','411400','柘城县','99' ); 
INSERT INTO `w_areas` VALUES( '411425','411400','虞城县','99' ); 
INSERT INTO `w_areas` VALUES( '411426','411400','夏邑县','99' ); 
INSERT INTO `w_areas` VALUES( '411481','411400','永城市','99' ); 
INSERT INTO `w_areas` VALUES( '411501','411500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411502','411500','浉河区','99' ); 
INSERT INTO `w_areas` VALUES( '411503','411500','平桥区','99' ); 
INSERT INTO `w_areas` VALUES( '411521','411500','罗山县','99' ); 
INSERT INTO `w_areas` VALUES( '411522','411500','光山县','99' ); 
INSERT INTO `w_areas` VALUES( '411523','411500','新县','99' ); 
INSERT INTO `w_areas` VALUES( '411524','411500','商城县','99' ); 
INSERT INTO `w_areas` VALUES( '411525','411500','固始县','99' ); 
INSERT INTO `w_areas` VALUES( '411526','411500','潢川县','99' ); 
INSERT INTO `w_areas` VALUES( '411527','411500','淮滨县','99' ); 
INSERT INTO `w_areas` VALUES( '411528','411500','息县','99' ); 
INSERT INTO `w_areas` VALUES( '411601','411600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411602','411600','川汇区','99' ); 
INSERT INTO `w_areas` VALUES( '411621','411600','扶沟县','99' ); 
INSERT INTO `w_areas` VALUES( '411622','411600','西华县','99' ); 
INSERT INTO `w_areas` VALUES( '411623','411600','商水县','99' ); 
INSERT INTO `w_areas` VALUES( '411624','411600','沈丘县','99' ); 
INSERT INTO `w_areas` VALUES( '411625','411600','郸城县','99' ); 
INSERT INTO `w_areas` VALUES( '411626','411600','淮阳县','99' ); 
INSERT INTO `w_areas` VALUES( '411627','411600','太康县','99' ); 
INSERT INTO `w_areas` VALUES( '411628','411600','鹿邑县','99' ); 
INSERT INTO `w_areas` VALUES( '411681','411600','项城市','99' ); 
INSERT INTO `w_areas` VALUES( '411701','411700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '411702','411700','驿城区','99' ); 
INSERT INTO `w_areas` VALUES( '411721','411700','西平县','99' ); 
INSERT INTO `w_areas` VALUES( '411722','411700','上蔡县','99' ); 
INSERT INTO `w_areas` VALUES( '411723','411700','平舆县','99' ); 
INSERT INTO `w_areas` VALUES( '411724','411700','正阳县','99' ); 
INSERT INTO `w_areas` VALUES( '411725','411700','确山县','99' ); 
INSERT INTO `w_areas` VALUES( '411726','411700','泌阳县','99' ); 
INSERT INTO `w_areas` VALUES( '411727','411700','汝南县','99' ); 
INSERT INTO `w_areas` VALUES( '411728','411700','遂平县','99' ); 
INSERT INTO `w_areas` VALUES( '411729','411700','新蔡县','99' ); 
INSERT INTO `w_areas` VALUES( '419001','419000','济源市','99' ); 
INSERT INTO `w_areas` VALUES( '420101','420100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420102','420100','江岸区','99' ); 
INSERT INTO `w_areas` VALUES( '420103','420100','江汉区','99' ); 
INSERT INTO `w_areas` VALUES( '420104','420100','硚口区','99' ); 
INSERT INTO `w_areas` VALUES( '420105','420100','汉阳区','99' ); 
INSERT INTO `w_areas` VALUES( '420106','420100','武昌区','99' ); 
INSERT INTO `w_areas` VALUES( '420107','420100','青山区','99' ); 
INSERT INTO `w_areas` VALUES( '420111','420100','洪山区','99' ); 
INSERT INTO `w_areas` VALUES( '420112','420100','东西湖区','99' ); 
INSERT INTO `w_areas` VALUES( '420113','420100','汉南区','99' ); 
INSERT INTO `w_areas` VALUES( '420114','420100','蔡甸区','99' ); 
INSERT INTO `w_areas` VALUES( '420115','420100','江夏区','99' ); 
INSERT INTO `w_areas` VALUES( '420116','420100','黄陂区','99' ); 
INSERT INTO `w_areas` VALUES( '420117','420100','新洲区','99' ); 
INSERT INTO `w_areas` VALUES( '420201','420200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420202','420200','黄石港区','99' ); 
INSERT INTO `w_areas` VALUES( '420203','420200','西塞山区','99' ); 
INSERT INTO `w_areas` VALUES( '420204','420200','下陆区','99' ); 
INSERT INTO `w_areas` VALUES( '420205','420200','铁山区','99' ); 
INSERT INTO `w_areas` VALUES( '420222','420200','阳新县','99' ); 
INSERT INTO `w_areas` VALUES( '420281','420200','大冶市','99' ); 
INSERT INTO `w_areas` VALUES( '420301','420300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420302','420300','茅箭区','99' ); 
INSERT INTO `w_areas` VALUES( '420303','420300','张湾区','99' ); 
INSERT INTO `w_areas` VALUES( '420321','420300','郧县','99' ); 
INSERT INTO `w_areas` VALUES( '420322','420300','郧西县','99' ); 
INSERT INTO `w_areas` VALUES( '420323','420300','竹山县','99' ); 
INSERT INTO `w_areas` VALUES( '420324','420300','竹溪县','99' ); 
INSERT INTO `w_areas` VALUES( '420325','420300','房县','99' ); 
INSERT INTO `w_areas` VALUES( '420381','420300','丹江口市','99' ); 
INSERT INTO `w_areas` VALUES( '420501','420500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420502','420500','西陵区','99' ); 
INSERT INTO `w_areas` VALUES( '420503','420500','伍家岗区','99' ); 
INSERT INTO `w_areas` VALUES( '420504','420500','点军区','99' ); 
INSERT INTO `w_areas` VALUES( '420505','420500','猇亭区','99' ); 
INSERT INTO `w_areas` VALUES( '420506','420500','夷陵区','99' ); 
INSERT INTO `w_areas` VALUES( '420525','420500','远安县','99' ); 
INSERT INTO `w_areas` VALUES( '420526','420500','兴山县','99' ); 
INSERT INTO `w_areas` VALUES( '420527','420500','秭归县','99' ); 
INSERT INTO `w_areas` VALUES( '420528','420500','长阳土家族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '420529','420500','五峰土家族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '420581','420500','宜都市','99' ); 
INSERT INTO `w_areas` VALUES( '420582','420500','当阳市','99' ); 
INSERT INTO `w_areas` VALUES( '420583','420500','枝江市','99' ); 
INSERT INTO `w_areas` VALUES( '420601','420600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420602','420600','襄城区','99' ); 
INSERT INTO `w_areas` VALUES( '420606','420600','樊城区','99' ); 
INSERT INTO `w_areas` VALUES( '420607','420600','襄州区','99' ); 
INSERT INTO `w_areas` VALUES( '420624','420600','南漳县','99' ); 
INSERT INTO `w_areas` VALUES( '420625','420600','谷城县','99' ); 
INSERT INTO `w_areas` VALUES( '420626','420600','保康县','99' ); 
INSERT INTO `w_areas` VALUES( '420682','420600','老河口市','99' ); 
INSERT INTO `w_areas` VALUES( '420683','420600','枣阳市','99' ); 
INSERT INTO `w_areas` VALUES( '420684','420600','宜城市','99' ); 
INSERT INTO `w_areas` VALUES( '420701','420700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420702','420700','梁子湖区','99' ); 
INSERT INTO `w_areas` VALUES( '420703','420700','华容区','99' ); 
INSERT INTO `w_areas` VALUES( '420704','420700','鄂城区','99' ); 
INSERT INTO `w_areas` VALUES( '420801','420800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420802','420800','东宝区','99' ); 
INSERT INTO `w_areas` VALUES( '420804','420800','掇刀区','99' ); 
INSERT INTO `w_areas` VALUES( '420821','420800','京山县','99' ); 
INSERT INTO `w_areas` VALUES( '420822','420800','沙洋县','99' ); 
INSERT INTO `w_areas` VALUES( '420881','420800','钟祥市','99' ); 
INSERT INTO `w_areas` VALUES( '420901','420900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '420902','420900','孝南区','99' ); 
INSERT INTO `w_areas` VALUES( '420921','420900','孝昌县','99' ); 
INSERT INTO `w_areas` VALUES( '420922','420900','大悟县','99' ); 
INSERT INTO `w_areas` VALUES( '420923','420900','云梦县','99' ); 
INSERT INTO `w_areas` VALUES( '420981','420900','应城市','99' ); 
INSERT INTO `w_areas` VALUES( '420982','420900','安陆市','99' ); 
INSERT INTO `w_areas` VALUES( '420984','420900','汉川市','99' ); 
INSERT INTO `w_areas` VALUES( '421001','421000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '421002','421000','沙市区','99' ); 
INSERT INTO `w_areas` VALUES( '421003','421000','荆州区','99' ); 
INSERT INTO `w_areas` VALUES( '421022','421000','公安县','99' ); 
INSERT INTO `w_areas` VALUES( '421023','421000','监利县','99' ); 
INSERT INTO `w_areas` VALUES( '421024','421000','江陵县','99' ); 
INSERT INTO `w_areas` VALUES( '421081','421000','石首市','99' ); 
INSERT INTO `w_areas` VALUES( '421083','421000','洪湖市','99' ); 
INSERT INTO `w_areas` VALUES( '421087','421000','松滋市','99' ); 
INSERT INTO `w_areas` VALUES( '421101','421100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '421102','421100','黄州区','99' ); 
INSERT INTO `w_areas` VALUES( '421121','421100','团风县','99' ); 
INSERT INTO `w_areas` VALUES( '421122','421100','红安县','99' ); 
INSERT INTO `w_areas` VALUES( '421123','421100','罗田县','99' ); 
INSERT INTO `w_areas` VALUES( '421124','421100','英山县','99' ); 
INSERT INTO `w_areas` VALUES( '421125','421100','浠水县','99' ); 
INSERT INTO `w_areas` VALUES( '421126','421100','蕲春县','99' ); 
INSERT INTO `w_areas` VALUES( '421127','421100','黄梅县','99' ); 
INSERT INTO `w_areas` VALUES( '421181','421100','麻城市','99' ); 
INSERT INTO `w_areas` VALUES( '421182','421100','武穴市','99' ); 
INSERT INTO `w_areas` VALUES( '421201','421200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '421202','421200','咸安区','99' ); 
INSERT INTO `w_areas` VALUES( '421221','421200','嘉鱼县','99' ); 
INSERT INTO `w_areas` VALUES( '421222','421200','通城县','99' ); 
INSERT INTO `w_areas` VALUES( '421223','421200','崇阳县','99' ); 
INSERT INTO `w_areas` VALUES( '421224','421200','通山县','99' ); 
INSERT INTO `w_areas` VALUES( '421281','421200','赤壁市','99' ); 
INSERT INTO `w_areas` VALUES( '421301','421300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '421303','421300','曾都区','99' ); 
INSERT INTO `w_areas` VALUES( '421321','421300','随县','99' ); 
INSERT INTO `w_areas` VALUES( '421381','421300','广水市','99' ); 
INSERT INTO `w_areas` VALUES( '422801','422800','恩施市','99' ); 
INSERT INTO `w_areas` VALUES( '422802','422800','利川市','99' ); 
INSERT INTO `w_areas` VALUES( '422822','422800','建始县','99' ); 
INSERT INTO `w_areas` VALUES( '422823','422800','巴东县','99' ); 
INSERT INTO `w_areas` VALUES( '422825','422800','宣恩县','99' ); 
INSERT INTO `w_areas` VALUES( '422826','422800','咸丰县','99' ); 
INSERT INTO `w_areas` VALUES( '422827','422800','来凤县','99' ); 
INSERT INTO `w_areas` VALUES( '422828','422800','鹤峰县','99' ); 
INSERT INTO `w_areas` VALUES( '429004','429000','仙桃市','99' ); 
INSERT INTO `w_areas` VALUES( '429005','429000','潜江市','99' ); 
INSERT INTO `w_areas` VALUES( '429006','429000','天门市','99' ); 
INSERT INTO `w_areas` VALUES( '429021','429000','神农架林区','99' ); 
INSERT INTO `w_areas` VALUES( '430101','430100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430102','430100','芙蓉区','99' ); 
INSERT INTO `w_areas` VALUES( '430103','430100','天心区','99' ); 
INSERT INTO `w_areas` VALUES( '430104','430100','岳麓区','99' ); 
INSERT INTO `w_areas` VALUES( '430105','430100','开福区','99' ); 
INSERT INTO `w_areas` VALUES( '430111','430100','雨花区','99' ); 
INSERT INTO `w_areas` VALUES( '430112','430100','望城区','99' ); 
INSERT INTO `w_areas` VALUES( '430121','430100','长沙县','99' ); 
INSERT INTO `w_areas` VALUES( '430124','430100','宁乡县','99' ); 
INSERT INTO `w_areas` VALUES( '430181','430100','浏阳市','99' ); 
INSERT INTO `w_areas` VALUES( '430201','430200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430202','430200','荷塘区','99' ); 
INSERT INTO `w_areas` VALUES( '430203','430200','芦淞区','99' ); 
INSERT INTO `w_areas` VALUES( '430204','430200','石峰区','99' ); 
INSERT INTO `w_areas` VALUES( '430211','430200','天元区','99' ); 
INSERT INTO `w_areas` VALUES( '430221','430200','株洲县','99' ); 
INSERT INTO `w_areas` VALUES( '430223','430200','攸县','99' ); 
INSERT INTO `w_areas` VALUES( '430224','430200','茶陵县','99' ); 
INSERT INTO `w_areas` VALUES( '430225','430200','炎陵县','99' ); 
INSERT INTO `w_areas` VALUES( '430281','430200','醴陵市','99' ); 
INSERT INTO `w_areas` VALUES( '430301','430300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430302','430300','雨湖区','99' ); 
INSERT INTO `w_areas` VALUES( '430304','430300','岳塘区','99' ); 
INSERT INTO `w_areas` VALUES( '430321','430300','湘潭县','99' ); 
INSERT INTO `w_areas` VALUES( '430381','430300','湘乡市','99' ); 
INSERT INTO `w_areas` VALUES( '430382','430300','韶山市','99' ); 
INSERT INTO `w_areas` VALUES( '430401','430400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430405','430400','珠晖区','99' ); 
INSERT INTO `w_areas` VALUES( '430406','430400','雁峰区','99' ); 
INSERT INTO `w_areas` VALUES( '430407','430400','石鼓区','99' ); 
INSERT INTO `w_areas` VALUES( '430408','430400','蒸湘区','99' ); 
INSERT INTO `w_areas` VALUES( '430412','430400','南岳区','99' ); 
INSERT INTO `w_areas` VALUES( '430421','430400','衡阳县','99' ); 
INSERT INTO `w_areas` VALUES( '430422','430400','衡南县','99' ); 
INSERT INTO `w_areas` VALUES( '430423','430400','衡山县','99' ); 
INSERT INTO `w_areas` VALUES( '430424','430400','衡东县','99' ); 
INSERT INTO `w_areas` VALUES( '430426','430400','祁东县','99' ); 
INSERT INTO `w_areas` VALUES( '430481','430400','耒阳市','99' ); 
INSERT INTO `w_areas` VALUES( '430482','430400','常宁市','99' ); 
INSERT INTO `w_areas` VALUES( '430501','430500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430502','430500','双清区','99' ); 
INSERT INTO `w_areas` VALUES( '430503','430500','大祥区','99' ); 
INSERT INTO `w_areas` VALUES( '430511','430500','北塔区','99' ); 
INSERT INTO `w_areas` VALUES( '430521','430500','邵东县','99' ); 
INSERT INTO `w_areas` VALUES( '430522','430500','新邵县','99' ); 
INSERT INTO `w_areas` VALUES( '430523','430500','邵阳县','99' ); 
INSERT INTO `w_areas` VALUES( '430524','430500','隆回县','99' ); 
INSERT INTO `w_areas` VALUES( '430525','430500','洞口县','99' ); 
INSERT INTO `w_areas` VALUES( '430527','430500','绥宁县','99' ); 
INSERT INTO `w_areas` VALUES( '430528','430500','新宁县','99' ); 
INSERT INTO `w_areas` VALUES( '430529','430500','城步苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '430581','430500','武冈市','99' ); 
INSERT INTO `w_areas` VALUES( '430601','430600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430602','430600','岳阳楼区','99' ); 
INSERT INTO `w_areas` VALUES( '430603','430600','云溪区','99' ); 
INSERT INTO `w_areas` VALUES( '430611','430600','君山区','99' ); 
INSERT INTO `w_areas` VALUES( '430621','430600','岳阳县','99' ); 
INSERT INTO `w_areas` VALUES( '430623','430600','华容县','99' ); 
INSERT INTO `w_areas` VALUES( '430624','430600','湘阴县','99' ); 
INSERT INTO `w_areas` VALUES( '430626','430600','平江县','99' ); 
INSERT INTO `w_areas` VALUES( '430681','430600','汨罗市','99' ); 
INSERT INTO `w_areas` VALUES( '430682','430600','临湘市','99' ); 
INSERT INTO `w_areas` VALUES( '430701','430700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430702','430700','武陵区','99' ); 
INSERT INTO `w_areas` VALUES( '430703','430700','鼎城区','99' ); 
INSERT INTO `w_areas` VALUES( '430721','430700','安乡县','99' ); 
INSERT INTO `w_areas` VALUES( '430722','430700','汉寿县','99' ); 
INSERT INTO `w_areas` VALUES( '430723','430700','澧县','99' ); 
INSERT INTO `w_areas` VALUES( '430724','430700','临澧县','99' ); 
INSERT INTO `w_areas` VALUES( '430725','430700','桃源县','99' ); 
INSERT INTO `w_areas` VALUES( '430726','430700','石门县','99' ); 
INSERT INTO `w_areas` VALUES( '430781','430700','津市市','99' ); 
INSERT INTO `w_areas` VALUES( '430801','430800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430802','430800','永定区','99' ); 
INSERT INTO `w_areas` VALUES( '430811','430800','武陵源区','99' ); 
INSERT INTO `w_areas` VALUES( '430821','430800','慈利县','99' ); 
INSERT INTO `w_areas` VALUES( '430822','430800','桑植县','99' ); 
INSERT INTO `w_areas` VALUES( '430901','430900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '430902','430900','资阳区','99' ); 
INSERT INTO `w_areas` VALUES( '430903','430900','赫山区','99' ); 
INSERT INTO `w_areas` VALUES( '430921','430900','南县','99' ); 
INSERT INTO `w_areas` VALUES( '430922','430900','桃江县','99' ); 
INSERT INTO `w_areas` VALUES( '430923','430900','安化县','99' ); 
INSERT INTO `w_areas` VALUES( '430981','430900','沅江市','99' ); 
INSERT INTO `w_areas` VALUES( '431001','431000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '431002','431000','北湖区','99' ); 
INSERT INTO `w_areas` VALUES( '431003','431000','苏仙区','99' ); 
INSERT INTO `w_areas` VALUES( '431021','431000','桂阳县','99' ); 
INSERT INTO `w_areas` VALUES( '431022','431000','宜章县','99' ); 
INSERT INTO `w_areas` VALUES( '431023','431000','永兴县','99' ); 
INSERT INTO `w_areas` VALUES( '431024','431000','嘉禾县','99' ); 
INSERT INTO `w_areas` VALUES( '431025','431000','临武县','99' ); 
INSERT INTO `w_areas` VALUES( '431026','431000','汝城县','99' ); 
INSERT INTO `w_areas` VALUES( '431027','431000','桂东县','99' ); 
INSERT INTO `w_areas` VALUES( '431028','431000','安仁县','99' ); 
INSERT INTO `w_areas` VALUES( '431081','431000','资兴市','99' ); 
INSERT INTO `w_areas` VALUES( '431101','431100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '431102','431100','零陵区','99' ); 
INSERT INTO `w_areas` VALUES( '431103','431100','冷水滩区','99' ); 
INSERT INTO `w_areas` VALUES( '431121','431100','祁阳县','99' ); 
INSERT INTO `w_areas` VALUES( '431122','431100','东安县','99' ); 
INSERT INTO `w_areas` VALUES( '431123','431100','双牌县','99' ); 
INSERT INTO `w_areas` VALUES( '431124','431100','道县','99' ); 
INSERT INTO `w_areas` VALUES( '431125','431100','江永县','99' ); 
INSERT INTO `w_areas` VALUES( '431126','431100','宁远县','99' ); 
INSERT INTO `w_areas` VALUES( '431127','431100','蓝山县','99' ); 
INSERT INTO `w_areas` VALUES( '431128','431100','新田县','99' ); 
INSERT INTO `w_areas` VALUES( '431129','431100','江华瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '431201','431200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '431202','431200','鹤城区','99' ); 
INSERT INTO `w_areas` VALUES( '431221','431200','中方县','99' ); 
INSERT INTO `w_areas` VALUES( '431222','431200','沅陵县','99' ); 
INSERT INTO `w_areas` VALUES( '431223','431200','辰溪县','99' ); 
INSERT INTO `w_areas` VALUES( '431224','431200','溆浦县','99' ); 
INSERT INTO `w_areas` VALUES( '431225','431200','会同县','99' ); 
INSERT INTO `w_areas` VALUES( '431226','431200','麻阳苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '431227','431200','新晃侗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '431228','431200','芷江侗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '431229','431200','靖州苗族侗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '431230','431200','通道侗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '431281','431200','洪江市','99' ); 
INSERT INTO `w_areas` VALUES( '431301','431300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '431302','431300','娄星区','99' ); 
INSERT INTO `w_areas` VALUES( '431321','431300','双峰县','99' ); 
INSERT INTO `w_areas` VALUES( '431322','431300','新化县','99' ); 
INSERT INTO `w_areas` VALUES( '431381','431300','冷水江市','99' ); 
INSERT INTO `w_areas` VALUES( '431382','431300','涟源市','99' ); 
INSERT INTO `w_areas` VALUES( '433101','433100','吉首市','99' ); 
INSERT INTO `w_areas` VALUES( '433122','433100','泸溪县','99' ); 
INSERT INTO `w_areas` VALUES( '433123','433100','凤凰县','99' ); 
INSERT INTO `w_areas` VALUES( '433124','433100','花垣县','99' ); 
INSERT INTO `w_areas` VALUES( '433125','433100','保靖县','99' ); 
INSERT INTO `w_areas` VALUES( '433126','433100','古丈县','99' ); 
INSERT INTO `w_areas` VALUES( '433127','433100','永顺县','99' ); 
INSERT INTO `w_areas` VALUES( '433130','433100','龙山县','99' ); 
INSERT INTO `w_areas` VALUES( '440101','440100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440103','440100','荔湾区','99' ); 
INSERT INTO `w_areas` VALUES( '440104','440100','越秀区','99' ); 
INSERT INTO `w_areas` VALUES( '440105','440100','海珠区','99' ); 
INSERT INTO `w_areas` VALUES( '440106','440100','天河区','99' ); 
INSERT INTO `w_areas` VALUES( '440111','440100','白云区','99' ); 
INSERT INTO `w_areas` VALUES( '440112','440100','黄埔区','99' ); 
INSERT INTO `w_areas` VALUES( '440113','440100','番禺区','99' ); 
INSERT INTO `w_areas` VALUES( '440114','440100','花都区','99' ); 
INSERT INTO `w_areas` VALUES( '440115','440100','南沙区','99' ); 
INSERT INTO `w_areas` VALUES( '440116','440100','萝岗区','99' ); 
INSERT INTO `w_areas` VALUES( '440183','440100','增城市','99' ); 
INSERT INTO `w_areas` VALUES( '440184','440100','从化市','99' ); 
INSERT INTO `w_areas` VALUES( '440201','440200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440203','440200','武江区','99' ); 
INSERT INTO `w_areas` VALUES( '440204','440200','浈江区','99' ); 
INSERT INTO `w_areas` VALUES( '440205','440200','曲江区','99' ); 
INSERT INTO `w_areas` VALUES( '440222','440200','始兴县','99' ); 
INSERT INTO `w_areas` VALUES( '440224','440200','仁化县','99' ); 
INSERT INTO `w_areas` VALUES( '440229','440200','翁源县','99' ); 
INSERT INTO `w_areas` VALUES( '440232','440200','乳源瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '440233','440200','新丰县','99' ); 
INSERT INTO `w_areas` VALUES( '440281','440200','乐昌市','99' ); 
INSERT INTO `w_areas` VALUES( '440282','440200','南雄市','99' ); 
INSERT INTO `w_areas` VALUES( '440301','440300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440303','440300','罗湖区','99' ); 
INSERT INTO `w_areas` VALUES( '440304','440300','福田区','99' ); 
INSERT INTO `w_areas` VALUES( '440305','440300','南山区','99' ); 
INSERT INTO `w_areas` VALUES( '440306','440300','宝安区','99' ); 
INSERT INTO `w_areas` VALUES( '440307','440300','龙岗区','99' ); 
INSERT INTO `w_areas` VALUES( '440308','440300','盐田区','99' ); 
INSERT INTO `w_areas` VALUES( '440401','440400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440402','440400','香洲区','99' ); 
INSERT INTO `w_areas` VALUES( '440403','440400','斗门区','99' ); 
INSERT INTO `w_areas` VALUES( '440404','440400','金湾区','99' ); 
INSERT INTO `w_areas` VALUES( '440501','440500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440507','440500','龙湖区','99' ); 
INSERT INTO `w_areas` VALUES( '440511','440500','金平区','99' ); 
INSERT INTO `w_areas` VALUES( '440512','440500','濠江区','99' ); 
INSERT INTO `w_areas` VALUES( '440513','440500','潮阳区','99' ); 
INSERT INTO `w_areas` VALUES( '440514','440500','潮南区','99' ); 
INSERT INTO `w_areas` VALUES( '440515','440500','澄海区','99' ); 
INSERT INTO `w_areas` VALUES( '440523','440500','南澳县','99' ); 
INSERT INTO `w_areas` VALUES( '440601','440600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440604','440600','禅城区','99' ); 
INSERT INTO `w_areas` VALUES( '440605','440600','南海区','99' ); 
INSERT INTO `w_areas` VALUES( '440606','440600','顺德区','99' ); 
INSERT INTO `w_areas` VALUES( '440607','440600','三水区','99' ); 
INSERT INTO `w_areas` VALUES( '440608','440600','高明区','99' ); 
INSERT INTO `w_areas` VALUES( '440701','440700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440703','440700','蓬江区','99' ); 
INSERT INTO `w_areas` VALUES( '440704','440700','江海区','99' ); 
INSERT INTO `w_areas` VALUES( '440705','440700','新会区','99' ); 
INSERT INTO `w_areas` VALUES( '440781','440700','台山市','99' ); 
INSERT INTO `w_areas` VALUES( '440783','440700','开平市','99' ); 
INSERT INTO `w_areas` VALUES( '440784','440700','鹤山市','99' ); 
INSERT INTO `w_areas` VALUES( '440785','440700','恩平市','99' ); 
INSERT INTO `w_areas` VALUES( '440801','440800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440802','440800','赤坎区','99' ); 
INSERT INTO `w_areas` VALUES( '440803','440800','霞山区','99' ); 
INSERT INTO `w_areas` VALUES( '440804','440800','坡头区','99' ); 
INSERT INTO `w_areas` VALUES( '440811','440800','麻章区','99' ); 
INSERT INTO `w_areas` VALUES( '440823','440800','遂溪县','99' ); 
INSERT INTO `w_areas` VALUES( '440825','440800','徐闻县','99' ); 
INSERT INTO `w_areas` VALUES( '440881','440800','廉江市','99' ); 
INSERT INTO `w_areas` VALUES( '440882','440800','雷州市','99' ); 
INSERT INTO `w_areas` VALUES( '440883','440800','吴川市','99' ); 
INSERT INTO `w_areas` VALUES( '440901','440900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '440902','440900','茂南区','99' ); 
INSERT INTO `w_areas` VALUES( '440903','440900','茂港区','99' ); 
INSERT INTO `w_areas` VALUES( '440923','440900','电白县','99' ); 
INSERT INTO `w_areas` VALUES( '440981','440900','高州市','99' ); 
INSERT INTO `w_areas` VALUES( '440982','440900','化州市','99' ); 
INSERT INTO `w_areas` VALUES( '440983','440900','信宜市','99' ); 
INSERT INTO `w_areas` VALUES( '441201','441200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '441202','441200','端州区','99' ); 
INSERT INTO `w_areas` VALUES( '441203','441200','鼎湖区','99' ); 
INSERT INTO `w_areas` VALUES( '441223','441200','广宁县','99' ); 
INSERT INTO `w_areas` VALUES( '441224','441200','怀集县','99' ); 
INSERT INTO `w_areas` VALUES( '441225','441200','封开县','99' ); 
INSERT INTO `w_areas` VALUES( '441226','441200','德庆县','99' ); 
INSERT INTO `w_areas` VALUES( '441283','441200','高要市','99' ); 
INSERT INTO `w_areas` VALUES( '441284','441200','四会市','99' ); 
INSERT INTO `w_areas` VALUES( '441301','441300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '441302','441300','惠城区','99' ); 
INSERT INTO `w_areas` VALUES( '441303','441300','惠阳区','99' ); 
INSERT INTO `w_areas` VALUES( '441322','441300','博罗县','99' ); 
INSERT INTO `w_areas` VALUES( '441323','441300','惠东县','99' ); 
INSERT INTO `w_areas` VALUES( '441324','441300','龙门县','99' ); 
INSERT INTO `w_areas` VALUES( '441401','441400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '441402','441400','梅江区','99' ); 
INSERT INTO `w_areas` VALUES( '441421','441400','梅县','99' ); 
INSERT INTO `w_areas` VALUES( '441422','441400','大埔县','99' ); 
INSERT INTO `w_areas` VALUES( '441423','441400','丰顺县','99' ); 
INSERT INTO `w_areas` VALUES( '441424','441400','五华县','99' ); 
INSERT INTO `w_areas` VALUES( '441426','441400','平远县','99' ); 
INSERT INTO `w_areas` VALUES( '441427','441400','蕉岭县','99' ); 
INSERT INTO `w_areas` VALUES( '441481','441400','兴宁市','99' ); 
INSERT INTO `w_areas` VALUES( '441501','441500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '441502','441500','城区','99' ); 
INSERT INTO `w_areas` VALUES( '441521','441500','海丰县','99' ); 
INSERT INTO `w_areas` VALUES( '441523','441500','陆河县','99' ); 
INSERT INTO `w_areas` VALUES( '441581','441500','陆丰市','99' ); 
INSERT INTO `w_areas` VALUES( '441601','441600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '441602','441600','源城区','99' ); 
INSERT INTO `w_areas` VALUES( '441621','441600','紫金县','99' ); 
INSERT INTO `w_areas` VALUES( '441622','441600','龙川县','99' ); 
INSERT INTO `w_areas` VALUES( '441623','441600','连平县','99' ); 
INSERT INTO `w_areas` VALUES( '441624','441600','和平县','99' ); 
INSERT INTO `w_areas` VALUES( '441625','441600','东源县','99' ); 
INSERT INTO `w_areas` VALUES( '441701','441700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '441702','441700','江城区','99' ); 
INSERT INTO `w_areas` VALUES( '441721','441700','阳西县','99' ); 
INSERT INTO `w_areas` VALUES( '441723','441700','阳东县','99' ); 
INSERT INTO `w_areas` VALUES( '441781','441700','阳春市','99' ); 
INSERT INTO `w_areas` VALUES( '441801','441800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '441802','441800','清城区','99' ); 
INSERT INTO `w_areas` VALUES( '441821','441800','佛冈县','99' ); 
INSERT INTO `w_areas` VALUES( '441823','441800','阳山县','99' ); 
INSERT INTO `w_areas` VALUES( '441825','441800','连山壮族瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '441826','441800','连南瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '441827','441800','清新县','99' ); 
INSERT INTO `w_areas` VALUES( '441881','441800','英德市','99' ); 
INSERT INTO `w_areas` VALUES( '441882','441800','连州市','99' ); 
INSERT INTO `w_areas` VALUES( '445101','445100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '445102','445100','湘桥区','99' ); 
INSERT INTO `w_areas` VALUES( '445121','445100','潮安县','99' ); 
INSERT INTO `w_areas` VALUES( '445122','445100','饶平县','99' ); 
INSERT INTO `w_areas` VALUES( '445201','445200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '445202','445200','榕城区','99' ); 
INSERT INTO `w_areas` VALUES( '445221','445200','揭东县','99' ); 
INSERT INTO `w_areas` VALUES( '445222','445200','揭西县','99' ); 
INSERT INTO `w_areas` VALUES( '445224','445200','惠来县','99' ); 
INSERT INTO `w_areas` VALUES( '445281','445200','普宁市','99' ); 
INSERT INTO `w_areas` VALUES( '445301','445300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '445302','445300','云城区','99' ); 
INSERT INTO `w_areas` VALUES( '445321','445300','新兴县','99' ); 
INSERT INTO `w_areas` VALUES( '445322','445300','郁南县','99' ); 
INSERT INTO `w_areas` VALUES( '445323','445300','云安县','99' ); 
INSERT INTO `w_areas` VALUES( '445381','445300','罗定市','99' ); 
INSERT INTO `w_areas` VALUES( '450101','450100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450102','450100','兴宁区','99' ); 
INSERT INTO `w_areas` VALUES( '450103','450100','青秀区','99' ); 
INSERT INTO `w_areas` VALUES( '450105','450100','江南区','99' ); 
INSERT INTO `w_areas` VALUES( '450107','450100','西乡塘区','99' ); 
INSERT INTO `w_areas` VALUES( '450108','450100','良庆区','99' ); 
INSERT INTO `w_areas` VALUES( '450109','450100','邕宁区','99' ); 
INSERT INTO `w_areas` VALUES( '450122','450100','武鸣县','99' ); 
INSERT INTO `w_areas` VALUES( '450123','450100','隆安县','99' ); 
INSERT INTO `w_areas` VALUES( '450124','450100','马山县','99' ); 
INSERT INTO `w_areas` VALUES( '450125','450100','上林县','99' ); 
INSERT INTO `w_areas` VALUES( '450126','450100','宾阳县','99' ); 
INSERT INTO `w_areas` VALUES( '450127','450100','横县','99' ); 
INSERT INTO `w_areas` VALUES( '450201','450200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450202','450200','城中区','99' ); 
INSERT INTO `w_areas` VALUES( '450203','450200','鱼峰区','99' ); 
INSERT INTO `w_areas` VALUES( '450204','450200','柳南区','99' ); 
INSERT INTO `w_areas` VALUES( '450205','450200','柳北区','99' ); 
INSERT INTO `w_areas` VALUES( '450221','450200','柳江县','99' ); 
INSERT INTO `w_areas` VALUES( '450222','450200','柳城县','99' ); 
INSERT INTO `w_areas` VALUES( '450223','450200','鹿寨县','99' ); 
INSERT INTO `w_areas` VALUES( '450224','450200','融安县','99' ); 
INSERT INTO `w_areas` VALUES( '450225','450200','融水苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '450226','450200','三江侗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '450301','450300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450302','450300','秀峰区','99' ); 
INSERT INTO `w_areas` VALUES( '450303','450300','叠彩区','99' ); 
INSERT INTO `w_areas` VALUES( '450304','450300','象山区','99' ); 
INSERT INTO `w_areas` VALUES( '450305','450300','七星区','99' ); 
INSERT INTO `w_areas` VALUES( '450311','450300','雁山区','99' ); 
INSERT INTO `w_areas` VALUES( '450321','450300','阳朔县','99' ); 
INSERT INTO `w_areas` VALUES( '450322','450300','临桂县','99' ); 
INSERT INTO `w_areas` VALUES( '450323','450300','灵川县','99' ); 
INSERT INTO `w_areas` VALUES( '450324','450300','全州县','99' ); 
INSERT INTO `w_areas` VALUES( '450325','450300','兴安县','99' ); 
INSERT INTO `w_areas` VALUES( '450326','450300','永福县','99' ); 
INSERT INTO `w_areas` VALUES( '450327','450300','灌阳县','99' ); 
INSERT INTO `w_areas` VALUES( '450328','450300','龙胜各族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '450329','450300','资源县','99' ); 
INSERT INTO `w_areas` VALUES( '450330','450300','平乐县','99' ); 
INSERT INTO `w_areas` VALUES( '450331','450300','荔浦县','99' ); 
INSERT INTO `w_areas` VALUES( '450332','450300','恭城瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '450401','450400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450403','450400','万秀区','99' ); 
INSERT INTO `w_areas` VALUES( '450404','450400','蝶山区','99' ); 
INSERT INTO `w_areas` VALUES( '450405','450400','长洲区','99' ); 
INSERT INTO `w_areas` VALUES( '450421','450400','苍梧县','99' ); 
INSERT INTO `w_areas` VALUES( '450422','450400','藤县','99' ); 
INSERT INTO `w_areas` VALUES( '450423','450400','蒙山县','99' ); 
INSERT INTO `w_areas` VALUES( '450481','450400','岑溪市','99' ); 
INSERT INTO `w_areas` VALUES( '450501','450500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450502','450500','海城区','99' ); 
INSERT INTO `w_areas` VALUES( '450503','450500','银海区','99' ); 
INSERT INTO `w_areas` VALUES( '450512','450500','铁山港区','99' ); 
INSERT INTO `w_areas` VALUES( '450521','450500','合浦县','99' ); 
INSERT INTO `w_areas` VALUES( '450601','450600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450602','450600','港口区','99' ); 
INSERT INTO `w_areas` VALUES( '450603','450600','防城区','99' ); 
INSERT INTO `w_areas` VALUES( '450621','450600','上思县','99' ); 
INSERT INTO `w_areas` VALUES( '450681','450600','东兴市','99' ); 
INSERT INTO `w_areas` VALUES( '450701','450700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450702','450700','钦南区','99' ); 
INSERT INTO `w_areas` VALUES( '450703','450700','钦北区','99' ); 
INSERT INTO `w_areas` VALUES( '450721','450700','灵山县','99' ); 
INSERT INTO `w_areas` VALUES( '450722','450700','浦北县','99' ); 
INSERT INTO `w_areas` VALUES( '450801','450800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450802','450800','港北区','99' ); 
INSERT INTO `w_areas` VALUES( '450803','450800','港南区','99' ); 
INSERT INTO `w_areas` VALUES( '450804','450800','覃塘区','99' ); 
INSERT INTO `w_areas` VALUES( '450821','450800','平南县','99' ); 
INSERT INTO `w_areas` VALUES( '450881','450800','桂平市','99' ); 
INSERT INTO `w_areas` VALUES( '450901','450900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '450902','450900','玉州区','99' ); 
INSERT INTO `w_areas` VALUES( '450921','450900','容县','99' ); 
INSERT INTO `w_areas` VALUES( '450922','450900','陆川县','99' ); 
INSERT INTO `w_areas` VALUES( '450923','450900','博白县','99' ); 
INSERT INTO `w_areas` VALUES( '450924','450900','兴业县','99' ); 
INSERT INTO `w_areas` VALUES( '450981','450900','北流市','99' ); 
INSERT INTO `w_areas` VALUES( '451001','451000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '451002','451000','右江区','99' ); 
INSERT INTO `w_areas` VALUES( '451021','451000','田阳县','99' ); 
INSERT INTO `w_areas` VALUES( '451022','451000','田东县','99' ); 
INSERT INTO `w_areas` VALUES( '451023','451000','平果县','99' ); 
INSERT INTO `w_areas` VALUES( '451024','451000','德保县','99' ); 
INSERT INTO `w_areas` VALUES( '451025','451000','靖西县','99' ); 
INSERT INTO `w_areas` VALUES( '451026','451000','那坡县','99' ); 
INSERT INTO `w_areas` VALUES( '451027','451000','凌云县','99' ); 
INSERT INTO `w_areas` VALUES( '451028','451000','乐业县','99' ); 
INSERT INTO `w_areas` VALUES( '451029','451000','田林县','99' ); 
INSERT INTO `w_areas` VALUES( '451030','451000','西林县','99' ); 
INSERT INTO `w_areas` VALUES( '451031','451000','隆林各族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451101','451100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '451102','451100','八步区','99' ); 
INSERT INTO `w_areas` VALUES( '451121','451100','昭平县','99' ); 
INSERT INTO `w_areas` VALUES( '451122','451100','钟山县','99' ); 
INSERT INTO `w_areas` VALUES( '451123','451100','富川瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451201','451200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '451202','451200','金城江区','99' ); 
INSERT INTO `w_areas` VALUES( '451221','451200','南丹县','99' ); 
INSERT INTO `w_areas` VALUES( '451222','451200','天峨县','99' ); 
INSERT INTO `w_areas` VALUES( '451223','451200','凤山县','99' ); 
INSERT INTO `w_areas` VALUES( '451224','451200','东兰县','99' ); 
INSERT INTO `w_areas` VALUES( '451225','451200','罗城仫佬族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451226','451200','环江毛南族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451227','451200','巴马瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451228','451200','都安瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451229','451200','大化瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451281','451200','宜州市','99' ); 
INSERT INTO `w_areas` VALUES( '451301','451300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '451302','451300','兴宾区','99' ); 
INSERT INTO `w_areas` VALUES( '451321','451300','忻城县','99' ); 
INSERT INTO `w_areas` VALUES( '451322','451300','象州县','99' ); 
INSERT INTO `w_areas` VALUES( '451323','451300','武宣县','99' ); 
INSERT INTO `w_areas` VALUES( '451324','451300','金秀瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '451381','451300','合山市','99' ); 
INSERT INTO `w_areas` VALUES( '451401','451400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '451402','451400','江洲区','99' ); 
INSERT INTO `w_areas` VALUES( '451421','451400','扶绥县','99' ); 
INSERT INTO `w_areas` VALUES( '451422','451400','宁明县','99' ); 
INSERT INTO `w_areas` VALUES( '451423','451400','龙州县','99' ); 
INSERT INTO `w_areas` VALUES( '451424','451400','大新县','99' ); 
INSERT INTO `w_areas` VALUES( '451425','451400','天等县','99' ); 
INSERT INTO `w_areas` VALUES( '451481','451400','凭祥市','99' ); 
INSERT INTO `w_areas` VALUES( '460101','460100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '460105','460100','秀英区','99' ); 
INSERT INTO `w_areas` VALUES( '460106','460100','龙华区','99' ); 
INSERT INTO `w_areas` VALUES( '460107','460100','琼山区','99' ); 
INSERT INTO `w_areas` VALUES( '460108','460100','美兰区','99' ); 
INSERT INTO `w_areas` VALUES( '460201','460200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '460321','460300','西沙群岛','99' ); 
INSERT INTO `w_areas` VALUES( '460322','460300','南沙群岛','99' ); 
INSERT INTO `w_areas` VALUES( '460323','460300','中沙群岛的岛礁及其海域','99' ); 
INSERT INTO `w_areas` VALUES( '469001','469000','五指山市','99' ); 
INSERT INTO `w_areas` VALUES( '469002','469000','琼海市','99' ); 
INSERT INTO `w_areas` VALUES( '469003','469000','儋州市','99' ); 
INSERT INTO `w_areas` VALUES( '469005','469000','文昌市','99' ); 
INSERT INTO `w_areas` VALUES( '469006','469000','万宁市','99' ); 
INSERT INTO `w_areas` VALUES( '469007','469000','东方市','99' ); 
INSERT INTO `w_areas` VALUES( '469021','469000','定安县','99' ); 
INSERT INTO `w_areas` VALUES( '469022','469000','屯昌县','99' ); 
INSERT INTO `w_areas` VALUES( '469023','469000','澄迈县','99' ); 
INSERT INTO `w_areas` VALUES( '469024','469000','临高县','99' ); 
INSERT INTO `w_areas` VALUES( '469025','469000','白沙黎族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '469026','469000','昌江黎族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '469027','469000','乐东黎族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '469028','469000','陵水黎族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '469029','469000','保亭黎族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '469030','469000','琼中黎族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '500101','500100','万州区','99' ); 
INSERT INTO `w_areas` VALUES( '500102','500100','涪陵区','99' ); 
INSERT INTO `w_areas` VALUES( '500103','500100','渝中区','99' ); 
INSERT INTO `w_areas` VALUES( '500104','500100','大渡口区','99' ); 
INSERT INTO `w_areas` VALUES( '500105','500100','江北区','99' ); 
INSERT INTO `w_areas` VALUES( '500106','500100','沙坪坝区','99' ); 
INSERT INTO `w_areas` VALUES( '500107','500100','九龙坡区','99' ); 
INSERT INTO `w_areas` VALUES( '500108','500100','南岸区','99' ); 
INSERT INTO `w_areas` VALUES( '500109','500100','北碚区','99' ); 
INSERT INTO `w_areas` VALUES( '500110','500100','綦江区','99' ); 
INSERT INTO `w_areas` VALUES( '500111','500100','大足区','99' ); 
INSERT INTO `w_areas` VALUES( '500112','500100','渝北区','99' ); 
INSERT INTO `w_areas` VALUES( '500113','500100','巴南区','99' ); 
INSERT INTO `w_areas` VALUES( '500114','500100','黔江区','99' ); 
INSERT INTO `w_areas` VALUES( '500115','500100','长寿区','99' ); 
INSERT INTO `w_areas` VALUES( '500116','500100','江津区','99' ); 
INSERT INTO `w_areas` VALUES( '500117','500100','合川区','99' ); 
INSERT INTO `w_areas` VALUES( '500118','500100','永川区','99' ); 
INSERT INTO `w_areas` VALUES( '500119','500100','南川区','99' ); 
INSERT INTO `w_areas` VALUES( '500223','500200','潼南县','99' ); 
INSERT INTO `w_areas` VALUES( '500224','500200','铜梁县','99' ); 
INSERT INTO `w_areas` VALUES( '500226','500200','荣昌县','99' ); 
INSERT INTO `w_areas` VALUES( '500227','500200','璧山县','99' ); 
INSERT INTO `w_areas` VALUES( '500228','500200','梁平县','99' ); 
INSERT INTO `w_areas` VALUES( '500229','500200','城口县','99' ); 
INSERT INTO `w_areas` VALUES( '500230','500200','丰都县','99' ); 
INSERT INTO `w_areas` VALUES( '500231','500200','垫江县','99' ); 
INSERT INTO `w_areas` VALUES( '500232','500200','武隆县','99' ); 
INSERT INTO `w_areas` VALUES( '500233','500200','忠县','99' ); 
INSERT INTO `w_areas` VALUES( '500234','500200','开县','99' ); 
INSERT INTO `w_areas` VALUES( '500235','500200','云阳县','99' ); 
INSERT INTO `w_areas` VALUES( '500236','500200','奉节县','99' ); 
INSERT INTO `w_areas` VALUES( '500237','500200','巫山县','99' ); 
INSERT INTO `w_areas` VALUES( '500238','500200','巫溪县','99' ); 
INSERT INTO `w_areas` VALUES( '500240','500200','石柱土家族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '500241','500200','秀山土家族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '500242','500200','酉阳土家族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '500243','500200','彭水苗族土家族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '510101','510100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510104','510100','锦江区','99' ); 
INSERT INTO `w_areas` VALUES( '510105','510100','青羊区','99' ); 
INSERT INTO `w_areas` VALUES( '510106','510100','金牛区','99' ); 
INSERT INTO `w_areas` VALUES( '510107','510100','武侯区','99' ); 
INSERT INTO `w_areas` VALUES( '510108','510100','成华区','99' ); 
INSERT INTO `w_areas` VALUES( '510112','510100','龙泉驿区','99' ); 
INSERT INTO `w_areas` VALUES( '510113','510100','青白江区','99' ); 
INSERT INTO `w_areas` VALUES( '510114','510100','新都区','99' ); 
INSERT INTO `w_areas` VALUES( '510115','510100','温江区','99' ); 
INSERT INTO `w_areas` VALUES( '510121','510100','金堂县','99' ); 
INSERT INTO `w_areas` VALUES( '510122','510100','双流县','99' ); 
INSERT INTO `w_areas` VALUES( '510124','510100','郫县','99' ); 
INSERT INTO `w_areas` VALUES( '510129','510100','大邑县','99' ); 
INSERT INTO `w_areas` VALUES( '510131','510100','蒲江县','99' ); 
INSERT INTO `w_areas` VALUES( '510132','510100','新津县','99' ); 
INSERT INTO `w_areas` VALUES( '510181','510100','都江堰市','99' ); 
INSERT INTO `w_areas` VALUES( '510182','510100','彭州市','99' ); 
INSERT INTO `w_areas` VALUES( '510183','510100','邛崃市','99' ); 
INSERT INTO `w_areas` VALUES( '510184','510100','崇州市','99' ); 
INSERT INTO `w_areas` VALUES( '510301','510300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510302','510300','自流井区','99' ); 
INSERT INTO `w_areas` VALUES( '510303','510300','贡井区','99' ); 
INSERT INTO `w_areas` VALUES( '510304','510300','大安区','99' ); 
INSERT INTO `w_areas` VALUES( '510311','510300','沿滩区','99' ); 
INSERT INTO `w_areas` VALUES( '510321','510300','荣县','99' ); 
INSERT INTO `w_areas` VALUES( '510322','510300','富顺县','99' ); 
INSERT INTO `w_areas` VALUES( '510401','510400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510402','510400','东区','99' ); 
INSERT INTO `w_areas` VALUES( '510403','510400','西区','99' ); 
INSERT INTO `w_areas` VALUES( '510411','510400','仁和区','99' ); 
INSERT INTO `w_areas` VALUES( '510421','510400','米易县','99' ); 
INSERT INTO `w_areas` VALUES( '510422','510400','盐边县','99' ); 
INSERT INTO `w_areas` VALUES( '510501','510500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510502','510500','江阳区','99' ); 
INSERT INTO `w_areas` VALUES( '510503','510500','纳溪区','99' ); 
INSERT INTO `w_areas` VALUES( '510504','510500','龙马潭区','99' ); 
INSERT INTO `w_areas` VALUES( '510521','510500','泸县','99' ); 
INSERT INTO `w_areas` VALUES( '510522','510500','合江县','99' ); 
INSERT INTO `w_areas` VALUES( '510524','510500','叙永县','99' ); 
INSERT INTO `w_areas` VALUES( '510525','510500','古蔺县','99' ); 
INSERT INTO `w_areas` VALUES( '510601','510600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510603','510600','旌阳区','99' ); 
INSERT INTO `w_areas` VALUES( '510623','510600','中江县','99' ); 
INSERT INTO `w_areas` VALUES( '510626','510600','罗江县','99' ); 
INSERT INTO `w_areas` VALUES( '510681','510600','广汉市','99' ); 
INSERT INTO `w_areas` VALUES( '510682','510600','什邡市','99' ); 
INSERT INTO `w_areas` VALUES( '510683','510600','绵竹市','99' ); 
INSERT INTO `w_areas` VALUES( '510701','510700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510703','510700','涪城区','99' ); 
INSERT INTO `w_areas` VALUES( '510704','510700','游仙区','99' ); 
INSERT INTO `w_areas` VALUES( '510722','510700','三台县','99' ); 
INSERT INTO `w_areas` VALUES( '510723','510700','盐亭县','99' ); 
INSERT INTO `w_areas` VALUES( '510724','510700','安县','99' ); 
INSERT INTO `w_areas` VALUES( '510725','510700','梓潼县','99' ); 
INSERT INTO `w_areas` VALUES( '510726','510700','北川羌族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '510727','510700','平武县','99' ); 
INSERT INTO `w_areas` VALUES( '510781','510700','江油市','99' ); 
INSERT INTO `w_areas` VALUES( '510801','510800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510802','510800','利州区','99' ); 
INSERT INTO `w_areas` VALUES( '510811','510800','元坝区','99' ); 
INSERT INTO `w_areas` VALUES( '510812','510800','朝天区','99' ); 
INSERT INTO `w_areas` VALUES( '510821','510800','旺苍县','99' ); 
INSERT INTO `w_areas` VALUES( '510822','510800','青川县','99' ); 
INSERT INTO `w_areas` VALUES( '510823','510800','剑阁县','99' ); 
INSERT INTO `w_areas` VALUES( '510824','510800','苍溪县','99' ); 
INSERT INTO `w_areas` VALUES( '510901','510900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '510903','510900','船山区','99' ); 
INSERT INTO `w_areas` VALUES( '510904','510900','安居区','99' ); 
INSERT INTO `w_areas` VALUES( '510921','510900','蓬溪县','99' ); 
INSERT INTO `w_areas` VALUES( '510922','510900','射洪县','99' ); 
INSERT INTO `w_areas` VALUES( '510923','510900','大英县','99' ); 
INSERT INTO `w_areas` VALUES( '511001','511000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511002','511000','市中区','99' ); 
INSERT INTO `w_areas` VALUES( '511011','511000','东兴区','99' ); 
INSERT INTO `w_areas` VALUES( '511024','511000','威远县','99' ); 
INSERT INTO `w_areas` VALUES( '511025','511000','资中县','99' ); 
INSERT INTO `w_areas` VALUES( '511028','511000','隆昌县','99' ); 
INSERT INTO `w_areas` VALUES( '511101','511100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511102','511100','市中区','99' ); 
INSERT INTO `w_areas` VALUES( '511111','511100','沙湾区','99' ); 
INSERT INTO `w_areas` VALUES( '511112','511100','五通桥区','99' ); 
INSERT INTO `w_areas` VALUES( '511113','511100','金口河区','99' ); 
INSERT INTO `w_areas` VALUES( '511123','511100','犍为县','99' ); 
INSERT INTO `w_areas` VALUES( '511124','511100','井研县','99' ); 
INSERT INTO `w_areas` VALUES( '511126','511100','夹江县','99' ); 
INSERT INTO `w_areas` VALUES( '511129','511100','沐川县','99' ); 
INSERT INTO `w_areas` VALUES( '511132','511100','峨边彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '511133','511100','马边彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '511181','511100','峨眉山市','99' ); 
INSERT INTO `w_areas` VALUES( '511301','511300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511302','511300','顺庆区','99' ); 
INSERT INTO `w_areas` VALUES( '511303','511300','高坪区','99' ); 
INSERT INTO `w_areas` VALUES( '511304','511300','嘉陵区','99' ); 
INSERT INTO `w_areas` VALUES( '511321','511300','南部县','99' ); 
INSERT INTO `w_areas` VALUES( '511322','511300','营山县','99' ); 
INSERT INTO `w_areas` VALUES( '511323','511300','蓬安县','99' ); 
INSERT INTO `w_areas` VALUES( '511324','511300','仪陇县','99' ); 
INSERT INTO `w_areas` VALUES( '511325','511300','西充县','99' ); 
INSERT INTO `w_areas` VALUES( '511381','511300','阆中市','99' ); 
INSERT INTO `w_areas` VALUES( '511401','511400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511402','511400','东坡区','99' ); 
INSERT INTO `w_areas` VALUES( '511421','511400','仁寿县','99' ); 
INSERT INTO `w_areas` VALUES( '511422','511400','彭山县','99' ); 
INSERT INTO `w_areas` VALUES( '511423','511400','洪雅县','99' ); 
INSERT INTO `w_areas` VALUES( '511424','511400','丹棱县','99' ); 
INSERT INTO `w_areas` VALUES( '511425','511400','青神县','99' ); 
INSERT INTO `w_areas` VALUES( '511501','511500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511502','511500','翠屏区','99' ); 
INSERT INTO `w_areas` VALUES( '511503','511500','南溪区','99' ); 
INSERT INTO `w_areas` VALUES( '511521','511500','宜宾县','99' ); 
INSERT INTO `w_areas` VALUES( '511523','511500','江安县','99' ); 
INSERT INTO `w_areas` VALUES( '511524','511500','长宁县','99' ); 
INSERT INTO `w_areas` VALUES( '511525','511500','高县','99' ); 
INSERT INTO `w_areas` VALUES( '511526','511500','珙县','99' ); 
INSERT INTO `w_areas` VALUES( '511527','511500','筠连县','99' ); 
INSERT INTO `w_areas` VALUES( '511528','511500','兴文县','99' ); 
INSERT INTO `w_areas` VALUES( '511529','511500','屏山县','99' ); 
INSERT INTO `w_areas` VALUES( '511601','511600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511602','511600','广安区','99' ); 
INSERT INTO `w_areas` VALUES( '511621','511600','岳池县','99' ); 
INSERT INTO `w_areas` VALUES( '511622','511600','武胜县','99' ); 
INSERT INTO `w_areas` VALUES( '511623','511600','邻水县','99' ); 
INSERT INTO `w_areas` VALUES( '511681','511600','华蓥市','99' ); 
INSERT INTO `w_areas` VALUES( '511701','511700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511702','511700','通川区','99' ); 
INSERT INTO `w_areas` VALUES( '511721','511700','达县','99' ); 
INSERT INTO `w_areas` VALUES( '511722','511700','宣汉县','99' ); 
INSERT INTO `w_areas` VALUES( '511723','511700','开江县','99' ); 
INSERT INTO `w_areas` VALUES( '511724','511700','大竹县','99' ); 
INSERT INTO `w_areas` VALUES( '511725','511700','渠县','99' ); 
INSERT INTO `w_areas` VALUES( '511781','511700','万源市','99' ); 
INSERT INTO `w_areas` VALUES( '511801','511800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511802','511800','雨城区','99' ); 
INSERT INTO `w_areas` VALUES( '511803','511800','名山区','99' ); 
INSERT INTO `w_areas` VALUES( '511822','511800','荥经县','99' ); 
INSERT INTO `w_areas` VALUES( '511823','511800','汉源县','99' ); 
INSERT INTO `w_areas` VALUES( '511824','511800','石棉县','99' ); 
INSERT INTO `w_areas` VALUES( '511825','511800','天全县','99' ); 
INSERT INTO `w_areas` VALUES( '511826','511800','芦山县','99' ); 
INSERT INTO `w_areas` VALUES( '511827','511800','宝兴县','99' ); 
INSERT INTO `w_areas` VALUES( '511901','511900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '511902','511900','巴州区','99' ); 
INSERT INTO `w_areas` VALUES( '511921','511900','通江县','99' ); 
INSERT INTO `w_areas` VALUES( '511922','511900','南江县','99' ); 
INSERT INTO `w_areas` VALUES( '511923','511900','平昌县','99' ); 
INSERT INTO `w_areas` VALUES( '512001','512000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '512002','512000','雁江区','99' ); 
INSERT INTO `w_areas` VALUES( '512021','512000','安岳县','99' ); 
INSERT INTO `w_areas` VALUES( '512022','512000','乐至县','99' ); 
INSERT INTO `w_areas` VALUES( '512081','512000','简阳市','99' ); 
INSERT INTO `w_areas` VALUES( '513221','513200','汶川县','99' ); 
INSERT INTO `w_areas` VALUES( '513222','513200','理县','99' ); 
INSERT INTO `w_areas` VALUES( '513223','513200','茂县','99' ); 
INSERT INTO `w_areas` VALUES( '513224','513200','松潘县','99' ); 
INSERT INTO `w_areas` VALUES( '513225','513200','九寨沟县','99' ); 
INSERT INTO `w_areas` VALUES( '513226','513200','金川县','99' ); 
INSERT INTO `w_areas` VALUES( '513227','513200','小金县','99' ); 
INSERT INTO `w_areas` VALUES( '513228','513200','黑水县','99' ); 
INSERT INTO `w_areas` VALUES( '513229','513200','马尔康县','99' ); 
INSERT INTO `w_areas` VALUES( '513230','513200','壤塘县','99' ); 
INSERT INTO `w_areas` VALUES( '513231','513200','阿坝县','99' ); 
INSERT INTO `w_areas` VALUES( '513232','513200','若尔盖县','99' ); 
INSERT INTO `w_areas` VALUES( '513233','513200','红原县','99' ); 
INSERT INTO `w_areas` VALUES( '513321','513300','康定县','99' ); 
INSERT INTO `w_areas` VALUES( '513322','513300','泸定县','99' ); 
INSERT INTO `w_areas` VALUES( '513323','513300','丹巴县','99' ); 
INSERT INTO `w_areas` VALUES( '513324','513300','九龙县','99' ); 
INSERT INTO `w_areas` VALUES( '513325','513300','雅江县','99' ); 
INSERT INTO `w_areas` VALUES( '513326','513300','道孚县','99' ); 
INSERT INTO `w_areas` VALUES( '513327','513300','炉霍县','99' ); 
INSERT INTO `w_areas` VALUES( '513328','513300','甘孜县','99' ); 
INSERT INTO `w_areas` VALUES( '513329','513300','新龙县','99' ); 
INSERT INTO `w_areas` VALUES( '513330','513300','德格县','99' ); 
INSERT INTO `w_areas` VALUES( '513331','513300','白玉县','99' ); 
INSERT INTO `w_areas` VALUES( '513332','513300','石渠县','99' ); 
INSERT INTO `w_areas` VALUES( '513333','513300','色达县','99' ); 
INSERT INTO `w_areas` VALUES( '513334','513300','理塘县','99' ); 
INSERT INTO `w_areas` VALUES( '513335','513300','巴塘县','99' ); 
INSERT INTO `w_areas` VALUES( '513336','513300','乡城县','99' ); 
INSERT INTO `w_areas` VALUES( '513337','513300','稻城县','99' ); 
INSERT INTO `w_areas` VALUES( '513338','513300','得荣县','99' ); 
INSERT INTO `w_areas` VALUES( '513401','513400','西昌市','99' ); 
INSERT INTO `w_areas` VALUES( '513422','513400','木里藏族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '513423','513400','盐源县','99' ); 
INSERT INTO `w_areas` VALUES( '513424','513400','德昌县','99' ); 
INSERT INTO `w_areas` VALUES( '513425','513400','会理县','99' ); 
INSERT INTO `w_areas` VALUES( '513426','513400','会东县','99' ); 
INSERT INTO `w_areas` VALUES( '513427','513400','宁南县','99' ); 
INSERT INTO `w_areas` VALUES( '513428','513400','普格县','99' ); 
INSERT INTO `w_areas` VALUES( '513429','513400','布拖县','99' ); 
INSERT INTO `w_areas` VALUES( '513430','513400','金阳县','99' ); 
INSERT INTO `w_areas` VALUES( '513431','513400','昭觉县','99' ); 
INSERT INTO `w_areas` VALUES( '513432','513400','喜德县','99' ); 
INSERT INTO `w_areas` VALUES( '513433','513400','冕宁县','99' ); 
INSERT INTO `w_areas` VALUES( '513434','513400','越西县','99' ); 
INSERT INTO `w_areas` VALUES( '513435','513400','甘洛县','99' ); 
INSERT INTO `w_areas` VALUES( '513436','513400','美姑县','99' ); 
INSERT INTO `w_areas` VALUES( '513437','513400','雷波县','99' ); 
INSERT INTO `w_areas` VALUES( '520101','520100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '520102','520100','南明区','99' ); 
INSERT INTO `w_areas` VALUES( '520103','520100','云岩区','99' ); 
INSERT INTO `w_areas` VALUES( '520111','520100','花溪区','99' ); 
INSERT INTO `w_areas` VALUES( '520112','520100','乌当区','99' ); 
INSERT INTO `w_areas` VALUES( '520113','520100','白云区','99' ); 
INSERT INTO `w_areas` VALUES( '520114','520100','小河区','99' ); 
INSERT INTO `w_areas` VALUES( '520121','520100','开阳县','99' ); 
INSERT INTO `w_areas` VALUES( '520122','520100','息烽县','99' ); 
INSERT INTO `w_areas` VALUES( '520123','520100','修文县','99' ); 
INSERT INTO `w_areas` VALUES( '520181','520100','清镇市','99' ); 
INSERT INTO `w_areas` VALUES( '520201','520200','钟山区','99' ); 
INSERT INTO `w_areas` VALUES( '520203','520200','六枝特区','99' ); 
INSERT INTO `w_areas` VALUES( '520221','520200','水城县','99' ); 
INSERT INTO `w_areas` VALUES( '520222','520200','盘县','99' ); 
INSERT INTO `w_areas` VALUES( '520301','520300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '520302','520300','红花岗区','99' ); 
INSERT INTO `w_areas` VALUES( '520303','520300','汇川区','99' ); 
INSERT INTO `w_areas` VALUES( '520321','520300','遵义县','99' ); 
INSERT INTO `w_areas` VALUES( '520322','520300','桐梓县','99' ); 
INSERT INTO `w_areas` VALUES( '520323','520300','绥阳县','99' ); 
INSERT INTO `w_areas` VALUES( '520324','520300','正安县','99' ); 
INSERT INTO `w_areas` VALUES( '520325','520300','道真仡佬族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520326','520300','务川仡佬族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520327','520300','凤冈县','99' ); 
INSERT INTO `w_areas` VALUES( '520328','520300','湄潭县','99' ); 
INSERT INTO `w_areas` VALUES( '520329','520300','余庆县','99' ); 
INSERT INTO `w_areas` VALUES( '520330','520300','习水县','99' ); 
INSERT INTO `w_areas` VALUES( '520381','520300','赤水市','99' ); 
INSERT INTO `w_areas` VALUES( '520382','520300','仁怀市','99' ); 
INSERT INTO `w_areas` VALUES( '520401','520400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '520402','520400','西秀区','99' ); 
INSERT INTO `w_areas` VALUES( '520421','520400','平坝县','99' ); 
INSERT INTO `w_areas` VALUES( '520422','520400','普定县','99' ); 
INSERT INTO `w_areas` VALUES( '520423','520400','镇宁布依族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520424','520400','关岭布依族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520425','520400','紫云苗族布依族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520502','520500','七星关区','99' ); 
INSERT INTO `w_areas` VALUES( '520521','520500','大方县','99' ); 
INSERT INTO `w_areas` VALUES( '520522','520500','黔西县','99' ); 
INSERT INTO `w_areas` VALUES( '520523','520500','金沙县','99' ); 
INSERT INTO `w_areas` VALUES( '520524','520500','织金县','99' ); 
INSERT INTO `w_areas` VALUES( '520525','520500','纳雍县','99' ); 
INSERT INTO `w_areas` VALUES( '520526','520500','威宁彝族回族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520527','520500','赫章县','99' ); 
INSERT INTO `w_areas` VALUES( '520602','520600','碧江区','99' ); 
INSERT INTO `w_areas` VALUES( '520603','520600','万山区','99' ); 
INSERT INTO `w_areas` VALUES( '520621','520600','江口县','99' ); 
INSERT INTO `w_areas` VALUES( '520622','520600','玉屏侗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520623','520600','石阡县','99' ); 
INSERT INTO `w_areas` VALUES( '520624','520600','思南县','99' ); 
INSERT INTO `w_areas` VALUES( '520625','520600','印江土家族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520626','520600','德江县','99' ); 
INSERT INTO `w_areas` VALUES( '520627','520600','沿河土家族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '520628','520600','松桃苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '522301','522300','兴义市','99' ); 
INSERT INTO `w_areas` VALUES( '522322','522300','兴仁县','99' ); 
INSERT INTO `w_areas` VALUES( '522323','522300','普安县','99' ); 
INSERT INTO `w_areas` VALUES( '522324','522300','晴隆县','99' ); 
INSERT INTO `w_areas` VALUES( '522325','522300','贞丰县','99' ); 
INSERT INTO `w_areas` VALUES( '522326','522300','望谟县','99' ); 
INSERT INTO `w_areas` VALUES( '522327','522300','册亨县','99' ); 
INSERT INTO `w_areas` VALUES( '522328','522300','安龙县','99' ); 
INSERT INTO `w_areas` VALUES( '522601','522600','凯里市','99' ); 
INSERT INTO `w_areas` VALUES( '522622','522600','黄平县','99' ); 
INSERT INTO `w_areas` VALUES( '522623','522600','施秉县','99' ); 
INSERT INTO `w_areas` VALUES( '522624','522600','三穗县','99' ); 
INSERT INTO `w_areas` VALUES( '522625','522600','镇远县','99' ); 
INSERT INTO `w_areas` VALUES( '522626','522600','岑巩县','99' ); 
INSERT INTO `w_areas` VALUES( '522627','522600','天柱县','99' ); 
INSERT INTO `w_areas` VALUES( '522628','522600','锦屏县','99' ); 
INSERT INTO `w_areas` VALUES( '522629','522600','剑河县','99' ); 
INSERT INTO `w_areas` VALUES( '522630','522600','台江县','99' ); 
INSERT INTO `w_areas` VALUES( '522631','522600','黎平县','99' ); 
INSERT INTO `w_areas` VALUES( '522632','522600','榕江县','99' ); 
INSERT INTO `w_areas` VALUES( '522633','522600','从江县','99' ); 
INSERT INTO `w_areas` VALUES( '522634','522600','雷山县','99' ); 
INSERT INTO `w_areas` VALUES( '522635','522600','麻江县','99' ); 
INSERT INTO `w_areas` VALUES( '522636','522600','丹寨县','99' ); 
INSERT INTO `w_areas` VALUES( '522701','522700','都匀市','99' ); 
INSERT INTO `w_areas` VALUES( '522702','522700','福泉市','99' ); 
INSERT INTO `w_areas` VALUES( '522722','522700','荔波县','99' ); 
INSERT INTO `w_areas` VALUES( '522723','522700','贵定县','99' ); 
INSERT INTO `w_areas` VALUES( '522725','522700','瓮安县','99' ); 
INSERT INTO `w_areas` VALUES( '522726','522700','独山县','99' ); 
INSERT INTO `w_areas` VALUES( '522727','522700','平塘县','99' ); 
INSERT INTO `w_areas` VALUES( '522728','522700','罗甸县','99' ); 
INSERT INTO `w_areas` VALUES( '522729','522700','长顺县','99' ); 
INSERT INTO `w_areas` VALUES( '522730','522700','龙里县','99' ); 
INSERT INTO `w_areas` VALUES( '522731','522700','惠水县','99' ); 
INSERT INTO `w_areas` VALUES( '522732','522700','三都水族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530101','530100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '530102','530100','五华区','99' ); 
INSERT INTO `w_areas` VALUES( '530103','530100','盘龙区','99' ); 
INSERT INTO `w_areas` VALUES( '530111','530100','官渡区','99' ); 
INSERT INTO `w_areas` VALUES( '530112','530100','西山区','99' ); 
INSERT INTO `w_areas` VALUES( '530113','530100','东川区','99' ); 
INSERT INTO `w_areas` VALUES( '530114','530100','呈贡区','99' ); 
INSERT INTO `w_areas` VALUES( '530122','530100','晋宁县','99' ); 
INSERT INTO `w_areas` VALUES( '530124','530100','富民县','99' ); 
INSERT INTO `w_areas` VALUES( '530125','530100','宜良县','99' ); 
INSERT INTO `w_areas` VALUES( '530126','530100','石林彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530127','530100','嵩明县','99' ); 
INSERT INTO `w_areas` VALUES( '530128','530100','禄劝彝族苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530129','530100','寻甸回族彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530181','530100','安宁市','99' ); 
INSERT INTO `w_areas` VALUES( '530301','530300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '530302','530300','麒麟区','99' ); 
INSERT INTO `w_areas` VALUES( '530321','530300','马龙县','99' ); 
INSERT INTO `w_areas` VALUES( '530322','530300','陆良县','99' ); 
INSERT INTO `w_areas` VALUES( '530323','530300','师宗县','99' ); 
INSERT INTO `w_areas` VALUES( '530324','530300','罗平县','99' ); 
INSERT INTO `w_areas` VALUES( '530325','530300','富源县','99' ); 
INSERT INTO `w_areas` VALUES( '530326','530300','会泽县','99' ); 
INSERT INTO `w_areas` VALUES( '530328','530300','沾益县','99' ); 
INSERT INTO `w_areas` VALUES( '530381','530300','宣威市','99' ); 
INSERT INTO `w_areas` VALUES( '530402','530400','红塔区','99' ); 
INSERT INTO `w_areas` VALUES( '530421','530400','江川县','99' ); 
INSERT INTO `w_areas` VALUES( '530422','530400','澄江县','99' ); 
INSERT INTO `w_areas` VALUES( '530423','530400','通海县','99' ); 
INSERT INTO `w_areas` VALUES( '530424','530400','华宁县','99' ); 
INSERT INTO `w_areas` VALUES( '530425','530400','易门县','99' ); 
INSERT INTO `w_areas` VALUES( '530426','530400','峨山彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530427','530400','新平彝族傣族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530428','530400','元江哈尼族彝族傣族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530501','530500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '530502','530500','隆阳区','99' ); 
INSERT INTO `w_areas` VALUES( '530521','530500','施甸县','99' ); 
INSERT INTO `w_areas` VALUES( '530522','530500','腾冲县','99' ); 
INSERT INTO `w_areas` VALUES( '530523','530500','龙陵县','99' ); 
INSERT INTO `w_areas` VALUES( '530524','530500','昌宁县','99' ); 
INSERT INTO `w_areas` VALUES( '530601','530600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '530602','530600','昭阳区','99' ); 
INSERT INTO `w_areas` VALUES( '530621','530600','鲁甸县','99' ); 
INSERT INTO `w_areas` VALUES( '530622','530600','巧家县','99' ); 
INSERT INTO `w_areas` VALUES( '530623','530600','盐津县','99' ); 
INSERT INTO `w_areas` VALUES( '530624','530600','大关县','99' ); 
INSERT INTO `w_areas` VALUES( '530625','530600','永善县','99' ); 
INSERT INTO `w_areas` VALUES( '530626','530600','绥江县','99' ); 
INSERT INTO `w_areas` VALUES( '530627','530600','镇雄县','99' ); 
INSERT INTO `w_areas` VALUES( '530628','530600','彝良县','99' ); 
INSERT INTO `w_areas` VALUES( '530629','530600','威信县','99' ); 
INSERT INTO `w_areas` VALUES( '530630','530600','水富县','99' ); 
INSERT INTO `w_areas` VALUES( '530701','530700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '530702','530700','古城区','99' ); 
INSERT INTO `w_areas` VALUES( '530721','530700','玉龙纳西族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530722','530700','永胜县','99' ); 
INSERT INTO `w_areas` VALUES( '530723','530700','华坪县','99' ); 
INSERT INTO `w_areas` VALUES( '530724','530700','宁蒗彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530801','530800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '530802','530800','思茅区','99' ); 
INSERT INTO `w_areas` VALUES( '530821','530800','宁洱哈尼族彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530822','530800','墨江哈尼族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530823','530800','景东彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530824','530800','景谷傣族彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530825','530800','镇沅彝族哈尼族拉祜族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530826','530800','江城哈尼族彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530827','530800','孟连傣族拉祜族佤族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530828','530800','澜沧拉祜族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530829','530800','西盟佤族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530901','530900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '530902','530900','临翔区','99' ); 
INSERT INTO `w_areas` VALUES( '530921','530900','凤庆县','99' ); 
INSERT INTO `w_areas` VALUES( '530922','530900','云县','99' ); 
INSERT INTO `w_areas` VALUES( '530923','530900','永德县','99' ); 
INSERT INTO `w_areas` VALUES( '530924','530900','镇康县','99' ); 
INSERT INTO `w_areas` VALUES( '530925','530900','双江拉祜族佤族布朗族傣族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530926','530900','耿马傣族佤族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '530927','530900','沧源佤族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '532301','532300','楚雄市','99' ); 
INSERT INTO `w_areas` VALUES( '532322','532300','双柏县','99' ); 
INSERT INTO `w_areas` VALUES( '532323','532300','牟定县','99' ); 
INSERT INTO `w_areas` VALUES( '532324','532300','南华县','99' ); 
INSERT INTO `w_areas` VALUES( '532325','532300','姚安县','99' ); 
INSERT INTO `w_areas` VALUES( '532326','532300','大姚县','99' ); 
INSERT INTO `w_areas` VALUES( '532327','532300','永仁县','99' ); 
INSERT INTO `w_areas` VALUES( '532328','532300','元谋县','99' ); 
INSERT INTO `w_areas` VALUES( '532329','532300','武定县','99' ); 
INSERT INTO `w_areas` VALUES( '532331','532300','禄丰县','99' ); 
INSERT INTO `w_areas` VALUES( '532501','532500','个旧市','99' ); 
INSERT INTO `w_areas` VALUES( '532502','532500','开远市','99' ); 
INSERT INTO `w_areas` VALUES( '532503','532500','蒙自市','99' ); 
INSERT INTO `w_areas` VALUES( '532523','532500','屏边苗族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '532524','532500','建水县','99' ); 
INSERT INTO `w_areas` VALUES( '532525','532500','石屏县','99' ); 
INSERT INTO `w_areas` VALUES( '532526','532500','弥勒县','99' ); 
INSERT INTO `w_areas` VALUES( '532527','532500','泸西县','99' ); 
INSERT INTO `w_areas` VALUES( '532528','532500','元阳县','99' ); 
INSERT INTO `w_areas` VALUES( '532529','532500','红河县','99' ); 
INSERT INTO `w_areas` VALUES( '532530','532500','金平苗族瑶族傣族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '532531','532500','绿春县','99' ); 
INSERT INTO `w_areas` VALUES( '532532','532500','河口瑶族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '532601','532600','文山市','99' ); 
INSERT INTO `w_areas` VALUES( '532622','532600','砚山县','99' ); 
INSERT INTO `w_areas` VALUES( '532623','532600','西畴县','99' ); 
INSERT INTO `w_areas` VALUES( '532624','532600','麻栗坡县','99' ); 
INSERT INTO `w_areas` VALUES( '532625','532600','马关县','99' ); 
INSERT INTO `w_areas` VALUES( '532626','532600','丘北县','99' ); 
INSERT INTO `w_areas` VALUES( '532627','532600','广南县','99' ); 
INSERT INTO `w_areas` VALUES( '532628','532600','富宁县','99' ); 
INSERT INTO `w_areas` VALUES( '532801','532800','景洪市','99' ); 
INSERT INTO `w_areas` VALUES( '532822','532800','勐海县','99' ); 
INSERT INTO `w_areas` VALUES( '532823','532800','勐腊县','99' ); 
INSERT INTO `w_areas` VALUES( '532901','532900','大理市','99' ); 
INSERT INTO `w_areas` VALUES( '532922','532900','漾濞彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '532923','532900','祥云县','99' ); 
INSERT INTO `w_areas` VALUES( '532924','532900','宾川县','99' ); 
INSERT INTO `w_areas` VALUES( '532925','532900','弥渡县','99' ); 
INSERT INTO `w_areas` VALUES( '532926','532900','南涧彝族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '532927','532900','巍山彝族回族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '532928','532900','永平县','99' ); 
INSERT INTO `w_areas` VALUES( '532929','532900','云龙县','99' ); 
INSERT INTO `w_areas` VALUES( '532930','532900','洱源县','99' ); 
INSERT INTO `w_areas` VALUES( '532931','532900','剑川县','99' ); 
INSERT INTO `w_areas` VALUES( '532932','532900','鹤庆县','99' ); 
INSERT INTO `w_areas` VALUES( '533102','533100','瑞丽市','99' ); 
INSERT INTO `w_areas` VALUES( '533103','533100','芒市','99' ); 
INSERT INTO `w_areas` VALUES( '533122','533100','梁河县','99' ); 
INSERT INTO `w_areas` VALUES( '533123','533100','盈江县','99' ); 
INSERT INTO `w_areas` VALUES( '533124','533100','陇川县','99' ); 
INSERT INTO `w_areas` VALUES( '533321','533300','泸水县','99' ); 
INSERT INTO `w_areas` VALUES( '533323','533300','福贡县','99' ); 
INSERT INTO `w_areas` VALUES( '533324','533300','贡山独龙族怒族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '533325','533300','兰坪白族普米族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '533421','533400','香格里拉县','99' ); 
INSERT INTO `w_areas` VALUES( '533422','533400','德钦县','99' ); 
INSERT INTO `w_areas` VALUES( '533423','533400','维西傈僳族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '540101','540100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '540102','540100','城关区','99' ); 
INSERT INTO `w_areas` VALUES( '540121','540100','林周县','99' ); 
INSERT INTO `w_areas` VALUES( '540122','540100','当雄县','99' ); 
INSERT INTO `w_areas` VALUES( '540123','540100','尼木县','99' ); 
INSERT INTO `w_areas` VALUES( '540124','540100','曲水县','99' ); 
INSERT INTO `w_areas` VALUES( '540125','540100','堆龙德庆县','99' ); 
INSERT INTO `w_areas` VALUES( '540126','540100','达孜县','99' ); 
INSERT INTO `w_areas` VALUES( '540127','540100','墨竹工卡县','99' ); 
INSERT INTO `w_areas` VALUES( '542121','542100','昌都县','99' ); 
INSERT INTO `w_areas` VALUES( '542122','542100','江达县','99' ); 
INSERT INTO `w_areas` VALUES( '542123','542100','贡觉县','99' ); 
INSERT INTO `w_areas` VALUES( '542124','542100','类乌齐县','99' ); 
INSERT INTO `w_areas` VALUES( '542125','542100','丁青县','99' ); 
INSERT INTO `w_areas` VALUES( '542126','542100','察雅县','99' ); 
INSERT INTO `w_areas` VALUES( '542127','542100','八宿县','99' ); 
INSERT INTO `w_areas` VALUES( '542128','542100','左贡县','99' ); 
INSERT INTO `w_areas` VALUES( '542129','542100','芒康县','99' ); 
INSERT INTO `w_areas` VALUES( '542132','542100','洛隆县','99' ); 
INSERT INTO `w_areas` VALUES( '542133','542100','边坝县','99' ); 
INSERT INTO `w_areas` VALUES( '542221','542200','乃东县','99' ); 
INSERT INTO `w_areas` VALUES( '542222','542200','扎囊县','99' ); 
INSERT INTO `w_areas` VALUES( '542223','542200','贡嘎县','99' ); 
INSERT INTO `w_areas` VALUES( '542224','542200','桑日县','99' ); 
INSERT INTO `w_areas` VALUES( '542225','542200','琼结县','99' ); 
INSERT INTO `w_areas` VALUES( '542226','542200','曲松县','99' ); 
INSERT INTO `w_areas` VALUES( '542227','542200','措美县','99' ); 
INSERT INTO `w_areas` VALUES( '542228','542200','洛扎县','99' ); 
INSERT INTO `w_areas` VALUES( '542229','542200','加查县','99' ); 
INSERT INTO `w_areas` VALUES( '542231','542200','隆子县','99' ); 
INSERT INTO `w_areas` VALUES( '542232','542200','错那县','99' ); 
INSERT INTO `w_areas` VALUES( '542233','542200','浪卡子县','99' ); 
INSERT INTO `w_areas` VALUES( '542301','542300','日喀则市','99' ); 
INSERT INTO `w_areas` VALUES( '542322','542300','南木林县','99' ); 
INSERT INTO `w_areas` VALUES( '542323','542300','江孜县','99' ); 
INSERT INTO `w_areas` VALUES( '542324','542300','定日县','99' ); 
INSERT INTO `w_areas` VALUES( '542325','542300','萨迦县','99' ); 
INSERT INTO `w_areas` VALUES( '542326','542300','拉孜县','99' ); 
INSERT INTO `w_areas` VALUES( '542327','542300','昂仁县','99' ); 
INSERT INTO `w_areas` VALUES( '542328','542300','谢通门县','99' ); 
INSERT INTO `w_areas` VALUES( '542329','542300','白朗县','99' ); 
INSERT INTO `w_areas` VALUES( '542330','542300','仁布县','99' ); 
INSERT INTO `w_areas` VALUES( '542331','542300','康马县','99' ); 
INSERT INTO `w_areas` VALUES( '542332','542300','定结县','99' ); 
INSERT INTO `w_areas` VALUES( '542333','542300','仲巴县','99' ); 
INSERT INTO `w_areas` VALUES( '542334','542300','亚东县','99' ); 
INSERT INTO `w_areas` VALUES( '542335','542300','吉隆县','99' ); 
INSERT INTO `w_areas` VALUES( '542336','542300','聂拉木县','99' ); 
INSERT INTO `w_areas` VALUES( '542337','542300','萨嘎县','99' ); 
INSERT INTO `w_areas` VALUES( '542338','542300','岗巴县','99' ); 
INSERT INTO `w_areas` VALUES( '542421','542400','那曲县','99' ); 
INSERT INTO `w_areas` VALUES( '542422','542400','嘉黎县','99' ); 
INSERT INTO `w_areas` VALUES( '542423','542400','比如县','99' ); 
INSERT INTO `w_areas` VALUES( '542424','542400','聂荣县','99' ); 
INSERT INTO `w_areas` VALUES( '542425','542400','安多县','99' ); 
INSERT INTO `w_areas` VALUES( '542426','542400','申扎县','99' ); 
INSERT INTO `w_areas` VALUES( '542427','542400','索县','99' ); 
INSERT INTO `w_areas` VALUES( '542428','542400','班戈县','99' ); 
INSERT INTO `w_areas` VALUES( '542429','542400','巴青县','99' ); 
INSERT INTO `w_areas` VALUES( '542430','542400','尼玛县','99' ); 
INSERT INTO `w_areas` VALUES( '542521','542500','普兰县','99' ); 
INSERT INTO `w_areas` VALUES( '542522','542500','札达县','99' ); 
INSERT INTO `w_areas` VALUES( '542523','542500','噶尔县','99' ); 
INSERT INTO `w_areas` VALUES( '542524','542500','日土县','99' ); 
INSERT INTO `w_areas` VALUES( '542525','542500','革吉县','99' ); 
INSERT INTO `w_areas` VALUES( '542526','542500','改则县','99' ); 
INSERT INTO `w_areas` VALUES( '542527','542500','措勤县','99' ); 
INSERT INTO `w_areas` VALUES( '542621','542600','林芝县','99' ); 
INSERT INTO `w_areas` VALUES( '542622','542600','工布江达县','99' ); 
INSERT INTO `w_areas` VALUES( '542623','542600','米林县','99' ); 
INSERT INTO `w_areas` VALUES( '542624','542600','墨脱县','99' ); 
INSERT INTO `w_areas` VALUES( '542625','542600','波密县','99' ); 
INSERT INTO `w_areas` VALUES( '542626','542600','察隅县','99' ); 
INSERT INTO `w_areas` VALUES( '542627','542600','朗县','99' ); 
INSERT INTO `w_areas` VALUES( '610101','610100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610102','610100','新城区','99' ); 
INSERT INTO `w_areas` VALUES( '610103','610100','碑林区','99' ); 
INSERT INTO `w_areas` VALUES( '610104','610100','莲湖区','99' ); 
INSERT INTO `w_areas` VALUES( '610111','610100','灞桥区','99' ); 
INSERT INTO `w_areas` VALUES( '610112','610100','未央区','99' ); 
INSERT INTO `w_areas` VALUES( '610113','610100','雁塔区','99' ); 
INSERT INTO `w_areas` VALUES( '610114','610100','阎良区','99' ); 
INSERT INTO `w_areas` VALUES( '610115','610100','临潼区','99' ); 
INSERT INTO `w_areas` VALUES( '610116','610100','长安区','99' ); 
INSERT INTO `w_areas` VALUES( '610122','610100','蓝田县','99' ); 
INSERT INTO `w_areas` VALUES( '610124','610100','周至县','99' ); 
INSERT INTO `w_areas` VALUES( '610125','610100','户县','99' ); 
INSERT INTO `w_areas` VALUES( '610126','610100','高陵县','99' ); 
INSERT INTO `w_areas` VALUES( '610201','610200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610202','610200','王益区','99' ); 
INSERT INTO `w_areas` VALUES( '610203','610200','印台区','99' ); 
INSERT INTO `w_areas` VALUES( '610204','610200','耀州区','99' ); 
INSERT INTO `w_areas` VALUES( '610222','610200','宜君县','99' ); 
INSERT INTO `w_areas` VALUES( '610301','610300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610302','610300','渭滨区','99' ); 
INSERT INTO `w_areas` VALUES( '610303','610300','金台区','99' ); 
INSERT INTO `w_areas` VALUES( '610304','610300','陈仓区','99' ); 
INSERT INTO `w_areas` VALUES( '610322','610300','凤翔县','99' ); 
INSERT INTO `w_areas` VALUES( '610323','610300','岐山县','99' ); 
INSERT INTO `w_areas` VALUES( '610324','610300','扶风县','99' ); 
INSERT INTO `w_areas` VALUES( '610326','610300','眉县','99' ); 
INSERT INTO `w_areas` VALUES( '610327','610300','陇县','99' ); 
INSERT INTO `w_areas` VALUES( '610328','610300','千阳县','99' ); 
INSERT INTO `w_areas` VALUES( '610329','610300','麟游县','99' ); 
INSERT INTO `w_areas` VALUES( '610330','610300','凤县','99' ); 
INSERT INTO `w_areas` VALUES( '610331','610300','太白县','99' ); 
INSERT INTO `w_areas` VALUES( '610401','610400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610402','610400','秦都区','99' ); 
INSERT INTO `w_areas` VALUES( '610403','610400','杨陵区','99' ); 
INSERT INTO `w_areas` VALUES( '610404','610400','渭城区','99' ); 
INSERT INTO `w_areas` VALUES( '610422','610400','三原县','99' ); 
INSERT INTO `w_areas` VALUES( '610423','610400','泾阳县','99' ); 
INSERT INTO `w_areas` VALUES( '610424','610400','乾县','99' ); 
INSERT INTO `w_areas` VALUES( '610425','610400','礼泉县','99' ); 
INSERT INTO `w_areas` VALUES( '610426','610400','永寿县','99' ); 
INSERT INTO `w_areas` VALUES( '610427','610400','彬县','99' ); 
INSERT INTO `w_areas` VALUES( '610428','610400','长武县','99' ); 
INSERT INTO `w_areas` VALUES( '610429','610400','旬邑县','99' ); 
INSERT INTO `w_areas` VALUES( '610430','610400','淳化县','99' ); 
INSERT INTO `w_areas` VALUES( '610431','610400','武功县','99' ); 
INSERT INTO `w_areas` VALUES( '610481','610400','兴平市','99' ); 
INSERT INTO `w_areas` VALUES( '610501','610500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610502','610500','临渭区','99' ); 
INSERT INTO `w_areas` VALUES( '610521','610500','华县','99' ); 
INSERT INTO `w_areas` VALUES( '610522','610500','潼关县','99' ); 
INSERT INTO `w_areas` VALUES( '610523','610500','大荔县','99' ); 
INSERT INTO `w_areas` VALUES( '610524','610500','合阳县','99' ); 
INSERT INTO `w_areas` VALUES( '610525','610500','澄城县','99' ); 
INSERT INTO `w_areas` VALUES( '610526','610500','蒲城县','99' ); 
INSERT INTO `w_areas` VALUES( '610527','610500','白水县','99' ); 
INSERT INTO `w_areas` VALUES( '610528','610500','富平县','99' ); 
INSERT INTO `w_areas` VALUES( '610581','610500','韩城市','99' ); 
INSERT INTO `w_areas` VALUES( '610582','610500','华阴市','99' ); 
INSERT INTO `w_areas` VALUES( '610601','610600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610602','610600','宝塔区','99' ); 
INSERT INTO `w_areas` VALUES( '610621','610600','延长县','99' ); 
INSERT INTO `w_areas` VALUES( '610622','610600','延川县','99' ); 
INSERT INTO `w_areas` VALUES( '610623','610600','子长县','99' ); 
INSERT INTO `w_areas` VALUES( '610624','610600','安塞县','99' ); 
INSERT INTO `w_areas` VALUES( '610625','610600','志丹县','99' ); 
INSERT INTO `w_areas` VALUES( '610626','610600','吴起县','99' ); 
INSERT INTO `w_areas` VALUES( '610627','610600','甘泉县','99' ); 
INSERT INTO `w_areas` VALUES( '610628','610600','富县','99' ); 
INSERT INTO `w_areas` VALUES( '610629','610600','洛川县','99' ); 
INSERT INTO `w_areas` VALUES( '610630','610600','宜川县','99' ); 
INSERT INTO `w_areas` VALUES( '610631','610600','黄龙县','99' ); 
INSERT INTO `w_areas` VALUES( '610632','610600','黄陵县','99' ); 
INSERT INTO `w_areas` VALUES( '610701','610700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610702','610700','汉台区','99' ); 
INSERT INTO `w_areas` VALUES( '610721','610700','南郑县','99' ); 
INSERT INTO `w_areas` VALUES( '610722','610700','城固县','99' ); 
INSERT INTO `w_areas` VALUES( '610723','610700','洋县','99' ); 
INSERT INTO `w_areas` VALUES( '610724','610700','西乡县','99' ); 
INSERT INTO `w_areas` VALUES( '610725','610700','勉县','99' ); 
INSERT INTO `w_areas` VALUES( '610726','610700','宁强县','99' ); 
INSERT INTO `w_areas` VALUES( '610727','610700','略阳县','99' ); 
INSERT INTO `w_areas` VALUES( '610728','610700','镇巴县','99' ); 
INSERT INTO `w_areas` VALUES( '610729','610700','留坝县','99' ); 
INSERT INTO `w_areas` VALUES( '610730','610700','佛坪县','99' ); 
INSERT INTO `w_areas` VALUES( '610801','610800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610802','610800','榆阳区','99' ); 
INSERT INTO `w_areas` VALUES( '610821','610800','神木县','99' ); 
INSERT INTO `w_areas` VALUES( '610822','610800','府谷县','99' ); 
INSERT INTO `w_areas` VALUES( '610823','610800','横山县','99' ); 
INSERT INTO `w_areas` VALUES( '610824','610800','靖边县','99' ); 
INSERT INTO `w_areas` VALUES( '610825','610800','定边县','99' ); 
INSERT INTO `w_areas` VALUES( '610826','610800','绥德县','99' ); 
INSERT INTO `w_areas` VALUES( '610827','610800','米脂县','99' ); 
INSERT INTO `w_areas` VALUES( '610828','610800','佳县','99' ); 
INSERT INTO `w_areas` VALUES( '610829','610800','吴堡县','99' ); 
INSERT INTO `w_areas` VALUES( '610830','610800','清涧县','99' ); 
INSERT INTO `w_areas` VALUES( '610831','610800','子洲县','99' ); 
INSERT INTO `w_areas` VALUES( '610901','610900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '610902','610900','汉滨区','99' ); 
INSERT INTO `w_areas` VALUES( '610921','610900','汉阴县','99' ); 
INSERT INTO `w_areas` VALUES( '610922','610900','石泉县','99' ); 
INSERT INTO `w_areas` VALUES( '610923','610900','宁陕县','99' ); 
INSERT INTO `w_areas` VALUES( '610924','610900','紫阳县','99' ); 
INSERT INTO `w_areas` VALUES( '610925','610900','岚皋县','99' ); 
INSERT INTO `w_areas` VALUES( '610926','610900','平利县','99' ); 
INSERT INTO `w_areas` VALUES( '610927','610900','镇坪县','99' ); 
INSERT INTO `w_areas` VALUES( '610928','610900','旬阳县','99' ); 
INSERT INTO `w_areas` VALUES( '610929','610900','白河县','99' ); 
INSERT INTO `w_areas` VALUES( '611001','611000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '611002','611000','商州区','99' ); 
INSERT INTO `w_areas` VALUES( '611021','611000','洛南县','99' ); 
INSERT INTO `w_areas` VALUES( '611022','611000','丹凤县','99' ); 
INSERT INTO `w_areas` VALUES( '611023','611000','商南县','99' ); 
INSERT INTO `w_areas` VALUES( '611024','611000','山阳县','99' ); 
INSERT INTO `w_areas` VALUES( '611025','611000','镇安县','99' ); 
INSERT INTO `w_areas` VALUES( '611026','611000','柞水县','99' ); 
INSERT INTO `w_areas` VALUES( '620101','620100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620102','620100','城关区','99' ); 
INSERT INTO `w_areas` VALUES( '620103','620100','七里河区','99' ); 
INSERT INTO `w_areas` VALUES( '620104','620100','西固区','99' ); 
INSERT INTO `w_areas` VALUES( '620105','620100','安宁区','99' ); 
INSERT INTO `w_areas` VALUES( '620111','620100','红古区','99' ); 
INSERT INTO `w_areas` VALUES( '620121','620100','永登县','99' ); 
INSERT INTO `w_areas` VALUES( '620122','620100','皋兰县','99' ); 
INSERT INTO `w_areas` VALUES( '620123','620100','榆中县','99' ); 
INSERT INTO `w_areas` VALUES( '620201','620200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620301','620300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620302','620300','金川区','99' ); 
INSERT INTO `w_areas` VALUES( '620321','620300','永昌县','99' ); 
INSERT INTO `w_areas` VALUES( '620401','620400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620402','620400','白银区','99' ); 
INSERT INTO `w_areas` VALUES( '620403','620400','平川区','99' ); 
INSERT INTO `w_areas` VALUES( '620421','620400','靖远县','99' ); 
INSERT INTO `w_areas` VALUES( '620422','620400','会宁县','99' ); 
INSERT INTO `w_areas` VALUES( '620423','620400','景泰县','99' ); 
INSERT INTO `w_areas` VALUES( '620501','620500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620502','620500','秦州区','99' ); 
INSERT INTO `w_areas` VALUES( '620503','620500','麦积区','99' ); 
INSERT INTO `w_areas` VALUES( '620521','620500','清水县','99' ); 
INSERT INTO `w_areas` VALUES( '620522','620500','秦安县','99' ); 
INSERT INTO `w_areas` VALUES( '620523','620500','甘谷县','99' ); 
INSERT INTO `w_areas` VALUES( '620524','620500','武山县','99' ); 
INSERT INTO `w_areas` VALUES( '620525','620500','张家川回族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '620601','620600','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620602','620600','凉州区','99' ); 
INSERT INTO `w_areas` VALUES( '620621','620600','民勤县','99' ); 
INSERT INTO `w_areas` VALUES( '620622','620600','古浪县','99' ); 
INSERT INTO `w_areas` VALUES( '620623','620600','天祝藏族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '620701','620700','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620702','620700','甘州区','99' ); 
INSERT INTO `w_areas` VALUES( '620721','620700','肃南裕固族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '620722','620700','民乐县','99' ); 
INSERT INTO `w_areas` VALUES( '620723','620700','临泽县','99' ); 
INSERT INTO `w_areas` VALUES( '620724','620700','高台县','99' ); 
INSERT INTO `w_areas` VALUES( '620725','620700','山丹县','99' ); 
INSERT INTO `w_areas` VALUES( '620801','620800','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620802','620800','崆峒区','99' ); 
INSERT INTO `w_areas` VALUES( '620821','620800','泾川县','99' ); 
INSERT INTO `w_areas` VALUES( '620822','620800','灵台县','99' ); 
INSERT INTO `w_areas` VALUES( '620823','620800','崇信县','99' ); 
INSERT INTO `w_areas` VALUES( '620824','620800','华亭县','99' ); 
INSERT INTO `w_areas` VALUES( '620825','620800','庄浪县','99' ); 
INSERT INTO `w_areas` VALUES( '620826','620800','静宁县','99' ); 
INSERT INTO `w_areas` VALUES( '620901','620900','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '620902','620900','肃州区','99' ); 
INSERT INTO `w_areas` VALUES( '620921','620900','金塔县','99' ); 
INSERT INTO `w_areas` VALUES( '620922','620900','瓜州县','99' ); 
INSERT INTO `w_areas` VALUES( '620923','620900','肃北蒙古族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '620924','620900','阿克塞哈萨克族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '620981','620900','玉门市','99' ); 
INSERT INTO `w_areas` VALUES( '620982','620900','敦煌市','99' ); 
INSERT INTO `w_areas` VALUES( '621001','621000','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '621002','621000','西峰区','99' ); 
INSERT INTO `w_areas` VALUES( '621021','621000','庆城县','99' ); 
INSERT INTO `w_areas` VALUES( '621022','621000','环县','99' ); 
INSERT INTO `w_areas` VALUES( '621023','621000','华池县','99' ); 
INSERT INTO `w_areas` VALUES( '621024','621000','合水县','99' ); 
INSERT INTO `w_areas` VALUES( '621025','621000','正宁县','99' ); 
INSERT INTO `w_areas` VALUES( '621026','621000','宁县','99' ); 
INSERT INTO `w_areas` VALUES( '621027','621000','镇原县','99' ); 
INSERT INTO `w_areas` VALUES( '621101','621100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '621102','621100','安定区','99' ); 
INSERT INTO `w_areas` VALUES( '621121','621100','通渭县','99' ); 
INSERT INTO `w_areas` VALUES( '621122','621100','陇西县','99' ); 
INSERT INTO `w_areas` VALUES( '621123','621100','渭源县','99' ); 
INSERT INTO `w_areas` VALUES( '621124','621100','临洮县','99' ); 
INSERT INTO `w_areas` VALUES( '621125','621100','漳县','99' ); 
INSERT INTO `w_areas` VALUES( '621126','621100','岷县','99' ); 
INSERT INTO `w_areas` VALUES( '621201','621200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '621202','621200','武都区','99' ); 
INSERT INTO `w_areas` VALUES( '621221','621200','成县','99' ); 
INSERT INTO `w_areas` VALUES( '621222','621200','文县','99' ); 
INSERT INTO `w_areas` VALUES( '621223','621200','宕昌县','99' ); 
INSERT INTO `w_areas` VALUES( '621224','621200','康县','99' ); 
INSERT INTO `w_areas` VALUES( '621225','621200','西和县','99' ); 
INSERT INTO `w_areas` VALUES( '621226','621200','礼县','99' ); 
INSERT INTO `w_areas` VALUES( '621227','621200','徽县','99' ); 
INSERT INTO `w_areas` VALUES( '621228','621200','两当县','99' ); 
INSERT INTO `w_areas` VALUES( '622901','622900','临夏市','99' ); 
INSERT INTO `w_areas` VALUES( '622921','622900','临夏县','99' ); 
INSERT INTO `w_areas` VALUES( '622922','622900','康乐县','99' ); 
INSERT INTO `w_areas` VALUES( '622923','622900','永靖县','99' ); 
INSERT INTO `w_areas` VALUES( '622924','622900','广河县','99' ); 
INSERT INTO `w_areas` VALUES( '622925','622900','和政县','99' ); 
INSERT INTO `w_areas` VALUES( '622926','622900','东乡族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '622927','622900','积石山保安族东乡族撒拉族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '623001','623000','合作市','99' ); 
INSERT INTO `w_areas` VALUES( '623021','623000','临潭县','99' ); 
INSERT INTO `w_areas` VALUES( '623022','623000','卓尼县','99' ); 
INSERT INTO `w_areas` VALUES( '623023','623000','舟曲县','99' ); 
INSERT INTO `w_areas` VALUES( '623024','623000','迭部县','99' ); 
INSERT INTO `w_areas` VALUES( '623025','623000','玛曲县','99' ); 
INSERT INTO `w_areas` VALUES( '623026','623000','碌曲县','99' ); 
INSERT INTO `w_areas` VALUES( '623027','623000','夏河县','99' ); 
INSERT INTO `w_areas` VALUES( '630101','630100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '630102','630100','城东区','99' ); 
INSERT INTO `w_areas` VALUES( '630103','630100','城中区','99' ); 
INSERT INTO `w_areas` VALUES( '630104','630100','城西区','99' ); 
INSERT INTO `w_areas` VALUES( '630105','630100','城北区','99' ); 
INSERT INTO `w_areas` VALUES( '630121','630100','大通回族土族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '630122','630100','湟中县','99' ); 
INSERT INTO `w_areas` VALUES( '630123','630100','湟源县','99' ); 
INSERT INTO `w_areas` VALUES( '632121','632100','平安县','99' ); 
INSERT INTO `w_areas` VALUES( '632122','632100','民和回族土族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '632123','632100','乐都县','99' ); 
INSERT INTO `w_areas` VALUES( '632126','632100','互助土族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '632127','632100','化隆回族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '632128','632100','循化撒拉族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '632221','632200','门源回族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '632222','632200','祁连县','99' ); 
INSERT INTO `w_areas` VALUES( '632223','632200','海晏县','99' ); 
INSERT INTO `w_areas` VALUES( '632224','632200','刚察县','99' ); 
INSERT INTO `w_areas` VALUES( '632321','632300','同仁县','99' ); 
INSERT INTO `w_areas` VALUES( '632322','632300','尖扎县','99' ); 
INSERT INTO `w_areas` VALUES( '632323','632300','泽库县','99' ); 
INSERT INTO `w_areas` VALUES( '632324','632300','河南蒙古族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '632521','632500','共和县','99' ); 
INSERT INTO `w_areas` VALUES( '632522','632500','同德县','99' ); 
INSERT INTO `w_areas` VALUES( '632523','632500','贵德县','99' ); 
INSERT INTO `w_areas` VALUES( '632524','632500','兴海县','99' ); 
INSERT INTO `w_areas` VALUES( '632525','632500','贵南县','99' ); 
INSERT INTO `w_areas` VALUES( '632621','632600','玛沁县','99' ); 
INSERT INTO `w_areas` VALUES( '632622','632600','班玛县','99' ); 
INSERT INTO `w_areas` VALUES( '632623','632600','甘德县','99' ); 
INSERT INTO `w_areas` VALUES( '632624','632600','达日县','99' ); 
INSERT INTO `w_areas` VALUES( '632625','632600','久治县','99' ); 
INSERT INTO `w_areas` VALUES( '632626','632600','玛多县','99' ); 
INSERT INTO `w_areas` VALUES( '632721','632700','玉树县','99' ); 
INSERT INTO `w_areas` VALUES( '632722','632700','杂多县','99' ); 
INSERT INTO `w_areas` VALUES( '632723','632700','称多县','99' ); 
INSERT INTO `w_areas` VALUES( '632724','632700','治多县','99' ); 
INSERT INTO `w_areas` VALUES( '632725','632700','囊谦县','99' ); 
INSERT INTO `w_areas` VALUES( '632726','632700','曲麻莱县','99' ); 
INSERT INTO `w_areas` VALUES( '632801','632800','格尔木市','99' ); 
INSERT INTO `w_areas` VALUES( '632802','632800','德令哈市','99' ); 
INSERT INTO `w_areas` VALUES( '632821','632800','乌兰县','99' ); 
INSERT INTO `w_areas` VALUES( '632822','632800','都兰县','99' ); 
INSERT INTO `w_areas` VALUES( '632823','632800','天峻县','99' ); 
INSERT INTO `w_areas` VALUES( '640101','640100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '640104','640100','兴庆区','99' ); 
INSERT INTO `w_areas` VALUES( '640105','640100','西夏区','99' ); 
INSERT INTO `w_areas` VALUES( '640106','640100','金凤区','99' ); 
INSERT INTO `w_areas` VALUES( '640121','640100','永宁县','99' ); 
INSERT INTO `w_areas` VALUES( '640122','640100','贺兰县','99' ); 
INSERT INTO `w_areas` VALUES( '640181','640100','灵武市','99' ); 
INSERT INTO `w_areas` VALUES( '640201','640200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '640202','640200','大武口区','99' ); 
INSERT INTO `w_areas` VALUES( '640205','640200','惠农区','99' ); 
INSERT INTO `w_areas` VALUES( '640221','640200','平罗县','99' ); 
INSERT INTO `w_areas` VALUES( '640301','640300','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '640302','640300','利通区','99' ); 
INSERT INTO `w_areas` VALUES( '640303','640300','红寺堡区','99' ); 
INSERT INTO `w_areas` VALUES( '640323','640300','盐池县','99' ); 
INSERT INTO `w_areas` VALUES( '640324','640300','同心县','99' ); 
INSERT INTO `w_areas` VALUES( '640381','640300','青铜峡市','99' ); 
INSERT INTO `w_areas` VALUES( '640401','640400','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '640402','640400','原州区','99' ); 
INSERT INTO `w_areas` VALUES( '640422','640400','西吉县','99' ); 
INSERT INTO `w_areas` VALUES( '640423','640400','隆德县','99' ); 
INSERT INTO `w_areas` VALUES( '640424','640400','泾源县','99' ); 
INSERT INTO `w_areas` VALUES( '640425','640400','彭阳县','99' ); 
INSERT INTO `w_areas` VALUES( '640501','640500','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '640502','640500','沙坡头区','99' ); 
INSERT INTO `w_areas` VALUES( '640521','640500','中宁县','99' ); 
INSERT INTO `w_areas` VALUES( '640522','640500','海原县','99' ); 
INSERT INTO `w_areas` VALUES( '650101','650100','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '650102','650100','天山区','99' ); 
INSERT INTO `w_areas` VALUES( '650103','650100','沙依巴克区','99' ); 
INSERT INTO `w_areas` VALUES( '650104','650100','新市区','99' ); 
INSERT INTO `w_areas` VALUES( '650105','650100','水磨沟区','99' ); 
INSERT INTO `w_areas` VALUES( '650106','650100','头屯河区','99' ); 
INSERT INTO `w_areas` VALUES( '650107','650100','达坂城区','99' ); 
INSERT INTO `w_areas` VALUES( '650109','650100','米东区','99' ); 
INSERT INTO `w_areas` VALUES( '650121','650100','乌鲁木齐县','99' ); 
INSERT INTO `w_areas` VALUES( '650201','650200','市辖区','99' ); 
INSERT INTO `w_areas` VALUES( '650202','650200','独山子区','99' ); 
INSERT INTO `w_areas` VALUES( '650203','650200','克拉玛依区','99' ); 
INSERT INTO `w_areas` VALUES( '650204','650200','白碱滩区','99' ); 
INSERT INTO `w_areas` VALUES( '650205','650200','乌尔禾区','99' ); 
INSERT INTO `w_areas` VALUES( '652101','652100','吐鲁番市','99' ); 
INSERT INTO `w_areas` VALUES( '652122','652100','鄯善县','99' ); 
INSERT INTO `w_areas` VALUES( '652123','652100','托克逊县','99' ); 
INSERT INTO `w_areas` VALUES( '652201','652200','哈密市','99' ); 
INSERT INTO `w_areas` VALUES( '652222','652200','巴里坤哈萨克自治县','99' ); 
INSERT INTO `w_areas` VALUES( '652223','652200','伊吾县','99' ); 
INSERT INTO `w_areas` VALUES( '652301','652300','昌吉市','99' ); 
INSERT INTO `w_areas` VALUES( '652302','652300','阜康市','99' ); 
INSERT INTO `w_areas` VALUES( '652323','652300','呼图壁县','99' ); 
INSERT INTO `w_areas` VALUES( '652324','652300','玛纳斯县','99' ); 
INSERT INTO `w_areas` VALUES( '652325','652300','奇台县','99' ); 
INSERT INTO `w_areas` VALUES( '652327','652300','吉木萨尔县','99' ); 
INSERT INTO `w_areas` VALUES( '652328','652300','木垒哈萨克自治县','99' ); 
INSERT INTO `w_areas` VALUES( '652701','652700','博乐市','99' ); 
INSERT INTO `w_areas` VALUES( '652722','652700','精河县','99' ); 
INSERT INTO `w_areas` VALUES( '652723','652700','温泉县','99' ); 
INSERT INTO `w_areas` VALUES( '652801','652800','库尔勒市','99' ); 
INSERT INTO `w_areas` VALUES( '652822','652800','轮台县','99' ); 
INSERT INTO `w_areas` VALUES( '652823','652800','尉犁县','99' ); 
INSERT INTO `w_areas` VALUES( '652824','652800','若羌县','99' ); 
INSERT INTO `w_areas` VALUES( '652825','652800','且末县','99' ); 
INSERT INTO `w_areas` VALUES( '652826','652800','焉耆回族自治县','99' ); 
INSERT INTO `w_areas` VALUES( '652827','652800','和静县','99' ); 
INSERT INTO `w_areas` VALUES( '652828','652800','和硕县','99' ); 
INSERT INTO `w_areas` VALUES( '652829','652800','博湖县','99' ); 
INSERT INTO `w_areas` VALUES( '652901','652900','阿克苏市','99' ); 
INSERT INTO `w_areas` VALUES( '652922','652900','温宿县','99' ); 
INSERT INTO `w_areas` VALUES( '652923','652900','库车县','99' ); 
INSERT INTO `w_areas` VALUES( '652924','652900','沙雅县','99' ); 
INSERT INTO `w_areas` VALUES( '652925','652900','新和县','99' ); 
INSERT INTO `w_areas` VALUES( '652926','652900','拜城县','99' ); 
INSERT INTO `w_areas` VALUES( '652927','652900','乌什县','99' ); 
INSERT INTO `w_areas` VALUES( '652928','652900','阿瓦提县','99' ); 
INSERT INTO `w_areas` VALUES( '652929','652900','柯坪县','99' ); 
INSERT INTO `w_areas` VALUES( '653001','653000','阿图什市','99' ); 
INSERT INTO `w_areas` VALUES( '653022','653000','阿克陶县','99' ); 
INSERT INTO `w_areas` VALUES( '653023','653000','阿合奇县','99' ); 
INSERT INTO `w_areas` VALUES( '653024','653000','乌恰县','99' ); 
INSERT INTO `w_areas` VALUES( '653101','653100','喀什市','99' ); 
INSERT INTO `w_areas` VALUES( '653121','653100','疏附县','99' ); 
INSERT INTO `w_areas` VALUES( '653122','653100','疏勒县','99' ); 
INSERT INTO `w_areas` VALUES( '653123','653100','英吉沙县','99' ); 
INSERT INTO `w_areas` VALUES( '653124','653100','泽普县','99' ); 
INSERT INTO `w_areas` VALUES( '653125','653100','莎车县','99' ); 
INSERT INTO `w_areas` VALUES( '653126','653100','叶城县','99' ); 
INSERT INTO `w_areas` VALUES( '653127','653100','麦盖提县','99' ); 
INSERT INTO `w_areas` VALUES( '653128','653100','岳普湖县','99' ); 
INSERT INTO `w_areas` VALUES( '653129','653100','伽师县','99' ); 
INSERT INTO `w_areas` VALUES( '653130','653100','巴楚县','99' ); 
INSERT INTO `w_areas` VALUES( '653131','653100','塔什库尔干塔吉克自治县','99' ); 
INSERT INTO `w_areas` VALUES( '653201','653200','和田市','99' ); 
INSERT INTO `w_areas` VALUES( '653221','653200','和田县','99' ); 
INSERT INTO `w_areas` VALUES( '653222','653200','墨玉县','99' ); 
INSERT INTO `w_areas` VALUES( '653223','653200','皮山县','99' ); 
INSERT INTO `w_areas` VALUES( '653224','653200','洛浦县','99' ); 
INSERT INTO `w_areas` VALUES( '653225','653200','策勒县','99' ); 
INSERT INTO `w_areas` VALUES( '653226','653200','于田县','99' ); 
INSERT INTO `w_areas` VALUES( '653227','653200','民丰县','99' ); 
INSERT INTO `w_areas` VALUES( '654002','654000','伊宁市','99' ); 
INSERT INTO `w_areas` VALUES( '654003','654000','奎屯市','99' ); 
INSERT INTO `w_areas` VALUES( '654021','654000','伊宁县','99' ); 
INSERT INTO `w_areas` VALUES( '654022','654000','察布查尔锡伯自治县','99' ); 
INSERT INTO `w_areas` VALUES( '654023','654000','霍城县','99' ); 
INSERT INTO `w_areas` VALUES( '654024','654000','巩留县','99' ); 
INSERT INTO `w_areas` VALUES( '654025','654000','新源县','99' ); 
INSERT INTO `w_areas` VALUES( '654026','654000','昭苏县','99' ); 
INSERT INTO `w_areas` VALUES( '654027','654000','特克斯县','99' ); 
INSERT INTO `w_areas` VALUES( '654028','654000','尼勒克县','99' ); 
INSERT INTO `w_areas` VALUES( '654201','654200','塔城市','99' ); 
INSERT INTO `w_areas` VALUES( '654202','654200','乌苏市','99' ); 
INSERT INTO `w_areas` VALUES( '654221','654200','额敏县','99' ); 
INSERT INTO `w_areas` VALUES( '654223','654200','沙湾县','99' ); 
INSERT INTO `w_areas` VALUES( '654224','654200','托里县','99' ); 
INSERT INTO `w_areas` VALUES( '654225','654200','裕民县','99' ); 
INSERT INTO `w_areas` VALUES( '654226','654200','和布克赛尔蒙古自治县','99' ); 
INSERT INTO `w_areas` VALUES( '654301','654300','阿勒泰市','99' ); 
INSERT INTO `w_areas` VALUES( '654321','654300','布尔津县','99' ); 
INSERT INTO `w_areas` VALUES( '654322','654300','富蕴县','99' ); 
INSERT INTO `w_areas` VALUES( '654323','654300','福海县','99' ); 
INSERT INTO `w_areas` VALUES( '654324','654300','哈巴河县','99' ); 
INSERT INTO `w_areas` VALUES( '654325','654300','青河县','99' ); 
INSERT INTO `w_areas` VALUES( '654326','654300','吉木乃县','99' ); 
INSERT INTO `w_areas` VALUES( '659001','659000','石河子市','99' ); 
INSERT INTO `w_areas` VALUES( '659002','659000','阿拉尔市','99' ); 
INSERT INTO `w_areas` VALUES( '659003','659000','图木舒克市','99' ); 
INSERT INTO `w_areas` VALUES( '441901','441900','莞城区','99' ); 
INSERT INTO `w_areas` VALUES( '441902','441900','南城区','99' ); 
INSERT INTO `w_areas` VALUES( '441903','441900','万江区','99' ); 
INSERT INTO `w_areas` VALUES( '441904','441900','东城区','99' ); 
INSERT INTO `w_areas` VALUES( '659004','659000','五家渠市','99' ); 
DROP TABLE IF EXISTS `w_article`;
 CREATE TABLE `w_article` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`title` varchar(250) NOT NULL  COMMENT '标题',
`content` text NOT NULL  COMMENT '内容',
`category_id` int(11) unsigned NOT NULL  COMMENT '分类ID',
`create_time` datetime NOT NULL  COMMENT '发布时间',
`keywords` varchar(255) NULL  DEFAULT NULL  COMMENT '关键词',
`description` varchar(255) NULL  DEFAULT NULL  COMMENT '描述',
`visibility` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '是否显示 0:不显示,1:显示',
`top` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '置顶',
`sort` int(11) NOT NULL  DEFAULT 0 COMMENT '排序',
`style` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '标题字体 0正常 1粗体,2斜体',
`color` varchar(7) NULL  DEFAULT NULL  COMMENT '标题颜色'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='文章表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_article_category`;
 CREATE TABLE `w_article_category` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(50) NOT NULL  COMMENT '分类名称',
`parent_id` int(11) unsigned NOT NULL  DEFAULT 0 COMMENT '父分类',
`issys` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '系统分类',
`sort` int(11) NOT NULL  DEFAULT 0 COMMENT '排序',
`path` varchar(255) NULL  DEFAULT NULL  COMMENT '路径'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='文章分类' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_attribute`;
 CREATE TABLE `w_attribute` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '属性ID',
`model_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '模型ID',
`type` tinyint(1) NULL  DEFAULT NULL  COMMENT '输入控件的类型,1:单选,2:复选,3:下拉',
`name` varchar(50) NULL  DEFAULT NULL  COMMENT '名称',
`value` text NULL  DEFAULT NULL  COMMENT '属性值(逗号分隔)',
`search` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否支持搜索0不支持1支持'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='属性表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_brand`;
 CREATE TABLE `w_brand` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '品牌ID',
`name` varchar(255) NOT NULL  COMMENT '品牌名称',
`logo` varchar(255) NULL  DEFAULT NULL  COMMENT 'logo地址',
`url` varchar(255) NULL  DEFAULT NULL  COMMENT '网址',
`description` text NULL  DEFAULT NULL  COMMENT '描述',
`sort` smallint(5) NOT NULL  DEFAULT 0 COMMENT '排序',
`category_ids` varchar(255) NULL  DEFAULT NULL  COMMENT '品牌分类分类,逗号分割id '
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='品牌表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_brand_category`;
 CREATE TABLE `w_brand_category` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '分类ID',
`name` varchar(255) NOT NULL  COMMENT '分类名称'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='品牌分类表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_category`;
 CREATE TABLE `w_category` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '分类ID',
`name` varchar(50) NOT NULL  COMMENT '分类名称',
`parent_id` int(11) unsigned NOT NULL  COMMENT '父分类ID',
`sort` smallint(5) NOT NULL  DEFAULT 0 COMMENT '排序',
`visibility` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '首页是否显示 1显示 0 不显示',
`model_id` int(11) unsigned NOT NULL  COMMENT '默认模型ID',
`keywords` varchar(255) NULL  DEFAULT NULL  COMMENT 'SEO 关键词',
`descript` varchar(255) NULL  DEFAULT NULL  COMMENT 'SEO 描述',
`title` varchar(255) NULL  DEFAULT NULL  COMMENT 'SEO 标题 title'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='产品分类表' AUTO_INCREMENT=7;

INSERT INTO `w_category` VALUES( '1','手机','0','0','1','0','','','' ); 
INSERT INTO `w_category` VALUES( '3','大家电','0','0','1','0','','','' ); 
INSERT INTO `w_category` VALUES( '4','平板电视','3','0','1','0','','','' ); 
INSERT INTO `w_category` VALUES( '5','空调','3','0','1','0','','','' ); 
INSERT INTO `w_category` VALUES( '6','冰箱','3','0','1','0','','','' ); 
DROP TABLE IF EXISTS `w_category_extend`;
 CREATE TABLE `w_category_extend` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID',
`category_id` int(11) unsigned NOT NULL  COMMENT '商品分类ID'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='商品扩展分类表' AUTO_INCREMENT=2;

INSERT INTO `w_category_extend` VALUES( '1','1','1' ); 
DROP TABLE IF EXISTS `w_collection_doc`;
 CREATE TABLE `w_collection_doc` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`order_id` int(11) unsigned NOT NULL  COMMENT '订单号',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`amount` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '金额',
`time` datetime NOT NULL  COMMENT '时间',
`payment_id` int(11) NOT NULL  COMMENT '支付方式ID',
`admin_id` int(11) NULL  DEFAULT NULL  COMMENT '管理员id',
`pay_status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '支付状态，0:准备，1:支付成功',
`note` text NULL  DEFAULT NULL  COMMENT '收款备注',
`if_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0:未删除 1:删除'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='收款单' AUTO_INCREMENT=3;

INSERT INTO `w_collection_doc` VALUES( '1','1','1','3318.90','2014-06-04 10:57:40','7','1','1','','1' ); 
INSERT INTO `w_collection_doc` VALUES( '2','2','1','3019.00','2014-06-04 11:02:46','7','1','1','','0' ); 
DROP TABLE IF EXISTS `w_commend_goods`;
 CREATE TABLE `w_commend_goods` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`commend_id` int(11) unsigned NOT NULL  COMMENT '推荐类型ID 1:最新商品 2:特价商品 3:热卖排行 4:推荐商品',
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='推荐类商品' AUTO_INCREMENT=3;

INSERT INTO `w_commend_goods` VALUES( '2','1','1' ); 
DROP TABLE IF EXISTS `w_comment`;
 CREATE TABLE `w_comment` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID',
`order_no` varchar(20) NOT NULL  COMMENT '订单编号',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`time` datetime NOT NULL  COMMENT '购买时间',
`comment_time` date NOT NULL  COMMENT '评论时间',
`contents` text NULL  DEFAULT NULL  COMMENT '评论内容',
`point` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '评论的分数',
`status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '评论状态：0：未评论 1:已评论'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='商品评论表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_delivery`;
 CREATE TABLE `w_delivery` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(50) NULL  DEFAULT NULL  COMMENT '快递名称',
`description` varchar(50) NULL  DEFAULT NULL  COMMENT '快递描述',
`area_groupid` text NULL  DEFAULT NULL  COMMENT '配送区域id',
`firstprice` text NULL  DEFAULT NULL  COMMENT '配送地址对应的首重价格',
`secondprice` text NULL  DEFAULT NULL  COMMENT '配送地区对应的续重价格',
`type` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '配送类型 0先付款后发货 1先发货后付款',
`first_weight` int(11) unsigned NOT NULL  COMMENT '首重重量(克)',
`second_weight` int(11) unsigned NOT NULL  COMMENT '续重重量(克)',
`first_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '首重价格',
`second_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '续重价格',
`status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '开启状态',
`sort` smallint(5) NOT NULL  DEFAULT 99 COMMENT '排序',
`is_save_price` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否支持物流保价 1支持保价 0  不支持保价',
`save_rate` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '保价费率',
`low_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '最低保价',
`price_type` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '费用类型 0统一设置 1指定地区费用',
`open_default` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '启用默认费用 1启用 0 不启用',
`is_delete` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否删除 0:未删除 1:删除',
`freight_id` int(11) unsigned NOT NULL  COMMENT '货运公司ID'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='配送方式表' AUTO_INCREMENT=2;

INSERT INTO `w_delivery` VALUES( '1','快递','直接由第三方物流公司配送','N;','N;','N;','0','1000','1000','20.00','20.00','1','0','0','0.00','0.00','0','0','0','1' ); 
DROP TABLE IF EXISTS `w_delivery_doc`;
 CREATE TABLE `w_delivery_doc` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '发货单ID',
`order_id` int(11) unsigned NOT NULL  COMMENT '订单ID',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`admin_id` int(11) unsigned NOT NULL  COMMENT '管理员ID',
`name` varchar(255) NOT NULL  COMMENT '收货人',
`postcode` varchar(6) NULL  DEFAULT NULL  COMMENT '邮编',
`telphone` varchar(20) NULL  DEFAULT NULL  COMMENT '联系电话',
`country` int(11) unsigned NULL  DEFAULT NULL  COMMENT '国ID',
`province` int(11) unsigned NOT NULL  COMMENT '省ID',
`city` int(11) unsigned NOT NULL  COMMENT '市ID',
`area` int(11) unsigned NOT NULL  COMMENT '区ID',
`address` varchar(250) NOT NULL  COMMENT '收货地址',
`mobile` varchar(20) NULL  DEFAULT NULL  COMMENT '手机',
`time` datetime NOT NULL  COMMENT '创建时间',
`freight` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '运费',
`delivery_code` varchar(255) NOT NULL  COMMENT '物流单号',
`delivery_type` varchar(255) NOT NULL  COMMENT '物流方式',
`note` text NULL  DEFAULT NULL  COMMENT '管理员添加的备注信息',
`if_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0:未删除 1:已删除'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='发货单' AUTO_INCREMENT=2;

INSERT INTO `w_delivery_doc` VALUES( '1','2','1','1','陈家龙','518000','','','440000','440100','440114','龙岗区布吉','15817487535','2014-06-04 11:03:40','20.00','','1','','0' ); 
DROP TABLE IF EXISTS `w_delivery_goods`;
 CREATE TABLE `w_delivery_goods` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`delivery_id` int(11) unsigned NOT NULL  COMMENT '发货单ID',
`goods_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '商品ID',
`product_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '货品id',
`goods_nums` int(11) NULL  DEFAULT NULL  COMMENT '货品数量',
`time` datetime NOT NULL  COMMENT '时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='发货清单' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_discussion`;
 CREATE TABLE `w_discussion` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`time` datetime NOT NULL  COMMENT '评论时间',
`contents` text NULL  DEFAULT NULL  COMMENT '评论内容',
`is_check` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '审核状态,0未审核 1已审核'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='商品讨论表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_email_registry`;
 CREATE TABLE `w_email_registry` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`email` varchar(80) NOT NULL  UNIQUE KEY  COMMENT 'Email'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='Email订阅表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_expresswaybill`;
 CREATE TABLE `w_expresswaybill` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(80) NOT NULL  COMMENT '快递单模板名字',
`config` text NULL  DEFAULT NULL  COMMENT '序列化的快递单结构数据',
`background` varchar(255) NULL  DEFAULT NULL  COMMENT '背景图片路径',
`width` smallint(5) unsigned NULL  DEFAULT 900 COMMENT '背景图片路径',
`height` smallint(5) unsigned NULL  DEFAULT 600 COMMENT '背景图片路径',
`is_close` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '状态 1关闭,0正常'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='快递单模板' AUTO_INCREMENT=6;

INSERT INTO `w_expresswaybill` VALUES( '1','EMS特快专递','a:12:{i:1;s:222:\"{\"x\":461,\"y\":350,\"typeId\":\"date_y\",\"typeText\":\"当前日期-年\",\"width\":33,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":18}\";i:5;s:227:\"{\"x\":70,\"y\":184,\"typeId\":\"dly_address\",\"typeText\":\"发货人-地址\",\"width\":318,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":54}\";i:6;s:224:\"{\"x\":271,\"y\":117,\"typeId\":\"dly_tel\",\"typeText\":\"发货人-电话\",\"width\":119,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":20}\";i:10;s:225:\"{\"x\":642,\"y\":237,\"typeId\":\"ship_zip\",\"typeText\":\"收货人-邮编\",\"width\":109,\"styleSheet\":{\"trackingLeft\":\"9\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":19}\";i:11;s:228:\"{\"x\":625,\"y\":117,\"typeId\":\"ship_mobile\",\"typeText\":\"收货人-手机\",\"width\":126,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":21}\";i:0;s:222:\"{\"x\":510,\"y\":348,\"typeId\":\"date_m\",\"typeText\":\"当前日期-月\",\"width\":29,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":21}\";i:9;s:224:\"{\"x\":458,\"y\":370,\"typeId\":\"order_memo\",\"typeText\":\"订单-备注\",\"width\":292,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":30}\";i:4;s:224:\"{\"x\":122,\"y\":120,\"typeId\":\"dly_name\",\"typeText\":\"发货人-姓名\",\"width\":94,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":24}\";i:8;s:223:\"{\"x\":301,\"y\":238,\"typeId\":\"dly_zip\",\"typeText\":\"发货人-邮编\",\"width\":99,\"styleSheet\":{\"trackingLeft\":\"9\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":19}\";i:3;s:246:\"{\"x\":409,\"y\":184,\"typeId\":\"ship_detail_addr\",\"typeText\":\"收货人-地区+详细地址\",\"width\":343,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":55}\";i:2;s:226:\"{\"x\":462,\"y\":117,\"typeId\":\"ship_name\",\"typeText\":\"收货人-姓名\",\"width\":104,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":27}\";i:7;s:222:\"{\"x\":559,\"y\":348,\"typeId\":\"date_d\",\"typeText\":\"当前日期-日\",\"width\":30,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":21}\";}','upload/2011/11/30/20111130103004185.jpg','900','500','0' ); 
INSERT INTO `w_expresswaybill` VALUES( '2','顺丰速运','a:12:{i:1;s:224:\"{\"x\":265,\"y\":104,\"typeId\":\"dly_name\",\"typeText\":\"发货人-姓名\",\"width\":74,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":22}\";i:3;s:222:\"{\"x\":549,\"y\":314,\"typeId\":\"date_m\",\"typeText\":\"当前日期-月\",\"width\":32,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":22}\";i:0;s:224:\"{\"x\":522,\"y\":426,\"typeId\":\"order_memo\",\"typeText\":\"订单-备注\",\"width\":182,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":35}\";i:6;s:224:\"{\"x\":54,\"y\":337,\"typeId\":\"ship_tel\",\"typeText\":\"收货人-电话\",\"width\":143,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":17}\";i:11;s:227:\"{\"x\":207,\"y\":188,\"typeId\":\"dly_mobile\",\"typeText\":\"发货人-手机\",\"width\":129,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":18}\";i:4;s:245:\"{\"x\":55,\"y\":271,\"typeId\":\"ship_detail_addr\",\"typeText\":\"收货人-地区+详细地址\",\"width\":284,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":56}\";i:5;s:228:\"{\"x\":376,\"y\":118,\"typeId\":\"ship_time\",\"typeText\":\"订单-送货时间\",\"width\":52,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":22}\";i:10;s:228:\"{\"x\":207,\"y\":336,\"typeId\":\"ship_mobile\",\"typeText\":\"收货人-手机\",\"width\":132,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":18}\";i:7;s:227:\"{\"x\":82,\"y\":132,\"typeId\":\"dly_address\",\"typeText\":\"发货人-地址\",\"width\":255,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":52}\";i:8;s:225:\"{\"x\":267,\"y\":219,\"typeId\":\"ship_name\",\"typeText\":\"收货人-姓名\",\"width\":72,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":23}\";i:2;s:223:\"{\"x\":51,\"y\":190,\"typeId\":\"dly_tel\",\"typeText\":\"发货人-电话\",\"width\":152,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":18}\";i:9;s:222:\"{\"x\":585,\"y\":314,\"typeId\":\"date_d\",\"typeText\":\"当前日期-日\",\"width\":33,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":20}\";}','upload/2011/11/30/20111130110521690.jpg','900','550','0' ); 
INSERT INTO `w_expresswaybill` VALUES( '3','申通快递','a:9:{i:1;s:222:\"{\"typeId\":\"date_d\",\"x\":153,\"typeText\":\"当前日期-日\",\"y\":389,\"width\":22,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":20}\";i:6;s:221:\"{\"typeId\":\"date_y\",\"x\":67,\"typeText\":\"当前日期-年\",\"y\":391,\"width\":35,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":22}\";i:8;s:224:\"{\"typeId\":\"dly_name\",\"x\":121,\"typeText\":\"发货人-姓名\",\"y\":97,\"width\":114,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":28}\";i:3;s:228:\"{\"typeId\":\"dly_address\",\"x\":114,\"typeText\":\"发货人-地址\",\"y\":167,\"width\":296,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":75}\";i:2;s:227:\"{\"typeId\":\"dly_mobile\",\"x\":140,\"typeText\":\"发货人-手机\",\"y\":240,\"width\":270,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":24}\";i:4;s:222:\"{\"typeId\":\"date_m\",\"x\":113,\"typeText\":\"当前日期-月\",\"y\":391,\"width\":24,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":18}\";i:5;s:228:\"{\"typeId\":\"ship_mobile\",\"x\":508,\"typeText\":\"收货人-手机\",\"y\":241,\"width\":274,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":21}\";i:0;s:225:\"{\"typeId\":\"ship_name\",\"x\":487,\"typeText\":\"收货人-姓名\",\"y\":95,\"width\":115,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":29}\";i:7;s:246:\"{\"typeId\":\"ship_detail_addr\",\"x\":474,\"typeText\":\"收货人-地区+详细地址\",\"y\":167,\"width\":310,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":72}\";}','upload/2011/11/30/20111130111842435.jpg','900','520','0' ); 
INSERT INTO `w_expresswaybill` VALUES( '4','宅急送','a:13:{i:2;s:225:\"{\"typeId\":\"ship_tel\",\"x\":429,\"typeText\":\"收货人-电话\",\"y\":234,\"width\":139,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":24}\";i:8;s:226:\"{\"typeId\":\"ship_name\",\"x\":456,\"typeText\":\"收货人-姓名\",\"y\":120,\"width\":123,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":31}\";i:1;s:227:\"{\"typeId\":\"dly_mobile\",\"x\":254,\"typeText\":\"发货人-手机\",\"y\":237,\"width\":130,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":25}\";i:11;s:225:\"{\"typeId\":\"dly_name\",\"x\":114,\"typeText\":\"发货人-姓名\",\"y\":123,\"width\":120,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":28}\";i:10;s:222:\"{\"typeId\":\"date_d\",\"x\":120,\"typeText\":\"当前日期-日\",\"y\":438,\"width\":23,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":16}\";i:6;s:223:\"{\"typeId\":\"dly_tel\",\"x\":90,\"typeText\":\"发货人-电话\",\"y\":235,\"width\":132,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":26}\";i:9;s:231:\"{\"typeId\":\"dly_area_1\",\"x\":255,\"typeText\":\"发货人-地区2级\",\"y\":123,\"width\":127,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":27}\";i:12;s:246:\"{\"typeId\":\"ship_detail_addr\",\"x\":428,\"typeText\":\"收货人-地区+详细地址\",\"y\":151,\"width\":294,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":57}\";i:3;s:231:\"{\"typeId\":\"dly_area_1\",\"x\":599,\"typeText\":\"发货人-地区2级\",\"y\":122,\"width\":123,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":29}\";i:5;s:221:\"{\"typeId\":\"date_m\",\"x\":90,\"typeText\":\"当前日期-月\",\"y\":438,\"width\":27,\"styleSheet\":{\"fontWeight\":\"normal\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"trackingLeft\":\"0\"},\"height\":17}\";i:4;s:224:\"{\"typeId\":\"order_memo\",\"x\":445,\"typeText\":\"订单-备注\",\"y\":364,\"width\":166,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":32}\";i:7;s:228:\"{\"typeId\":\"ship_mobile\",\"x\":585,\"typeText\":\"收货人-手机\",\"y\":234,\"width\":136,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":22}\";i:0;s:227:\"{\"typeId\":\"dly_address\",\"x\":86,\"typeText\":\"发货人-地址\",\"y\":154,\"width\":286,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":55}\";}','upload/2011/11/30/20111130112722985.jpg','900','520','0' ); 
INSERT INTO `w_expresswaybill` VALUES( '5','中通速递','a:11:{i:2;s:224:\"{\"typeId\":\"order_memo\",\"x\":372,\"typeText\":\"订单-备注\",\"y\":369,\"width\":145,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":34}\";i:10;s:222:\"{\"typeId\":\"date_d\",\"x\":159,\"typeText\":\"当前日期-日\",\"y\":379,\"width\":24,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":17}\";i:7;s:228:\"{\"typeId\":\"dly_address\",\"x\":130,\"typeText\":\"发货人-地址\",\"y\":137,\"width\":259,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":59}\";i:4;s:222:\"{\"typeId\":\"date_m\",\"x\":118,\"typeText\":\"当前日期-月\",\"y\":379,\"width\":34,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":19}\";i:0;s:225:\"{\"typeId\":\"dly_name\",\"x\":129,\"typeText\":\"发货人-姓名\",\"y\":103,\"width\":101,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":25}\";i:8;s:226:\"{\"typeId\":\"ship_name\",\"x\":476,\"typeText\":\"收货人-姓名\",\"y\":103,\"width\":110,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":22}\";i:6;s:224:\"{\"typeId\":\"dly_tel\",\"x\":122,\"typeText\":\"发货人-电话\",\"y\":242,\"width\":125,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":27}\";i:9;s:225:\"{\"typeId\":\"ship_zip\",\"x\":642,\"typeText\":\"收货人-邮编\",\"y\":244,\"width\":106,\"styleSheet\":{\"trackingLeft\":\"9\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":23}\";i:1;s:246:\"{\"typeId\":\"ship_detail_addr\",\"x\":476,\"typeText\":\"收货人-地区+详细地址\",\"y\":134,\"width\":262,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":61}\";i:5;s:224:\"{\"typeId\":\"dly_zip\",\"x\":291,\"typeText\":\"发货人-邮编\",\"y\":243,\"width\":103,\"styleSheet\":{\"trackingLeft\":\"9\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":27}\";i:3;s:228:\"{\"typeId\":\"ship_mobile\",\"x\":464,\"typeText\":\"收货人-手机\",\"y\":241,\"width\":142,\"styleSheet\":{\"trackingLeft\":\"0\",\"fontSize\":\"12\",\"fontStyle\":\"normal\",\"fontFamily\":\"宋体\",\"textAlign\":\"left\",\"fontWeight\":\"normal\"},\"height\":30}\";}','upload/2011/11/30/20111130113535527.jpg','900','520','0' ); 
DROP TABLE IF EXISTS `w_favorite`;
 CREATE TABLE `w_favorite` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`rid` int(11) unsigned NOT NULL  COMMENT '商品ID',
`time` datetime NOT NULL  COMMENT '收藏时间',
`summary` varchar(255) NULL  DEFAULT NULL  COMMENT '备注',
`cat_id` int(11) unsigned NOT NULL  COMMENT '商品分类'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='收藏夹表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_find_password`;
 CREATE TABLE `w_find_password` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`hash` char(32) NOT NULL  COMMENT 'hash值',
`addtime` int(11) NOT NULL  COMMENT '申请找回的时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='找回密码' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_freight_company`;
 CREATE TABLE `w_freight_company` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`freight_type` varchar(255) NOT NULL  COMMENT '货运类型',
`freight_name` varchar(255) NOT NULL  COMMENT '货运公司名称',
`url` varchar(255) NOT NULL  COMMENT '网址',
`sort` smallint(5) NOT NULL  DEFAULT 99 COMMENT '排序',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0未删除1删除'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='货运公司' AUTO_INCREMENT=21;

INSERT INTO `w_freight_company` VALUES( '1','CNEMS','中国邮政','http://www.ems.com.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '2','CNST','申通快递','http://www.sto.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '3','CNTT','天天快递','http://www.ttkd.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '4','CNYT','圆通速递','http://www.yto.net.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '5','CNSF','顺丰速运','http://www.sf-express.com','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '6','CNYD','韵达快递','http://www.yundaex.com','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '7','CNZT','中通速递','http://www.zto.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '8','CNLB','龙邦物流','http://www.lbex.com.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '9','CNZJS','宅急送','http://www.zjs.com.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '10','CNQY','全一快递','http://www.apex100.com','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '11','CNHT','汇通速递','http://www.htky365.com','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '12','CNMH','民航快递','http://www.cae.com.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '13','CNYF','亚风速递','http://www.airfex.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '14','CNKJ','快捷速递','http://www.fastexpress.com.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '15','DDS','DDS快递','http://www.qc-dds.net','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '16','CNHY','华宇物流','http://www.hoau.net','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '17','CNZY','中铁快运','http://www.cre.cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '18','FEDEX','FedEx','http://www.fedex.com/cn','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '19','UPS','UPS','http://www.ups.com','0','0' ); 
INSERT INTO `w_freight_company` VALUES( '20','DHL','DHL','http://www.cn.dhl.com','0','0' ); 
DROP TABLE IF EXISTS `w_goods`;
 CREATE TABLE `w_goods` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '商品ID',
`name` varchar(50) NOT NULL  COMMENT '商品名称',
`goods_no` varchar(20) NOT NULL  COMMENT '商品的货号',
`model_id` int(11) unsigned NOT NULL  COMMENT '模型ID',
`sell_price` decimal(15,2) NOT NULL  COMMENT '销售价格',
`market_price` decimal(15,2) NULL  DEFAULT NULL  COMMENT '市场价格',
`cost_price` decimal(15,2) NULL  DEFAULT NULL  COMMENT '成本价格',
`up_time` datetime NULL  DEFAULT NULL  COMMENT '上架时间',
`down_time` datetime NULL  DEFAULT NULL  COMMENT '下架时间',
`create_time` datetime NOT NULL  COMMENT '创建时间',
`store_nums` int(11) NOT NULL  DEFAULT 0 COMMENT '库存',
`img` varchar(255) NULL  DEFAULT NULL  COMMENT '原图',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '删除 0未删除 1已删除 2下架',
`content` text NULL  DEFAULT NULL  COMMENT '商品描述',
`keywords` varchar(255) NULL  DEFAULT NULL  COMMENT 'SEO关键词',
`description` varchar(255) NULL  DEFAULT NULL  COMMENT 'SEO描述',
`search_words` text NULL  DEFAULT NULL  COMMENT '产品搜索词库,逗号分隔',
`weight` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '重量',
`point` int(11) NOT NULL  DEFAULT 0 COMMENT '积分',
`unit` varchar(10) NULL  DEFAULT NULL  COMMENT '计量单位',
`brand_id` int(11) NULL  DEFAULT NULL  COMMENT '品牌ID',
`visit` int(11) NOT NULL  DEFAULT 0 COMMENT '浏览次数',
`favorite` int(11) NOT NULL  DEFAULT 0 COMMENT '收藏次数',
`sort` smallint(5) NOT NULL  DEFAULT 99 COMMENT '排序',
`spec_array` text NULL  DEFAULT NULL  COMMENT '序列化存储规格,key值为规则ID，value为此商品具有的规格值',
`exp` int(11) NOT NULL  DEFAULT 0 COMMENT '经验值',
`comments` int(11) NOT NULL  DEFAULT 0 COMMENT '评论次数',
`sale` int(11) NOT NULL  DEFAULT 0 COMMENT '销量',
`grade` int(11) NOT NULL  DEFAULT 0 COMMENT '评分总数'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='商品信息表' AUTO_INCREMENT=2;

INSERT INTO `w_goods` VALUES( '1','iphone4s','SD140177808855','0','2999.00','4999.00','0.00','2014-06-03 14:52:29','','2014-06-03 14:52:05','98','upload/2014/06/03/20140603025153177.jpg','0','','','','iphone4s','0.00','100','个','0','1','0','99','','0','0','2','0' ); 
DROP TABLE IF EXISTS `w_goods_attribute`;
 CREATE TABLE `w_goods_attribute` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID',
`attribute_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '属性ID',
`attribute_value` varchar(255) NULL  DEFAULT NULL  COMMENT '属性值',
`spec_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '规格ID',
`spec_value` varchar(255) NULL  DEFAULT NULL  COMMENT '规格值',
`model_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '模型ID',
`order` smallint(5) NOT NULL  DEFAULT 99 COMMENT '排序'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='属性值表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_goods_car`;
 CREATE TABLE `w_goods_car` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`content` text NULL  DEFAULT NULL  COMMENT '购物内容',
`create_time` datetime NOT NULL  COMMENT '创建时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='购物车' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_goods_photo`;
 CREATE TABLE `w_goods_photo` (
`id` char(32) NOT NULL  PRIMARY KEY  COMMENT '图片的md5值',
`img` varchar(255) NULL  DEFAULT NULL  COMMENT '原始图片路径'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='图片表';

INSERT INTO `w_goods_photo` VALUES( '81c98527e867504ffbed84d0c5d2b5d7','upload/2014/06/03/20140603025153177.jpg' ); 
INSERT INTO `w_goods_photo` VALUES( 'ca819714dc941deeb6defa5604af910f','upload/2014/06/03/20140603025159871.jpg' ); 
INSERT INTO `w_goods_photo` VALUES( '86de2195d225d6923f48cc5f7873f1a8','upload/2014/06/03/20140603025159428.jpg' ); 
DROP TABLE IF EXISTS `w_goods_photo_relation`;
 CREATE TABLE `w_goods_photo_relation` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID',
`photo_id` char(32) NOT NULL  COMMENT '图片ID,图片的md5值'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='相册商品关系表' AUTO_INCREMENT=7;

INSERT INTO `w_goods_photo_relation` VALUES( '6','1','86de2195d225d6923f48cc5f7873f1a8' ); 
INSERT INTO `w_goods_photo_relation` VALUES( '5','1','ca819714dc941deeb6defa5604af910f' ); 
INSERT INTO `w_goods_photo_relation` VALUES( '4','1','81c98527e867504ffbed84d0c5d2b5d7' ); 
DROP TABLE IF EXISTS `w_group_price`;
 CREATE TABLE `w_group_price` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '产品ID',
`product_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '货品ID',
`group_id` int(11) unsigned NOT NULL  COMMENT '用户组ID',
`price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '价格'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='记录某件商品对于某组会员的价格关系表，优先权大于组设定的折扣率。' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_guide`;
 CREATE TABLE `w_guide` (
`order` smallint(5) unsigned NOT NULL  PRIMARY KEY  COMMENT '排序',
`name` varchar(255) NOT NULL  COMMENT '导航名字',
`link` varchar(255) NOT NULL  COMMENT '链接地址'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='首页导航栏';

INSERT INTO `w_guide` VALUES( '0','品牌专区','http://www.baidu.com' ); 
INSERT INTO `w_guide` VALUES( '1','新品上市','http://www.baidu.com' ); 
INSERT INTO `w_guide` VALUES( '2','晒单专区','http://www.baidu.com' ); 
DROP TABLE IF EXISTS `w_help`;
 CREATE TABLE `w_help` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`cat_id` int(11) unsigned NOT NULL  COMMENT '帮助分类，如果为0则代表着是下面的帮助单页',
`sort` smallint(5) NOT NULL  DEFAULT 99 COMMENT '顺序',
`name` varchar(50) NOT NULL  COMMENT '标题',
`content` text NOT NULL  COMMENT '内容',
`dateline` int(11) NOT NULL  COMMENT '发布时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='帮助' AUTO_INCREMENT=56;

INSERT INTO `w_help` VALUES( '4','3','0','购物流程','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、搜索商品</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为您提供了方便快捷的商品搜索功能：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）您可以通过在首页输入关键字的方法来搜索您想要购买的商品</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）您还可以通过</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">的分类导航栏来找到您想要购买的商品分类，根据分类找到您的商品</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）观看搜索商品演示</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、放入购物车在您想要购买的商品的详情页点击“购买”，商品会添加到您的购物车中；您还可以继续挑选商品放入购物车，一起结算。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）在购物车中，系统默认每件商品的订购数量为一件，如果您想购买多件商品，可修改购买数量</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）在购物车中，您可以将商品移至收藏，或是选择删除</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）在购物车中，您可以直接查看到商品的优惠折和参加促销活动的商品名称、促销主题</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）购物车页面下方的商品是</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">根据您挑选的商品为您作出的推荐，若有您喜爱的商品，点击“放入购物车”即可</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">温馨提示：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）商品价格会不定期调整，最终价格以您提交订单后订单中的价格为准</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）优惠政策、配送时间、运费收取标准等都有可能进行调整，最终成交信息以您提交订单时网站公布的最新信息为准</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、选择订单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">和商家的商品需要分别提交订单订购</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）不同商家的商品需要分别提交订单订购</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、注册登陆</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）老顾客：请在“登陆”页面输入</span><span lang=\\\"EN-US\\\">Email</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">地址或昵称、注册密码进行登陆</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）新顾客：请在“新用户注册”页面按照提示完成注册</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、填写收货人信息</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）请填写正确完整的收货人姓名、收货人联系方式、详细的收货地址和邮编，否则将会影响您订单的处理或配送</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）您可以进入“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">—帐户管理—收货地址簿”编辑常用收货地址，保存成功后，再订购时，可以直接选择使用</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、选择收货方式</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">提供多种收货方式：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）普通快递送货上门</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）加急快递送货上门</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）普通邮递</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）邮政特快专递</span><span lang=\\\"EN-US\\\">(EMS)</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">详情请点击查看配送范围、时间及运费</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、选择支付方式</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">提供多种支付方式，订购过程中您可以选择：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）货到付款</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）网上支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）银行转帐</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）邮局汇款</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">点击查看各种支付方式订单的支付期限</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、索取发票</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">请点击“索取发票”，填写正确的发票抬头、选择正确的发票内容，发票选择成功后，将于订单货物一起送达</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">点击查看发票制度</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">&nbsp;</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、提交订单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）以上信息核实无误后，请点击“提交订单”，系统生成一个订单号，就说明您已经成功提交订单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）订单提交成功后，您可以登陆“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">”查看订单信息或为订单进行网上支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">特别提示</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、若您帐户中有礼品卡，可以在“支付方式”处选择使用礼品卡支付，详情请点击查看</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">礼品卡</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、若您帐户中有符合支付该订单的礼券，在结算页面会有“使用礼券”按钮，您点击选择礼券即可，点击查看礼券使用规则</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">当您选择了礼券并点击“确定使用”后，便无法再取消使用该礼券</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、在订单提交高峰时段，新订单可能一段时间之后才会在“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">”中显示。如果您在“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;\\\">”中暂未找到这张订单，请您耐心等待</span></p>\r\n<p class=\\\"MsoNormal\\\"><br />\r\n</p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;\\\"><br />\r\n</span></p>','0' ); 
INSERT INTO `w_help` VALUES( '27','3','0','积分说明','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">所有会员在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">购物均可获得积分，积分可以用来参与兑换活动。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">会不定期推出各类积分兑换活动，请随时关注关于积分的活动告知。详情请点击查看以下各项说明。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">积分获得</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、每一张成功交易的订单，所付现金部分（含</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">礼品卡）都可获得积分，不同商品积分标准不同，获得积分以订单提交时所注明的积分为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、贵宾会员购物时，将额外获得相应级别的级别赠分。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、阶段性的积分促销活动，也会给您带来额外的促销赠分，详见积分活动。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、促销商品不能获得积分。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">积分有效期</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">积分有效期：获得之日起到次年年底。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">查询积分</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">积分有效期：获得之日起到次年年底。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您可以在</span><span lang=\\\"EN-US\\\">\\\"</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">我的</span><span lang=\\\"EN-US\\\">iWebShop-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">我的积分</span><span lang=\\\"EN-US\\\">\\\"</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">中，查看您的累计积分。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">积分活动</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">会不定期地推出各种积分活动，请随时关注关于积分促销的告知。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、会员可以用积分参与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">指定的各种活动，参与后会扣减相应的积分。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、积分不可用于兑换现金，仅限参加</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">指定兑换物品、参与抽奖等各种活动。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">会员积分计划细则</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不同帐户积分不可合并使用；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">·本计划只适用于个人用途而进行的购物，不适用于团体购物、以营利或销售为目的的购买行为、其它非个人用途购买行为。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">·会员积分计划及原</span><span lang=\\\"EN-US\\\">VIP</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">制度的最终解释权归</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">所有。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">免责条款</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">感谢您访问</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的会员积分计划，本计划由</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">或其关联企业提供。以上计划条款和条件，连同计划有关的任何促销内容的相应条款和条件，构成本计划会员与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">之间关于制度的完整协议。如果您使用</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">，您就参加了本计划并接受了这些条款、条件、限制和要求。请注意，您对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">站的使用以及您的会员资格还受制于</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">站上时常更新的所有条款、条件、限制和要求，请仔细阅读这些条款和条件。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">协议的变更</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">可以在没有特殊通知的情况下自行变更本条款、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">的任何其它条款和条件、或您的计划会员资格的任何方面。对这些条款的任何修改将被包含在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">的更新的条款中。如果任何变更被认定为无效、废止或因任何原因不可执行，则该变更是可分割的，且不影响其它变更或条件的有效性或可执行性。在我们变更这些条款后，您对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">的继续使用，构成您对变更的接受。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">终止</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">可以不经通知而自行决定终止全部或部分计划，或终止您的计划会员资格。即使</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">没有要求或强制您严格遵守这些条款，也并不构成对属于</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">的任何权利的放弃。如果您在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的客户帐户被关闭，那么您也将丧失您的会员资格。对于该会员资格的丧失，您对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">不能主张任何权利或为此索赔。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">责任限制</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">除了</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的使用条件中规定的其它限制和除外情况之外，在中国法律法规所允许的限度内，对于因会员积分计划而引起的或与之有关的任何直接的、间接的、特殊的、附带的、后果性的或惩罚性的损害，或任何其它性质的损害，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的董事、管理人员、雇员、代理或其它代表在任何情况下都不承担责任。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">的全部责任，不论是合同、保证、侵权（包括过失）项下的还是其它的责任，均不超过您所购买的与该索赔有关的商品价值额。这些责任排除和限制条款将在法律所允许的最大限度内适用，并在您的计划会员资格被撤销或终止后仍继续有效。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\"><br />\r\n</span></p>','1303975443' ); 
INSERT INTO `w_help` VALUES( '26','3','0','会员制度','<div>会员级别共分七级，具体为：注册会员、铁牌会员、铜牌会员、银牌会员、金牌会员、钻石会员、双钻石会员，级别升降均由系统自动实现，无需申请。</div>\r\n<div><br />\r\n</div>\r\n<div>注册会员：</div>\r\n<div>申请条件：任何愿意到iWebShop购物的用户都可以免费注册。</div>\r\n<div>待　　遇：可以享受注册会员所能购买的产品及服务。</div>\r\n<div>铁牌会员：</div>\r\n<div>申请条件：一年内有过成功消费的会员，金额不限。</div>\r\n<div>待　　遇：可以享受铁牌会员级别所能购买的产品及服务。</div>\r\n<div>铜牌会员：</div>\r\n<div>申请条件：一年内消费金额超过2000元（含）的会员。</div>\r\n<div>待　　遇：可以享受铜牌会员级别所能购买的产品及服务。</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。</div>\r\n<div>银牌会员：</div>\r\n<div>申请条件：一年内消费金额超过5000元（含），需填写本人真实的身份证号码进行升级</div>\r\n<div>待　　遇：可以享受银牌会员级别所能购买的产品及服务。</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。</div>\r\n<div>金牌会员：</div>\r\n<div>申请条件： 一年内累计消费金额超过10000 元（含）。</div>\r\n<div>待　　遇：</div>\r\n<div>享有优先购物权 —— 对国内少见的优秀产品或者其它比较紧俏的产品具有优先购买权。</div>\r\n<div>享受运费优惠政策（详见这里）</div>\r\n<div>享有一年两次的特别针对金牌会员抽奖的权利</div>\r\n<div>不定期举办个别产品针对金牌会员的优惠活动。</div>\r\n<div>享有支付66元DIY装机服务费的权利。</div>\r\n<div>其它相关要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在2500元（含）——5000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为银牌会员；如消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。　</div>\r\n<div>钻石会员：</div>\r\n<div>申请条件：一年内累计消费金额达到 30000 元（含）</div>\r\n<div>享受金牌会员全部待遇。</div>\r\n<div>享受运费优惠政策（详见这里）</div>\r\n<div>享有支付30元DIY装机服务费的权利。</div>\r\n<div>享受一定范围内免返修品快递运费的服务。（详情请查看售后返修品运费规定）</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在5000元（含）——15000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为金牌会员；如消费金额在2500元（含）——5000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为银牌会员；如消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。&nbsp;</div>\r\n<div>双钻石会员：</div>\r\n<div>申请条件：个人用户，年消费金额在10万元（含）以上。</div>\r\n<div>待　　遇：</div>\r\n<div>钻石会员的全部待遇都可以享受。</div>\r\n<div>享有iWebShop网站高管定期提供的沟通服务。</div>\r\n<div>享有不需审核，只需报名，即可参加iWebShop网站举办的网友见面会等网友活动。</div>\r\n<div>享有客服专员定期回访征询意见服务。</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在15000元（含）——50000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为钻石会员；如消费金额在5000元（含）——15000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为金牌会员；如消费金额在2500元（含）——5000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为银牌会员；如消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。&nbsp;</div>\r\n<div><br />\r\n</div>\r\n<div>注：针对各个级别会员特别声明：</div>\r\n<div>会员账号禁止转借或转让他人使用，如因转借或转让他人使用所带来的一切后果，iWebShop网站概不负责，如被iWebShop网站发现有转借或转让使用情况，iWebShop网站则有权立即取消此会员账号的相应级别资格。</div>\r\n<div>如iWebShop网站发现相应的级别中有经销商，则iWebShop网站有权立即取消此会员帐号的相应级别资格。</div>\r\n<div><br />\r\n</div>','1303972391' ); 
INSERT INTO `w_help` VALUES( '28','3','0','交易条款','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站交易条款</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站和您之间的契约</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1.iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站将尽最大努力保证您所购商品与网站上公布的价格一致，但价目表和声明并不构成要约。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站有权在发现了其网站上显现的产品及订单的明显错误或缺货的情况下，单方面撤回。</span><span lang=\\\"EN-US\\\">(</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">参见下面相关条款</span><span lang=\\\"EN-US\\\">)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站保留对产品订购的数量的限制权。</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">在下订单的同时，您也同时承认了您拥有购买这些产品的权利能力和行为能力，并且您对您在订单中提供的所有信息的真实性负责。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2. </span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">价格变化和缺货</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">产品的价格和可获性都在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站上指明。这类信息将随时更改且不发任何通知。商品的价格都包含了增值税。送货费将另外结算，费用根据您选择的送货方式的不同而异。如果发生了意外情况，在确认了您的订单后，由于供应商提价，税额变化引起的价格变化，或是由于网站的错误等造成商品价格变化，您有权取消您的订单，并希望您能及时通过电子邮件或电话通知</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">客户服务部。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您所订购的商品，如果发生缺货，您有权取消订单。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3. </span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮件</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">短信服务</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站保留通过邮件和短信的形式，对本网站注册、购物用户发送订单信息、促销活动等告知服务的权利。如果您在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站注册、购物，表明您已默示同意接受此项服务。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">若您不希望接收</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的邮件，请在邮件下方输入您的</span><span lang=\\\"EN-US\\\">E-mail</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">地址自助完成退阅；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">若您不希望接收</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的短信，请提供您的手机号码</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">联系客服</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">处理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4. </span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">送货</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站将会把产品送到您所指定的送货地址。所有在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站上列出的送货时间为参考时间，参考时间的计算是根据库存状况、正常的处理过程和送货时间、送货地点的基础上估计得出的。参考时间不代表等同于到货时间。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退款政策</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退货或换货商品缺货时产生的现金款项，退回方式视支付方式的不同而不同：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网上支付的订单，退款退回至原支付卡；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">银行转帐或邮局汇款支付的订单，退款退回至下订单账户的账户余额中。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6. </span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">条款的修正</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">这些交易条件的条款适用于</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站为您提供的产品销售服务。这些条款将有可能不时的被修正。任何修正条款的发生，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站都将会及时公布。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7. </span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">条款的可执行性</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果出于任何原因，这些条款及其条件的部分不能得以执行，其他条款及其条件的有效性将不受影响。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8. </span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">适用的法律和管辖权</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您和</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站之间的契约将适用中华人民共和国的法律，所有的争端将诉诸于</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站所在地的人民法院。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站会员制计划（</span><span lang=\\\"EN-US\\\">VIP</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">计划）协议的变更</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">终止</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">责任限制</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的会员制计划（</span><span lang=\\\"EN-US\\\">VIP</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">计划），本计划由</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">或其关联企业提供。以上计划条款和条件，连同计划有关的任何促销内容的相应条款和条件，构成本计划会员与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">之间关于制度的完整协议。如果您参加计划，您就接受了这些条款、条件、限制和要求。请注意，您对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的使用以及您的会员资格还受制于</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站上时常更新的所有条款、条件、限制和要求，请仔细阅读这些条款和条件。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">协议的变更</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站可以在没有特殊通知的情况下自行变更本条款、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的任何其它条款和条件、或您的计划会员资格的任何方面。</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">对这些条款的任何修改将被包含在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的更新的条款中。如果任何变更被认定为无效、废止或因任何原因不可执行，则该变更是可分割的，且不影响其它变更或条件的有效性或可执行性。在我们变更这些条款后，您对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的继续使用，构成您对变更的接受。如果您不同意本使用交易条款中的任何一条，您可以不使用</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的帐户余额自助提现功能</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站为您提供了帐户余额自助提现功能，在提交提现申请单时，您也同时承认了您拥有提现账户余额的权利能力和行为能力，并且将对您在申请单中提供的所有信息的真实性负责。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">用户在申请使用</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站网络服务时，必须准确提供必要的资料，如资料有任何变动</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">，请在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站产品网站上及时更新。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">用户注册成功后，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站将为其开通一个账户，为用户在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站交易及使用</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站服务时的唯一身份标识，该账户的登录名和密码由用户负责保管；用户应当对以其账户进行的所有活动和事件负法律责任。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">终止</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站可以不经通知而自行决定终止全部或部分计划，或终止您的计划会员资格。即使</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站没有要求或强制您严格遵守这些条款，也并不构成对属于</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的任何权利的放弃。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的客户账户被关闭，那么您也将丧失您的会员资格。对于该会员资格的丧失，您对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站不能主张任何权利或为此索赔。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">责任限制</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">除了</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的使用条件中规定的其它限制和除外情况之外，在中国法律法规所允许的限度内，对于因</span><span lang=\\\"EN-US\\\">VIP</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">计划而引起的或与之有关的任何直接的、间接的、特殊的、附带的、后果性的或惩罚性的损害，或任何其它性质的损害，</span><span lang=\\\"EN-US\\\"> iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的董事、管理人员、雇员、代理或其它代表在任何情况下都不承担责任。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的全部责任</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，不论是合同、保证、侵权（包括过失）项下的还是其它的责任，均不超过您所购买的与该索赔有关的商品价值额。这些责任排除和限制条款将在法律所允许的最大限度内适用，并在您的计划会员资格被撤销或终止后仍继续有效。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">隐私声明</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">电子通讯</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">当您访问</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站或给我们发送电子邮件时，您与我们用电子方式进行联系。您同意以电子方式接受我们的信息。我们将用电子邮件或通过在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站上发布通知的方式与您进行联系。您同意我们用电子方式提供给您的所有协议、通知、披露和其他信息是符合此类通讯必须是书面形式的法定要求的。如果</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站能够证明以电子形式的信息已经发送给您或者</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站立即在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站上张贴这样的通知，将被视为您已收到所有协议、声明、披露和其他信息</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">版权声明</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站上的所有内容诸如文字、图表、标识、按钮图标、图像、声音文件片段、数字下载、数据编辑和软件、商标都是</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站或其关联公司或其内容提供者的财产，受中国和国际版权法的保护。未经</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站书面授权或许可</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，不得以任何目的对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站或其任何部分进行复制、复印、仿造、出售、转售、访问、或以其他方式加以利用。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您的账户</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您使用</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站，您有责任对您的账户和密码保守秘密并对进入您的计算机作出限制，并且您同意对在您的账户和密码下发生的所有活动承担责任。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的确销售供儿童使用的产品，但只将它们销售给成年人。如果您在</span><span lang=\\\"EN-US\\\">18</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">岁以下，您只能在父母或监护人的参与下才能使用</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站及其关联公司保留在中华人民共和国法律允许的范围内独自决定拒绝服务、关闭账户、清除或编辑内容或取消订单的权利。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">评论、意见、消息和其他内容</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">访问者可以张贴评论、意见及其他内容，以及提出建议、主意、意见、问题或其他信息，只要内容不是非法、淫秽、威胁、诽谤、侵犯隐私、侵犯知识产权或以其他形式对第三者构成伤害或侵犯或令公众讨厌，也不包含软件病毒、政治宣传、商业招揽、连锁信、大宗邮件或任何形式的</span><span lang=\\\"EN-US\\\">\\\"</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">垃圾邮件</span><span lang=\\\"EN-US\\\">\\\"</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">。您不可以使用虚假的电子邮件地址、冒充任何他人或实体或以其它方式对卡片或其他内容的来源进行误导。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站保留清除或编辑这些内容的权利（但非义务），但不对所张贴的内容进行经常性的审查。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您确实张贴了内容或提交了材料，除非我们有相反指示，您授予</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站及其关联公司非排他的、免费的、永久的、不可撤销的和完全的再许可权而在全世界范围内任何媒体上使用、复制、修改、改写、出版、翻译、创作衍生作品、分发和展示这样的内容。您授予</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站及其关联公司和被转许可人使用您所提交的与这些内容有关的名字的权利，如果他们选择这样做的话。您声明并担保您拥有或以其它方式控制您所张贴内容的权利，内容是准确的，对您所提供内容的使用不违反本政策并不会对任何人和实体造成伤害。您声明并保证对于因您所提供的内容引起的对</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站或其关联公司的损害进行赔偿。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站有权（但非义务）监控和编辑或清除任何活动或内容。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站对您或任何第三方所张贴的内容不承担责任。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">合同缔结</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您通过我们网站订购产品，您的订单就成为一种购买产品的申请或要约。我们将发送给您一封确认收到订单的电子邮件，其中载明订单的细节。但是只有当我们向您发出送货确认的电子邮件通知您我们已将产品发出时，我们对您合同申请的批准与接受才成立。如果您在一份订单里订购了多种产品并且我们只给您发出了关于其中一部分的发货确认电子邮件，那么直到我们发出关于其他产品的发货确认电子邮件，关于那部分产品的合同才成立。当您所购买的商品离开了</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站或其关联公司的库房时，该物品的所有权和灭失风险即转移到您这一方。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">产品说明</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站及其关联公司努力使产品说明尽可能准确。不过，我们并不保证产品说明或</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站上的其他内容是准确的、完整的、可靠的、最新的或无错误的。如果</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站提供的产品本身并非如说明所说，您唯一的救济是将该未经使用过的产品退还我们。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">价格</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">直到您发出订单，我们才能确认商品的价格。尽管我们做出最大的努力，我们的商品目录里的一小部分商品可能会有定价错误。如果我们发现错误定价，我们将采取下列之一措施：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">i</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">如果某一商品的正确定价低于我们的错误定价，我们将按照较低的定价向您销售交付该商品。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">ii</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">如果某一商品的正确定价高于我们的错误定价，我们会根据我们的情况决定</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">是否在交付前联系您寻求您的指示</span><span lang=\\\"EN-US\\\">, </span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">或者取消订单并通知您。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">其他企业</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站及其关联企业之外的其他人可能在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站上经营商店、提供服务或者销售产品。另外，我们提供与关联公司和其他企业的链接。我们不负责审查和评估也不担保任何这些企业或个人的待售商品及它们网站的内容。我们对所有这些企业或任何其他第三人或其网站的行为、产品和内容不承担责任。您应仔细阅读它们自己的隐私政策及使用条件。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975478' ); 
INSERT INTO `w_help` VALUES( '29','3','0','订单状态','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">一个</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的新订单从下单到订单完成，会经历各种状态，我们会将各种状态显示在订单详情页面，希望以此种方式让您更好的了解订单情况，及时跟踪订单状态，打消疑虑并顺利完成购物。以下是订单状态的简单说明：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">等待付款：如果您选择“在线支付”“银行卡转账”“邮局汇款”“公司转账”“分期付款”“高校</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自己支付”“高校</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">代理垫付”这几种支付方式，在成功支付且得到财务确认之前，订单状态会显示为等待付款；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">正在配货：该状态说明</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站正在为您的订单进行配货，包括</span><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个子状态</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）打印：将您订购的商品打印成单，便于出库员取货</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）出库：出库员找到您订购的商品并出库</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）扫描：扫描员扫描您订购的商品并确认商品成功出库</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）打包：打包员将您订购的商品放入包裹以便运输</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）发货：发货员将您的包裹发货运输</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站送货：您订购的商品已经发货，正在运送途中</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">收货并确认：货物已发出一段时间，如果您已收到货物可以点击确认按钮进行确认</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">上门自提：该状态说明您订购的商品已经送至相应自提点，请您尽快到自提点提货</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">已完成：此次交易已经完成，希望能得到您的满意</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">已锁定：如果您修改了订单但没有修改成功，则系统会自动锁定您的订单，您可以在订单列表页面点击操作栏中的“解锁订单”使订单恢复正常</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">订单待审核：该状态说明您订购的某类商品缺货，需要</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站将货物备齐后订单才会恢复正常状态，此状态下请您不要进行付款操作，以免货物无法备齐而占用您的货款</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">修改订单常见问题：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、什么时候允许修改订单？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站下单后，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站后台程序会通过一系列算法来判断您的订单是否可以修改，如果可以修改，您在订单操作一列可以看到“修改订单”链接，此时说明订单可以修改。如果没有此链接，说明该订单不可修改。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">一般来说，在您选购的商品没有打印完毕之前，都是可以修改订单的。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、我能修改订单的哪些内容？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">修改购物车内的商品数量，增加或删除商品；（暂不支持添加套装）</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">修改收货人信息、配送方式、发票信息、订单备注；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">添加优惠券或删除已使用的优惠券；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：由于目前暂不支持修改支付方式，所以一些与支付方式相关联的收货地址可能也无法修改。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、修改订单时，订单为什么会被锁定？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为了避免您在修改订单的同时，您的订单继续被程序处理和执行，我们会在您修改订单过程中锁定您的订单，直到您完成修改并点击了“提交订单”按钮。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您在修改过程当中放弃了修改，建议您返回订单列表页面点击操作栏中的“解锁订单”，否则您的订单将在</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个小时后解锁，将影响您订单的生产时间和收货时间。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、如果购物车里某一款商品下单时的价格和修改订单当时的价格不一致，按哪个来算商品价格呢？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您不修改该商品的购买数量，那么价格和赠品都会维持您下单时的状态不变；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您修改了该商品购买数量或者添加了新商品，那么价格和赠品都会与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站最新显示的价格和赠品一致。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果您添加了新商品，那么新商品的价格与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站最新显示的价格和赠品一致。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、可以先申请价保后再修改订单吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不可以，如果你对某商品申请了价保，那么该商品将不能进行修改和删除，除非您删除整个订单。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975502' ); 
INSERT INTO `w_help` VALUES( '30','4','0','货到付款','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">货到付款：货物送到订单指定的收货地址后，由收货人支付货款给送货人员</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">货到付款适用于加急快递、普通快递送货上门的订单。请您在订购过程的“付款方式”处，选择货到付款</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">温馨提示：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、货到付款仅限支付现金</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、签收时，请您仔细核兑款项、务必作到货款两清，若事后发现款项错误，我们将无法再核实确认点击查看当当网签收验货政策</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、部分商店街的商家不支持货到付款，请您通过网上支付、邮局汇款、银行转帐方式支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975553' ); 
INSERT INTO `w_help` VALUES( '31','4','0','在线支付','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站提供的在线支付方式</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站目前有以下支付平台可供选择：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）工商银行网上银行支付平台，支持工商银行银行卡网上在线支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）招商银行网上银行支付平台，支持招商银行银行卡网上在线支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）建设银行网上银行支付平台，支持建设银行银行卡网上在线支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）农业银行网上银行支付平台，支持</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">农业银行银行卡网上在线支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）支付宝支付平台，关于支付宝的支付帮助请查看</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">6</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）财付通支付平台，关于财付通的支付帮助请查看</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">7</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）快钱</span><span lang=\\\"EN-US\\\">99Bill</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">支付平台，关于快钱支付平台的支付帮助请查看</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">8</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）环迅</span><span lang=\\\"EN-US\\\">IPS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，关于环迅支付平台的支付帮助请查看</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">9</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站虚拟账户支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、如您是第一次进行网上在线支付，建议事先拨打银行卡所属发卡银行的热线电话，详细咨询可在其网上进行在线支付的银行卡种类及相关开通手续。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975582' ); 
INSERT INTO `w_help` VALUES( '32','4','0','银行电汇','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">请在电汇单“汇款用途”一栏处注明您的订单号，银行汇款到账通常需要</span><span lang=\\\"EN-US\\\">2~3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个工作日的时间，我们将在款到后当日为您发货。否则我们无法及时核对审核，这将延误您的发货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">使用银行电汇支付，请务必在</span><span lang=\\\"EN-US\\\">3*24</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">小时之内支付，逾时订单将会自动作废。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果有些银行网点不能提供填写订单号，请汇款后联系我们。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">银行电汇账户信息：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">银行</span><span lang=\\\"EN-US\\\"> <span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">账户信息</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">工商银行</span><span lang=\\\"EN-US\\\"> <span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">户</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">名：</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">有限公司</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">开户行：工商银行</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">支行</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">账</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">号：</span><span lang=\\\"EN-US\\\">1001*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">建设银行</span><span lang=\\\"EN-US\\\"> <span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">户</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">名：</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">有限公司</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">开户行：建设银行</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">支行</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">账</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">号：</span><span lang=\\\"EN-US\\\">3100*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">招商银行</span><span lang=\\\"EN-US\\\"> <span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">户</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">名：</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">有限公司</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">开户行：招商银行</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">支行</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">账</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">号：</span><span lang=\\\"EN-US\\\">1219*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">交通银行</span><span lang=\\\"EN-US\\\"> <span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">户</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">名：</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">有限公司</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">开户行：交通银行</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">支行</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">账</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">号：</span><span lang=\\\"EN-US\\\">3100*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">汇单范例</span></p>','1303975610' ); 
INSERT INTO `w_help` VALUES( '33','4','0','余额支付','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">用户还可以通过使用账户中心中的余额来对订单进行支付</span></p>','1303975628' ); 
INSERT INTO `w_help` VALUES( '34','6','0','配送范围及运费','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站购物满</span><span lang=\\\"EN-US\\\">29</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元免运费，查看详情</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">普通快递送货上门</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">覆盖全国</span><span lang=\\\"EN-US\\\">800</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">多个城市，运费</span><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">包裹，购物满</span><span lang=\\\"EN-US\\\">29</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元免运费</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">加急快递送货上门</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">支持北京、天津、上海、广州、深圳、廊坊，限当地发货订单，运费</span><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">包裹</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">圆通快递</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">北京地区：运费</span><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">普通邮递</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">大陆地区：运费</span><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">包裹，购物满</span><span lang=\\\"EN-US\\\">29</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元免运费</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">港澳地区：运费为商品原价总金额的</span><span lang=\\\"EN-US\\\">30%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，最低</span><span lang=\\\"EN-US\\\">20</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">海外地区：运费为商品原价总金额的</span><span lang=\\\"EN-US\\\">50%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，最低</span><span lang=\\\"EN-US\\\">50</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政特快专递</span><span lang=\\\"EN-US\\\">(EMS)</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">北京地区：运费为订单总金额的</span><span lang=\\\"EN-US\\\">50%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，最低</span><span lang=\\\"EN-US\\\">20</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">大陆其它地区：运费为订单总金额的</span><span lang=\\\"EN-US\\\">100%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，最低</span><span lang=\\\"EN-US\\\">20</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">港澳台地区：运费为商品原价总金额的</span><span lang=\\\"EN-US\\\">70%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，最低</span><span lang=\\\"EN-US\\\">60</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975661' ); 
INSERT INTO `w_help` VALUES( '35','6','0','上门自提','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注意事项：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提时间：周一至周日，</span><span lang=\\\"EN-US\\\">09:00</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">－</span><span lang=\\\"EN-US\\\">19:00</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（如遇国家法定节假日，则以</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站新闻发布放假时间为准，请大家届时关注）</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品到达自提点后，我们将为您保留三天，超过三天不上门提货，则视为默认取消订单；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">钱、货需客户当面点清，离开提货前台后</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站将不再对钱、货数量负责；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">货物价保需客户在自提当场提出，离开提货前台后</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站不再对自提货物提供价保服务；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">普通发票：每张订单需在自提当日开具发票，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站不提供累计开具发票的服务；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">增值税发票：选择</span><span lang=\\\"EN-US\\\">POS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">机刷卡，不能开具增票；增票当日无法开具，需订单完成后三个工作日左右</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站按订单地址将增票快递给客户，如订单中地址有误请及时通知</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服人员。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">特殊说明：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">上门自提的订单，请在规定的时间内到自提点提取货物。上门自提订单原则上免收配送费用，但如果一个</span><span lang=\\\"EN-US\\\">ID</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">帐号在一个月内有过</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">次以上或一年内有过</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">次以上，在规定的时间内无理由不履约提货，我司将在相应的</span><span lang=\\\"EN-US\\\">ID</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">帐户里每单扣除</span><span lang=\\\"EN-US\\\">50</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个积分做为运费；时间计算方法为：成功提交订单后向前推算</span><span lang=\\\"EN-US\\\">30</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天为一个月，成功提交订单后向前推算</span><span lang=\\\"EN-US\\\">365</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天为一年，不以自然月和自然年计算；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">对于上门自提的客户，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站可以接受现金、支票（北京和上海的自提点支持，其他城市的自提点不支持）和</span><span lang=\\\"EN-US\\\">POS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">机刷卡三种付款方式。选择支票支付方式，需要客户自行将支票内容填写完整（货款在</span><span lang=\\\"EN-US\\\">5000</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元或</span><span lang=\\\"EN-US\\\">5000</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元以上，需要款到帐后方可提货）；</span><span lang=\\\"EN-US\\\">POS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">机刷卡只支持带有银联标识的银行卡。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">信用卡</span><span lang=\\\"EN-US\\\">POS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">机刷卡消费超过</span><span lang=\\\"EN-US\\\">4500</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元时，发卡银行按照相关规定有可能不向您赠送积分，具体信息请致电发卡行确认。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提点</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提点适用范围：以下地区用户均可到相应自提点付款提货，无需支付运费（大家电产品限物流中心自提点）。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">以下各自提点均不接收由于各种原因被客户邮寄退回的商品，否则出现的一切后果</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站概不负责。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">友好提示</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">下单之后可以更换自提点或更换配送方式吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">可以更换自提点但无法更换配送方式。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">方法：我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">订单中心</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">点“查看”</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">进入订单详细页面</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">订单操作</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">修改订单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">一般来说，在您选购的商品没有打印完毕之前，都是可以修改订单的。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提时验货发现问题，可以当场换货吗？如何处理？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不可以。自提时如果发现货品有问题请当场反映给</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站工作人员，由工作人员帮您处理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提价格和其它配送方式价格是否一样？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不管您选用哪种配送方式，商品的价格是一样的。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">可以到自提点付款，贵公司工作人员送货到家吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不可以，自提点采用的是上门付款提货方式。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为何结算时找不到某某自提点？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）可能是您所下订单的收货地址与该自提点不在一个省市；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）或者该自提点已经更换名称、地址；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）或者是您所购买的商品是大家电，该分类下部分商品只支持部分地区物流总部自提。详情以下单时所支持配送方式为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提点可以先验货后付款吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不可以，我司不管哪种配送方式都是采取先付款后验货的方式。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">任何商品都可以自提吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">除了虚拟商品和服务类商品（如网络版杀毒软件）及部分大家电无法自提外，其它都可以自提。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">上门自提能用支付宝支付吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不可以。对于上门自提的客户，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站可以接受现金、支票和</span><span lang=\\\"EN-US\\\">POS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">机刷卡三种付款方式。选择支票支付方式，需要客户自行将支票内容填写完整（货款在</span><span lang=\\\"EN-US\\\">5000</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元或</span><span lang=\\\"EN-US\\\">5000</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元以上，需要款到帐后方可提货）；</span><span lang=\\\"EN-US\\\">POS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">机刷卡只支持带有银联标识的银行卡。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提点装机需要自带什么，比如：系统盘等等</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提点装机服务负责仅配置单里的散件组装，如您希望安装系统请自带系统盘，我们会指导您安装。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">购买配件，上门自提时可以提供安装服务吗？（比如内存条）</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">购买配件，自提时不提供安装服务，希望您能理解。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975686' ); 
INSERT INTO `w_help` VALUES( '36','6','0','加急快递','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如何正确选择加急配送服务</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">北京、天津、上海、广州、深圳、廊坊</span><span lang=\\\"EN-US\\\">6</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个城市地区的用户，并且为当地发货订单，用户可在结算中心“送货方式”部分选择加急快递送货上门服务。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">常见问题解答：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">我的订单什么时候可以送到？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">具体配送时间根据不同城市略有不同，请查看配送范围及运费</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2.\\\"</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">加急快递送货上门</span><span lang=\\\"EN-US\\\">\\\"</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的费收取标准？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">北京、天津、上海、广州、深圳、廊坊</span><span lang=\\\"EN-US\\\">6</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个城市的“加急快递送货上门”配送费为</span><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">单。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975706' ); 
INSERT INTO `w_help` VALUES( '37','6','0','商品验货与签收','<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">快递送货上门、圆通快递的订单</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">1</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、签收时仔细核对：商品及配件、商品数量、</span><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">iWebShop</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">网站的发货清单、发票（如有）、三包凭证（如有）等</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">2</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、若存在包装破损、商品错误、商品少发、商品有表面质量问题等影响签收的因素，请您一定要当面向送货员说明情况并当场整单退货</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">邮局邮寄的订单</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">1</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、请您一定要小心开包，以免尖锐物件损伤到包裹内的商品</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">2</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、签收时仔细核对：商品及配件、商品数量、</span><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">iWebShop</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">网站的发货清单、发票（如有）、三包凭证（如有）等</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">3</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、若包装破损、商品错误、商品少发、商品存在表面质量问题等，您可以选择整单退货；或是求邮局开具相关证明后签收，然后登陆</span><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">iWebShop</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">网站申请退货或申请换货</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">温馨提示</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">1</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、货到付款的订单送达时，请您当面与送货员核兑商品与款项，确保货款两清；若事后发现款项有误，</span><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">iWebShop</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">网站将无法为您处理</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">2</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、请收货时务必认真核对，若您或您的委托人已签收，则说明订单商品正确无误且不存在影响使用的因素，</span><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">iWebShop</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">网站有权不受理因包装或商品破损、商品错漏发、商品表面质量问题、商品附带品及赠品少发为由的退换货申请</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">3</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">、部分商品由商店街的商家提供</span><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">,</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">这部分商品的验货验收不在</span><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\">iWebShop</span><span style=\\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\\">网站承诺的范围内</span></p>\r\n<p class=\\\"\\\\&quot;MsoNormal\\\\&quot;\\\"><span lang=\\\"\\\\&quot;EN-US\\\\&quot;\\\"><o:p>&nbsp;</o:p></span></p>','1303975725' ); 
INSERT INTO `w_help` VALUES( '38','6','0','EMS/邮政普包','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站目前除提供</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站快递以及上门自提服务以外，还提供了更多样的配送方式，支持更多地区的配送服务。目前开通的快递有圆通快递、宅急送、邮政普包和邮政</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（邮政特快专递）等。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政普包运费标准</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">区域</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">省</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">市</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count: 1\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">运费</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">一区</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">北京、上海、广东、江苏、浙江、山东、湖北、陕西、四川</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">二区</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天津、重庆、黑龙江、吉林、辽宁、河北、河南、山西、安徽、江西、湖南、福建、广西、海南</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">公斤以下：</span><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（含）公斤以上：</span><span lang=\\\"EN-US\\\">6</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">三区</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">内蒙古、甘肃、宁夏、云南、贵州、青海、新疆、西藏</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-tab-count:1;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">公斤以下：</span><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（含）公斤以上：</span><span lang=\\\"EN-US\\\">15</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">单</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政普包到货时间</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">根据邮政系统服务时限，邮政普包的货物到货（到客户所在地邮政局）时间为</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">～</span><span lang=\\\"EN-US\\\">15</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个工作日，在到货后需要凭包裹单据去包裹所在邮政局领取。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政普包跟踪查询</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政普包跟踪查询请点击此处</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">http://yjcx.chinapost.com.cn/queryMail.do?action=batchQueryMail</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">运费标准</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">按优惠资费起重</span><span lang=\\\"EN-US\\\">500</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">克以内</span><span lang=\\\"EN-US\\\">16</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元，续重不同省市资费会有所不同。以</span><span lang=\\\"EN-US\\\">500</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">克为计算资费单位，即每件包裹重量尾数不满</span><span lang=\\\"EN-US\\\">500</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">克的，应进整按</span><span lang=\\\"EN-US\\\">500</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">克计算资费。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">到货时间</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">根据邮政系统服务时限，邮政</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的货物到货时间为</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">～</span><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个工作日（节假日除外）。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">跟踪查询</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">跟踪查询请点击此处</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">http://www.ems.com.cn/qcgzOutQueryNewAction.do?reqCode=gotoSearch</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">温馨提示</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">由于第三方物流公司配送区域变动频繁，请您采用以上配送方式时先行查阅配送公司的配送范围，以保证您的订单可以及时到达。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">在您成功提交订单后，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站在确认到款的情况下会尽快安排商品的出库，您的货物运单号也会在货物出库后的第二至三个工作日添加到您的帐户中心</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您可以登陆帐户中心的订单查询页面进行查询跟踪您的货物情况。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">音响设备江浙沪地区以外的地方需要空运，请选择</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，选择圆通可能会造成不必要的延误和退件。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">关于送货时间</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">货物如未在您选定送货方式规定的最长送货时间内送达，您可以选择以下方式处理；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您可以进入</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站网帐户中心，选择“订单管理”，根据您的订单号码查询到自己的运单号，然后直接进入圆通快递公司网站</span><span lang=\\\"EN-US\\\">http://www.yto.net.cn/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">，输入运单号，在线查询配送状况；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您可以进入相应快递公司网站，查询您所在地的快递公司分部联系电话，拨打查询；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您可以点击网站首页右侧的在线客服给我们留言，告知订单号，我们将为您及时处理；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您可以拨打服务电话</span><span lang=\\\"EN-US\\\">400-820-4400</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">通知我们，我们将为您及时处理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">选择邮政配送方式的客户在收到产品后可在邮局工作人员的面前拆包，如产品损坏，可直接在签收单上注明：内件损坏，本人拒收字样，由邮局再返回</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站和邮局协商赔偿事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如签收后未当面开封，产品出现问题，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站很难和邮局协商赔偿，为了客户的利益，希望客户能够执行并理解。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">选择其他方式的客户在收到货物时，请您认真检查外包装。如有明显损坏迹象，您可以拒收该货品，并及时通知我们。我们会处理并承担由此而产生的运输费用，请客户不必担心。如您签收有明显损坏迹象的外包装后再投诉货物有误或有损坏，恕我们不能受理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975760' ); 
INSERT INTO `w_help` VALUES( '39','5','0','换货说明','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站承诺自顾客收到商品之日起</span><span lang=\\\"EN-US\\\">15</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">日内（以发票日期为准，如无发票以</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站发货清单的日期为准），如符合以下条件，我们提供换货服务：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、商品及商品本身的外包装没有损坏，保持</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站出售时的原质原样；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、注明换货原因，如果商品存在质量问题，请务必说明；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、确保商品及配件、附带品或者赠品、保修卡、三包凭证、发票、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站发货清单齐全；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、如果成套商品中有部分商品存在质量问题，在办理换货时，必须提供成套商品；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站中的部分商品是由与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站签订合同的商家提供的，这些商品的换货请与商家联系</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">以下情况不予办理换货：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、任何非由</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站出售的商品；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、任何已使用过的商品，但有质量问题除外；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、任何因非正常使用及保管导致出现质量问题的商品。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、所有未经客服确认擅自退回的商品，换货申请无法受理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">特殊说明：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、食品、保健食品类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">食品类商品不予换货，但有质量问题除外；如商品过期或距离保质期结束不到</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个月。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、美妆个护类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">化妆品及个人护理用品属于特殊商品不予换货，但有质量问题除外，如商品包装破损，商品过期或离过期不到</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个月。我们保证商品的进货渠道和质量，如果您在使用时对商品质量表示置疑，请出具书面鉴定，我们会按照国家法律规定予以处理。因个人喜好（气味，色泽、型号，外观）和个人肤质不同要求的换货将无法受理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、母婴用品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品签收后不予换货，但有质量问题除外，洗涤方法参考说明，正常缩水</span><span lang=\\\"EN-US\\\">10%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">以内正常，不属于质量问题。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、服装类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">内衣类商品，如内衣裤，袜子，文胸类商品，除质量问题除外，不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、鞋帽箱包类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品配件（如配饰挂坠等）、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、玩具类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品签收后不予换货，但有质量问题除外。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、家居类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤），不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品配件、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、手表类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">手表类商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">以下情况不予办理换货：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果商品自身携带的产品序列号与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站售出的不符；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">缺少随商品附带的保修卡、发票、配件等；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品已打开塑封包装或撕开开箱即损贴纸者，但有质量问题除外；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">将商品存储、暴露在超出商品适宜的环境中；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">未经授权的修理、误用、疏忽、滥用、事故、改动、不正确的安装；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">食物或液体溅落造成损坏；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品使用中出现的磨损，非质量问题。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">手表表带经过调整，但有质量问题除外。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">非质量问题。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、珠宝首饰类及礼品类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">对于附带国家级宝玉石鉴定中心出具的鉴定证书的，非质量问题不予换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客在收到商品之日起（以发票日期为准）</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个月内，如果出现质量问题，请到当地的质量监督部门</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">珠宝玉石质量检验中心进行检测，如检测报告确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货时，请您务必将商品的外包装、内带附件、鉴定证书、说明书等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">对于高档首饰都附带国家级宝玉石鉴定中心出具的鉴定证书，如果您对此有任何质疑，请到出具该证书的鉴定机构进行复检。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">瑞士军刀、</span><span lang=\\\"EN-US\\\">zippo</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">打火机、钻石、</span><span lang=\\\"EN-US\\\">18K</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">金，如无质量问题不换货，有质量问题请出示检测报告，方可换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为了保证您的利益，请您在收到商品时，仔细检查，如果您发现有任何问题，请您当时指出，并办理换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、软件类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">软件类商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如出现质量问题请您直接按照说明书上的联系方式与厂家的售后部门联系解决；已打开塑封包装，不予退换货，但有质量问题除外。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">11</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、手机、数码相机、数码摄像机、笔记本电脑等商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客收到商品之日起（以发票日期为准）七日内，有非人为质量问题凭有效检测报告可选择退换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客收到商品之日起（以发票日期为准）八至十五日内，有非人为质量问题凭有效检测报告可选择更换同型号商品。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客收到商品之日起（以发票日期为准）十六日至一年内，有非人为质量问题可在当地保修点免费保修。配件保修请参阅保修卡。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为了您的自身权益请妥善保存发票和保修卡，如有发生质量问题请携带发票和保修卡及时到当地检测点检测，以免给您造成不必要的损失。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退换货要求：保修卡、发票、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站发货清单、有效检测报告一律齐全，并且配件完整，包装盒完好，否则将不予受理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">全国各地检测、保修点请在保修卡中查找。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不接受无检测报告</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">并且不在规定时间内的退换货要求。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换机产生的邮费由买卖双方各自承担。换货商品一律以邮寄的方式发出。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货地址及联系电话详见各商品页面“售后服务”。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如需换货请您先联系</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服，在客服人员指导下，一律以邮寄方式完成换货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">12</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、数码类（手机、数码相机、数码摄像机、笔记本电脑除外）</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">13</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、电脑办公类</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">14</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、家电类</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系，如果确认属于质量问题，持厂家出具质量问题检测报告与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">15</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、康体保健器材类商品</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">16</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、汽车用品类</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">汽车养护用品、汽车耗材开封后不换货。（例如车蜡、防护贴膜、清洗剂、车内空气净化、车用油品等）</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>','1303975802' ); 
INSERT INTO `w_help` VALUES( '40','5','0','退货说明','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站承诺自顾客收到商品之日起</span><span lang=\\\"EN-US\\\">7</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">日内（以发票日期为准，如无发票以</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站发货清单的日期为准），如符合以下条件，我们将提供全款退货的服务：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、商品及商品本身的外包装没有损坏，保持</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站出售时的原质原样；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、注明退货原因，如果商品存在质量问题，请务必说明；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、确保商品及配件、附带品或者赠品、保修卡、三包凭证、发票、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站发货清单齐全；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、如果成套商品中有部分商品存在质量问题，在办理退货时，必须提供成套商品；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站中的部分商品是由与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站签订合同的商家提供的，这些商品的退货请与商家联系</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">以下情况不予办理退货：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、任何非由</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站出售的商品；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、任何已使用过的商品，但有质量问题除外；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、任何因非正常使用及保管导致出现质量问题的商品。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">特殊说明：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、食品、保健食品类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">食品类商品不予退货，但有质量问题除外；如商品过期或距离保质期结束不到</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个月。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、美妆个护类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">化妆品及个人护理用品属于特殊商品不予退货，但有质量问题除外，如商品包装破损，商品过期或离过期不到</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个月。我们保证商品的进货渠道和质量，如果您在使用时对商品质量表示置疑，请出具书面鉴定，我们会按照国家法律规定予以处理。因个人喜好（气味，色泽、型号，外观）和个人肤质不同要求的退货将无法受理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、母婴用品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品签收后不予退货，但有质量问题除外，洗涤方法参考说明，正常缩水</span><span lang=\\\"EN-US\\\">10%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">以内正常，不属于质量问题。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、服装类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">内衣类商品，如内衣裤，袜子，文胸类商品，除质量问题除外，不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、鞋帽箱包类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品配件（如配饰挂坠等）、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、玩具类：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品签收后不予退货，但有质量问题除外。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、家居类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤），不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品吊牌，包装破损，发货单、商品配件、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、手表类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">手表类商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">以下情况不予办理退货：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果商品自身携带的产品序列号与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站售出的不符；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">缺少随商品附带的保修卡、发票、配件等；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品已打开塑封包装或撕开开箱即损贴纸者，但有质量问题除外；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">将商品存储、暴露在超出商品适宜的环境中；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">未经授权的修理、误用、疏忽、滥用、事故、改动、不正确的安装；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">食物或液体溅落造成损坏；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品使用中出现的磨损，非质量问题。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">手表表带经过调整，但有质量问题除外。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">非质量问题。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、珠宝首饰类及礼品类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">对于附带国家级宝玉石鉴定中心出具的鉴定证书的，非质量问题不予退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客在收到商品之日起（以发票日期为准）</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个月内，如果出现质量问题，请到当地的质量监督部门</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">珠宝玉石质量检验中心进行检测，如检测报告确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退货时，请您务必将商品的外包装、内带附件、鉴定证书、说明书等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">对于高档首饰都附带国家级宝玉石鉴定中心出具的鉴定证书，如果您对此有任何质疑，请到出具该证书的鉴定机构进行复检。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">瑞士军刀、</span><span lang=\\\"EN-US\\\">zippo</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">打火机、钻石、</span><span lang=\\\"EN-US\\\">18K</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">金，如无质量问题不退货，有质量问题请出示检测报告，方可退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为了保证您的利益，请您在收到商品时，仔细检查，如果您发现有任何问题，请您当时指出，并办理退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、软件类商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">软件类商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如出现质量问题请您直接按照说明书上的联系方式与厂家的售后部门联系解决；已打开塑封包装，不予退换货，但有质量问题除外。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">11</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、手机、数码相机、数码摄像机、笔记本电脑等商品：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客收到商品之日起（以发票日期为准）七日内，有非人为质量问题凭有效检测报告可选择退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客收到商品之日起（以发票日期为准）八至十五日内，有非人为质量问题凭有效检测报告可选择更换同型号商品。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">顾客收到商品之日起（以发票日期为准）十六日至一年内，有非人为质量问题可在当地保修点免费保修。配件保修请参阅保修卡。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为了您的自身权益请妥善保存发票和保修卡，如有发生质量问题请携带发票和保修卡及时到当地检测点检测，以免给您造成不必要的损失。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退换货要求：保修卡、发票、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站发货清单、有效检测报告一律齐全，并且配件完整，包装盒完好，否则将不予受理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">6)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">全国各地检测、保修点请在保修卡中查找。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">7)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不接受无检测报告</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">并且不在规定时间内的退换货要求。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">8)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换机产生的邮费由买卖双方各自承担。换货商品一律以邮寄的方式发出。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">9)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货地址及联系电话详见各商品页面“售后服务”。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">10)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如需退货请您先联系</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服，在客服人员指导下，一律以邮寄方式完成退货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">12</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、数码类（手机、数码相机、数码摄像机、笔记本电脑除外）</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">13</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、电脑办公类</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">14</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、家电类</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系，如果确认属于质量问题，持厂家出具质量问题检测报告与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">15</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、康体保健器材类商品</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">16</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、汽车用品类</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">汽车养护用品、汽车耗材开封后不予退货。（例如车蜡、防护贴膜、清洗剂、车内空气净化、车用油品等）</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\"><br />\r\n</span></p>','1303975837' ); 
INSERT INTO `w_help` VALUES( '41','5','0','退/换货注意事项','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、邮寄时请认真填写以下信息，否则将影响您的退</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货办理：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　·您的姓名</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　·收货地址、</span><span lang=\\\"EN-US\\\">Email</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　·订单号、商品名称和型号</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">　·退</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货原因</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、如需检验报告的商品</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">您还需要提供检验报告，查看退货说明、换货说明；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、请您在收到商品后尽快进行“确认收货”操作，否则将会影响您的退</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货的办理；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的部分商品是由与</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站合作的商家提供的，此商品的退</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换货流程请直接与商家联系。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975866' ); 
INSERT INTO `w_help` VALUES( '42','5','0','余额的使用与提现','<p class=\"\\&quot;MsoNormal\\&quot;\"><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">一、账户余额支付：</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">1</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、“我的</span><span lang=\"\\&quot;EN-US\\&quot;\">iWebShop</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;\">网站</span><span lang=\"\\&quot;EN-US\\&quot;\">-</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">账户管理”是您在</span><span lang=\"\\&quot;EN-US\\&quot;\">iWebShop</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;\">网站上的专用帐户。</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">2</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、账户内的金额是顾客在</span><span lang=\"\\&quot;EN-US\\&quot;\">iWebShop</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;\">网站购物后余下的现金或通过邮局、银行多余汇款的总和，如下图：</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">3</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、您可登录“我的</span><span lang=\"\\&quot;EN-US\\&quot;\">iWebShop</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;\">网站”查询余额。</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">4</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、在订单结算时，系统将自动使用您的账户余额，您只需支付其余货款：</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">5</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、如果您的账户余额足以支付订单，您仍需选择一种支付方式，否则将无法提交订单。</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">二、账户余额提现</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">iWebShop</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">网站为您提供了账户余额提现功能，您可以将您在</span><span lang=\"\\&quot;EN-US\\&quot;\">iWebShop</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;\">网站账户余额中的可用余额提取为现金，我们会已邮局汇款的方式退给您。</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">账户余额提现的流程：</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">温馨提示：</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">1</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、账户余额内的现金只能以邮局汇款方式提现；</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">2</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、每日提现次数不超过</span><span lang=\"\\&quot;EN-US\\&quot;\">1</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">次；</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">3</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、提现账户余额，需向邮局支付一定比例的手续费：</span><span lang=\"\\&quot;EN-US\\&quot;\">200</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">元以下</span><span lang=\"\\&quot;EN-US\\&quot;\">2</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">元，</span><span lang=\"\\&quot;EN-US\\&quot;\">200</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">元以上</span><span lang=\"\\&quot;EN-US\\&quot;\">1%</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">，最高不超过</span><span lang=\"\\&quot;EN-US\\&quot;\">50</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">元；</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">4</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、账户余额提现服务暂不支持国外和港澳台地区；</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">5</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、若您提现失败，邮局不退回相应的手续费；</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">6</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、提现金额不可大于可用余额；</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">7</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、申请提现后，</span><span lang=\"\\&quot;EN-US\\&quot;\">iWebShop</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;\">网站处理时限是</span><span lang=\"\\&quot;EN-US\\&quot;\">3</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">个工作日，邮局处理时限是</span><span lang=\"\\&quot;EN-US\\&quot;\">14</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">个工作日；</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\">8</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">、常见提现失败原因：</span><span lang=\"\\&quot;EN-US\\&quot;\">1</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">）逾期退汇；</span><span lang=\"\\&quot;EN-US\\&quot;\">2</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">）地址不详；</span><span lang=\"\\&quot;EN-US\\&quot;\">3</span><span style=\"\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;\">）原地址查无此人</span></p>\r\n<p class=\"\\&quot;MsoNormal\\&quot;\"><span lang=\"\\&quot;EN-US\\&quot;\"><o:p>&nbsp;</o:p></span></p>','1303975894' ); 
INSERT INTO `w_help` VALUES( '43','5','0','发票制度','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">发票政策</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、发票性质</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站提供的是“</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">公司销售商品专用发票”或“</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">有限公司销售商品专用发票”</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、发票信息</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">发票抬头：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）发票抬头不能为空；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）您可填写：“个人”、您的姓名、或您的单位名称</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">发票内容：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站可开具的发票内容：图书、音像、游戏、软件、资料、办公用品、</span><span lang=\\\"EN-US\\\">IT</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">数码、通讯器材、体育休闲、礼品、饰品、汽车用品、化妆品、家用电器、玩具、箱包皮具，请您根据需要选择</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）数码、手机、家电类商品的发票内容只能开具商品名称和型号，无法开具其它内容</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">发票金额：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站仅开具现金购物金额的发票，不含运费、礼券、礼品卡金额</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">温馨提示：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）请您在收货时向送货员索取运费发票</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）此政策仅适用于</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站自营，若您订购商店街的商品，请与商家联系确认</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">索取发票</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">请在提交订单时的结算页面，选择“索取发票”，按照提示填写发票抬头、选择发票内容，发票将会随您的订单商品一起送达：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">温馨提示：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">若您订购了数码、手机、家电类商品，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站只能将发票内容开具商品的名称和型号</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）补开</span><span lang=\\\"EN-US\\\">/</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">换开发票期限：订单发货后一年以内</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）若您提交订单时未选择发票，请接收到商品后在补开发票期限内</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">发邮件至客服邮箱</span><span lang=\\\"EN-US\\\">service@cs.dangdang.com</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，并注明您的订单号、发票抬头、发票内容、邮寄地址、邮编及收件人，我们会在五个工作日内为您开具发票并以平信方式为您寄出</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）若您接收到的发票信息有误，请在换开发票期限内，将原发票寄至以下地址，同时请务必注明您的订单号、正确的发票抬头、内容、新发票的邮寄地址、邮编、收件人，我们收到后，会在五个工作日内为您重新开具发票以平信方式寄出</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮寄地址：</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">信箱</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮编：</span><span lang=\\\"EN-US\\\">000000</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">温馨提示：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）若您订购的是数码、手机、家电类商品，发票内容只能开具商品名称和型号，无法开具其他内容</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（</span><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）若您订购商店街的商品，请与商家联系索取发票</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975926' ); 
INSERT INTO `w_help` VALUES( '44','7','0','关于我们','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">Jooyea</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">技术团队</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">济南聚易信息技术有限公司（</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">）专注于基于开源协作的云计算及云服务技术，其高负载高扩展能力的分布式计算与服务技术体系，已成为开源社区软件领域领先的云计算技术平台，该平台通用产品化的名称为</span><span lang=\\\"EN-US\\\">iWeb SuperInteraction</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">，简称</span><span lang=\\\"EN-US\\\">iWebSI</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">。</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">的云计算技术框架可涵盖</span><span lang=\\\"EN-US\\\">Internet</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">和移动互联网。依托具有自主知识产权的云技术平台，</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">发起了一系列高负载高度交互类的开源软件产品，其产品线由社会化网络服务</span><span lang=\\\"EN-US\\\">(iWebSNS)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">、社区电子商务</span><span lang=\\\"EN-US\\\">(iWebShop&amp;Mall)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、即时通讯服务</span><span lang=\\\"EN-US\\\">(iWebIM)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">等产品构成。由于领先的高负载技术体系和先进的产品理念，</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">从一开始运作就得到天使投资人的注资。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的产品愿景和团队理念是“开放、分享、共赢、丰富互联网”。</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">提倡互联网的开放、创新和共创机遇，而不单单像盈利或者商业组织那样只强调商业利益。并且，</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">把成功定义为丰富、繁荣的互联网市场面貌。在这种环境下，互联网上的众多站点应该呈现出不同的形态、风貌，体现出个性化，真正塑造每一个站点的“性格”，让每一个站点“</span><span lang=\\\"EN-US\\\">Live</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">起来”，避免同质化。从而真正做到用技术实现创意，用创意丰富生活，使人们的网络生活变得更加丰富多彩。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">JooyeaTech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">遵循开源社区互动提升产品的原则，不闭门造车。这也是开源软件的精髓所在。所以和</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">在一起，即便是个人站长，也可以自信的说：“我不是一个人！”做永远的</span><span lang=\\\"EN-US\\\">Beta</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">版，</span><span lang=\\\"EN-US\\\">Jooyea Tech</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">正在、也会一直这样：通过与用户构建良好互动，倾听用户的意见和批评，吸取大众的智慧，来改善产品，形成产品发布</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">用户使用</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">用户反馈</span><span lang=\\\"EN-US\\\">-</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">产品改进的良性循环。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">Jooyea</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的团队宗旨</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">致力于帮助在线企业平滑实现规模化。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">Jooyea</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">的服务口号</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">用我们领先的技术，服务于您的全球客户。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975962' ); 
INSERT INTO `w_help` VALUES( '45','7','0','常见问题','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站所售商品都是正品行货吗？有售后保修吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站所售商品都是正品行货，均自带机打发票。凭</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站发票，所有商品都可以享受生产厂家的全国联保服务。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站将严格按照国家三包政策，针对所售商品履行保修、换货和退货的义务。您也可以到</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站任一分公司售后部享受售后服务。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：购买的商品能开发票？如果是公司购买，可以开增值税发票吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站所售商品都是正品行货，每张订单均自带中文机打的“商品专用发票”，此发票可用作单位报销凭证。发票会随包裹一同发出，发票金额含配送费金额。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">企业客户在提供《一般纳税人证书》、《营业执照》、《税务登记证》、《开户许可证》四类证件复印件后，可向</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站开取增值税发票，开好后，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站会以快递方式为您寄出。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：各种库存状态是什么意思？下单多久后可以发货？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：现货：库存有货，下单后会尽快发货，您可以立即下单；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">在途：商品正在内部配货，一般</span><span lang=\\\"EN-US\\\">1-2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天有货，您可立即下单；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">预订：商品正在备货，一般下单后</span><span lang=\\\"EN-US\\\">2-20</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天可发货，您可立即下单；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">无货：商品已售完，相应物流中心覆盖地区内的用户不能下单购买。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：无货商品什么时候能到货？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：无货商品的到货时间根据配货情况而不同，无法准确估计，但您可以使用“到货通知”功能，一旦商品有货，我们会通过电子邮件等方式通知您。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：下单后何时可以收到货？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：在商品有现货的情况下，下单后一般</span><span lang=\\\"EN-US\\\">24</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">小时内可收到货（郊区县配送时间可能会更长一些）；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">其它地区用户，将根据您的收货地址及所选择的配送方式而不同，一般到货时间在</span><span lang=\\\"EN-US\\\">1-7</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天（极偏远地区配送时间可能会更长一些）；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果商品处于预订或在途状态，那么还应加上调配货时间。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：快递费是多少？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：凡选用“</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站快递”或“快递运输”的会员即可享受免运费优惠。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：在线支付支持哪些银行卡？支持大额支付吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：我们为您提供几乎全部银行的银行卡及信用卡在线支付，只要您开通了“网上支付”功能，即可进行在线支付，无需手续费，实时到帐，方便快捷。（如客户原因取消订单退款，则需要客户承担</span><span lang=\\\"EN-US\\\">1%</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">平台手续费）如您订单金额较大，可以使用快钱支付中的招行、工行、建行、农行、广发进行一次性大额支付（一万元以下）。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站购物支持信用卡分期付款吗？如何申请？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站目前支持中国银行、招商银行两家银行的信用卡分期付款，只要商品单价在</span><span lang=\\\"EN-US\\\">500</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">元以上，您即可点击“信用卡分期付款”按钮申请分期付款</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：上门提货、货到付款支持刷卡吗？周末可以自提吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站全部自提点均支持现金及刷卡支付，绝大部分货到付款地区支持现金及刷卡支付</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站自提点营业时间一律为：周一至周日，</span><span lang=\\\"EN-US\\\">09:00</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">－</span><span lang=\\\"EN-US\\\">19:00</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">（如遇法定假日，以商城新闻公告为准）。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：下单时可以指定送货时间吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：可以，您下单时可以选择“只工作日送货</span><span lang=\\\"EN-US\\\">(</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">双休日、假日不用送</span><span lang=\\\"EN-US\\\">)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">”、“工作日、双休日与假日均可送货”、“只双休日、假日送货</span><span lang=\\\"EN-US\\\">(</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">工作日不用送</span><span lang=\\\"EN-US\\\">)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">”等时间类型，并选择是否提前电话确认。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">另外，您还可以在订单备注里填写更具体的需求，我们会尽量满足您的要求。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：哪些地区支持货到付款？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站已在多个省市开通了货到付款</span><span lang=\\\"EN-US\\\">(</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">其它城市正陆续开通</span><span lang=\\\"EN-US\\\">)</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，您可使用现金、移动</span><span lang=\\\"EN-US\\\">POS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">机当面付款收货</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：收货时发现问题可以拒收吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：在签收货物时如发现货物有损坏，请直接拒收退回我公司，相关人员将为您重新安排发货。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：如果我刚刚下单商品就降价了，能给我补偿吗？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的商品价格随市场价格的波动每日都会有涨价、降价或者优惠等变化。如果下完订单后价格发生了变化，可到“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站”自主申请价格保护</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：下单后，我能做什么？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：如果是在线支付方式，请您尽快完成付款，待付款被确认后我们会立即为您发货，</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如果选择自提或货到付款，您可以进入“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站”，在“订单列表”中找到您的订单，然后可随时查看订单处理状态，做好收货或者上门自提的准备。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">在您成功购物后，您还可以发表商品评价，向其他用户分享商品使用心得。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：为什么我无法登陆商城？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：首先要检查您的用户名、密码是否正确，确认您的浏览器是否支持</span><span lang=\\\"EN-US\\\">COOKIE</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：产品如何保修？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站销售的商品都以商品说明中的保修承诺为准。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：订单得到确认后我该做什么？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：按照订单所提示的实际应汇款金额，汇款至该订单所在的公司账号内，汇款交易成功后，登陆“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站”查看您的订单，在订单中的“汇款备注”中输入您的相关汇款信息</span><span lang=\\\"EN-US\\\">(</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">例如：汇入行、汇入我司银行账号的实际金额、汇款日期和汇入账号、订单号等），等待我司财务人员确认汇款。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：汇款确认后多久能够将货物发出？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：正常情况下会在工作时间</span><span lang=\\\"EN-US\\\">24-48</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">小时内可以将您的货物发出。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：非商品自身质量问题是否可以退货？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：部分商品在不影响二次销售的情况下，加收一定的退货手续费，是可以办理退货的，详情请查看“退换货政策”</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：在哪能填写汇款信息？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：首先要在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站”，点击左侧的“订单中心”，即可查看到您所有的订单，点击汇款订单后面的“查看”，打开后下拉页面，有“付款信息未完成</span><span lang=\\\"EN-US\\\">,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">请您尽快填写</span><span lang=\\\"EN-US\\\">.</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">”一项，直接在里面填写汇款信息，然后提交即可，相关人员在查收到您的汇款信息后会进行核实，无异议的汇款会在三个工作小时内确认完毕，如有问题，相关人员会电话与您联系。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：怎样咨询商品的详细信息？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：请您在该商品页面下方“购买咨询”处进行提问，相关商品管理员会为您回复。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：在哪进行在线支付？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站”，进入后点击左侧的“在线支付”，点击进入后就可以进行在线支付了。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：工作时间？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：客服中心受理热线电话及订单处理时间为</span><span lang=\\\"EN-US\\\">7x24</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">小时全天候服务；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">自提接待时间为周一至周日</span><span lang=\\\"EN-US\\\">9</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：</span><span lang=\\\"EN-US\\\">00-19</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">：</span><span lang=\\\"EN-US\\\">00</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注：如遇国家法定节假日，则以</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站新闻发布放假时间为准，请大家届时关注。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：如何将退款打回银行卡？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：在投诉中心留言相关信息，如银行卡的开户行</span><span lang=\\\"EN-US\\\">(</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">详细到支行）、开户姓名、卡号，相关人员会为您处理，退款周期视您的货物是否发出而定，如果货物未出库发出，退款会在三个工作日内完成；如果货物已发出，则需货物返回我司物流中心后为您办理退款。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：商品包装问题？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：我司所发送商品均由专人进行打包，商品在未签收前都由我司负责，如在收到商品时发现包装有破损或是其它方面问题，请直接致电我司客服</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">，客服人员会帮您解决。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：怎样申请高校代理送货？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站”，进入后点击左侧的“个人资料”，在“所在学校”一栏中选择您所在的院校，</span><span lang=\\\"EN-US\\\">(</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">如没有您所在的院校，则说明您的学校暂未开通高校代理，您将无法选择高校代理送货），然后点击底部的“修改”，我司相关人员在收到申请后的</span><span lang=\\\"EN-US\\\">24</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">个工作小时内进行审核，审核通过后，您下单时就可以选择高校代理送货了，高校代理订单的运费按照钻石（双钻）会员普通快递运费标准收取，具体请您参照帮助中心中快递运输页面的“普通快递收取标准一览表”，货物由代理直接送达，货款由高校代理收取。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：拍卖成功后如何转成订单？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站”，进入后点击左侧的“我的拍卖”，在“操作”处有一个“转成订单”按钮，点击该按钮就可以转成订单了，在左侧“订单中心”处可查询到该订单，和商品订单一样，您可以直接进行支付。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：订单付款后，如果长时间未收到货，我是否可以申请办理退款？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：非</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站快递覆盖区域内，由第三方快递公司负责直接送达的订单，如圆通快递，自发货时间算起超过</span><span lang=\\\"EN-US\\\">10</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天仍未收到货或收货地址超出第三方快递覆盖的区域，由第三方快递转邮政，如圆通转</span><span lang=\\\"EN-US\\\">EMS</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">等，自发货时间算起超过</span><span lang=\\\"EN-US\\\">20</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">天仍未收到货，可致电客服中心，由客服人员为您申请办理退款事宜。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">问：如果我有问题或建议是否可以通过邮件向你们反馈？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">答：可以。</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站受理建议或投诉的邮箱是：</span><span lang=\\\"EN-US\\\">service@iwebshop.com</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303975993' ); 
INSERT INTO `w_help` VALUES( '46','7','0','找回密码','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">忘记了帐户密码？</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">不用担心，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站提供找回密码服务，您点击</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">忘记密码</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">按照系统提示操作即可。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">操作步骤详解如下：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站登陆页面，点击</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">忘记密码</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、按照提示，填写您在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站的注册邮箱及验证码</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、系统提示成功发送“密码重置”邮件，若您长时间未收到，可以点击“重新发送”</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、登陆您的个人邮箱，找到“</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站新密码重置确认信</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站新密码重置确认信”点击“设置新密码”</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、按照系统提示，设置新密码即可</span><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">温馨提示：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">为了确保顾客注册信息的安全，</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站只提供网上找回密码服务，若您忘记</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站注册邮箱或是忘记注册邮箱的登陆密码，请</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">注册新用户</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303976019' ); 
INSERT INTO `w_help` VALUES( '47','7','0','退订邮件/短信','<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站保留通过邮件和短信的形式，对本网站注册、购物用户发送订单信息、促销活动等告知服务的权利。如果您在</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\">网站注册、购物，表明您已默示接受此项服务。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">若您不希望接收</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的邮件，请在邮件下方输入您的</span><span lang=\\\"EN-US\\\">E-mail</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">地址自助完成退阅；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">若您不希望接收</span><span lang=\\\"EN-US\\\">iWebShop</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">网站的短信，请提供您的手机号码</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">联系客服</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">处理。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303976040' ); 
INSERT INTO `w_help` VALUES( '48','7','0','联系客服','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮件联系</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">Kefu@jooyea.cn</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">电话联系</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">客服中心电话热线工作时间：</span><span lang=\\\"EN-US\\\">24</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">小时全天候</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">客服热线：</span><span lang=\\\"EN-US\\\">*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">客服传真：</span><span lang=\\\"EN-US\\\">*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮局汇款地址：</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">信箱</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">邮编：</span><span lang=\\\"EN-US\\\">*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">邮政信箱地址：</span><span lang=\\\"EN-US\\\">*****</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">分箱</span> <span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\\">邮编：</span><span lang=\\\"EN-US\\\">*****</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">在线问答</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\">iWebIM</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">在线客服</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303976070' ); 
INSERT INTO `w_help` VALUES( '49','7','0','诚聘英才','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">测试工程师</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">岗位职责：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、负责公司互联网产品和项目的测试工作，搭建测试环境，确保产品和项目质量；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、编写测试计划，测试大纲和测试用例；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、对测试过程中发现的问题进行跟踪分析和报告并推动问题及时合理地解决；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、按照测试计划编写测试脚本和测试程序对产品进行功能、强度、性能测试；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、通过对产品的测试，保证产品质量达到指定质量目标，并能够提出进一步改进的要求并依照执行。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">岗位要求：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、相关专业专科以上学历，至少</span><span lang=\\\"EN-US\\\">1</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">年以上测试经验；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>2</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、熟悉测试流程，测试用例与测试计划的编写；熟悉各种</span><span lang=\\\"EN-US\\\">Bug</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">管理和测试管理工具；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>3</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、较强的发现问题，分析问题的能力；较强的语言表达和文档撰写能力，能根据产品需求编写测试用例；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>4</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、工作责任心强，细致，耐心；</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><span style=\\\"mso-spacerun:yes;\\\">&nbsp;&nbsp;&nbsp; </span>5</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">、能承受较大的工作压力。</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">联系人：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">联系方式：</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303976088' ); 
INSERT INTO `w_help` VALUES( '50','7','0','友情链接','<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">申请友链</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">链接显示的顺序以提交的先后顺序为准</span><span lang=\\\"EN-US\\\">.</span></p>\r\n<p class=\\\"MsoNormal\\\"><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">申请链接请将你的网站名称</span><span lang=\\\"EN-US\\\">\\\\logo\\\\</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">链接地址</span><span lang=\\\"EN-US\\\">\\\\</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">联系人等信息发至信箱：</span><span lang=\\\"EN-US\\\">admin@iwebshop.com,</span><span style=\\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\">经我们网站管理员审核后再更新上线</span></p>\r\n<p class=\\\"MsoNormal\\\"><span lang=\\\"EN-US\\\"><o:p>&nbsp;</o:p></span></p>','1303976108' ); 
INSERT INTO `w_help` VALUES( '52','5','0','售后服务','<div style=\"display:block;\" class=\"mc tabcon hide\">\r\n                    本产品全国联保，享受三包服务，质保期为：十五天质保<br />\r\n				</div>\r\n				\r\n				\r\n				<div id=\"promises\">\r\n					<strong>Iweb商城服务承诺：</strong><br />\r\n<strong>Iweb</strong>商城向您保证所售商品均为正品行货，自带机打发票，与商品一起寄送。凭质保证书及<strong>Iweb</strong>商城发票，可享受全国联保服务，与您亲临商场选购的商品享受相同的质量保证。<br />\r\n<strong>Iweb</strong>商城还为您提供具有竞争力的商品价格和免运费政策，请您放心购买！ \r\n				</div>\r\n				<div id=\"state\"><strong>声明:</strong>因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</div>','1305696881' ); 
INSERT INTO `w_help` VALUES( '53','4','0','支付帮助','Iweb商城为您提供以下7种支付方式<br />\r\n货到付款： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n我们在以下省市开通了货到付款(其他城市正陆续开通)，您可使用现金、移动POS机（部分地区支持刷卡）当面付款收货，点击城市名可查看详细配送范围及运费：<br />\r\n北京&nbsp;&nbsp; 上海&nbsp;&nbsp; 广州&nbsp;&nbsp; 广东（不含广州）&nbsp;&nbsp; 天津&nbsp;&nbsp; 杭州&nbsp;&nbsp; 山东&nbsp;&nbsp; 厦门&nbsp;&nbsp; 武汉&nbsp;&nbsp; 成都&nbsp;&nbsp; 深圳&nbsp;&nbsp; 西安&nbsp;&nbsp; 宁波&nbsp;&nbsp; 东莞&nbsp;&nbsp; 沈阳&nbsp;&nbsp; 福州&nbsp;&nbsp; 重庆&nbsp;&nbsp; 温州&nbsp;&nbsp; 长沙&nbsp;&nbsp; 哈尔滨&nbsp;&nbsp; 佛山&nbsp;&nbsp; 郑州&nbsp;&nbsp; 嘉兴&nbsp;&nbsp; 廊坊&nbsp;&nbsp; 绍兴&nbsp;&nbsp; 金华&nbsp;&nbsp; 珠海&nbsp;&nbsp; 太原&nbsp;&nbsp; 大连&nbsp;&nbsp; 长春&nbsp;&nbsp; 南昌&nbsp;&nbsp; 合肥&nbsp;&nbsp; 昆明&nbsp;&nbsp; 石家庄&nbsp;&nbsp; 浙江&nbsp;&nbsp; 贵州&nbsp;&nbsp; 兰州&nbsp;&nbsp; 南宁&nbsp;&nbsp; 呼和浩特&nbsp;&nbsp; 江苏&nbsp;&nbsp; 四川&nbsp;&nbsp; 惠州&nbsp;&nbsp; 烟台<br />\r\n在线支付： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n我们为您提供几乎全部银行的银行卡及信用卡在线支付，只要您开通了\"网上支付\"功能，即可进行在线支付，无需手续费，实时到帐，方便快捷，支付限额说明&gt;&gt;<br />\r\n<br />\r\n您还可以使用以下支付平台进行在线支付及帐户余额付款：<br />\r\n来Iweb自提： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n我们在以下城市开通了自提点(其他城市正陆续开通)，您可就近选择自提点当面付款提货，无需支付运费，点击城市名可查看详细地点及公交线路：<br />\r\n北京&nbsp;&nbsp; 上海&nbsp;&nbsp; 广州&nbsp;&nbsp; 深圳&nbsp;&nbsp; 东莞&nbsp;&nbsp; 佛山&nbsp;&nbsp; 珠海&nbsp;&nbsp; 惠州&nbsp;&nbsp; 天津&nbsp;&nbsp; 苏州&nbsp;&nbsp; 无锡&nbsp;&nbsp; 南京&nbsp;&nbsp; 宿迁&nbsp;&nbsp; 昆山&nbsp;&nbsp; 南通&nbsp;&nbsp; 常州&nbsp;&nbsp; 常熟&nbsp;&nbsp; 杭州&nbsp;&nbsp; 宁波&nbsp;&nbsp; 温州&nbsp;&nbsp; 嘉兴&nbsp;&nbsp; 绍兴&nbsp;&nbsp; 金华&nbsp;&nbsp; 济南&nbsp;&nbsp; 青岛&nbsp;&nbsp; 烟台&nbsp;&nbsp; 厦门&nbsp;&nbsp; 福州&nbsp;&nbsp; 武汉&nbsp;&nbsp; 成都&nbsp;&nbsp; 绵阳&nbsp;&nbsp; 西安&nbsp;&nbsp; 沈阳&nbsp;&nbsp; 大连&nbsp;&nbsp; 重庆&nbsp;&nbsp; 长沙&nbsp;&nbsp; 哈尔滨&nbsp;&nbsp; 郑州&nbsp;&nbsp; 廊坊&nbsp;&nbsp; 太原&nbsp;&nbsp; 长春&nbsp;&nbsp; 南昌&nbsp;&nbsp; 合肥&nbsp;&nbsp; 昆明&nbsp;&nbsp; 石家庄&nbsp;&nbsp; 贵阳&nbsp;&nbsp; 兰州&nbsp;&nbsp; 南宁&nbsp;&nbsp; 呼和浩特<br />\r\n分期付款： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n单个商品价格在500元以上，可使用中国银行、招商银行发行的信用卡申请分期付款，支持3期、6期、12期付款，查看详细说明&gt;&gt;<br />\r\n公司转帐： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n您可以向Iweb公司的三个公司帐户汇款，到帐时间一般为款汇出后的1-5个工作日，查看公司帐户&gt;&gt;<br />\r\n邮局汇款： &nbsp;&nbsp;&nbsp; 您可通过邮局向Iweb商城付款，到帐时间一般为款汇出后的1-5个工作日，查看汇款地址&gt;&gt;<br />','1305697182' ); 
INSERT INTO `w_help` VALUES( '54','8','0','供销商直通车','123123','1401867392' ); 
INSERT INTO `w_help` VALUES( '55','8','0','企业采购','213123','1401867403' ); 
DROP TABLE IF EXISTS `w_help_category`;
 CREATE TABLE `w_help_category` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(10) NOT NULL  COMMENT '标题',
`sort` smallint(5) NOT NULL  COMMENT '顺序',
`position_left` tinyint(1) NOT NULL  COMMENT '是否在帮助内容、列表页面的左侧显示',
`position_foot` tinyint(1) NOT NULL  COMMENT '是否在整站页面下方显示'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='帮助分类' AUTO_INCREMENT=9;

INSERT INTO `w_help_category` VALUES( '4','支付帮助','2','0','1' ); 
INSERT INTO `w_help_category` VALUES( '3','购物指南','1','0','1' ); 
INSERT INTO `w_help_category` VALUES( '5','售后服务','4','0','1' ); 
INSERT INTO `w_help_category` VALUES( '6','配送帮助','3','0','1' ); 
INSERT INTO `w_help_category` VALUES( '7','帮助信息','5','0','1' ); 
INSERT INTO `w_help_category` VALUES( '8','商家合作','99','0','1' ); 
DROP TABLE IF EXISTS `w_keyword`;
 CREATE TABLE `w_keyword` (
`word` varchar(15) NOT NULL  PRIMARY KEY  COMMENT '关键词',
`goods_nums` int(11) NOT NULL  DEFAULT 1 COMMENT '产品数量',
`hot` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否为热门',
`order` smallint(5) NOT NULL  DEFAULT 99 COMMENT '关键词排序'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='关键词';

INSERT INTO `w_keyword` VALUES( 'iphone4s','1','0','99' ); 
DROP TABLE IF EXISTS `w_log_error`;
 CREATE TABLE `w_log_error` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`file` varchar(200) NOT NULL  COMMENT '文件',
`line` smallint(5) unsigned NOT NULL  COMMENT '出错文件行数',
`content` varchar(255) NOT NULL  COMMENT '内容',
`datetime` datetime NOT NULL  COMMENT '时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='错误日志表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_log_operation`;
 CREATE TABLE `w_log_operation` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`author` varchar(80) NULL  DEFAULT NULL  COMMENT '操作人员',
`action` varchar(200) NULL  DEFAULT NULL  COMMENT '动作',
`content` text NULL  DEFAULT NULL  COMMENT '内容',
`datetime` datetime NOT NULL  COMMENT '时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='日志操作记录' AUTO_INCREMENT=7;

INSERT INTO `w_log_operation` VALUES( '1','管理员:admin','订单更新为已付款','订单号：20140603150231441317，已经确定付款','2014-06-04 10:57:40' ); 
INSERT INTO `w_log_operation` VALUES( '2','管理员:admin','订单更新为作废','订单号：20140603150231441317','2014-06-04 10:59:23' ); 
INSERT INTO `w_log_operation` VALUES( '3','管理员:admin','收款单移除到回收站内','收款单ID：1','2014-06-04 11:00:40' ); 
INSERT INTO `w_log_operation` VALUES( '4','管理员:admin','订单移除到回收站内','订单号：20140603150231441317','2014-06-04 11:00:46' ); 
INSERT INTO `w_log_operation` VALUES( '5','管理员:admin','删除回收站中退货单','退货单ID：1','2014-06-04 11:00:52' ); 
INSERT INTO `w_log_operation` VALUES( '6','管理员:admin','订单更新为已付款','订单号：20140604110116268200，已经确定付款','2014-06-04 11:02:46' ); 
DROP TABLE IF EXISTS `w_log_sql`;
 CREATE TABLE `w_log_sql` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`content` varchar(255) NOT NULL  COMMENT '执行的SQL语句',
`runtime` decimal(15,2) unsigned NOT NULL  COMMENT '语句执行时间(秒)',
`datetime` datetime NOT NULL  COMMENT '发生的时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='SQL日志记录' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_member`;
 CREATE TABLE `w_member` (
`user_id` int(11) unsigned NOT NULL  PRIMARY KEY  COMMENT '用户ID',
`true_name` varchar(50) NULL  DEFAULT NULL  COMMENT '真实姓名',
`telephone` varchar(50) NULL  DEFAULT NULL  COMMENT '联系电话',
`mobile` varchar(20) NULL  DEFAULT NULL  COMMENT '手机',
`area` varchar(255) NULL  DEFAULT NULL  COMMENT '地区',
`contact_addr` varchar(250) NULL  DEFAULT NULL  COMMENT '联系地址',
`qq` varchar(15) NULL  DEFAULT NULL  COMMENT 'QQ',
`msn` varchar(250) NULL  DEFAULT NULL  COMMENT 'MSN',
`sex` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '性别1男2女',
`birthday` date NULL  DEFAULT NULL  COMMENT '生日',
`group_id` int(11) NULL  DEFAULT NULL  COMMENT '分组',
`exp` int(11) NOT NULL  DEFAULT 0 COMMENT '经验值',
`point` int(11) NOT NULL  DEFAULT 0 COMMENT '积分',
`message_ids` text NULL  DEFAULT NULL  COMMENT '消息ID',
`time` datetime NOT NULL  COMMENT '注册日期时间',
`zip` varchar(10) NULL  DEFAULT NULL  COMMENT '邮政编码',
`status` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '用户状态 1正常状态 2 删除至回收站 3锁定',
`prop` text NULL  DEFAULT NULL  COMMENT '用户拥有的工具',
`balance` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '用户余额',
`last_login` datetime NULL  DEFAULT NULL  COMMENT '最后一次登录时间',
`custom` varchar(255) NULL  DEFAULT NULL  COMMENT '用户习惯方式,配送和支付方式等信息'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='用户信息表';

INSERT INTO `w_member` VALUES( '1','','','','','','','','1','','','0','200','','2014-06-03 14:53:24','','1','','5000.00','','a:2:{s:7:\"payment\";i:7;s:8:\"delivery\";i:1;}' ); 
DROP TABLE IF EXISTS `w_merch_ship_info`;
 CREATE TABLE `w_merch_ship_info` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`ship_name` varchar(255) NOT NULL  COMMENT '发货点名称',
`ship_user_name` varchar(255) NOT NULL  COMMENT '发货人姓名',
`sex` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '性别 0:女 1:男',
`country` int(11) NULL  DEFAULT NULL  COMMENT '国id',
`province` int(11) NOT NULL  COMMENT '省id',
`city` int(11) NOT NULL  COMMENT '市id',
`area` int(11) NOT NULL  COMMENT '地区id',
`postcode` varchar(6) NULL  DEFAULT NULL  COMMENT '邮编',
`address` varchar(255) NOT NULL  COMMENT '具体地址',
`mobile` varchar(20) NOT NULL  COMMENT '手机',
`telphone` varchar(20) NULL  DEFAULT NULL  COMMENT '电话',
`is_default` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '1为默认地址，0则不是',
`note` text NULL  DEFAULT NULL  COMMENT '备注',
`addtime` datetime NOT NULL  COMMENT '保存时间',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0为删除，1为显示'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='商家发货点信息' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_message`;
 CREATE TABLE `w_message` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`title` varchar(255) NOT NULL  COMMENT '标题',
`content` text NULL  DEFAULT NULL  COMMENT '内容',
`time` datetime NOT NULL  COMMENT '发送时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='站内消息' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_model`;
 CREATE TABLE `w_model` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '模型ID',
`name` varchar(50) NOT NULL  COMMENT '模型名称',
`spec_ids` text NULL  DEFAULT NULL  COMMENT '规格ID逗号分隔'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='模型表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_msg_template`;
 CREATE TABLE `w_msg_template` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(255) NOT NULL  COMMENT '模板名称',
`title` varchar(255) NULL  DEFAULT NULL  COMMENT '标题',
`content` text NOT NULL  COMMENT '模板内容',
`variable` varchar(255) NULL  DEFAULT NULL  COMMENT '模板中的变量标签'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='消息模板表' AUTO_INCREMENT=4;

INSERT INTO `w_msg_template` VALUES( '1','到货通知','最近到货通知','<p>dear：{$user_name}你关注的商品：{$goods_name}已到货，由于此商品近期销售火爆，请及时购买！</p>\n<p>-------IWeb商场</p>','用户名 {$user_name} 商品名 {$goods_name}' ); 
INSERT INTO `w_msg_template` VALUES( '2','网站订阅','2011年1月最新上架商品','2011年1月最新上架商品','' ); 
INSERT INTO `w_msg_template` VALUES( '3','找回密码','IWeb密码找回','<p>dear：{$user_name}：</p><br /><p>您的新密码为{$password},请您尽快登陆用户中心，修改为您常用的密码！</p><br /><p>-------IWeb商场</p><br />','用户名 {$user_name} 新密码 {$password}' ); 
DROP TABLE IF EXISTS `w_notify_registry`;
 CREATE TABLE `w_notify_registry` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`email` varchar(255) NULL  DEFAULT NULL  COMMENT 'emaill',
`mobile` varchar(20) NULL  DEFAULT NULL  COMMENT '手机',
`register_time` datetime NOT NULL  COMMENT '登记时间',
`notify_time` datetime NULL  DEFAULT NULL  COMMENT '通知时间',
`notify_status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0未通知1已通知'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='到货通知表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_oauth`;
 CREATE TABLE `w_oauth` (
`id` smallint(5) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(80) NOT NULL  COMMENT '名称',
`config` text NULL  DEFAULT NULL  COMMENT '配置信息',
`file` varchar(80) NOT NULL  COMMENT '接口文件名称',
`description` varchar(80) NULL  DEFAULT NULL  COMMENT '描述',
`is_close` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否关闭;0开启,1关闭',
`logo` varchar(80) NULL  DEFAULT NULL  COMMENT 'logo'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='认证方案' AUTO_INCREMENT=5;

INSERT INTO `w_oauth` VALUES( '1','人人网','','renren','人人网开放平台','1','plugins/oauth/images/renren.gif' ); 
INSERT INTO `w_oauth` VALUES( '2','QQ','','qq','腾讯开发平台','1','plugins/oauth/images/qq.gif' ); 
INSERT INTO `w_oauth` VALUES( '3','新浪','','sina','新浪微博的开发平台','1','plugins/oauth/images/sina.gif' ); 
INSERT INTO `w_oauth` VALUES( '4','淘宝','','taobao','淘宝的开放平台','1','plugins/oauth/images/taobao.gif' ); 
DROP TABLE IF EXISTS `w_oauth_user`;
 CREATE TABLE `w_oauth_user` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`oauth_user_id` varchar(80) NOT NULL  COMMENT '第三方平台的用户唯一标识',
`oauth_id` smallint(5) unsigned NOT NULL  COMMENT '第三方平台id',
`user_id` int(11) unsigned NOT NULL  COMMENT '系统内部的用户id',
`datetime` datetime NOT NULL  COMMENT '绑定时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='oauth开发平台绑定用户表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_online_recharge`;
 CREATE TABLE `w_online_recharge` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户id',
`recharge_no` varchar(20) NOT NULL  COMMENT '充值单号',
`account` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '充值金额',
`time` datetime NOT NULL  COMMENT '时间',
`payment_name` varchar(80) NOT NULL  COMMENT '充值方式名称',
`status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '充值状态 0:未成功 1:充值成功'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='在线充值表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_order`;
 CREATE TABLE `w_order` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`order_no` varchar(20) NOT NULL  COMMENT '订单号',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`pay_type` int(11) NOT NULL  COMMENT '支付方式ID,当为0时表示货到付款',
`distribution` int(11) NULL  DEFAULT NULL  COMMENT '配送ID',
`status` tinyint(1) NULL  DEFAULT 1 COMMENT '订单状态1:生成订单,2：确认订单,3取消订单,4作废订单,5完成订单',
`pay_status` tinyint(1) NULL  DEFAULT 0 COMMENT '支付状态 0：未支付，1：已支付，2：退款',
`distribution_status` tinyint(1) NULL  DEFAULT 0 COMMENT '配送状态0：未发送，1：已发送',
`accept_name` varchar(20) NOT NULL  COMMENT '收货人姓名',
`postcode` varchar(6) NULL  DEFAULT NULL  COMMENT '邮编',
`telphone` varchar(20) NULL  DEFAULT NULL  COMMENT '联系电话',
`country` int(11) NULL  DEFAULT NULL  COMMENT '国ID',
`province` int(11) NULL  DEFAULT NULL  COMMENT '省ID',
`city` int(11) NULL  DEFAULT NULL  COMMENT '市ID',
`area` int(11) NULL  DEFAULT NULL  COMMENT '区ID',
`address` varchar(250) NULL  DEFAULT NULL  COMMENT '收货地址',
`mobile` varchar(20) NULL  DEFAULT NULL  COMMENT '手机',
`payable_amount` decimal(15,2) NULL  DEFAULT 0.00 COMMENT '应付商品总金额',
`real_amount` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '实付商品总金额',
`payable_freight` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '总运费金额',
`real_freight` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '实付运费',
`pay_time` datetime NULL  DEFAULT NULL  COMMENT '付款时间',
`send_time` datetime NULL  DEFAULT NULL  COMMENT '发货时间',
`create_time` datetime NULL  DEFAULT NULL  COMMENT '下单时间',
`completion_time` datetime NULL  DEFAULT NULL  COMMENT '订单完成时间',
`invoice` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '发票：0不索要1索要',
`postscript` varchar(255) NULL  DEFAULT NULL  COMMENT '用户附言',
`note` text NULL  DEFAULT NULL  COMMENT '管理员备注',
`if_del` tinyint(1) NULL  DEFAULT 0 COMMENT '是否删除1为删除',
`insured` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '保价',
`if_insured` tinyint(1) NULL  DEFAULT 0 COMMENT '是否保价0:不保价，1保价',
`pay_fee` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '支付手续费',
`invoice_title` varchar(100) NULL  DEFAULT NULL  COMMENT '发票抬头',
`taxes` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '税金',
`promotions` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '促销优惠金额',
`discount` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '订单折扣或涨价',
`order_amount` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '订单总金额',
`if_print` varchar(255) NULL  DEFAULT NULL  COMMENT '已打印的类型,类型的代码以逗号进行分割; shop购物单,pick配货单,merge购物和配货,express快递单',
`prop` varchar(255) NULL  DEFAULT NULL  COMMENT '使用的道具id',
`accept_time` varchar(80) NULL  DEFAULT NULL  COMMENT '用户收货时间',
`exp` smallint(5) unsigned NOT NULL  DEFAULT 0 COMMENT '增加的经验',
`point` smallint(5) unsigned NOT NULL  DEFAULT 0 COMMENT '增加的积分',
`type` tinyint(1) unsigned NOT NULL  DEFAULT 0 COMMENT '0普通订单,1团购订单,2限时抢购',
`trade_no` varchar(255) NULL  DEFAULT NULL  COMMENT '支付平台交易号'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='订单表' AUTO_INCREMENT=3;

INSERT INTO `w_order` VALUES( '2','20140604110116268200','1','7','1','2','1','1','陈家龙','518000','','','440000','440100','440114','龙岗区布吉','15817487535','2999.00','2999.00','20.00','20.00','2014-06-04 11:02:46','2014-06-04 11:03:40','2014-06-04 11:01:16','','0','','','0','0.00','0','0.00','','0.00','0.00','0.00','3019.00','','','任意','0','100','0','' ); 
DROP TABLE IF EXISTS `w_order_goods`;
 CREATE TABLE `w_order_goods` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`order_id` int(11) unsigned NOT NULL  COMMENT '订单ID',
`goods_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '商品ID',
`img` varchar(255) NOT NULL  COMMENT '商品图片',
`product_id` int(11) NULL  DEFAULT NULL  COMMENT '货品ID',
`goods_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '商品价格',
`real_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '实付金额',
`goods_nums` int(11) NOT NULL  DEFAULT 1 COMMENT '商品数量',
`goods_weight` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '重量',
`goods_array` text NULL  DEFAULT NULL  COMMENT '商品和货品名称name和规格value串json数据格式'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='订单商品表' AUTO_INCREMENT=3;

INSERT INTO `w_order_goods` VALUES( '2','2','1','upload/2014/06/03/20140603025153177.jpg','0','2999.00','2999.00','1','0.00','{\"name\":\"iphone4s\",\"value\":\"\"}' ); 
DROP TABLE IF EXISTS `w_order_log`;
 CREATE TABLE `w_order_log` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`order_id` int(11) NULL  DEFAULT NULL  COMMENT '订单id',
`user` varchar(20) NULL  DEFAULT NULL  COMMENT '操作人：顾客或admin',
`action` varchar(20) NULL  DEFAULT NULL  COMMENT '动作',
`addtime` datetime NULL  DEFAULT NULL  COMMENT '添加时间',
`result` varchar(10) NULL  DEFAULT NULL  COMMENT '操作的结果',
`note` varchar(100) NULL  DEFAULT NULL  COMMENT '备注'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='订单日志表' AUTO_INCREMENT=5;

INSERT INTO `w_order_log` VALUES( '1','1','admin','付款','2014-06-04 10:57:40','成功','订单【20140603150231441317】付款3318.9' ); 
INSERT INTO `w_order_log` VALUES( '2','1','admin','作废','2014-06-04 10:59:23','成功','订单【20140603150231441317】作废成功' ); 
INSERT INTO `w_order_log` VALUES( '3','2','admin','付款','2014-06-04 11:02:46','成功','订单【20140604110116268200】付款3019' ); 
INSERT INTO `w_order_log` VALUES( '4','2','admin','发货','2014-06-04 11:03:40','成功','订单【20140604110116268200】发货成功' ); 
DROP TABLE IF EXISTS `w_order_prop_relation`;
 CREATE TABLE `w_order_prop_relation` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`order_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '订单ID',
`prop_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '道具ID',
`user_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '用户ID',
`create_time` datetime NULL  DEFAULT NULL  COMMENT '生成时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='订单与道具表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_payment`;
 CREATE TABLE `w_payment` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(50) NOT NULL  COMMENT '支付名称',
`type` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '1:线上、2:线下',
`class_name` varchar(50) NOT NULL  COMMENT '支付类名称',
`description` text NULL  DEFAULT NULL  COMMENT '描述',
`logo` varchar(255) NOT NULL  COMMENT '支付方式logo图片路径',
`status` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '安装状态 0启用 1禁用',
`order` smallint(5) NOT NULL  DEFAULT 99 COMMENT '排序',
`note` text NULL  DEFAULT NULL  COMMENT '支付说明',
`poundage` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '手续费',
`poundage_type` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '手续费方式 1百分比 2固定值',
`partner_id` varchar(80) NULL  DEFAULT NULL  COMMENT '支付方提供的合作者ID',
`partner_key` varchar(80) NULL  DEFAULT NULL  COMMENT '支付方提供的密钥'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='支付方式表' AUTO_INCREMENT=10;

INSERT INTO `w_payment` VALUES( '1','预存款支付','1','balance','预存款是客户在您网站上的虚拟资金帐户。','/payments/logos/pay_deposit.gif','0','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '2','网银在线支付','1','chinabank','网银在线是中国领先的电子支付解决方案提供商之一。','/payments/logos/pay_chinabank.gif','1','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '3','腾讯财付通','1','tenpay','财付通是腾讯公司创办的中国领先的在线支付平台，致力于为互联网用户和企业提供安全、便捷、专业的在线支付服务。','/payments/logos/pay_tenpay.gif','1','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '4','快钱支付','1','bill99','快钱是国内领先的独立第三方支付企业，旨在为各类企业及个人提供安全、便捷和保密的支付清算与账务服务。','/payments/logos/pay_99bill.gif','1','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '5','支付宝','1','trade_alipay','担保交易支付方式，淘宝买家最熟悉的付款方式：买家先将交易资金存入支付宝并通知卖家发货，买家确认收货后资金自动进入卖家支付宝账户，完成交易。','/payments/logos/pay_alipay.gif','1','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '6','支付宝','1','direct_alipay','即时到帐支付方式，网上交易时，买家的交易资金直接打入卖家支付宝账户，快速回笼交易资金。','/payments/logos/pay_alipay.gif','1','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '7','支付宝','1','alipay','担保+即使双接口支付方式，给于买家充足的自主选择权。','/payments/logos/pay_alipay.gif','0','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '8','PayPal','1','paypal','是全球最大的在线支付平台，同时也是目前全球贸易网上支付标准。','/payments/logos/pay_paypal.gif','1','99','','0.00','1','','' ); 
INSERT INTO `w_payment` VALUES( '9','线下付款','2','offline','iwebshop的线下付款方式','/payments/logos/pay_offline.gif','1','99','','0.00','1','','' ); 
DROP TABLE IF EXISTS `w_point_log`;
 CREATE TABLE `w_point_log` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户id',
`datetime` datetime NOT NULL  COMMENT '发生时间',
`value` int(11) NOT NULL  COMMENT '积分增减 增加正数 减少负数',
`intro` varchar(50) NOT NULL  COMMENT '积分改动说明'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='积分增减记录表' AUTO_INCREMENT=3;

INSERT INTO `w_point_log` VALUES( '1','1','2014-06-04 10:57:40','100','成功购买了订单号：20140603150231441317中的商品,奖励积分100' ); 
INSERT INTO `w_point_log` VALUES( '2','1','2014-06-04 11:02:46','100','成功购买了订单号：20140604110116268200中的商品,奖励积分100' ); 
DROP TABLE IF EXISTS `w_products`;
 CREATE TABLE `w_products` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '货品ID',
`products_no` varchar(20) NOT NULL  COMMENT '货品的货号(以商品的货号加横线加数字组成)',
`spec_array` text NULL  DEFAULT NULL  COMMENT 'json规格数据',
`store_nums` int(11) NOT NULL  DEFAULT 0 COMMENT '库存',
`market_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '市场价格',
`sell_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '销售价格',
`cost_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '成本价格',
`weight` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '重量'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='货品表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_promotion`;
 CREATE TABLE `w_promotion` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`start_time` datetime NOT NULL  COMMENT '开始时间',
`end_time` datetime NOT NULL  COMMENT '结束时间',
`condition` int(11) NOT NULL  COMMENT '生效条件 type=0时为消费额度 type=1时为goods_id',
`type` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '活动类型 0:购物车促销规则 1:商品限时抢购',
`award_value` varchar(255) NULL  DEFAULT NULL  COMMENT '奖励值 type=0时奖励值 type=1时为抢购价格',
`name` varchar(20) NOT NULL  COMMENT '活动名称',
`intro` text NULL  DEFAULT NULL  COMMENT '活动介绍',
`award_type` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '奖励方式:0限时抢购 1减金额 2奖励折扣 3赠送积分 4赠送代金券 5赠送赠品 6免运费',
`is_close` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否关闭 0:否 1:是',
`user_group` text NULL  DEFAULT NULL  COMMENT '允许参与活动的用户组,all表示所有用户组'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='记录促销活动的表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_prop`;
 CREATE TABLE `w_prop` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(50) NOT NULL  COMMENT '道具名称',
`card_name` varchar(32) NULL  DEFAULT NULL  COMMENT '道具的卡号',
`card_pwd` varchar(32) NULL  DEFAULT NULL  COMMENT '道具的密码',
`start_time` datetime NOT NULL  COMMENT '开始时间',
`end_time` datetime NOT NULL  COMMENT '结束时间',
`value` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '面值',
`type` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '道具类型 0:代金券',
`condition` varchar(255) NULL  DEFAULT NULL  COMMENT '条件数据 type=0时,表示ticket的表id,模型id',
`is_close` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否关闭 0:正常,1:关闭,2:下订单未支付时临时锁定',
`img` varchar(255) NULL  DEFAULT NULL  COMMENT '道具图片',
`is_userd` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否被使用过 0:未使用,1:已使用',
`is_send` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否被发送过 0:否 1:是'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='道具表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_quick_naviga`;
 CREATE TABLE `w_quick_naviga` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`admin_id` int(11) unsigned NOT NULL  COMMENT '管理员id',
`naviga_name` varchar(255) NOT NULL  COMMENT '导航名称',
`url` varchar(255) NOT NULL  COMMENT '导航链接',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否删除1为删除'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='管理员快速导航' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_refer`;
 CREATE TABLE `w_refer` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`question` text NOT NULL  COMMENT '咨询内容',
`user_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '咨询人会员ID，非会员为空',
`goods_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '产品ID',
`order_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '订单ID',
`answer` text NULL  DEFAULT NULL  COMMENT '回复内容',
`admin_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '管理员ID',
`status` tinyint(1) NULL  DEFAULT 0 COMMENT '0：待回复 1已回复 9关闭 ',
`time` datetime NULL  DEFAULT NULL  COMMENT '咨询时间',
`reply_time` datetime NULL  DEFAULT NULL  COMMENT '回复时间',
`type` tinyint(1) NULL  DEFAULT 0 COMMENT '咨询的类别'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='咨询表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_refundment_doc`;
 CREATE TABLE `w_refundment_doc` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`order_no` varchar(20) NOT NULL  COMMENT '订单号',
`order_id` int(11) unsigned NOT NULL  COMMENT '订单id',
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`amount` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '退款金额',
`time` datetime NULL  DEFAULT NULL  COMMENT '时间',
`admin_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '管理员id',
`pay_status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '退款状态，0:申请退款 1:退款失败 2:退款成功',
`content` text NULL  DEFAULT NULL  COMMENT '申请退款原因',
`dispose_time` datetime NULL  DEFAULT NULL  COMMENT '处理时间',
`dispose_idea` text NULL  DEFAULT NULL  COMMENT '处理意见',
`if_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0:未删除 1:删除'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='退款单' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_regiment`;
 CREATE TABLE `w_regiment` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`title` varchar(255) NOT NULL  COMMENT '团购标题',
`start_time` datetime NOT NULL  COMMENT '开始时间',
`end_time` datetime NOT NULL  COMMENT '结束时间',
`store_nums` int(11) NOT NULL  DEFAULT 0 COMMENT '库存量',
`sum_count` int(11) NOT NULL  DEFAULT 0 COMMENT '已销售量',
`least_count` int(11) NOT NULL  DEFAULT 0 COMMENT '最少购买数量',
`intro` varchar(255) NULL  DEFAULT NULL  COMMENT '介绍',
`is_close` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '是否关闭',
`regiment_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '团购价格',
`sell_price` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '原来价格',
`goods_id` int(11) unsigned NOT NULL  COMMENT '关联商品id',
`img` varchar(255) NULL  DEFAULT NULL  COMMENT '商品图片'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='团购' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_regiment_user_relation`;
 CREATE TABLE `w_regiment_user_relation` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户id',
`regiment_id` int(11) unsigned NOT NULL  COMMENT '团购id',
`join_time` datetime NOT NULL  COMMENT '用户参加团购的时间，过了一定时间此名额失效',
`is_over` tinyint(4) NOT NULL  COMMENT '1:已经完成购买,0：未完成',
`hash` varchar(32) NOT NULL  COMMENT '未登录用户的唯一性hash',
`order_no` varchar(20) NOT NULL  DEFAULT  0 COMMENT '与这次团购行为的关联的订单号'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='团购与用户关系表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_relation`;
 CREATE TABLE `w_relation` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`goods_id` int(11) unsigned NOT NULL  COMMENT '商品ID',
`article_id` int(11) unsigned NOT NULL  COMMENT '文章ID'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='文章商品关系表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_right`;
 CREATE TABLE `w_right` (
`id` int(10) NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(80) NOT NULL  COMMENT '权限名字',
`right` text NULL  DEFAULT NULL  COMMENT '权限码(控制器+动作)',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '删除状态 1删除,0正常'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='权限资源码' AUTO_INCREMENT=125;

INSERT INTO `w_right` VALUES( '1','[商品]商品列表','goods@goods_list,goods@goods_stats','0' ); 
INSERT INTO `w_right` VALUES( '2','[商品]商品添加修改','goods@goods_img_upload,goods@goods_edit,goods@goods_update,goods@member_price,goods@model_init,goods@attribute_init,goods@search_spec,goods@select_spec','0' ); 
INSERT INTO `w_right` VALUES( '3','[商品]商品CSV导入','goods@csvImport,goods@importCsvFile','0' ); 
INSERT INTO `w_right` VALUES( '4','[商品]商品删除','goods@goods_del','0' ); 
INSERT INTO `w_right` VALUES( '5','[商品]商品回收站','goods@goods_recycle_del,goods@goods_recycle_restore,goods@goods_recycle_list','0' ); 
INSERT INTO `w_right` VALUES( '6','[商品]商品分类列表','goods@category_list,goods@category_sort','0' ); 
INSERT INTO `w_right` VALUES( '7','[商品]商品分类添加修改','goods@category_edit,goods@category_save','0' ); 
INSERT INTO `w_right` VALUES( '8','[商品]商品分类删除','goods@category_del','0' ); 
INSERT INTO `w_right` VALUES( '9','[商品]品牌列表','brand@brand_list,goods@brand_sort','0' ); 
INSERT INTO `w_right` VALUES( '10','[商品]品牌添加修改','brand@brand_save,brand@brand_edit','0' ); 
INSERT INTO `w_right` VALUES( '11','[商品]品牌删除','brand@brand_del','0' ); 
INSERT INTO `w_right` VALUES( '12','[商品]品牌分类列表','brand@category_list','0' ); 
INSERT INTO `w_right` VALUES( '13','[商品]品牌分类添加修改','brand@category_save,brand@category_edit','0' ); 
INSERT INTO `w_right` VALUES( '14','[商品]品牌分类删除','brand@category_del','0' ); 
INSERT INTO `w_right` VALUES( '15','[商品]模型列表','goods@model_list','0' ); 
INSERT INTO `w_right` VALUES( '16','[商品]模型添加修改','goods@search_spec,goods@model_update,goods@model_edit','0' ); 
INSERT INTO `w_right` VALUES( '17','[商品]模型删除','goods@model_del','0' ); 
INSERT INTO `w_right` VALUES( '18','[商品]规格列表','goods@spec_list','0' ); 
INSERT INTO `w_right` VALUES( '19','[商品]规格添加修改','goods@spec_edit,goods@spec_update','0' ); 
INSERT INTO `w_right` VALUES( '20','[商品]规格删除','goods@spec_del','0' ); 
INSERT INTO `w_right` VALUES( '21','[商品]规格图库','goods@spec_photo,goods@spec_photo_del','0' ); 
INSERT INTO `w_right` VALUES( '22','[商品]规格回收站','goods@spec_recycle_list,goods@spec_recycle_restore,goods@spec_recycle_del,goods@spec_del','0' ); 
INSERT INTO `w_right` VALUES( '23','[会员]会员列表','member@member_list','0' ); 
INSERT INTO `w_right` VALUES( '24','[会员]会员添加修改','member@member_edit,member@member_save','0' ); 
INSERT INTO `w_right` VALUES( '25','[会员]会员删除','member@member_reclaim','0' ); 
INSERT INTO `w_right` VALUES( '26','[会员]会员回收站','member@member_del,member@member_restore,member@recycling','0' ); 
INSERT INTO `w_right` VALUES( '27','[会员]会员预付款操作','member@member_recharge','0' ); 
INSERT INTO `w_right` VALUES( '28','[会员]会员组列表','member@group_list','0' ); 
INSERT INTO `w_right` VALUES( '29','[会员]会员组添加修改','member@group_edit,member@group_save','0' ); 
INSERT INTO `w_right` VALUES( '30','[会员]会员组删除','member@group_del','0' ); 
INSERT INTO `w_right` VALUES( '31','[会员]会员提现列表','member@withdraw_list','0' ); 
INSERT INTO `w_right` VALUES( '32','[会员]会员提现删除','member@withdraw_del','0' ); 
INSERT INTO `w_right` VALUES( '33','[会员]会员提现回收站','member@withdraw_update,member@withdraw_recycle','0' ); 
INSERT INTO `w_right` VALUES( '34','[会员]会员提现状态修改','member@withdraw_status','0' ); 
INSERT INTO `w_right` VALUES( '35','[会员]会员提现详情','member@withdraw_detail','0' ); 
INSERT INTO `w_right` VALUES( '36','[会员]建议列表','comment@suggestion_list','0' ); 
INSERT INTO `w_right` VALUES( '37','[会员]建议详情','comment@suggestion_edit','0' ); 
INSERT INTO `w_right` VALUES( '38','[会员]建议回复','comment@suggestion_edit_act','0' ); 
INSERT INTO `w_right` VALUES( '39','[会员]建议删除','comment@suggestion_del','0' ); 
INSERT INTO `w_right` VALUES( '40','[会员]咨询列表','comment@refer_list','0' ); 
INSERT INTO `w_right` VALUES( '41','[会员]咨询详情','comment@refer_edit','0' ); 
INSERT INTO `w_right` VALUES( '42','[会员]咨询回复','comment@refer_reply','0' ); 
INSERT INTO `w_right` VALUES( '43','[会员]咨询删除','comment@refer_del','0' ); 
INSERT INTO `w_right` VALUES( '44','[会员]讨论列表','comment@discussion_list','0' ); 
INSERT INTO `w_right` VALUES( '45','[会员]讨论详情','comment@discussion_edit','0' ); 
INSERT INTO `w_right` VALUES( '46','[会员]讨论删除','comment@discussion_del','0' ); 
INSERT INTO `w_right` VALUES( '47','[会员]评价列表','comment@comment_list','0' ); 
INSERT INTO `w_right` VALUES( '48','[会员]评价详情','comment@comment_edit','0' ); 
INSERT INTO `w_right` VALUES( '49','[会员]评价删除','comment@comment_del','0' ); 
INSERT INTO `w_right` VALUES( '50','[会员]站内消息列表','comment@message_list','0' ); 
INSERT INTO `w_right` VALUES( '51','[会员]站内消息发送','comment@message_send','0' ); 
INSERT INTO `w_right` VALUES( '52','[会员]站内消息删除','comment@message_del','0' ); 
INSERT INTO `w_right` VALUES( '53','[会员]到货通知列表','message@notify_list,message@notify_filter','0' ); 
INSERT INTO `w_right` VALUES( '54','[会员]到货通知删除','message@notify_del','0' ); 
INSERT INTO `w_right` VALUES( '55','[会员]到货通知发送Email','message@notify_send','0' ); 
INSERT INTO `w_right` VALUES( '56','[会员]到货通知导出CSV','message@notify_export','0' ); 
INSERT INTO `w_right` VALUES( '57','[会员]消息模板展示','message@tpl_list','0' ); 
INSERT INTO `w_right` VALUES( '58','[会员]邮件订阅列表','message@registry_list','0' ); 
INSERT INTO `w_right` VALUES( '59','[会员]邮件订阅发送','message@registry_message_send','0' ); 
INSERT INTO `w_right` VALUES( '60','[会员]邮件订阅删除','message@registry_del','0' ); 
INSERT INTO `w_right` VALUES( '61','[会员]邮件订阅导出CSV','message@registry_export','0' ); 
INSERT INTO `w_right` VALUES( '62','[会员]消息模板修改','message@tpl_edit,message@tpl_save','0' ); 
INSERT INTO `w_right` VALUES( '63','[订单]订单列表','order@order_list','0' ); 
INSERT INTO `w_right` VALUES( '64','[订单]订单添加','order@order_note,order@order_update,order@order_edit','0' ); 
INSERT INTO `w_right` VALUES( '65','[订单]订单修改','order@gePay_fee,order@order_pri_num,order@order_pri_num_del,order@order_note,order@order_update,order@order_edit,order@order_message','0' ); 
INSERT INTO `w_right` VALUES( '66','[订单]订单详情','order@order_show','0' ); 
INSERT INTO `w_right` VALUES( '67','[订单]订单回收站','order@order_recycle_restore,order@order_recycle_del,order@order_recycle_list','0' ); 
INSERT INTO `w_right` VALUES( '68','[订单]订单打印','order@merge_template,order@pick_template,order@shop_template,order@template,order@print_template_update,order@print_template','0' ); 
INSERT INTO `w_right` VALUES( '69','[订单]订单删除','order@order_del','0' ); 
INSERT INTO `w_right` VALUES( '70','[订单]订单状态修改','order@order_delivery_doc,order@order_collection_doc,order@order_complete,order@order_refundment,order@order_collection,order@order_deliver','0' ); 
INSERT INTO `w_right` VALUES( '71','[订单]收款单列表','order@order_collection_list','0' ); 
INSERT INTO `w_right` VALUES( '72','[订单]收款单详情','order@order_collection,order@collection_show','0' ); 
INSERT INTO `w_right` VALUES( '73','[订单]收款单删除','order@collection_del','0' ); 
INSERT INTO `w_right` VALUES( '74','[订单]收款单回收站','order@collection_recycle_restore,order@collection_recycle_del,order@collection_recycle_list','0' ); 
INSERT INTO `w_right` VALUES( '75','[订单]退款单列表','order@order_refundment_list','0' ); 
INSERT INTO `w_right` VALUES( '76','[订单]退款单删除','order@order_refundment_del','0' ); 
INSERT INTO `w_right` VALUES( '77','[订单]退款单回收站','order@refundment_recycle_list,order@refundment_recycle_restore,order@refundment_recycle_del','0' ); 
INSERT INTO `w_right` VALUES( '78','[订单]退款单详情','order@refundment_show,order@order_refundment','0' ); 
INSERT INTO `w_right` VALUES( '79','[订单]配货单列表','order@order_delivery_list','0' ); 
INSERT INTO `w_right` VALUES( '80','[订单]配货单删除','order@delivery_del','0' ); 
INSERT INTO `w_right` VALUES( '81','[订单]配货单回收站','order@delivery_recycle_list,order@delivery_recycle_restore,order@delivery_recycle_del','0' ); 
INSERT INTO `w_right` VALUES( '82','[订单]退款申请单列表','order@refundment_list','0' ); 
INSERT INTO `w_right` VALUES( '83','[订单]退款申请单详情','order@refundment_doc_show','0' ); 
INSERT INTO `w_right` VALUES( '84','[订单]退款申请单删除','order@refundment_doc_del','0' ); 
INSERT INTO `w_right` VALUES( '85','[订单]退款申请单修改','order@refundment_doc_show_save','0' ); 
INSERT INTO `w_right` VALUES( '86','[订单]快递单添加修改','order@expresswaybill_edit,order@expresswaybill_edit_act,order@expresswaybill_upload,order@expresswaybill_template','0' ); 
INSERT INTO `w_right` VALUES( '87','[订单]快递单删除','order@expresswaybill_del','0' ); 
INSERT INTO `w_right` VALUES( '88','[订单]订单退款操作','order@order_refundment_doc','0' ); 
INSERT INTO `w_right` VALUES( '89','[订单]配货单详情','order@delivery_show','0' ); 
INSERT INTO `w_right` VALUES( '90','[营销]促销规则列表','market@pro_rule_list','0' ); 
INSERT INTO `w_right` VALUES( '91','[营销]促销规则添加修改','market@pro_rule_edit_act,market@pro_rule_edit,market@getTicketList','0' ); 
INSERT INTO `w_right` VALUES( '92','[营销]促销规则删除','market@pro_rule_del','0' ); 
INSERT INTO `w_right` VALUES( '93','[营销]限时抢购列表','market@pro_speed_list','0' ); 
INSERT INTO `w_right` VALUES( '94','[营销]限时抢购删除','market@pro_speed_del','0' ); 
INSERT INTO `w_right` VALUES( '95','[营销]限时抢购添加修改','market@pro_speed_edit,market@pro_speed_edit_act','0' ); 
INSERT INTO `w_right` VALUES( '96','[营销]团购列表','market@regiment_list','0' ); 
INSERT INTO `w_right` VALUES( '97','[营销]团购添加修改','market@regiment_edit_act,market@regiment_edit','0' ); 
INSERT INTO `w_right` VALUES( '98','[营销]团购删除','market@regiment_del','0' ); 
INSERT INTO `w_right` VALUES( '99','[营销]代金券列表','market@ticket_list','0' ); 
INSERT INTO `w_right` VALUES( '100','[营销]代金券文件列表','market@ticket_excel_list','0' ); 
INSERT INTO `w_right` VALUES( '101','[营销]代金券添加修改','market@ticket_edit_act,market@ticket_edit','0' ); 
INSERT INTO `w_right` VALUES( '102','[营销]代金券文件详情','market@ticket_more_list','0' ); 
INSERT INTO `w_right` VALUES( '103','[营销]代金券删除','market@ticket_more_del,market@ticket_del','0' ); 
INSERT INTO `w_right` VALUES( '104','[营销]代金券文件删除','market@ticket_excel_del','0' ); 
INSERT INTO `w_right` VALUES( '105','[营销]代金券批量生成','market@ticket_create','0' ); 
INSERT INTO `w_right` VALUES( '106','[营销]代金券EXCEL导出','market@ticket_excel_pack,market@ticket_excel','0' ); 
INSERT INTO `w_right` VALUES( '107','[营销]代金券文件打包下载','market@ticket_excel_pack','0' ); 
INSERT INTO `w_right` VALUES( '108','[营销]代金券文件下载','market@ticket_excel_download','0' ); 
INSERT INTO `w_right` VALUES( '109','[营销]代金券状态修改','market@ticket_status','0' ); 
INSERT INTO `w_right` VALUES( '110','[统计]基础数据统计','market@init_count,market@spanding_avg,market@amount,market@user_reg','0' ); 
INSERT INTO `w_right` VALUES( '111','[统计]资金操作记录','market@operation_list','0' ); 
INSERT INTO `w_right` VALUES( '112','[统计]后台操作记录','market@account_list','0' ); 
INSERT INTO `w_right` VALUES( '113','[统计]资金和后台操作记录删除','market@clear_log','0' ); 
INSERT INTO `w_right` VALUES( '114','[系统]网站设置','system@test_sendmail,system@clearCache,system@conf_skin,system@save_conf,system@conf_base','0' ); 
INSERT INTO `w_right` VALUES( '115','[系统]主题设置','system@applySkin,system@applyTheme,system@conf_skin','0' ); 
INSERT INTO `w_right` VALUES( '116','[系统]支付管理','system@payment_update,system@payment_edit,system@payment_list','0' ); 
INSERT INTO `w_right` VALUES( '117','[系统]配送管理','system@freight_recycle_del,system@freight_recycle_restore,system@freight_recycle,system@freight_del,system@freight_update,system@delivery_update,system@delivery_operate,system@delivery_edit,system@freight_edit,system@freight_list,system@delivery,system@delivery_recycle','0' ); 
INSERT INTO `w_right` VALUES( '118','[系统]地域管理','system@area_list,system@area_update,system@area_del','0' ); 
INSERT INTO `w_right` VALUES( '119','[工具]数据库备份','tools@db_act_bak,tools@db_bak,tools@upload_sql','0' ); 
INSERT INTO `w_right` VALUES( '120','[工具]数据库还原','tools@download_pack,tools@localUpload,tools@res_act,tools@backup_del,tools@download,tools@db_res','0' ); 
INSERT INTO `w_right` VALUES( '121','[工具]文章管理','tools@cat_del,tools@cat_edit,tools@cat_edit_act,tools@article_edit_act,tools@article_del,tools@article_list,tools@article_cat_list,tools@article_edit,tools@article_cat_edit','0' ); 
INSERT INTO `w_right` VALUES( '122','[工具]帮助管理','tools@help_cat_del,tools@help_cat_position,tools@help_cat_edit_act,tools@help_del,tools@help_edit_act,tools@help_list,tools@help_cat_list,tools@help_edit,tools@help_cat_edit','0' ); 
INSERT INTO `w_right` VALUES( '123','[工具]广告管理','tools@ad_edit_act,tools@ad_del,tools@ad_position_edit_act,tools@ad_position_del,tools@ad_position_list,tools@ad_list,tools@ad_position_edit,tools@ad_edit','0' ); 
INSERT INTO `w_right` VALUES( '124','[工具]公告管理','tools@notice_del,tools@notice_edit_act,tools@notice_list,tools@notice_edit','0' ); 
DROP TABLE IF EXISTS `w_search`;
 CREATE TABLE `w_search` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`keyword` varchar(255) NOT NULL  COMMENT '搜索关键字',
`num` int(11) unsigned NOT NULL  DEFAULT 0 COMMENT '搜索次数'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='搜索关键字' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_spec`;
 CREATE TABLE `w_spec` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(50) NOT NULL  COMMENT '规格名称',
`value` text NULL  DEFAULT NULL  COMMENT '规格值',
`type` tinyint(1) NOT NULL  DEFAULT 1 COMMENT '显示类型 1文字 2图片',
`note` varchar(255) NULL  DEFAULT NULL  COMMENT '备注说明',
`is_del` tinyint(1) NULL  DEFAULT 0 COMMENT '是否删除1删除'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='规格表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_spec_photo`;
 CREATE TABLE `w_spec_photo` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`address` varchar(255) NULL  DEFAULT NULL  COMMENT '图片地址',
`name` varchar(100) NULL  DEFAULT NULL  COMMENT '图片名称',
`create_time` datetime NULL  DEFAULT NULL  COMMENT '创建时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='规格图片表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_suggestion`;
 CREATE TABLE `w_suggestion` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`title` varchar(255) NOT NULL  COMMENT '标题',
`content` text NOT NULL  COMMENT '内容',
`time` datetime NULL  DEFAULT NULL  COMMENT '提问时间',
`admin_id` int(11) unsigned NULL  DEFAULT NULL  COMMENT '管理员ID',
`re_content` text NULL  DEFAULT NULL  COMMENT '回复内容',
`re_time` datetime NULL  DEFAULT NULL  COMMENT '回复时间'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='意见箱表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_ticket`;
 CREATE TABLE `w_ticket` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`name` varchar(50) NOT NULL  COMMENT '代金券名称',
`value` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '代金券面额值',
`start_time` datetime NULL  DEFAULT NULL  COMMENT '开始时间',
`end_time` datetime NULL  DEFAULT NULL  COMMENT '结束时间',
`point` smallint(5) NOT NULL  DEFAULT 0 COMMENT '兑换优惠券所需积分,如果是0表示禁止兑换'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='代金券类型表' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_user`;
 CREATE TABLE `w_user` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`username` varchar(20) NOT NULL  UNIQUE KEY  COMMENT '用户名',
`password` char(32) NOT NULL  COMMENT '密码',
`email` varchar(250) NULL  DEFAULT NULL  COMMENT 'Email',
`head_ico` varchar(250) NULL  DEFAULT NULL  COMMENT '头像'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='用户表' AUTO_INCREMENT=2;

INSERT INTO `w_user` VALUES( '1','klchan','dc483e80a7a0bd9ef71d8cf973673924','517315432@qq.com','' ); 
DROP TABLE IF EXISTS `w_user_group`;
 CREATE TABLE `w_user_group` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment COMMENT '用户组ID',
`group_name` varchar(20) NOT NULL  COMMENT '组名',
`discount` decimal(15,2) NOT NULL  DEFAULT 100.00 COMMENT '折扣率',
`minexp` int(11) NULL  DEFAULT NULL  COMMENT '最小经验',
`maxexp` int(11) NULL  DEFAULT NULL  COMMENT '最大经验',
`message_ids` varchar(255) NULL  DEFAULT NULL  COMMENT '消息ID'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='用户组' AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `w_withdraw`;
 CREATE TABLE `w_withdraw` (
`id` int(11) unsigned NOT NULL  PRIMARY KEY auto_increment,
`user_id` int(11) unsigned NOT NULL  COMMENT '用户ID',
`time` datetime NOT NULL  COMMENT '时间',
`amount` decimal(15,2) NOT NULL  DEFAULT 0.00 COMMENT '金额',
`name` varchar(255) NOT NULL  COMMENT '开户姓名',
`status` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '-1失败,0未处理,1处理中,2成功',
`note` varchar(255) NULL  DEFAULT NULL  COMMENT '用户备注',
`re_note` varchar(255) NULL  DEFAULT NULL  COMMENT '回复备注信息',
`is_del` tinyint(1) NOT NULL  DEFAULT 0 COMMENT '0未删除,1已删除'
 ) ENGINE=MyISAM CHARSET=utf8 COMMENT='提现记录' AUTO_INCREMENT=1;

