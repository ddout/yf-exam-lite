SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for el_exam
-- ----------------------------
DROP TABLE IF EXISTS `el_exam`;
CREATE TABLE `el_exam` (
  `id` varchar(64) NOT NULL COMMENT 'ID',
  `title` varchar(255) NOT NULL COMMENT '考试名称',
  `content` varchar(255) NOT NULL COMMENT '考试描述',
  `open` tinyint(3) NOT NULL DEFAULT '1' COMMENT '是否公开',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '口令密码',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '课程状态',
  `rule_id` varchar(64) NOT NULL DEFAULT '' COMMENT '考试规则ID',
  `time_limit` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否限时',
  `start_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `end_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `subj_score` int(11) NOT NULL DEFAULT '0' COMMENT '主观题分数',
  `obj_score` int(11) NOT NULL DEFAULT '0' COMMENT '客观题分数',
  `total_score` int(11) NOT NULL DEFAULT '0' COMMENT '总分数',
  `total_time` int(11) NOT NULL DEFAULT '0' COMMENT '总时长（分钟）',
  `qualify_score` int(11) NOT NULL DEFAULT '0' COMMENT '及格分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程';

-- ----------------------------
-- Records of el_exam
-- ----------------------------
BEGIN;
INSERT INTO `el_exam` VALUES ('1287188594607308801', '新人入职智力测试题', '简单的智力测试，考试结果随员工档案存储！', 0, 'AK1981', 1, '1265561656944033793', 0, '2020-07-26 08:50:50', '2020-07-26 08:50:50', '2020-07-26 08:50:50', '2020-07-26 08:50:50', 0, 100, 100, 120, 90);
COMMIT;

-- ----------------------------
-- Table structure for el_exam_person
-- ----------------------------
DROP TABLE IF EXISTS `el_exam_person`;
CREATE TABLE `el_exam_person` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `exam_id` varchar(32) NOT NULL DEFAULT '' COMMENT '考试ID',
  `max_score` int(11) NOT NULL DEFAULT '0' COMMENT '最高分数',
  `is_pass` tinyint(11) NOT NULL DEFAULT '0' COMMENT '是否合格',
  `exam_count` int(11) NOT NULL DEFAULT '0' COMMENT '考试次数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '考试时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `user_id` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of el_exam_person
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for el_paper
-- ----------------------------
DROP TABLE IF EXISTS `el_paper`;
CREATE TABLE `el_paper` (
  `id` varchar(64) NOT NULL COMMENT '试卷ID',
  `user_id` varchar(64) NOT NULL COMMENT '用户ID',
  `exam_id` varchar(64) NOT NULL COMMENT '规则ID',
  `title` varchar(64) NOT NULL COMMENT '考试标题',
  `total_time` int(11) NOT NULL DEFAULT '0' COMMENT '考试时长',
  `user_time` int(11) NOT NULL DEFAULT '0' COMMENT '用户时长',
  `total_score` int(11) NOT NULL DEFAULT '0' COMMENT '试卷总分',
  `qualify_score` int(11) NOT NULL DEFAULT '0' COMMENT '及格分',
  `obj_score` int(11) NOT NULL DEFAULT '0' COMMENT '客观分',
  `subj_score` int(11) NOT NULL DEFAULT '0' COMMENT '主观分',
  `user_score` int(11) NOT NULL COMMENT '用户得分',
  `has_saq` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否包含简答题',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '试卷状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试卷';



-- ----------------------------
-- Table structure for el_paper_qu
-- ----------------------------
DROP TABLE IF EXISTS `el_paper_qu`;
CREATE TABLE `el_paper_qu` (
  `id` varchar(64) NOT NULL COMMENT 'ID',
  `paper_id` varchar(64) NOT NULL COMMENT '试卷ID',
  `qu_id` varchar(64) NOT NULL COMMENT '题目ID',
  `qu_type` int(11) NOT NULL COMMENT '题目类型',
  `answered` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否已答',
  `answer` varchar(5000) NOT NULL DEFAULT '' COMMENT '主观答案',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '问题排序',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '单题分分值',
  `actual_score` int(11) NOT NULL DEFAULT '0' COMMENT '实际得分(主观题)',
  `is_right` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否答对',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试卷考题';


-- ----------------------------
-- Table structure for el_paper_qu_answer
-- ----------------------------
DROP TABLE IF EXISTS `el_paper_qu_answer`;
CREATE TABLE `el_paper_qu_answer` (
  `id` varchar(64) NOT NULL COMMENT '自增ID',
  `paper_id` varchar(64) NOT NULL COMMENT '试卷ID',
  `answer_id` varchar(32) NOT NULL COMMENT '回答项ID',
  `qu_id` varchar(32) NOT NULL COMMENT '题目ID',
  `is_right` tinyint(11) NOT NULL DEFAULT '0' COMMENT '是否正确项',
  `checked` tinyint(11) NOT NULL DEFAULT '0' COMMENT '是否选中',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `abc` varchar(64) NOT NULL DEFAULT '' COMMENT '选项标签',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试卷考题备选答案';



-- ----------------------------
-- Table structure for el_paper_rule
-- ----------------------------
DROP TABLE IF EXISTS `el_paper_rule`;
CREATE TABLE `el_paper_rule` (
  `id` varchar(64) NOT NULL COMMENT '规则编号',
  `title` varchar(255) NOT NULL COMMENT '规则名称',
  `subj_score` int(11) NOT NULL DEFAULT '0' COMMENT '主观题分数',
  `obj_score` int(11) NOT NULL DEFAULT '0' COMMENT '客观题分数',
  `total_score` int(11) NOT NULL DEFAULT '0' COMMENT '总分',
  `total_time` int(65) NOT NULL DEFAULT '0' COMMENT '时长(分钟)',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注信息',
  `code` varchar(64) NOT NULL DEFAULT '' COMMENT '规则编号',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `qualify_score` int(11) NOT NULL DEFAULT '0' COMMENT '合格分数线',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试卷规则';

-- ----------------------------
-- Records of el_paper_rule
-- ----------------------------
BEGIN;
INSERT INTO `el_paper_rule` VALUES ('1265561656944033793', '智商测试题', 0, 100, 100, 120, '', '', 0, 90);
COMMIT;

-- ----------------------------
-- Table structure for el_paper_rule_repo
-- ----------------------------
DROP TABLE IF EXISTS `el_paper_rule_repo`;
CREATE TABLE `el_paper_rule_repo` (
  `id` varchar(64) NOT NULL COMMENT 'ID',
  `rule_id` varchar(64) NOT NULL COMMENT '规则ID',
  `repo_id` varchar(64) NOT NULL COMMENT '题库ID',
  `radio_count` int(11) NOT NULL DEFAULT '0' COMMENT '单选题数量',
  `radio_score` int(11) NOT NULL DEFAULT '0' COMMENT '单选题分数',
  `multi_count` int(11) NOT NULL DEFAULT '0' COMMENT '多选题数量',
  `multi_score` int(11) NOT NULL DEFAULT '0' COMMENT '多选题分数',
  `judge_count` int(11) NOT NULL DEFAULT '0' COMMENT '判断题数量',
  `judge_score` int(11) NOT NULL DEFAULT '0' COMMENT '判断题分数',
  `saq_count` int(11) NOT NULL DEFAULT '0' COMMENT '简答题数量',
  `saq_score` int(11) NOT NULL DEFAULT '0' COMMENT '简答题分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则题库';

-- ----------------------------
-- Records of el_paper_rule_repo
-- ----------------------------
BEGIN;
INSERT INTO `el_paper_rule_repo` VALUES ('1265561657036308481', '1265561656944033793', '1265561101609795585', 10, 5, 2, 10, 1, 10, 1, 20);
COMMIT;

-- ----------------------------
-- Table structure for el_qu
-- ----------------------------
DROP TABLE IF EXISTS `el_qu`;
CREATE TABLE `el_qu` (
  `id` varchar(64) NOT NULL COMMENT '题目ID',
  `qu_type` int(11) NOT NULL COMMENT '题目类型',
  `content` varchar(2000) NOT NULL COMMENT '题目内容',
  `image` varchar(500) NOT NULL DEFAULT '' COMMENT '题目图片',
  `video` varchar(500) NOT NULL DEFAULT '' COMMENT '题目视频',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '题目备注',
  `analysis` varchar(2000) NOT NULL DEFAULT '' COMMENT '整题解析',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问题题目';

-- ----------------------------
-- Records of el_qu
-- ----------------------------
BEGIN;
INSERT INTO `el_qu` VALUES ('1286851033166860289', 1, '五个答案中哪一个是最好的类比？工工人人人工人对于2211121相当于工工人人工人人工对于', '', '', '2020-07-25 10:29:29', '2020-07-25 10:29:29', '', '');
INSERT INTO `el_qu` VALUES ('1286851474533470209', 1, '找出与众不同的一个', '', '', '2020-07-25 10:31:14', '2020-07-25 10:31:14', '', '');
INSERT INTO `el_qu` VALUES ('1286852069432578050', 1, '找出与众不同的一个NAVHF', '', '', '2020-07-25 10:33:36', '2020-07-25 10:33:36', '', '');
INSERT INTO `el_qu` VALUES ('1286852328741228545', 1, '全班学生排成一行，从左数和从右数沃斯都是第15名，问全班共有学生多少人？', '', '', '2020-07-25 10:34:38', '2020-07-25 10:34:38', '', '');
INSERT INTO `el_qu` VALUES ('1286852596111331329', 1, '找出与“确信”意思相同或意义最相近的词', '', '', '2020-07-25 10:35:42', '2020-07-25 10:35:42', '', '');
INSERT INTO `el_qu` VALUES ('1286852847618576385', 1, '五个答案中哪一个是最好的类比？脚对于手相当于腿对于___________', '', '', '2020-07-25 10:36:42', '2020-07-25 10:36:42', '', '');
INSERT INTO `el_qu` VALUES ('1286853081350361089', 1, '如果所有的甲是乙，没有一个乙是丙，那么，一定没有一个丙是甲。这句话是：', '', '', '2020-07-25 10:37:37', '2020-07-25 10:37:37', '', '');
INSERT INTO `el_qu` VALUES ('1286853276834287617', 1, '找出下列数字中特殊的一个', '', '', '2020-07-25 10:38:24', '2020-07-25 10:38:24', '', '');
INSERT INTO `el_qu` VALUES ('1286853481637957634', 1, '找出与众不同的一个DGCPR：', '', '', '2020-07-25 10:39:13', '2020-07-25 10:39:13', '', '');
INSERT INTO `el_qu` VALUES ('1286853734541905921', 1, '沃斯比乔丹大，麦瑞比沃斯小。下列陈述中哪一句是正确的？', '', '', '2020-07-25 10:40:13', '2020-07-25 10:40:13', '', '');
INSERT INTO `el_qu` VALUES ('1286853998313295874', 1, '五个答案中哪一个是最好的类比： “预杉”对于“须抒”相当于8326对于________', '', '', '2020-07-25 10:41:16', '2020-07-25 10:41:16', '', '');
INSERT INTO `el_qu` VALUES ('1286854225275473921', 1, '沃斯有12枚硬币，共3角6分钱。其中有5枚硬币是一样的，那么这五枚一定是', '', '', '2020-07-25 10:42:10', '2020-07-25 10:42:10', '', '');
INSERT INTO `el_qu` VALUES ('1286854455957999617', 1, '找出与众不同的一个', '', '', '2020-07-25 10:43:05', '2020-07-25 10:43:05', '', '');
INSERT INTO `el_qu` VALUES ('1286854691942125570', 1, '经过破译敌人密码，已经知道了“香蕉苹果大鸭梨”的意思是“星期三秘密进攻”；“苹果甘蔗水蜜桃”的意思是“执行秘密计划”；“广柑香蕉西红柿”的意识是“星期三的胜利属于我们”；那么，“大鸭梨”的意思是：', '', '', '2020-07-25 10:44:01', '2020-07-25 10:44:01', '', '');
INSERT INTO `el_qu` VALUES ('1286854982146019329', 1, '五个答案中哪个是做好的类比？爱对于恨相当于英勇对于_______', '', '', '2020-07-25 10:45:11', '2020-07-25 10:45:11', '', '');
INSERT INTO `el_qu` VALUES ('1286855293522759681', 1, '一本书的价格低了50%。现在，如果按原价出售，提高了百分之几？', '', '', '2020-07-25 10:46:25', '2020-07-25 10:46:25', '', '');
INSERT INTO `el_qu` VALUES ('1286855625946517506', 1, '找出与众不同的一个：', '', '', '2020-07-25 10:47:44', '2020-07-25 10:47:44', '', '');
INSERT INTO `el_qu` VALUES ('1286855888933572610', 1, '从五个答案中找出最好的类比：水对于龙头相当于电对于_______', '', '', '2020-07-25 10:48:47', '2020-07-25 10:48:47', '', '');
INSERT INTO `el_qu` VALUES ('1286856130881998850', 1, '打满水缸要11桶水。王林第次只能提两桶水，要打满水缸他需要走几趟？', '', '', '2020-07-25 10:49:44', '2020-07-25 10:49:44', '', '');
INSERT INTO `el_qu` VALUES ('1286856270095142913', 1, '如果所有的甲都是乙，所有的乙都是丙，那么一定所有的甲都是丙。这句话是', '', '', '2020-07-25 10:50:18', '2020-07-25 10:50:18', '', '');
INSERT INTO `el_qu` VALUES ('1286856503755624449', 1, '汉期、赛斯、麦克、约翰逊共买苹果144个。汉期买的苹果比赛斯多10个，比麦克多26个，比约翰逊多32个。汉期买了多少个苹果？', '', '', '2020-07-25 10:51:13', '2020-07-25 10:51:13', '', '');
INSERT INTO `el_qu` VALUES ('1286856786200055810', 1, '五个答案中哪个是最好的类比？女儿对于父亲相当于侄女对于', '', '', '2020-07-25 10:52:21', '2020-07-25 10:52:21', '', '');
INSERT INTO `el_qu` VALUES ('1286856991045668865', 1, '找出下列数字中多余的一个：', '', '', '2020-07-25 10:53:09', '2020-07-25 10:53:09', '', '');
INSERT INTO `el_qu` VALUES ('1286857269660700674', 1, '五个答案中哪个是最好的类比？皮对于树相当于鳞对于', '', '', '2020-07-25 10:54:16', '2020-07-25 10:54:16', '', '');
INSERT INTO `el_qu` VALUES ('1286858556779352066', 1, '火车守车(车尾)长6.4米。机车的长度等于守车的长加上半节车厢的长。车厢长度等于守车长加上机车长。火车的机车、车厢、守车共长多少米？', '', '', '2020-07-25 10:59:23', '2020-07-25 10:59:23', '', '');
INSERT INTO `el_qu` VALUES ('1286858826460516353', 1, '角对于元相当于小时对于', '', '', '2020-07-25 11:00:27', '2020-07-25 11:00:27', '', '');
INSERT INTO `el_qu` VALUES ('1286859119977910274', 1, '如果把这个大立方体的六个面全部涂上黑色，然后按图中虚线把它切成36个小方块，两面有黑色的小方块有多少个？', 'http://files.aibulls.com/2020/07-25/1286858978181074946.jpg', '', '2020-07-25 11:01:37', '2020-07-25 11:01:37', '', '');
INSERT INTO `el_qu` VALUES ('1286859363650195458', 1, '找出与众不同的一个：', '', '', '2020-07-25 11:02:35', '2020-07-25 11:02:35', '', '');
INSERT INTO `el_qu` VALUES ('1286859710305226754', 1, '图中阴影部分占面积百分之几？', 'http://files.aibulls.com/2020/07-25/1286859531300720641.jpg', '', '2020-07-25 11:03:58', '2020-07-25 11:03:58', '', '');
INSERT INTO `el_qu` VALUES ('1286860480865980417', 1, '数数有多少个三角形', 'http://files.aibulls.com/2020/07-25/1286860401430056962.jpg', '', '2020-07-25 11:07:02', '2020-07-25 11:07:02', '', '');
INSERT INTO `el_qu` VALUES ('1286862562465501185', 1, '车站对于火车相当于港口对于', '', '', '2020-07-25 11:15:18', '2020-07-25 11:15:18', '', '');
INSERT INTO `el_qu` VALUES ('1286863586148306945', 1, '找出与众不同的一个：', '', '', '2020-07-25 11:19:22', '2020-07-25 11:19:22', '', '');
INSERT INTO `el_qu` VALUES ('1286863891812405250', 1, '找出与众不同的一个：', '', '', '2020-07-25 11:20:35', '2020-07-25 11:20:35', '', '');
INSERT INTO `el_qu` VALUES ('1288731653644009473', 2, '以下哪些是中国的特别行政区？', '', '', '2020-07-30 15:02:24', '2020-07-30 15:02:24', '', '中国的特别行政区有香港和澳门');
INSERT INTO `el_qu` VALUES ('1288732225914847234', 3, '互联网是中国西大发明之一', '', '', '2020-07-30 15:04:40', '2020-07-30 15:04:40', '', '纯属扯淡！');
INSERT INTO `el_qu` VALUES ('1288732611354607618', 4, '一个猎人带着一只羊，一只狼和一棵白菜回家，路上遇到一条河。河边只有一条船，但船太小，一次最多只可载猎人和另一样东西过河。但猎人不在时，狼要吃羊，羊要吃白菜。请问怎样才能把狼，羊，白菜都安全运过河？', '', '', '2020-07-30 15:06:12', '2020-07-30 15:06:12', '', '');
INSERT INTO `el_qu` VALUES ('1288732739331211266', 4, '老师盒子里有10颗糖,正好学生有10人.\n老师说:你们每人要分到颗糖,同时盒子里还要剩下一颗,请问怎么分', '', '', '2020-07-30 15:06:43', '2020-07-30 15:06:43', '', '');
INSERT INTO `el_qu` VALUES ('1288732805995479041', 4, '小明和小华买了10斤蜂蜜,装在一个大瓶子里.要把蜂蜜平分,只有两个空瓶子,一个正好装7斤,另一个正好装3斤.怎样才能用最简单的方法把蜂蜜分出来.', '', '', '2020-07-30 15:06:59', '2020-07-30 15:06:59', '', '');
INSERT INTO `el_qu` VALUES ('1288732889634095105', 4, '有口井不知有多深,现有一跟绳子,也不知道有多长.\n把绳子折成3折,把一端垂下井底.当绳子的下端到达井底时,上端比井口低1尺.\n如果把绳子折成2折.那下端到达井低时,上端高出6尺.\n你知道井有多深,绳子有多长了吗?', '', '', '2020-07-30 15:07:19', '2020-07-30 15:07:19', '', '');
INSERT INTO `el_qu` VALUES ('1288732994244231169', 4, '有4条船,这4条船划到对岸所需的时间各不同,1号船要1分钟,2号船要2分钟,3号船要5分钟,4号船要10分钟.\n怎样才能用最快时间把4条船划到对岸?\n[只有一个人划船,一次最多可划两条船走,但必须要划条回来.]', '', '', '2020-07-30 15:07:43', '2020-07-30 15:07:43', '', '');
INSERT INTO `el_qu` VALUES ('1288733204697628674', 2, '找出以下奇数', '', '', '2020-07-30 15:08:34', '2020-07-30 15:08:34', '', '');
INSERT INTO `el_qu` VALUES ('1289451350763671554', 1, '我国最北边的是什么河（）', '', '', '2020-08-01 14:42:13', '2020-08-01 14:42:13', '', '');
INSERT INTO `el_qu` VALUES ('1289452449356746754', 1, '著名的亚欧间的海峡是（）', '', '', '2020-08-01 14:46:35', '2020-08-01 14:46:35', '', '');
INSERT INTO `el_qu` VALUES ('1289452973904793602', 2, '中国东北三省是指（）', '', '', '2020-08-01 14:48:40', '2020-08-01 14:48:40', '', '');
INSERT INTO `el_qu` VALUES ('1289453247356637186', 3, '咖啡的故乡是非洲吗？', '', '', '2020-08-01 14:49:45', '2020-08-01 14:49:45', '', '');
INSERT INTO `el_qu` VALUES ('1289453570242547714', 1, '我国少数民族分布最多的省份是（）', '', '', '2020-08-01 14:51:02', '2020-08-01 14:51:02', '', '云南民族风情古朴浓郁,多姿多彩,独具特色.是全国少数民族成分最多的省份,聚居人口在5000人以上的少数民族达25个,其中16个跨境而居,15个为云南特有.各个民族独特的风俗习惯和多彩的文化艺术,为其增添了不少令人神往的色彩和更多的想象空间');
INSERT INTO `el_qu` VALUES ('1289454234880348161', 4, '水库大坝建设选址在河流的峡谷处，原因是什么', '', '', '2020-08-01 14:53:41', '2020-08-01 14:53:41', '', '①地处峡谷处，利于筑坝；\n②有盆地地形，蓄水量大。');
INSERT INTO `el_qu` VALUES ('1289458348364304385', 2, '交通运输线路（公路、铁路），选址的原因有（）', '', '', '2020-08-01 15:10:01', '2020-08-01 15:10:01', '', '');
INSERT INTO `el_qu` VALUES ('1289458693232562177', 1, '泼水节是我国哪个少数民族的传统节日（）', '', '', '2020-08-01 15:11:24', '2020-08-01 15:11:24', '', '');
INSERT INTO `el_qu` VALUES ('1289459005381054465', 1, '我国最大的瀑布“黄果树瀑布”位于哪个省份（）', '', '', '2020-08-01 15:12:38', '2020-08-01 15:12:38', '', '');
INSERT INTO `el_qu` VALUES ('1289459195177504769', 1, '中国面积最大的省份（）', '', '', '2020-08-01 15:13:23', '2020-08-01 15:13:23', '', '');
INSERT INTO `el_qu` VALUES ('1289459623126536193', 1, '山东山西中的山是指()山', '', '', '2020-08-01 15:15:05', '2020-08-01 15:15:05', '', '山东与山西的bai“山”——太行山脉，历史上du山东、山zhi西的边界是相邻的，当时的太行dao山脉，恰好是两省之间的天然分界线。\n\n太行山脉位于山西省与华北平原之间，纵跨北京、河北、山西、河南4省、市。\n\n山脉北起北京市西山，向南延伸至河南与山西交界地区的王屋山，西接山西高原，东临华北平原，呈东北—西南走向，绵延400余公里。');
INSERT INTO `el_qu` VALUES ('1289471133567586305', 1, '石头城是对我国哪座城市的美称（）', '', '', '2020-08-01 16:00:50', '2020-08-01 16:00:50', '', '');
INSERT INTO `el_qu` VALUES ('1289471480130342913', 1, '我国面积最大的湖泊是（）', '', '', '2020-08-01 16:02:12', '2020-08-01 16:02:12', '', '');
INSERT INTO `el_qu` VALUES ('1289471729733373953', 1, '下列河流哪一条是世界流程最长的（）', '', '', '2020-08-01 16:03:12', '2020-08-01 16:03:12', '', '');
INSERT INTO `el_qu` VALUES ('1289472863202086914', 3, '世界上的“风车之国”是指荷兰', '', '', '2020-08-01 16:07:42', '2020-08-01 16:07:42', '', '');
INSERT INTO `el_qu` VALUES ('1289473193486749697', 3, '中国海岸线的北起端点丹东', '', '', '2020-08-01 16:09:01', '2020-08-01 16:09:01', '', '');
INSERT INTO `el_qu` VALUES ('1289473379982282753', 3, '世界上最长的山脉安第斯山脉', '', '', '2020-08-01 16:09:45', '2020-08-01 16:09:45', '', '');
INSERT INTO `el_qu` VALUES ('1289473577370423297', 3, '黄河最终于注入南海', '', '', '2020-08-01 16:10:32', '2020-08-01 16:10:32', '', '');
INSERT INTO `el_qu` VALUES ('1289473900633821186', 1, '世界上面积最大的国家是哪一个（）', '', '', '2020-08-01 16:11:49', '2020-08-01 16:11:49', '', '');
INSERT INTO `el_qu` VALUES ('1289474314263498754', 1, '测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊测试长度啊啊啊特αβ⒈ⅢⅡⅣⅤⅥ殊符号', '', '', '2020-08-01 16:13:28', '2020-08-01 16:13:28', '', '');
INSERT INTO `el_qu` VALUES ('1289474556119650305', 4, '说一说中国三峡大坝的选址原因', '', '', '2020-08-01 16:14:26', '2020-08-01 16:14:26', '', '');
INSERT INTO `el_qu` VALUES ('1289475132563820546', 4, '选择登山路线的因素', '', '', '2020-08-01 16:16:43', '2020-08-01 16:16:43', '', '该地等高线稀疏，地形坡度小，爬坡容易');
INSERT INTO `el_qu` VALUES ('1289475783523995650', 4, '盐度最低的波罗的海，原因：', '', '', '2020-08-01 16:19:18', '2020-08-01 16:19:18', '', '1、地处较高纬度，气温低，蒸发弱；\n2、周围是热带沙漠地区，缺少大河注入；');
COMMIT;

-- ----------------------------
-- Table structure for el_qu_answer
-- ----------------------------
DROP TABLE IF EXISTS `el_qu_answer`;
CREATE TABLE `el_qu_answer` (
  `id` varchar(64) NOT NULL COMMENT '答案ID',
  `qu_id` varchar(64) NOT NULL COMMENT '问题ID',
  `is_right` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否正确',
  `content` varchar(5000) NOT NULL DEFAULT '' COMMENT '答案内容',
  `image` varchar(500) NOT NULL DEFAULT '' COMMENT '图片地址',
  `analysis` varchar(5000) NOT NULL DEFAULT '' COMMENT '答案分析',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='候选答案';

-- ----------------------------
-- Records of el_qu_answer
-- ----------------------------
BEGIN;
INSERT INTO `el_qu_answer` VALUES ('09f62967d43e41d6a4dd1205a481e629', 'bcb8766f82da40d88d7ad8f22b9481da', 0, '老虎', '', '');
INSERT INTO `el_qu_answer` VALUES ('0b12f829e99641ad84fa1d45a0792f34', '8611f45913c5442fa625822da21978f9', 0, '更多的大衣', '', '');
INSERT INTO `el_qu_answer` VALUES ('0dfcdd2db065499780cef13a04b8a421', '1de822400fd446feb36a347c4bb46f34', 0, '3/7', '', '');
INSERT INTO `el_qu_answer` VALUES ('101d907375bf49e0bdcf1a2d1f6cd3e4', 'c475ad7ed37f4d3380cb1937fa4a224f', 1, '6', '', '');
INSERT INTO `el_qu_answer` VALUES ('1265250714574151681', '1265250713689153538', 1, '选项1', '', '选项1解析');
INSERT INTO `el_qu_answer` VALUES ('1265250714582540289', '1265250713689153538', 0, '选项2', '', '选项2解析');
INSERT INTO `el_qu_answer` VALUES ('1265480468057350145', '1265480467990241282', 0, '21212', '', '1212');
INSERT INTO `el_qu_answer` VALUES ('1265480468065738753', '1265480467990241282', 0, '22222', '', '22222');
INSERT INTO `el_qu_answer` VALUES ('1285740664174858241', '1285740663696707585', 0, '1', '', '');
INSERT INTO `el_qu_answer` VALUES ('1285740664174858242', '1285740663696707585', 0, '2', '', '');
INSERT INTO `el_qu_answer` VALUES ('1285740664174858243', '1285740663696707585', 1, 'd1', '', '');
INSERT INTO `el_qu_answer` VALUES ('1285740664174858244', '1285740663696707585', 0, '1', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286480128901156866', '1286462371518255105', 0, '', 'http://files.aibulls.com/2020/07-24/1286479992871489538.jpg', '');
INSERT INTO `el_qu_answer` VALUES ('1286480128905351170', '1286462371518255105', 0, '', 'http://files.aibulls.com/2020/07-24/1286480009325744130.jpg', '');
INSERT INTO `el_qu_answer` VALUES ('1286480128905351171', '1286462371518255105', 0, '', 'http://files.aibulls.com/2020/07-24/1286480037998006274.jpg', '');
INSERT INTO `el_qu_answer` VALUES ('1286480128905351172', '1286462371518255105', 0, '', 'http://files.aibulls.com/2020/07-24/1286480072999473153.jpg', '');
INSERT INTO `el_qu_answer` VALUES ('1286480128905351173', '1286462371518255105', 1, '', 'http://files.aibulls.com/2020/07-24/1286480092620427265.jpg', '');
INSERT INTO `el_qu_answer` VALUES ('1286481285073637378', '1286481285023305730', 1, '对', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286481285090414593', '1286481285023305730', 0, '错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851033326243842', '1286851033166860289', 0, '22122112', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851033330438145', '1286851033166860289', 0, '22112122', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851033334632449', '1286851033166860289', 1, '22112112', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851033334632450', '1286851033166860289', 0, '11221221', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851033338826754', '1286851033166860289', 0, '21221121', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851474562830338', '1286851474533470209', 0, '铝', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851474562830339', '1286851474533470209', 0, '锡', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851474571218945', '1286851474533470209', 1, '钢', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851474571218946', '1286851474533470209', 0, '铁', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286851474571218947', '1286851474533470209', 0, '铜', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852069453549569', '1286852069432578050', 0, 'N', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852069457743874', '1286852069432578050', 0, 'A', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852069457743875', '1286852069432578050', 1, 'V', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852069457743876', '1286852069432578050', 0, 'H', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852069461938178', '1286852069432578050', 0, 'F', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852328766394369', '1286852328741228545', 0, '15', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852328770588674', '1286852328741228545', 0, '25', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852328770588675', '1286852328741228545', 1, '29', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852328774782977', '1286852328741228545', 0, '30', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852328774782978', '1286852328741228545', 0, '31', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852596157468673', '1286852596111331329', 0, '正确', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852596157468674', '1286852596111331329', 0, '明确', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852596161662977', '1286852596111331329', 0, '信心', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852596161662978', '1286852596111331329', 1, '肯定', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852596165857282', '1286852596111331329', 0, '真实', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852847639547906', '1286852847618576385', 0, '肘', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852847643742210', '1286852847618576385', 0, '膝', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852847643742211', '1286852847618576385', 1, '臂', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852847647936514', '1286852847618576385', 0, '手指', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286852847647936515', '1286852847618576385', 0, '脚趾\n', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853081371332610', '1286853081350361089', 1, '对的', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853081375526913', '1286853081350361089', 0, '错的', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853081375526914', '1286853081350361089', 0, '既不对也不错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276859453442', '1286853276834287617', 0, '1', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276863647745', '1286853276834287617', 0, '3', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276863647746', '1286853276834287617', 0, '5', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276867842050', '1286853276834287617', 0, '7', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276867842051', '1286853276834287617', 0, '11', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276867842052', '1286853276834287617', 0, '13', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276867842053', '1286853276834287617', 1, '15', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853276872036354', '1286853276834287617', 0, '17', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853481663123458', '1286853481637957634', 0, 'D', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853481663123459', '1286853481637957634', 0, 'G', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853481663123460', '1286853481637957634', 1, 'C', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853481663123461', '1286853481637957634', 0, 'P', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853481663123462', '1286853481637957634', 0, 'R', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853734571266049', '1286853734541905921', 0, '麦瑞比乔丹大', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853734571266050', '1286853734541905921', 0, '麦瑞比乔丹小', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853734575460353', '1286853734541905921', 0, '麦瑞与乔丹一样大', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853734575460354', '1286853734541905921', 1, '无法确定麦瑞与乔丹谁大 ', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853998330073090', '1286853998313295874', 0, '2368', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853998334267393', '1286853998313295874', 0, '6238', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853998334267394', '1286853998313295874', 0, '2683', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853998334267395', '1286853998313295874', 1, '6328', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286853998338461697', '1286853998313295874', 0, '3628', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854225292251137', '1286854225275473921', 0, '1分的', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854225300639745', '1286854225275473921', 0, '2分的', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854225300639746', '1286854225275473921', 1, '5分的', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854455978971138', '1286854455957999617', 0, '公里', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854455983165441', '1286854455957999617', 0, '英寸', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854455983165442', '1286854455957999617', 1, '亩', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854455983165443', '1286854455957999617', 0, '丈', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854455983165444', '1286854455957999617', 0, '米', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854691958902786', '1286854691942125570', 0, '秘密', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854691963097089', '1286854691942125570', 0, '星期三', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854691963097090', '1286854691942125570', 1, '进攻', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854691967291394', '1286854691942125570', 0, '执行', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854691967291395', '1286854691942125570', 0, '计划', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854982166990850', '1286854982146019329', 0, '士气', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854982166990851', '1286854982146019329', 0, '安全', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854982171185154', '1286854982146019329', 1, '怯懦', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854982171185155', '1286854982146019329', 0, '愤怒', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286854982171185156', '1286854982146019329', 0, '恐怖', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855293535342593', '1286855293522759681', 0, '25%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855293539536898', '1286855293522759681', 0, '50%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855293539536899', '1286855293522759681', 0, '75%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855293543731201', '1286855293522759681', 1, '100%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855293543731202', '1286855293522759681', 0, '200%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855625971683329', '1286855625946517506', 0, '葡萄', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855625971683330', '1286855625946517506', 0, '南瓜', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855625971683331', '1286855625946517506', 0, '黄瓜', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855625971683332', '1286855625946517506', 1, '玉米', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855625971683333', '1286855625946517506', 0, '豌豆', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855888958738434', '1286855888933572610', 0, '光线', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855888958738435', '1286855888933572610', 1, '开关', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855888958738436', '1286855888933572610', 0, '电话', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855888962932737', '1286855888933572610', 0, '危险', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286855888962932738', '1286855888933572610', 0, '电线', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856130894581762', '1286856130881998850', 0, '5', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856130898776065', '1286856130881998850', 0, '11/2', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856130898776066', '1286856130881998850', 1, '6', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856130898776067', '1286856130881998850', 0, '13/2', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856130898776068', '1286856130881998850', 0, '7', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856270107725826', '1286856270095142913', 1, '对的', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856270111920130', '1286856270095142913', 0, '错的', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856270111920131', '1286856270095142913', 0, '既不对的也不错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856503772401665', '1286856503755624449', 0, '73', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856503776595970', '1286856503755624449', 0, '63', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856503776595971', '1286856503755624449', 1, '53', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856503776595972', '1286856503755624449', 0, '43', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856503776595973', '1286856503755624449', 0, '27', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856786216833025', '1286856786200055810', 0, '侄子', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856786216833026', '1286856786200055810', 0, '表兄', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856786221027330', '1286856786200055810', 1, '叔叔', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856786221027331', '1286856786200055810', 0, '母亲', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856786221027332', '1286856786200055810', 0, '哥哥', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991058251778', '1286856991045668865', 0, '4', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991058251779', '1286856991045668865', 0, '5', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991058251780', '1286856991045668865', 0, '8', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991062446081', '1286856991045668865', 0, '10', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991062446082', '1286856991045668865', 1, '11', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991062446083', '1286856991045668865', 0, '16', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991062446084', '1286856991045668865', 0, '19', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991062446085', '1286856991045668865', 0, '32', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286856991062446086', '1286856991045668865', 0, '36', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286857269673283585', '1286857269660700674', 0, '鳃', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286857269673283586', '1286857269660700674', 0, '大海', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286857269673283587', '1286857269660700674', 0, '渔夫', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286857269677477889', '1286857269660700674', 1, '鱼', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286857269677477890', '1286857269660700674', 0, '鳍', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858556800323585', '1286858556779352066', 0, '25.6米', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858556800323586', '1286858556779352066', 0, '36米', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858556800323587', '1286858556779352066', 1, '51.2米', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858556800323588', '1286858556779352066', 0, '64.4米', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858556804517889', '1286858556779352066', 0, '76.2米', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858826477293569', '1286858826460516353', 0, '分', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858826485682178', '1286858826460516353', 0, '秒', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858826485682179', '1286858826460516353', 0, '月', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858826485682180', '1286858826460516353', 0, '日', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286858826485682181', '1286858826460516353', 0, '钟', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859119998881794', '1286859119977910274', 0, '8', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859120003076098', '1286859119977910274', 0, '10', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859120003076099', '1286859119977910274', 0, '12', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859120003076100', '1286859119977910274', 1, '16', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859120007270402', '1286859119977910274', 0, '20', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859363675361281', '1286859363650195458', 0, '南昌', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859363675361282', '1286859363650195458', 0, '西安', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859363679555586', '1286859363650195458', 0, '郑州', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859363679555587', '1286859363650195458', 1, '哈尔滨', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859363679555588', '1286859363650195458', 0, '昆明', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859710326198274', '1286859710305226754', 0, '20%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859710330392578', '1286859710305226754', 1, '25% ', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859710330392579', '1286859710305226754', 0, '30%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859710330392580', '1286859710305226754', 0, '35%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286859710334586881', '1286859710305226754', 0, '40%', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286860480878563329', '1286860480865980417', 0, '5', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286860480882757634', '1286860480865980417', 0, '7', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286860480882757635', '1286860480865980417', 0, '9', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286860480882757636', '1286860480865980417', 1, '11', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286860480886951937', '1286860480865980417', 0, '13', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286862562486472705', '1286862562465501185', 0, '起重机', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286862562490667010', '1286862562465501185', 0, '船坞', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286862562490667011', '1286862562465501185', 0, '领航员\n', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286862562490667012', '1286862562465501185', 1, '轮船', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286862562490667013', '1286862562465501185', 0, '旅行', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863586165084161', '1286863586148306945', 0, '画家', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863586169278465', '1286863586148306945', 0, '排球运动员', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863586169278466', '1286863586148306945', 1, '播音员', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863586169278467', '1286863586148306945', 0, '舞蹈演员', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863586173472769', '1286863586148306945', 0, '化妆师', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863891829182466', '1286863891812405250', 0, '水', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863891833376769', '1286863891812405250', 0, '太阳', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863891833376770', '1286863891812405250', 0, '汽油', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863891833376771', '1286863891812405250', 0, '风', '', '');
INSERT INTO `el_qu_answer` VALUES ('1286863891833376772', '1286863891812405250', 1, '水泥', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288731653853724674', '1288731653644009473', 1, '香港', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288731653862113282', '1288731653644009473', 1, '澳门', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288731653866307585', '1288731653644009473', 0, '珠海', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288731653866307586', '1288731653644009473', 0, '重庆', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288732225973567489', '1288732225914847234', 0, '对', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288732225986150401', '1288732225914847234', 1, '错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288733204731183105', '1288733204697628674', 1, '1', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288733204731183106', '1288733204697628674', 1, '3', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288733204739571714', '1288733204697628674', 0, '6', '', '');
INSERT INTO `el_qu_answer` VALUES ('1288733204739571715', '1288733204697628674', 1, '9', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289451351275376641', '1289451350763671554', 1, '漠河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289451351287959553', '1289451350763671554', 0, '黄河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289451351287959554', '1289451350763671554', 0, '长江', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289451351287959555', '1289451350763671554', 0, '太湖', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289452449897811969', '1289452449356746754', 1, '中国京杭大运河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289452449902006273', '1289452449356746754', 0, '苏伊士运河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289452449902006274', '1289452449356746754', 0, '巴拿马运河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289452974399721473', '1289452973904793602', 1, '黑龙江省', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289452974412304386', '1289452973904793602', 1, '吉林省', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289452974412304387', '1289452973904793602', 1, '辽宁省', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289452974412304388', '1289452973904793602', 0, '河北省', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289453247851565057', '1289453247356637186', 1, '对', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289453247851565058', '1289453247356637186', 0, '错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289453570737475585', '1289453570242547714', 0, '广西', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289453570745864193', '1289453570242547714', 0, '西藏', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289453570745864194', '1289453570242547714', 1, '云南', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289453570745864195', '1289453570242547714', 0, '四川', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458348859232258', '1289458348364304385', 1, '等高线稀疏', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458348863426562', '1289458348364304385', 1, '地形坡度和缓', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458348863426563', '1289458348364304385', 0, '隧道多', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458348863426564', '1289458348364304385', 0, '地形复杂', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458693740072962', '1289458693232562177', 0, '彝族', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458693740072963', '1289458693232562177', 0, '回族', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458693744267265', '1289458693232562177', 0, '壮族', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458693744267266', '1289458693232562177', 1, '傣族', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289458746080792578', '1289458693232562177', 0, '汉族', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459005892759553', '1289459005381054465', 1, '贵州', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459005892759554', '1289459005381054465', 0, '湖南', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459005896953857', '1289459005381054465', 0, '江西', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459005896953858', '1289459005381054465', 0, '四川', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459195685015554', '1289459195177504769', 1, '新疆', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459195689209858', '1289459195177504769', 0, '内蒙古', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459195689209859', '1289459195177504769', 0, '西藏', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459623629852673', '1289459623126536193', 0, '泰山', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459623638241281', '1289459623126536193', 1, '太行山', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459623638241282', '1289459623126536193', 0, '沂蒙山', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289459623638241283', '1289459623126536193', 0, '恒山', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471134062514177', '1289471133567586305', 0, '南昌', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471134070902786', '1289471133567586305', 1, '南京', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471134070902787', '1289471133567586305', 0, '拉萨', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471134070902788', '1289471133567586305', 0, '西安', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471480625270786', '1289471480130342913', 1, '青海湖', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471480629465089', '1289471480130342913', 0, '鄱阳湖', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471480629465090', '1289471480130342913', 0, '洞庭湖', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471480629465091', '1289471480130342913', 0, '太湖', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471730228301825', '1289471729733373953', 1, '尼罗河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471730228301826', '1289471729733373953', 0, '长江', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471730228301827', '1289471729733373953', 0, '亚马孙河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289471730228301828', '1289471729733373953', 0, '密西西比河', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289472863676043266', '1289472863202086914', 1, '对', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289472863680237570', '1289472863202086914', 0, '错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473193977483265', '1289473193486749697', 1, '对', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473193977483266', '1289473193486749697', 0, '错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473380460433409', '1289473379982282753', 1, '对', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473380464627714', '1289473379982282753', 0, '错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473577861156866', '1289473577370423297', 0, '对', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473577865351169', '1289473577370423297', 1, '错', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473901128749057', '1289473900633821186', 0, '中国', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473901128749058', '1289473900633821186', 1, '俄罗斯', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473901128749059', '1289473900633821186', 0, '澳大利亚', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289473901128749060', '1289473900633821186', 0, '加拿大', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289474314758426626', '1289474314263498754', 1, '这个是正确答案', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289474314762620929', '1289474314263498754', 0, '干扰项1', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289474314762620930', '1289474314263498754', 0, '干扰项2', '', '');
INSERT INTO `el_qu_answer` VALUES ('1289474314762620931', '1289474314263498754', 0, '干扰项3', '', '');
INSERT INTO `el_qu_answer` VALUES ('1854b08085e84ef5abfe08821aef61e6', '003dc86c67174767beba3fe0b4a695f1', 1, '深圳', '', '1212');
INSERT INTO `el_qu_answer` VALUES ('1b61f07c4d0945cf8d1bff223fcc1c1d', 'd0c85f3ff0614ec0808669eb68ca0569', 0, '羊', '', '');
INSERT INTO `el_qu_answer` VALUES ('2477afad42ae4b0fb8a5603a7adb875d', 'c0c28ed165de4311bd76e53be03774ab', 1, '9', '', '');
INSERT INTO `el_qu_answer` VALUES ('2514101100ff4f1f998d5a20dea80bd4', 'a42fc6afd8ec4efcb6a77b63b3fbb2b5', 0, '学文化', '', '');
INSERT INTO `el_qu_answer` VALUES ('2a74423ddf1e4858a4c5147a00aea8f6', '13a7f9a6f0d94b6180ddfa32fef474d0', 0, '偃', '', '');
INSERT INTO `el_qu_answer` VALUES ('2a77a55017e443e5b47c1a55c65f5252', '8611f45913c5442fa625822da21978f9', 1, '大衣', '', '');
INSERT INTO `el_qu_answer` VALUES ('333b785745cc414eb509105bc3e29600', '164509e7600f41a49d150ce238ba0b05', 1, '澳门', '', '');
INSERT INTO `el_qu_answer` VALUES ('3cfaa9baa2c64df7aa64f6ad2d35782f', 'c475ad7ed37f4d3380cb1937fa4a224f', 1, '9', '', '');
INSERT INTO `el_qu_answer` VALUES ('40abf32a2133489b9208a0420b0bb724', 'bcb8766f82da40d88d7ad8f22b9481da', 1, '大树', '', '');
INSERT INTO `el_qu_answer` VALUES ('4214a7f5dfb348079cd3c115d9455c96', '003dc86c67174767beba3fe0b4a695f1', 1, '汕头', '', '');
INSERT INTO `el_qu_answer` VALUES ('42d3687234e04e1abeea79dce694fde0', '548c291b8ecb413b9c90aa1653045a52', 1, '学历证书', 'http://files.aibulls.com/2020/07-23/1286124495370842114.jpeg', '这个是肯定要的');
INSERT INTO `el_qu_answer` VALUES ('46e900557e9c43a1b36aa79f69280737', 'c475ad7ed37f4d3380cb1937fa4a224f', 1, '3', '', '');
INSERT INTO `el_qu_answer` VALUES ('4aaf62b0e3f947a8bfa17a8b9b6e83a3', '003dc86c67174767beba3fe0b4a695f1', 0, '上海', '', '');
INSERT INTO `el_qu_answer` VALUES ('515a8cc47a7a4905baf0cd18a848de61', 'd49c7b3a100b4aadb75bc182aad9301c', 0, '牛棚', '', '');
INSERT INTO `el_qu_answer` VALUES ('552e097ecb8942b89edc74898e847dd1', 'd49c7b3a100b4aadb75bc182aad9301c', 0, '农场', '', '');
INSERT INTO `el_qu_answer` VALUES ('5a5ec9a6de6d45ee9a16789bdf03ffae', '13a7f9a6f0d94b6180ddfa32fef474d0', 1, '揠', '', '');
INSERT INTO `el_qu_answer` VALUES ('5c8b315deb984c3288330a8bf41e5d55', 'c475ad7ed37f4d3380cb1937fa4a224f', 1, '12', '', '');
INSERT INTO `el_qu_answer` VALUES ('5d37f51234024e6193138b933bef7fcf', 'd49c7b3a100b4aadb75bc182aad9301c', 1, '房屋', '', '');
INSERT INTO `el_qu_answer` VALUES ('61b2d3d459ff4ae6bc5dbd288fe6bd08', '5859c292a6ad486da6d9ea41084affe2', 0, '窗户', '', '');
INSERT INTO `el_qu_answer` VALUES ('648a63c3df3f4353a36a9eae7b887160', 'c0c28ed165de4311bd76e53be03774ab', 1, '1', '', '');
INSERT INTO `el_qu_answer` VALUES ('65ab3b7dc7574c35b630b4d5e7e57b66', 'c0c28ed165de4311bd76e53be03774ab', 1, '3', '', '');
INSERT INTO `el_qu_answer` VALUES ('6d9be774ff964938b3e9fcef30746791', 'c0c28ed165de4311bd76e53be03774ab', 0, '6', '', '');
INSERT INTO `el_qu_answer` VALUES ('6f8f2b37efe342fe9f9eb442dcf13b97', '548c291b8ecb413b9c90aa1653045a52', 0, '房产证', 'http://files.aibulls.com/2020/07-23/1286124589230977026.jpeg', '沙雕，炫富吗？');
INSERT INTO `el_qu_answer` VALUES ('7937429ad9fa4abdbab02686ef918f23', '164509e7600f41a49d150ce238ba0b05', 1, '香港', '', '');
INSERT INTO `el_qu_answer` VALUES ('819cd3738d8a431d94bd5940574c96d5', '1de822400fd446feb36a347c4bb46f34', 1, '3/9', '', '');
INSERT INTO `el_qu_answer` VALUES ('8233da0ec3a34700b7f096a61917ec3f', '003dc86c67174767beba3fe0b4a695f1', 1, '厦门', '', '');
INSERT INTO `el_qu_answer` VALUES ('86881db55de54b9fa50ef230989a4473', '5859c292a6ad486da6d9ea41084affe2', 1, '窗帘', '', '');
INSERT INTO `el_qu_answer` VALUES ('8e56589be47b45a7b7e68e6dfc24cee3', '164509e7600f41a49d150ce238ba0b05', 0, '上海', '', '');
INSERT INTO `el_qu_answer` VALUES ('8e77dba9deb04d3abf1ac289827fafa6', 'd0c85f3ff0614ec0808669eb68ca0569', 1, '鸡', '', '');
INSERT INTO `el_qu_answer` VALUES ('8eda1a3caa5f4f7088e00476a93c06f6', '164509e7600f41a49d150ce238ba0b05', 0, '重庆', '', '');
INSERT INTO `el_qu_answer` VALUES ('8fc0251ca1034e9fa11a9d56598e343e', 'cff894ebd7464c1290863f38f198e013', 0, '是一个干扰项', '', '');
INSERT INTO `el_qu_answer` VALUES ('906c5cb7063a40edb53f9530ee33e195', 'a42fc6afd8ec4efcb6a77b63b3fbb2b5', 0, '娱乐', '', '');
INSERT INTO `el_qu_answer` VALUES ('95480930be4e441b9223004c198eba2f', 'cff894ebd7464c1290863f38f198e013', 0, '错误答案', '', '');
INSERT INTO `el_qu_answer` VALUES ('9877c9ce6ca64eb1b608a2ed8244e592', '548c291b8ecb413b9c90aa1653045a52', 1, '', 'http://files.aibulls.com/2020/07-24/1286475984253521922.jpeg', '');
INSERT INTO `el_qu_answer` VALUES ('a3ba4ee5eddd45958b70589630b96943', '8611f45913c5442fa625822da21978f9', 0, '昂贵的大衣', '', '');
INSERT INTO `el_qu_answer` VALUES ('a7bedd907df64270b1810d172a0a1c9c', 'a42fc6afd8ec4efcb6a77b63b3fbb2b5', 0, '解除疲劳', '', '');
INSERT INTO `el_qu_answer` VALUES ('a9637102b18e4cd29d7647f9a4270e23', '1de822400fd446feb36a347c4bb46f34', 0, '3/5', '', '');
INSERT INTO `el_qu_answer` VALUES ('ab8340f438aa4054887fef5759fe59fe', '1ca360472a644ed59138f52b01795fd2', 0, '姑娘', '', '');
INSERT INTO `el_qu_answer` VALUES ('b053dd4b21634b1287be93968193ce63', '003dc86c67174767beba3fe0b4a695f1', 1, '珠海', '', '');
INSERT INTO `el_qu_answer` VALUES ('b12626ba51034eeda1ceff1251a7922b', '8611f45913c5442fa625822da21978f9', 0, '时髦的大衣', '', '');
INSERT INTO `el_qu_answer` VALUES ('b4d58add590e4038ae5ac25ecaebd8ea', '1ca360472a644ed59138f52b01795fd2', 0, '孩子', '', '');
INSERT INTO `el_qu_answer` VALUES ('bd79e5cbfd1f42c38fbf152af97ecab2', '548c291b8ecb413b9c90aa1653045a52', 1, '', 'http://files.aibulls.com/2020/07-24/1286476005023715330.jpeg', '');
INSERT INTO `el_qu_answer` VALUES ('be49d5d892c94f4d89e1c987af40f9b1', 'bcb8766f82da40d88d7ad8f22b9481da', 0, '蛇', '', '');
INSERT INTO `el_qu_answer` VALUES ('c01b2988339344718a1bcd8bb1860ae5', 'cff894ebd7464c1290863f38f198e013', 1, '正确答案', '', '');
INSERT INTO `el_qu_answer` VALUES ('c2bb74ee9e4b463d87f234ed94db6b51', '003dc86c67174767beba3fe0b4a695f1', 0, '广州', '', '');
INSERT INTO `el_qu_answer` VALUES ('c315328034a0487b8256ac39acd563de', '13a7f9a6f0d94b6180ddfa32fef474d0', 0, '堰', '', '');
INSERT INTO `el_qu_answer` VALUES ('d183001c87924bd58805b45ef85781f7', 'd0c85f3ff0614ec0808669eb68ca0569', 0, '牛', '', '');
INSERT INTO `el_qu_answer` VALUES ('d2eea418d0d243ef901a8184c053e9e2', '003dc86c67174767beba3fe0b4a695f1', 1, '海南', '', '');
INSERT INTO `el_qu_answer` VALUES ('de79fb22ebc14b3d94603689ecbd3629', '548c291b8ecb413b9c90aa1653045a52', 1, '离职证明', '', '');
INSERT INTO `el_qu_answer` VALUES ('df1814e06a1842de8a4de4150a07df86', 'd0c85f3ff0614ec0808669eb68ca0569', 0, '猪', '', '');
INSERT INTO `el_qu_answer` VALUES ('e6534e1d3f414ba69d69179e00275ae7', 'd49c7b3a100b4aadb75bc182aad9301c', 0, '马车', '', '');
INSERT INTO `el_qu_answer` VALUES ('ea2d52e8f9024dd8ae9b96631b11a218', 'c475ad7ed37f4d3380cb1937fa4a224f', 0, '23', '', '');
INSERT INTO `el_qu_answer` VALUES ('eefd067a55a54e949f4825a4036e06f5', '1ca360472a644ed59138f52b01795fd2', 0, '夫人', '', '');
INSERT INTO `el_qu_answer` VALUES ('ef9d9a9b186a4c0da2db58369bd65718', '1ca360472a644ed59138f52b01795fd2', 1, '妇女', '', '');
INSERT INTO `el_qu_answer` VALUES ('f54765b959d344cab41e5c7519ef83e7', '1ca360472a644ed59138f52b01795fd2', 0, '青年', '', '');
INSERT INTO `el_qu_answer` VALUES ('f6fb83eb2ac144b0a1024a96ffa9af94', '5859c292a6ad486da6d9ea41084affe2', 0, '壁橱', '', '');
INSERT INTO `el_qu_answer` VALUES ('fa1ab27983c1403dbbbc2eaa6a7d712d', 'a42fc6afd8ec4efcb6a77b63b3fbb2b5', 1, '阅读', '', '');
INSERT INTO `el_qu_answer` VALUES ('fa395270b05f4cc488e6de5a4bad370f', '5859c292a6ad486da6d9ea41084affe2', 0, '地板', '', '');
INSERT INTO `el_qu_answer` VALUES ('fb30c269389e44ef998ee4dccfda7514', 'd49c7b3a100b4aadb75bc182aad9301c', 0, '楼房', '', '');
COMMIT;

-- ----------------------------
-- Table structure for el_qu_repo
-- ----------------------------
DROP TABLE IF EXISTS `el_qu_repo`;
CREATE TABLE `el_qu_repo` (
  `id` varchar(64) NOT NULL COMMENT '题库ID',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '题库编号',
  `title` varchar(255) NOT NULL COMMENT '题库名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '题库备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='题库';

-- ----------------------------
-- Records of el_qu_repo
-- ----------------------------
BEGIN;
INSERT INTO `el_qu_repo` VALUES ('1265561101609795585', '新人入职培训题库', '智商测试题', '智商测试题', '2020-05-27 16:30:54', '2020-05-27 16:30:54');
INSERT INTO `el_qu_repo` VALUES ('1289451674266144770', '', '地理知识竞赛试题2020', '', '2020-08-01 14:43:30', '2020-08-01 14:43:30');
COMMIT;

-- ----------------------------
-- Table structure for el_qu_repo_ref
-- ----------------------------
DROP TABLE IF EXISTS `el_qu_repo_ref`;
CREATE TABLE `el_qu_repo_ref` (
  `id` varchar(64) NOT NULL,
  `qu_id` varchar(64) NOT NULL COMMENT '试题',
  `repo_id` varchar(64) NOT NULL COMMENT '归属题库',
  `qu_type` int(11) NOT NULL DEFAULT '0' COMMENT '题目类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试题题库';

-- ----------------------------
-- Records of el_qu_repo_ref
-- ----------------------------
BEGIN;
INSERT INTO `el_qu_repo_ref` VALUES ('1286917208915591170', '1286863891812405250', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917208940756993', '1286863586148306945', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917208957534209', '1286862562465501185', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917208974311426', '1286860480865980417', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209003671553', '1286859710305226754', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209020448770', '1286859363650195458', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209037225985', '1286859119977910274', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209054003201', '1286858826460516353', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209074974722', '1286858556779352066', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209095946241', '1286857269660700674', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209116917762', '1286856991045668865', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209142083586', '1286856786200055810', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209167249410', '1286856503755624449', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209184026625', '1286856270095142913', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209213386754', '1286856130881998850', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209234358274', '1286855888933572610', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209255329794', '1286855625946517506', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209284689922', '1286855293522759681', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209305661441', '1286854982146019329', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209330827266', '1286854691942125570', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209355993090', '1286854455957999617', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209381158913', '1286854225275473921', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209406324738', '1286853998313295874', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209431490561', '1286853734541905921', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209452462081', '1286853481637957634', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209473433601', '1286853276834287617', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209502793729', '1286853081350361089', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209519570946', '1286852847618576385', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209540542465', '1286852596111331329', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209565708290', '1286852328741228545', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209586679809', '1286852069432578050', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209607651329', '1286851474533470209', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1286917209628622850', '1286851033166860289', '1265561101609795585', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1288731653925027842', '1288731653644009473', '1265561101609795585', 2);
INSERT INTO `el_qu_repo_ref` VALUES ('1288732226019704833', '1288732225914847234', '1265561101609795585', 3);
INSERT INTO `el_qu_repo_ref` VALUES ('1288732611425910786', '1288732611354607618', '1265561101609795585', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1288732739364765698', '1288732739331211266', '1265561101609795585', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1288732806037422082', '1288732805995479041', '1265561101609795585', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1288732889676038145', '1288732889634095105', '1265561101609795585', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1288732994294562818', '1288732994244231169', '1265561101609795585', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1288733204760543234', '1288733204697628674', '1265561101609795585', 2);
INSERT INTO `el_qu_repo_ref` VALUES ('1289451760421343234', '1289451350763671554', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289452450967359489', '1289452449356746754', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289452975540572161', '1289452973904793602', '1289451674266144770', 2);
INSERT INTO `el_qu_repo_ref` VALUES ('1289453248673648641', '1289453247356637186', '1289451674266144770', 3);
INSERT INTO `el_qu_repo_ref` VALUES ('1289453571878326274', '1289453570242547714', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289454236239302658', '1289454234880348161', '1289451674266144770', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1289458350000082946', '1289458348364304385', '1289451674266144770', 2);
INSERT INTO `el_qu_repo_ref` VALUES ('1289458747573964801', '1289458693232562177', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289459007058776066', '1289459005381054465', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289459196683259906', '1289459195177504769', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289459624795869185', '1289459623126536193', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289471135207559169', '1289471133567586305', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289471481766121473', '1289471480130342913', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289471731390124034', '1289471729733373953', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289472864460378113', '1289472863202086914', '1289451674266144770', 3);
INSERT INTO `el_qu_repo_ref` VALUES ('1289473194799566849', '1289473193486749697', '1289451674266144770', 3);
INSERT INTO `el_qu_repo_ref` VALUES ('1289473381244768257', '1289473379982282753', '1289451674266144770', 3);
INSERT INTO `el_qu_repo_ref` VALUES ('1289473578679046145', '1289473577370423297', '1289451674266144770', 3);
INSERT INTO `el_qu_repo_ref` VALUES ('1289473902315737089', '1289473900633821186', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289474376330809345', '1289474314263498754', '1289451674266144770', 1);
INSERT INTO `el_qu_repo_ref` VALUES ('1289474557273083905', '1289474556119650305', '1289451674266144770', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1289475133708865537', '1289475132563820546', '1289451674266144770', 4);
INSERT INTO `el_qu_repo_ref` VALUES ('1289475784673234946', '1289475783523995650', '1289451674266144770', 4);
COMMIT;

-- ----------------------------
-- Table structure for el_qu_tag
-- ----------------------------
DROP TABLE IF EXISTS `el_qu_tag`;
CREATE TABLE `el_qu_tag` (
  `id` varchar(64) NOT NULL COMMENT 'ID',
  `tag_type` int(11) DEFAULT '0' COMMENT '标签类型',
  `tag_name` varchar(255) NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标签';

-- ----------------------------
-- Records of el_qu_tag
-- ----------------------------
BEGIN;
INSERT INTO `el_qu_tag` VALUES ('8383eb50e2a643db9c12ad53a8f61562', NULL, '智商题');
INSERT INTO `el_qu_tag` VALUES ('866d0e5d5c2a4023afef1d67df00011f', NULL, '基础题');
INSERT INTO `el_qu_tag` VALUES ('a4bff4c49a4442c2a9f64c0f651bdcb0', NULL, '附加题');
INSERT INTO `el_qu_tag` VALUES ('e93d05151b34429fab3ab9f0ace9edc6', NULL, '情商题');
COMMIT;

-- ----------------------------
-- Table structure for el_qu_tag_ref
-- ----------------------------
DROP TABLE IF EXISTS `el_qu_tag_ref`;
CREATE TABLE `el_qu_tag_ref` (
  `id` varchar(64) NOT NULL COMMENT 'ID',
  `qu_id` varchar(64) NOT NULL COMMENT '问题',
  `tag_id` varchar(64) NOT NULL COMMENT '标签',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='题目标签';


-- ----------------------------
-- Table structure for el_user_course
-- ----------------------------
DROP TABLE IF EXISTS `el_user_course`;
CREATE TABLE `el_user_course` (
  `id` varchar(32) NOT NULL COMMENT '自然ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `course_id` varchar(32) NOT NULL COMMENT '课程ID',
  `study_state` int(11) NOT NULL DEFAULT '0' COMMENT '学习状态',
  `exam_state` int(11) NOT NULL COMMENT '考试状态',
  `exam_result` int(11) NOT NULL COMMENT '考试结果',
  `exam_score` int(11) NOT NULL COMMENT '最高分数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_uq_uc` (`course_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户课程状态';

-- ----------------------------
-- Records of el_user_course
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for el_user_ware
-- ----------------------------
DROP TABLE IF EXISTS `el_user_ware`;
CREATE TABLE `el_user_ware` (
  `id` varchar(64) NOT NULL COMMENT 'ID',
  `user_id` varchar(64) NOT NULL COMMENT '用户ID',
  `course_id` varchar(64) NOT NULL COMMENT '课程ID',
  `ware_id` varchar(64) NOT NULL COMMENT '课件ID',
  `need_min` int(11) NOT NULL DEFAULT '0' COMMENT '需要分钟',
  `learn_sec` int(11) NOT NULL DEFAULT '0' COMMENT '已读秒数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_wq` (`ware_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课件阅读记录';

-- ----------------------------
-- Records of el_user_ware
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for el_user_wrong_book
-- ----------------------------
DROP TABLE IF EXISTS `el_user_wrong_book`;
CREATE TABLE `el_user_wrong_book` (
  `id` varchar(64) NOT NULL COMMENT 'ID',
  `user_id` varchar(64) NOT NULL COMMENT '用户ID',
  `qu_id` varchar(64) NOT NULL COMMENT '题目ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最近错误时间',
  `wrong_count` int(11) NOT NULL COMMENT '错误时间',
  `title` varchar(255) NOT NULL COMMENT '题目标题',
  `sort` int(11) NOT NULL COMMENT '错题序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='错题本';


-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `prepare` int(11) NOT NULL COMMENT '预热时长',
  `rest_start` time NOT NULL COMMENT '休市开始时间',
  `rest_end` time NOT NULL COMMENT '休市结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通用配置';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` VALUES ('0', 15, '02:00:00', '08:00:00');
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `title` varchar(255) NOT NULL COMMENT '日志名称',
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户ID',
  `user_name` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名称',
  `ip` varchar(255) NOT NULL DEFAULT '' COMMENT 'IP地址',
  `ip_region` varchar(255) NOT NULL DEFAULT '' COMMENT 'IP归属地',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `data` text NOT NULL COMMENT '日志明细',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志';


-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(32) NOT NULL COMMENT '角色ID',
  `role_name` varchar(255) NOT NULL DEFAULT '' COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES ('sa', '超级管理员');
INSERT INTO `sys_role` VALUES ('student', '学员');
INSERT INTO `sys_role` VALUES ('teacher', '老师');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `real_name` varchar(255) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(255) NOT NULL DEFAULT '' COMMENT '密码盐',
  `role_ids` varchar(500) NOT NULL DEFAULT '' COMMENT '角色列表',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('10001', 'admin', 'https://face-files.oss-cn-shenzhen.aliyuncs.com/logo.png', '超管A', '18c000b5a1d9f21afd1bc254c33de7fb', 'ibzeHD', 'sa', '2020-04-20 13:51:03', '2020-04-20 13:51:03', 0);
INSERT INTO `sys_user` VALUES ('1252125239901696002', 'student', 'https://file.meetboxs.com/2020/04-20/1252131827962134529.jpeg', '学员A', 'c87b067e2e4f63e93d962f422a392003', 'rfeGHz', 'student', '2020-04-20 14:41:35', '2020-04-20 14:41:35', 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `role_id` varchar(32) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户角色';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES ('10001', '10001', 'sa');
INSERT INTO `sys_user_role` VALUES ('1252200991868907521', '1252125239901696002', 'student');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
