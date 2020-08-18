SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `gnf_noah` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gnf_noah`;

-- --------------------------------------------------------

--
-- Table structure for table `address_book`
--

CREATE TABLE IF NOT EXISTS `address_book` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_name` varchar(255) NOT NULL,
  `address_address1` varchar(255) NOT NULL,
  `address_address2` varchar(255) NOT NULL,
  `address_zip` varchar(10) NOT NULL,
  `address_town` varchar(255) NOT NULL,
  `address_att` varchar(255) NOT NULL,
  `address_customer_id` bigint(20) NOT NULL,
  `address_location_id` bigint(20) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `agreements`
--

CREATE TABLE IF NOT EXISTS `agreements` (
  `agreement_id` int(99) NOT NULL AUTO_INCREMENT,
  `agreement_number` varchar(255) NOT NULL,
  `agreement_type_id` int(11) NOT NULL,
  `agreement_start_date` date NOT NULL,
  `agreement_end_date` date NOT NULL,
  `agreement_description` varchar(255) NOT NULL,
  `agreement_created_date` datetime NOT NULL,
  `agreement_created_by` bigint(20) NOT NULL,
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `agreement_asset_rel`
--

CREATE TABLE IF NOT EXISTS `agreement_asset_rel` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agreement_id` int(99) NOT NULL,
  `agreement_number` varchar(255) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `asset_serial` varchar(255) NOT NULL,
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `agreement_responsibleuser_rel`
--

CREATE TABLE IF NOT EXISTS `agreement_responsibleuser_rel` (
  `agreement_id` int(99) NOT NULL,
  `user_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `agreement_supplier_rel`
--

CREATE TABLE IF NOT EXISTS `agreement_supplier_rel` (
  `agreement_id` int(99) NOT NULL,
  `supplier_id` int(99) NOT NULL,
  KEY `agreement_supplier_idx` (`agreement_id`,`supplier_id`),
  KEY `ag_sup_idx` (`agreement_id`,`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `agreement_types`
--

CREATE TABLE IF NOT EXISTS `agreement_types` (
  `agreement_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `agreement_type_name` varchar(255) NOT NULL,
  `agreement_type_description` text NOT NULL,
  PRIMARY KEY (`agreement_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE IF NOT EXISTS `alerts` (
  `alert_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alert_asset` bigint(20) NOT NULL,
  `alert_circuit` bigint(20) NOT NULL,
  `alert_acked` tinyint(4) NOT NULL,
  `alert_acked_datetime` datetime NOT NULL,
  `alert_source` text NOT NULL,
  `alert_datetime` datetime NOT NULL,
  `alert_string` text NOT NULL,
  PRIMARY KEY (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE IF NOT EXISTS `applications` (
  `app_id` int(11) NOT NULL AUTO_INCREMENT,
  `environment_id` int(11) NOT NULL,
  `application_resilience_level_id` int(11) NOT NULL,
  `app_name` varchar(255) NOT NULL,
  `app_description` text NOT NULL,
  `app_version` varchar(20) NOT NULL,
  `app_patch_level` varchar(20) NOT NULL,
  `app_license_status` int(11) NOT NULL,
  `app_lifespan` int(11) NOT NULL,
  `app_poe_user` int(11) NOT NULL,
  `app_owner` bigint(20) NOT NULL,
  `app_provider` bigint(20) NOT NULL,
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `application_resilience_level`
--

CREATE TABLE IF NOT EXISTS `application_resilience_level` (
  `application_resilience_level_id` int(11) NOT NULL AUTO_INCREMENT,
  `application_resilience_level_name` varchar(255) NOT NULL,
  `application_resilience_level_description` text NOT NULL,
  PRIMARY KEY (`application_resilience_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `application_users_rel`
--

CREATE TABLE IF NOT EXISTS `application_users_rel` (
  `app_id` int(11) NOT NULL,
  `user_id` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE IF NOT EXISTS `assets` (
  `asset_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asset_certificate` int(11) NOT NULL,
  `asset_external_id` varchar(255) NOT NULL,
  `asset_parent_id` bigint(20) NOT NULL COMMENT 'assetid which this asset belongs to',
  `asset_status` int(1) NOT NULL DEFAULT '1',
  `asset_name` varchar(255) NOT NULL,
  `asset_created_date` datetime NOT NULL,
  `asset_created_by_user_id` int(99) NOT NULL,
  `asset_deleted_date` datetime NOT NULL,
  `asset_deleted_by` int(99) NOT NULL,
  `asset_primary_group` int(11) NOT NULL,
  `asset_primary_techie` int(99) NOT NULL,
  `asset_secondary_techie` int(99) NOT NULL,
  `type_id` int(99) NOT NULL DEFAULT '5',
  `position_id` bigint(20) NOT NULL,
  `position_u` tinyint(5) NOT NULL COMMENT 'Bottom Unit Asset is mounted at',
  `x_coord` varchar(50) NOT NULL DEFAULT '55',
  `y_coord` varchar(50) NOT NULL DEFAULT '10',
  `asset_producer` varchar(255) NOT NULL,
  `asset_serialnumber` varchar(255) NOT NULL,
  `asset_unitshigh` varchar(3) NOT NULL,
  `asset_memory` varchar(255) NOT NULL,
  `asset_snmp_community` varchar(100) NOT NULL,
  `asset_invoice_date` date NOT NULL,
  `asset_invoice` varchar(50) NOT NULL,
  `asset_warranty_period` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'in years',
  `asset_owner_status` varchar(255) NOT NULL,
  `asset_supplier` varchar(255) NOT NULL,
  `asset_supplied_date` date NOT NULL,
  `asset_cost` varchar(255) NOT NULL,
  `asset_cost_currency` int(11) NOT NULL,
  `asset_condition` tinyint(1) NOT NULL COMMENT '0=new, 1=used',
  `asset_supposed_kw` varchar(10) NOT NULL DEFAULT '0',
  `asset_consumed_kw` varchar(10) NOT NULL DEFAULT '0',
  `asset_chill_kw` varchar(10) NOT NULL DEFAULT '0',
  `asset_height` varchar(10) NOT NULL,
  `asset_length` varchar(10) NOT NULL,
  `asset_depth` varchar(10) NOT NULL,
  `asset_weight` varchar(10) NOT NULL,
  `asset_comment` text NOT NULL,
  `asset_model` int(11) NOT NULL,
  `os_type_name` varchar(255) NOT NULL,
  `asset_type_no` varchar(255) NOT NULL,
  `asset_spareparts` text NOT NULL,
  `asset_responsibility` tinyint(4) NOT NULL DEFAULT '0',
  `environment_id` int(11) NOT NULL,
  `asset_memory_prefix` tinyint(1) NOT NULL,
  `asset_oat_state` tinyint(4) NOT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `asset_location_idx` (`position_id`),
  KEY `asset_serialnumber_idx` (`asset_serialnumber`),
  KEY `asset_status_idx` (`asset_status`),
  KEY `asset_data_idx` (`position_id`,`asset_serialnumber`,`asset_status`),
  KEY `Locations` (`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `assets`
--
DELIMITER $$
CREATE TRIGGER `before_assets_create` AFTER INSERT ON `assets` FOR EACH ROW BEGIN
          INSERT INTO `audit_assets`
          SET audit_action = 'create', audit_datetime = NOW(),
                asset_id = asset_id,asset_external_id = asset_external_id,asset_parent_id = asset_parent_id,asset_status = asset_status,asset_name = asset_name,asset_created_date = asset_created_date,asset_created_by_user_id = asset_created_by_user_id,asset_deleted_date = asset_deleted_date,asset_deleted_by = asset_deleted_by,asset_primary_group = asset_primary_group,asset_primary_techie = asset_primary_techie,asset_secondary_techie = asset_secondary_techie,type_id = type_id,position_id = position_id,position_u = position_u,x_coord = x_coord,y_coord = y_coord,asset_producer = asset_producer,asset_serialnumber = asset_serialnumber,asset_unitshigh = asset_unitshigh,asset_memory = asset_memory,asset_snmp_community = asset_snmp_community,asset_invoice_date = asset_invoice_date,asset_invoice = asset_invoice,asset_warranty_period = asset_warranty_period,asset_owner_status = asset_owner_status,asset_supplier = asset_supplier,asset_supplied_date = asset_supplied_date,asset_cost = asset_cost,asset_cost_currency = asset_cost_currency,asset_condition = asset_condition,asset_supposed_kw = asset_supposed_kw,asset_consumed_kw = asset_consumed_kw,asset_chill_kw = asset_chill_kw,asset_height = asset_height,asset_length = asset_length,asset_depth = asset_depth,asset_weight = asset_weight,asset_comment = asset_comment,asset_model = asset_model,os_type_name = os_type_name,asset_type_no = asset_type_no,asset_spareparts = asset_spareparts,asset_responsibility = asset_responsibility,environment_id = environment_id,asset_memory_prefix = asset_memory_prefix;
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_assets_delete` BEFORE DELETE ON `assets` FOR EACH ROW BEGIN
          INSERT INTO `audit_assets`
          SET audit_action = 'delete', audit_datetime = NOW(),
                asset_id = OLD.asset_id,asset_external_id = OLD.asset_external_id,asset_parent_id = OLD.asset_parent_id,asset_status = OLD.asset_status,asset_name = OLD.asset_name,asset_created_date = OLD.asset_created_date,asset_created_by_user_id = OLD.asset_created_by_user_id,asset_deleted_date = OLD.asset_deleted_date,asset_deleted_by = OLD.asset_deleted_by,asset_primary_group = OLD.asset_primary_group,asset_primary_techie = OLD.asset_primary_techie,asset_secondary_techie = OLD.asset_secondary_techie,type_id = OLD.type_id,position_id = OLD.position_id,position_u = OLD.position_u,x_coord = OLD.x_coord,y_coord = OLD.y_coord,asset_producer = OLD.asset_producer,asset_serialnumber = OLD.asset_serialnumber,asset_unitshigh = OLD.asset_unitshigh,asset_memory = OLD.asset_memory,asset_snmp_community = OLD.asset_snmp_community,asset_invoice_date = OLD.asset_invoice_date,asset_invoice = OLD.asset_invoice,asset_warranty_period = OLD.asset_warranty_period,asset_owner_status = OLD.asset_owner_status,asset_supplier = OLD.asset_supplier,asset_supplied_date = OLD.asset_supplied_date,asset_cost = OLD.asset_cost,asset_cost_currency = OLD.asset_cost_currency,asset_condition = OLD.asset_condition,asset_supposed_kw = OLD.asset_supposed_kw,asset_consumed_kw = OLD.asset_consumed_kw,asset_chill_kw = OLD.asset_chill_kw,asset_height = OLD.asset_height,asset_length = OLD.asset_length,asset_depth = OLD.asset_depth,asset_weight = OLD.asset_weight,asset_comment = OLD.asset_comment,asset_model = OLD.asset_model,os_type_name = OLD.os_type_name,asset_type_no = OLD.asset_type_no,asset_spareparts = OLD.asset_spareparts,asset_responsibility = OLD.asset_responsibility,environment_id = OLD.environment_id,asset_memory_prefix = OLD.asset_memory_prefix;
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_assets_update` BEFORE UPDATE ON `assets` FOR EACH ROW BEGIN
          INSERT INTO `audit_assets`
          SET audit_action = 'update', audit_datetime = NOW(),
                asset_id = OLD.asset_id,asset_external_id = OLD.asset_external_id,asset_parent_id = OLD.asset_parent_id,asset_status = OLD.asset_status,asset_name = OLD.asset_name,asset_created_date = OLD.asset_created_date,asset_created_by_user_id = OLD.asset_created_by_user_id,asset_deleted_date = OLD.asset_deleted_date,asset_deleted_by = OLD.asset_deleted_by,asset_primary_group = OLD.asset_primary_group,asset_primary_techie = OLD.asset_primary_techie,asset_secondary_techie = OLD.asset_secondary_techie,type_id = OLD.type_id,position_id = OLD.position_id,position_u = OLD.position_u,x_coord = OLD.x_coord,y_coord = OLD.y_coord,asset_producer = OLD.asset_producer,asset_serialnumber = OLD.asset_serialnumber,asset_unitshigh = OLD.asset_unitshigh,asset_memory = OLD.asset_memory,asset_snmp_community = OLD.asset_snmp_community,asset_invoice_date = OLD.asset_invoice_date,asset_invoice = OLD.asset_invoice,asset_warranty_period = OLD.asset_warranty_period,asset_owner_status = OLD.asset_owner_status,asset_supplier = OLD.asset_supplier,asset_supplied_date = OLD.asset_supplied_date,asset_cost = OLD.asset_cost,asset_cost_currency = OLD.asset_cost_currency,asset_condition = OLD.asset_condition,asset_supposed_kw = OLD.asset_supposed_kw,asset_consumed_kw = OLD.asset_consumed_kw,asset_chill_kw = OLD.asset_chill_kw,asset_height = OLD.asset_height,asset_length = OLD.asset_length,asset_depth = OLD.asset_depth,asset_weight = OLD.asset_weight,asset_comment = OLD.asset_comment,asset_model = OLD.asset_model,os_type_name = OLD.os_type_name,asset_type_no = OLD.asset_type_no,asset_spareparts = OLD.asset_spareparts,asset_responsibility = OLD.asset_responsibility,environment_id = OLD.environment_id,asset_memory_prefix = OLD.asset_memory_prefix;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `asset_agreement_rel`
--

CREATE TABLE IF NOT EXISTS `asset_agreement_rel` (
  `asset_id` bigint(20) NOT NULL,
  `agreement_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_application_rel`
--

CREATE TABLE IF NOT EXISTS `asset_application_rel` (
  `asset_id` bigint(20) NOT NULL,
  `app_id` int(11) NOT NULL,
  `asset_app_comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_backup_rel`
--

CREATE TABLE IF NOT EXISTS `asset_backup_rel` (
  `asset_id` bigint(20) NOT NULL,
  `backup_id` int(11) NOT NULL,
  `asset_backup_comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_certificates_rel`
--

CREATE TABLE IF NOT EXISTS `asset_certificates_rel` (
  `asset_id` bigint(20) NOT NULL,
  `certificate_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `asset_cpu_type_rel`
--

CREATE TABLE IF NOT EXISTS `asset_cpu_type_rel` (
  `asset_id` bigint(20) NOT NULL,
  `cpu_id` int(99) NOT NULL,
  `cpu_sockets` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_customer_rel`
--

CREATE TABLE IF NOT EXISTS `asset_customer_rel` (
  `asset_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `dummy_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`dummy_id`),
  KEY `asset_customer_rel_idx` (`asset_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_enclosure_rel`
--

CREATE TABLE IF NOT EXISTS `asset_enclosure_rel` (
  `asset_id` bigint(20) NOT NULL,
  `enclosure_id` int(99) NOT NULL,
  `enclosure_position` int(99) NOT NULL,
  `enclosure_back_position` tinyint(1) NOT NULL,
  PRIMARY KEY (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_hba_rel`
--

CREATE TABLE IF NOT EXISTS `asset_hba_rel` (
  `asset_id` bigint(20) NOT NULL,
  `hba_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_history`
--

CREATE TABLE IF NOT EXISTS `asset_history` (
  `history_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) NOT NULL,
  `datetime` datetime NOT NULL,
  `user_id` int(2) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `task` varchar(255) NOT NULL,
  `form_data` text NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_images`
--

CREATE TABLE IF NOT EXISTS `asset_images` (
  `asset_image_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) NOT NULL,
  `asset_image_name` varchar(255) NOT NULL,
  `asset_image_type` varchar(30) NOT NULL,
  `asset_image_size` varchar(30) NOT NULL,
  PRIMARY KEY (`asset_image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_interface_rel`
--

CREATE TABLE IF NOT EXISTS `asset_interface_rel` (
  `asset_id` bigint(20) NOT NULL,
  `interface_id` bigint(20) NOT NULL,
  KEY `asset_id` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_license_rel`
--

CREATE TABLE IF NOT EXISTS `asset_license_rel` (
  `asset_id` int(10) UNSIGNED NOT NULL,
  `license_id` int(10) UNSIGNED NOT NULL,
  `license_number_assigned` int(10) UNSIGNED NOT NULL,
  `asset_license_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_oats`
--

CREATE TABLE IF NOT EXISTS `asset_oats` (
  `asset_oat_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) NOT NULL,
  `oat_id` int(11) NOT NULL,
  `oat_userid` bigint(20) NOT NULL,
  `oat_handler_user_id` bigint(20) NOT NULL,
  `oat_status` int(11) NOT NULL COMMENT '0=ongoing, 1=approved, 2= rejected',
  `oat_datetime` datetime NOT NULL,
  `asset_oat_type` int(11) NOT NULL,
  `asset_oat_status` int(11) NOT NULL,
  PRIMARY KEY (`asset_oat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `asset_oat_question_answer_rel`
--

CREATE TABLE IF NOT EXISTS `asset_oat_question_answer_rel` (
  `answer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `asset_oat_id` bigint(20) NOT NULL,
  `oat_id` int(10) UNSIGNED NOT NULL,
  `asset_id` int(10) UNSIGNED NOT NULL,
  `question_id` int(10) UNSIGNED NOT NULL,
  `answer_text` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `question_id` (`question_id`,`asset_oat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `asset_oat_template`
--

CREATE TABLE IF NOT EXISTS `asset_oat_template` (
  `oat_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `oat_template_name` varchar(256) NOT NULL,
  `asset_type` int(10) UNSIGNED NOT NULL,
  `asset_status` int(3) UNSIGNED NOT NULL,
  `person_to_confirm` varchar(256) NOT NULL,
  PRIMARY KEY (`oat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `asset_oat_template_question_rel`
--

CREATE TABLE IF NOT EXISTS `asset_oat_template_question_rel` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `oat_id` int(11) NOT NULL,
  `oat_id_order` int(11) NOT NULL COMMENT 'sort order',
  `task_question` text CHARACTER SET utf8 NOT NULL,
  `task_suggestion` text CHARACTER SET utf8 NOT NULL,
  `task_type_of_answer` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `asset_parts_rel`
--

CREATE TABLE IF NOT EXISTS `asset_parts_rel` (
  `asset_id` bigint(20) NOT NULL,
  `part_id` bigint(20) NOT NULL,
  `no_items` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `asset_password_rel`
--

CREATE TABLE IF NOT EXISTS `asset_password_rel` (
  `asset_id` bigint(20) NOT NULL,
  `password_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_port_rel`
--

CREATE TABLE IF NOT EXISTS `asset_port_rel` (
  `asset_id` bigint(20) NOT NULL,
  `port_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_snmp_data`
--

CREATE TABLE IF NOT EXISTS `asset_snmp_data` (
  `snmp_id` int(11) NOT NULL AUTO_INCREMENT,
  `scan_date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hostname` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `system` varchar(255) NOT NULL,
  `memory` varchar(255) NOT NULL,
  `asset_id` int(11) NOT NULL,
  `interface_ip_address` varchar(40) NOT NULL,
  PRIMARY KEY (`snmp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_snmp_data_processors`
--

CREATE TABLE IF NOT EXISTS `asset_snmp_data_processors` (
  `snmp_id` int(11) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `interface_ip_address` varchar(255) NOT NULL,
  `processor` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_status`
--

CREATE TABLE IF NOT EXISTS `asset_status` (
  `assetstatus_id` int(1) NOT NULL AUTO_INCREMENT,
  `assetstatus_name` varchar(255) NOT NULL,
  `assetstatus_desc` varchar(255) NOT NULL,
  `image_link` varchar(255) NOT NULL,
  `status_icon_color` varchar(10) NOT NULL,
  PRIMARY KEY (`assetstatus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_types`
--

CREATE TABLE IF NOT EXISTS `asset_types` (
  `type_id` int(99) NOT NULL AUTO_INCREMENT,
  `locked_record` tinyint(4) NOT NULL DEFAULT '0',
  `type_entity` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-physical; 1-virtual',
  `type_name` varchar(255) NOT NULL,
  `type_description` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `asset_type_elements`
--

CREATE TABLE IF NOT EXISTS `asset_type_elements` (
  `ate_id` int(11) NOT NULL AUTO_INCREMENT,
  `ate_name` varchar(255) NOT NULL,
  `ate_description` text NOT NULL,
  PRIMARY KEY (`ate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabs/Elements part of type';

-- --------------------------------------------------------

--
-- Table structure for table `asset_users_rel`
--

CREATE TABLE IF NOT EXISTS `asset_users_rel` (
  `asset_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ate_type_rel`
--

CREATE TABLE IF NOT EXISTS `ate_type_rel` (
  `ate_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='binding between asset type and entety/tab';

-- --------------------------------------------------------

--
-- Table structure for table `audit_assets`
--

CREATE TABLE IF NOT EXISTS `audit_assets` (
  `audit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `audit_datetime` datetime NOT NULL,
  `audit_action` varchar(50) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `asset_external_id` varchar(255) NOT NULL,
  `asset_parent_id` bigint(20) NOT NULL,
  `asset_status` int(1) NOT NULL,
  `asset_name` varchar(255) NOT NULL,
  `asset_created_date` datetime NOT NULL,
  `asset_created_by_user_id` int(99) NOT NULL,
  `asset_deleted_date` datetime NOT NULL,
  `asset_deleted_by` int(99) NOT NULL,
  `asset_primary_group` int(11) NOT NULL,
  `asset_primary_techie` int(99) NOT NULL,
  `asset_secondary_techie` int(99) NOT NULL,
  `type_id` int(99) NOT NULL,
  `position_id` bigint(20) NOT NULL,
  `position_u` tinyint(5) NOT NULL,
  `x_coord` varchar(50) NOT NULL,
  `y_coord` varchar(50) NOT NULL,
  `asset_producer` varchar(255) NOT NULL,
  `asset_serialnumber` varchar(255) NOT NULL,
  `asset_unitshigh` varchar(3) NOT NULL,
  `asset_memory` varchar(255) NOT NULL,
  `asset_snmp_community` varchar(100) NOT NULL,
  `asset_invoice_date` date NOT NULL,
  `asset_invoice` varchar(50) NOT NULL,
  `asset_warranty_period` tinyint(1) NOT NULL,
  `asset_owner_status` varchar(255) NOT NULL,
  `asset_supplier` varchar(255) NOT NULL,
  `asset_supplied_date` date NOT NULL,
  `asset_cost` varchar(255) NOT NULL,
  `asset_cost_currency` int(11) NOT NULL,
  `asset_condition` tinyint(1) NOT NULL,
  `asset_supposed_kw` varchar(10) NOT NULL,
  `asset_consumed_kw` varchar(10) NOT NULL,
  `asset_chill_kw` varchar(10) NOT NULL,
  `asset_height` varchar(10) NOT NULL,
  `asset_length` varchar(10) NOT NULL,
  `asset_depth` varchar(10) NOT NULL,
  `asset_weight` varchar(10) NOT NULL,
  `asset_comment` text NOT NULL,
  `asset_model` varchar(255) NOT NULL,
  `os_type_name` varchar(255) NOT NULL,
  `asset_type_no` varchar(255) NOT NULL,
  `asset_spareparts` text NOT NULL,
  `asset_responsibility` tinyint(4) NOT NULL,
  `environment_id` int(11) NOT NULL,
  `asset_memory_prefix` tinyint(1) NOT NULL,
  `asset_oat_state` tinyint(4) NOT NULL,
  `asset_certificate` int(11) NOT NULL,
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `audit_circuits`
--

CREATE TABLE IF NOT EXISTS `audit_circuits` (
  `audit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `audit_datetime` datetime NOT NULL,
  `audit_action` varchar(50) NOT NULL,
  `circuit_id` bigint(20) NOT NULL,
  `circuit_name` varchar(255) NOT NULL,
  `circuit_external_name` varchar(255) NOT NULL,
  `circuit_comment` text NOT NULL,
  `circuit_type_id` int(99) NOT NULL,
  `position_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `fixA_point` varchar(255) NOT NULL COMMENT 'First point of exit',
  `fixB_point` varchar(255) NOT NULL COMMENT 'Second point of exit',
  `fixA_interface` varchar(255) NOT NULL,
  `fixB_interface` varchar(255) NOT NULL,
  `circuit_size` varchar(5) NOT NULL,
  `circuit_prefix` tinyint(4) NOT NULL,
  PRIMARY KEY (`audit_id`),
  KEY `circuit_name_idx` (`circuit_name`),
  KEY `circuit_data_idx` (`circuit_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `audit_tickets`
--

CREATE TABLE IF NOT EXISTS `audit_tickets` (
  `audit_id` bigint(20) NOT NULL,
  `audit_action` varchar(50) NOT NULL,
  `audit_datetime` datetime NOT NULL,
  `ticket_id` bigint(20) NOT NULL,
  `public_token` text NOT NULL COMMENT 'ticket_id and key',
  `customer_id` bigint(20) NOT NULL,
  `mail_data_id` bigint(20) NOT NULL COMMENT 'ID from Mail received crontab_imap_ticket.php',
  `ticket_status` int(1) NOT NULL COMMENT '1=open, 2=active, 3=closed,4=spam',
  `maintenance_id` int(99) NOT NULL,
  `ticket_level` bigint(20) NOT NULL DEFAULT '0' COMMENT '0:top level, else incident_id',
  `ticket_title` varchar(255) NOT NULL,
  `ticket_desc` text NOT NULL,
  `ticket_priority` int(1) NOT NULL,
  `ticket_ext_priority` tinyint(1) NOT NULL COMMENT 'customers priority',
  `ticket_internal_comment` text NOT NULL,
  `ticket_external_id` varchar(255) NOT NULL,
  `ticket_created_date` datetime NOT NULL,
  `ticket_created_by_user_id` int(99) NOT NULL,
  `ticket_onbehalfof` bigint(20) NOT NULL,
  `ticket_created_by_contact_id` bigint(20) NOT NULL,
  `ticket_closed_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ticket_closing_user` bigint(20) NOT NULL COMMENT 'Who closed the case',
  `ticket_current_user_id` bigint(20) NOT NULL COMMENT 'Who has the case now!?',
  `ticket_current_group_id` int(99) NOT NULL COMMENT 'Which group has the incident now?',
  `ticket_latest_update_datetime` datetime NOT NULL,
  `ticket_latest_update_by_userid` bigint(20) NOT NULL,
  `ticket_notify_creator_on_close` int(1) NOT NULL,
  `ticket_type_id` int(9) NOT NULL,
  `ticket_sub_type_id` int(99) NOT NULL,
  `ticket_category_id` int(99) NOT NULL,
  `ticket_urgency` tinyint(1) NOT NULL DEFAULT '3' COMMENT '3=low, 2=average, 1=high',
  `ticket_impact` tinyint(1) NOT NULL DEFAULT '3' COMMENT '3=low, 2=average, 1=high',
  `ticket_risk` tinyint(4) NOT NULL,
  `ticket_fallback` text NOT NULL,
  `ticket_reason` tinyint(4) NOT NULL COMMENT 'Reason for creating RFC ',
  `ticket_rfc_execution_date` datetime NOT NULL,
  `await_ticket_id` int(11) NOT NULL,
  `wf_task_id` bigint(20) NOT NULL,
  `ticket_responsible_user` bigint(20) NOT NULL,
  `ticket_sender_email` varchar(255) NOT NULL,
  `ticket_deadline` date NOT NULL,
  `ticket_start_date` date NOT NULL,
  `ticket_end_date` date NOT NULL,
  `ticket_finance_note` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `backups`
--

CREATE TABLE IF NOT EXISTS `backups` (
  `backup_id` int(11) NOT NULL AUTO_INCREMENT,
  `backup_name` varchar(255) NOT NULL,
  `backup_description` text NOT NULL,
  PRIMARY KEY (`backup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `calendars`
--

CREATE TABLE IF NOT EXISTS `calendars` (
  `calendar_id` int(11) NOT NULL AUTO_INCREMENT,
  `calendar_name` varchar(255) NOT NULL,
  `calendar_description` text NOT NULL,
  `calendar_creator` bigint(20) NOT NULL,
  `calendar_created_date` date NOT NULL,
  PRIMARY KEY (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `calendar_user_rel`
--

CREATE TABLE IF NOT EXISTS `calendar_user_rel` (
  `calendar_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE IF NOT EXISTS `certificates` (
  `certificate_id` int(10) UNSIGNED NOT NULL,
  `certificate_name` varchar(256) NOT NULL,
  `certificate_type` int(11) NOT NULL COMMENT 'root, server, personal, software, content signing certificate',
  `encryption_algorythm` varchar(256) CHARACTER SET utf8 NOT NULL,
  `key_size` smallint(6) NOT NULL,
  `common_name` varchar(256) CHARACTER SET utf8 NOT NULL,
  `organization` varchar(256) CHARACTER SET utf8 NOT NULL,
  `country` varchar(256) CHARACTER SET utf8 NOT NULL,
  `location` varchar(256) CHARACTER SET utf8 NOT NULL,
  `san_domains` text CHARACTER SET utf8 NOT NULL,
  `valid_from` date NOT NULL,
  `valid_to` date NOT NULL,
  `provider` varchar(256) CHARACTER SET utf8 NOT NULL,
  `responsible_userid` bigint(20) NOT NULL,
  `optional_certification_types` varchar(256) CHARACTER SET utf8 NOT NULL,
  `certificate_format` varchar(256) CHARACTER SET utf8 NOT NULL,
  `vpn` text CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cf_options`
--

CREATE TABLE IF NOT EXISTS `cf_options` (
  `cf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cf_time_id` varchar(20) NOT NULL,
  `customer_field_id` int(11) NOT NULL,
  `cf_text` varchar(255) NOT NULL,
  PRIMARY KEY (`cf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='options to customer_fields';

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE IF NOT EXISTS `chat_messages` (
  `message_id` bigint(20) UNSIGNED NOT NULL,
  `user` text NOT NULL,
  `message` text NOT NULL,
  `sent_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `circuits`
--

CREATE TABLE IF NOT EXISTS `circuits` (
  `circuit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `circuit_name` varchar(255) NOT NULL,
  `circuit_external_name` varchar(255) NOT NULL,
  `circuit_comment` text NOT NULL,
  `circuit_type_id` int(99) NOT NULL,
  `position_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `fixA_point` varchar(255) NOT NULL COMMENT 'First point of exit',
  `fixB_point` varchar(255) NOT NULL COMMENT 'Second point of exit',
  `fixA_interface` varchar(255) NOT NULL,
  `fixB_interface` varchar(255) NOT NULL,
  `circuit_size` varchar(5) NOT NULL,
  `circuit_prefix` tinyint(4) NOT NULL,
  PRIMARY KEY (`circuit_id`),
  KEY `circuit_name_idx` (`circuit_name`),
  KEY `circuit_data_idx` (`circuit_id`,`circuit_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `circuits`
--
DELIMITER $$
CREATE TRIGGER `before_circuits_create` AFTER INSERT ON `circuits` FOR EACH ROW BEGIN
          INSERT INTO `audit_circuits`
          SET audit_action = 'create', audit_datetime = NOW(),
                circuit_id = circuit_id,circuit_name = circuit_name,circuit_external_name = circuit_external_name,circuit_comment = circuit_comment,circuit_type_id = circuit_type_id,position_id = position_id,supplier_id = supplier_id,customer_id = customer_id,fixA_point = fixA_point,fixB_point = fixB_point,fixA_interface = fixA_interface,fixB_interface = fixB_interface,circuit_size = circuit_size,circuit_prefix = circuit_prefix;
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_circuits_delete` BEFORE DELETE ON `circuits` FOR EACH ROW BEGIN
          INSERT INTO `audit_circuits`
          SET audit_action = 'delete', audit_datetime = NOW(),
                circuit_id = OLD.circuit_id,circuit_name = OLD.circuit_name,circuit_external_name = OLD.circuit_external_name,circuit_comment = OLD.circuit_comment,circuit_type_id = OLD.circuit_type_id,position_id = OLD.position_id,supplier_id = OLD.supplier_id,customer_id = OLD.customer_id,fixA_point = OLD.fixA_point,fixB_point = OLD.fixB_point,fixA_interface = OLD.fixA_interface,fixB_interface = OLD.fixB_interface,circuit_size = OLD.circuit_size,circuit_prefix = OLD.circuit_prefix;
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_circuits_update` BEFORE UPDATE ON `circuits` FOR EACH ROW BEGIN
          INSERT INTO `audit_circuits`
          SET audit_action = 'update', audit_datetime = NOW(),
                circuit_id = OLD.circuit_id,circuit_name = OLD.circuit_name,circuit_external_name = OLD.circuit_external_name,circuit_comment = OLD.circuit_comment,circuit_type_id = OLD.circuit_type_id,position_id = OLD.position_id,supplier_id = OLD.supplier_id,customer_id = OLD.customer_id,fixA_point = OLD.fixA_point,fixB_point = OLD.fixB_point,fixA_interface = OLD.fixA_interface,fixB_interface = OLD.fixB_interface,circuit_size = OLD.circuit_size,circuit_prefix = OLD.circuit_prefix;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `circuit_agreement_rel`
--

CREATE TABLE IF NOT EXISTS `circuit_agreement_rel` (
  `circuit_id` bigint(20) NOT NULL,
  `agreement_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `circuit_history`
--

CREATE TABLE IF NOT EXISTS `circuit_history` (
  `history_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `circuit_id` bigint(20) NOT NULL,
  `datetime` datetime NOT NULL,
  `user_id` int(2) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `task` varchar(255) NOT NULL,
  `form_data` text NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `circuit_types`
--

CREATE TABLE IF NOT EXISTS `circuit_types` (
  `circuit_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `circuit_type_name` varchar(255) NOT NULL,
  `circuit_type_description` varchar(255) NOT NULL,
  PRIMARY KEY (`circuit_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `clusters`
--

CREATE TABLE IF NOT EXISTS `clusters` (
  `cluster_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL COMMENT 'Master Asset (virtual asset)',
  `cluster_management_server` bigint(20) NOT NULL COMMENT 'Asset for management server',
  `created_by_user` int(99) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cluster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cluster_guest_asset_rel`
--

CREATE TABLE IF NOT EXISTS `cluster_guest_asset_rel` (
  `cluster_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cluster_node_asset_rel`
--

CREATE TABLE IF NOT EXISTS `cluster_node_asset_rel` (
  `cluster_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cluster_shares`
--

CREATE TABLE IF NOT EXISTS `cluster_shares` (
  `cluster_share_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cluster_id` bigint(20) NOT NULL,
  `disc_storage_ext_id` bigint(20) NOT NULL,
  `cluster_share_name` varchar(255) NOT NULL,
  `cluster_share_size` varchar(100) NOT NULL,
  `cluster_share_path` text NOT NULL,
  `disk_prefix` tinyint(4) NOT NULL,
  PRIMARY KEY (`cluster_share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `contact_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_name` varchar(255) NOT NULL,
  `contact_title` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `contact_phone` varchar(40) NOT NULL,
  `contact_mobile` varchar(40) NOT NULL,
  `contact_address1` varchar(255) NOT NULL,
  `contact_address2` varchar(255) NOT NULL,
  `contact_pono` varchar(10) NOT NULL,
  `contact_city` varchar(255) NOT NULL,
  `contact_country_id` int(99) NOT NULL,
  `contact_type_id` int(99) NOT NULL,
  `contact_company` varchar(255) NOT NULL,
  `contact_comment` varchar(255) NOT NULL,
  `contact_password` varchar(255) NOT NULL,
  `contact_active_login` tinyint(1) NOT NULL DEFAULT '0',
  `contact_last_login` datetime NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `contact_name_idx` (`contact_name`),
  KEY `contact_email_idx` (`contact_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `contact_email_rel`
--

CREATE TABLE IF NOT EXISTS `contact_email_rel` (
  `contact_id` bigint(20) NOT NULL,
  `email_id` bigint(20) NOT NULL,
  KEY `email_idx` (`contact_id`,`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contact_portal_rights_rel`
--

CREATE TABLE IF NOT EXISTS `contact_portal_rights_rel` (
  `contact_id` bigint(20) NOT NULL,
  `portal_right_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `contact_types`
--

CREATE TABLE IF NOT EXISTS `contact_types` (
  `contact_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `contact_type_name` varchar(255) NOT NULL,
  `contact_type_description` text NOT NULL,
  PRIMARY KEY (`contact_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `core_data`
--

CREATE TABLE IF NOT EXISTS `core_data` (
  `core_version` varchar(10) NOT NULL,
  `core_revision` varchar(2) NOT NULL,
  `core_upgrade_date` datetime NOT NULL,
  `core_upgrade_available` varchar(1) NOT NULL DEFAULT '0' COMMENT '0=na, 1=available',
  `core_pwd_days_expire` varchar(3) NOT NULL DEFAULT '90',
  `super_user_email` varchar(100) NOT NULL,
  `support_email` varchar(255) NOT NULL,
  `replyto_email` varchar(255) NOT NULL,
  `custom_logo` varchar(255) NOT NULL,
  `cookietime` varchar(10) NOT NULL COMMENT 'Number of days',
  `maintainance_mode` varchar(5) NOT NULL,
  `ldap_host` varchar(255) NOT NULL,
  `ldap_domain` varchar(255) NOT NULL,
  `ldap_admin` varchar(255) NOT NULL,
  `ldap_password` varchar(50) NOT NULL,
  `cookiename` varchar(50) NOT NULL,
  `imap_host` varchar(255) NOT NULL,
  `imap_domain` varchar(255) NOT NULL,
  `imap_user` varchar(255) NOT NULL,
  `imap_password` varchar(50) NOT NULL,
  `imap_tuo_host` varchar(255) NOT NULL,
  `imap_tuo_port` varchar(6) NOT NULL,
  `imap_tuo_domain` varchar(255) NOT NULL,
  `imap_tuo_user` varchar(255) NOT NULL,
  `imap_tuo_password` text NOT NULL,
  `nmap_path` text NOT NULL,
  `ticket_throttle_time` varchar(4) NOT NULL DEFAULT '10' COMMENT 'seconds until end of throttle',
  `ticket_indicator` varchar(10) NOT NULL,
  `ticket_all_allowed` varchar(5) NOT NULL DEFAULT '0',
  `ticket_email_delete` varchar(5) NOT NULL DEFAULT '0' COMMENT '0=leave, 1=delete mail after processing',
  `ticket_billing_email` varchar(255) NOT NULL,
  `ticket_inactive_days` varchar(5) NOT NULL DEFAULT '0',
  `ticket_close_on_inactive` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1=activated',
  `ticket_default_deadline_period` tinyint(4) NOT NULL DEFAULT '0',
  `ticket_dispatch_email` varchar(255) NOT NULL COMMENT 'relates to dispatch rules',
  `ticket_dispatch_tags` varchar(255) NOT NULL DEFAULT 'FWD:, VS:',
  `ticket_send_link_to_sender` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=no, 1=yes',
  `ticket_save_rfc_pdf` varchar(5) NOT NULL,
  `ticket_save_rfc_pdf_path` text NOT NULL,
  `portal_active` varchar(5) NOT NULL DEFAULT '0',
  `portal_host` varchar(255) NOT NULL,
  `portal_db_name` varchar(255) NOT NULL,
  `portal_db_username` varchar(255) NOT NULL,
  `portal_db_password` varchar(255) NOT NULL,
  `portal_db_token` varchar(40) NOT NULL COMMENT 'Token for the Portal Part',
  `api_key` varchar(255) NOT NULL,
  `core_installed` int(11) NOT NULL,
  `core_salt` varchar(255) NOT NULL,
  `core_language` varchar(2) NOT NULL,
  `sms_text_gateway_script_string` varchar(255) NOT NULL,
  `exchange_active` varchar(5) NOT NULL DEFAULT '0',
  `exchange_encryption_type` varchar(20) NOT NULL,
  `exchange_version` varchar(50) NOT NULL,
  `exchange_host` varchar(255) NOT NULL,
  `exchange_port` varchar(5) NOT NULL,
  `exchange_domain` varchar(255) NOT NULL,
  `exchange_user` varchar(255) NOT NULL,
  `exchange_password` varchar(255) NOT NULL,
  `exchange_reminder_setting` varchar(255) NOT NULL,
  `ldap_active` varchar(5) NOT NULL DEFAULT '0',
  `imap_active` varchar(5) NOT NULL DEFAULT '0',
  `imap_encryption_type` varchar(5) NOT NULL,
  `imap_port` varchar(100) NOT NULL,
  `ticket_page_refresh` int(2) NOT NULL,
  `ticket_default_action` varchar(5) NOT NULL,
  `ticket_domain_relate` varchar(5) NOT NULL,
  `ticket_dispatch_active` varchar(5) NOT NULL DEFAULT '0',
  `ticket_default_priority` int(11) NOT NULL DEFAULT '3' COMMENT '1-5, 1 high, 5 low',
  `custom_mail_header` text NOT NULL,
  `custom_mail_footer` text NOT NULL,
  `finance_agreement_system` varchar(5) NOT NULL,
  `finance_agreement_key_string` text NOT NULL,
  `finance_agreement_active` varchar(5) NOT NULL DEFAULT '0',
  `finance_agreement_default_activity` varchar(5) NOT NULL,
  `finance_agreement_entry_string` varchar(255) NOT NULL,
  `knowledgebase_active` varchar(5) NOT NULL DEFAULT '0',
  `mail_response_prevent` tinyint(4) NOT NULL DEFAULT '1',
  `mail_throttle_override` tinyint(4) NOT NULL DEFAULT '0',
  `google_map_api_key` text NOT NULL,
  `date_time_zone` varchar(100) NOT NULL DEFAULT 'Europe/Copenhagen',
  `feeds_active` tinyint(4) NOT NULL DEFAULT '1',
  `oat_enable` tinyint(4) NOT NULL,
  `enable_logging` smallint(1) NOT NULL DEFAULT '0' COMMENT '1=enabled logging',
  `enable_debugging` smallint(2) NOT NULL COMMENT '1=enabled',
  PRIMARY KEY (`core_pwd_days_expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `core_data_history`
--

CREATE TABLE IF NOT EXISTS `core_data_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_data` text NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `core_scripts`
--

CREATE TABLE IF NOT EXISTS `core_scripts` (
  `script_id` int(11) NOT NULL AUTO_INCREMENT,
  `script_active` int(1) NOT NULL COMMENT '0=inactive, 1=active',
  `script_last_run` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `script_name` varchar(255) NOT NULL,
  `script_description` varchar(255) NOT NULL,
  PRIMARY KEY (`script_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `country_id` int(99) NOT NULL AUTO_INCREMENT,
  `iso` char(2) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`country_id`),
  KEY `iso_idx` (`iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cpu_types`
--

CREATE TABLE IF NOT EXISTS `cpu_types` (
  `cpu_id` int(99) NOT NULL AUTO_INCREMENT,
  `cpu_model` varchar(255) NOT NULL,
  `cpu_cores` int(4) NOT NULL,
  PRIMARY KEY (`cpu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `crontab_control`
--

CREATE TABLE IF NOT EXISTS `crontab_control` (
  `cron_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `core_script_id` int(11) NOT NULL,
  `cron_time` time NOT NULL,
  `cron_interval` int(11) NOT NULL DEFAULT '1' COMMENT '1=min, 2=hour as',
  `cron_interval_type` varchar(10) NOT NULL COMMENT 'min, hour, day, week, month, year',
  `cron_next_run` datetime NOT NULL,
  `cron_status` int(1) NOT NULL,
  PRIMARY KEY (`cron_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE IF NOT EXISTS `currencies` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_base` varchar(10) NOT NULL,
  `currency_date` date NOT NULL,
  `currency_name` varchar(10) NOT NULL,
  `currency_rate` varchar(10) NOT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_status` int(1) NOT NULL COMMENT '1=inactive',
  `customer_name` varchar(255) NOT NULL,
  `customer_alias` varchar(255) NOT NULL,
  `customer_created_date` datetime NOT NULL,
  `customer_created_by_user_id` bigint(20) NOT NULL,
  `customer_deleted_date` datetime NOT NULL,
  `customer_deleted_by` int(99) NOT NULL,
  `customer_sales_rep` bigint(20) NOT NULL,
  `customer_project_rep` bigint(20) NOT NULL,
  `customer_level` int(9) NOT NULL COMMENT '0:Main - n:customer_id of maincustomer',
  `customer_address1` varchar(255) NOT NULL,
  `customer_address2` varchar(255) NOT NULL,
  `customer_pono` varchar(10) NOT NULL,
  `customer_city` varchar(255) NOT NULL,
  `customer_country_id` int(99) NOT NULL,
  `customer_x_coord` varchar(20) NOT NULL,
  `customer_y_coord` varchar(20) NOT NULL,
  `customer_primary_phone` varchar(20) NOT NULL,
  `customer_contract_start_date` date NOT NULL,
  `customer_contract_end_date` date NOT NULL,
  `customer_comment` text NOT NULL,
  `export_data` tinyint(1) NOT NULL,
  `customer_type` tinyint(4) NOT NULL,
  `customer_finance_note` varchar(255) NOT NULL,
  `customer_urgency` text NOT NULL,
  `customer_impact` text NOT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `customer_name_idx` (`customer_name`),
  KEY `customer_level_idx` (`customer_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_agreement_rel`
--

CREATE TABLE IF NOT EXISTS `customer_agreement_rel` (
  `customer_id` bigint(20) NOT NULL,
  `agreement_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_application_rel`
--

CREATE TABLE IF NOT EXISTS `customer_application_rel` (
  `customer_id` bigint(20) NOT NULL,
  `app_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_backup_rel`
--

CREATE TABLE IF NOT EXISTS `customer_backup_rel` (
  `customer_id` bigint(20) NOT NULL,
  `backup_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_contact_rel`
--

CREATE TABLE IF NOT EXISTS `customer_contact_rel` (
  `customer_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_domain_rel`
--

CREATE TABLE IF NOT EXISTS `customer_domain_rel` (
  `customer_id` bigint(20) NOT NULL,
  `domain_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_fields`
--

CREATE TABLE IF NOT EXISTS `customer_fields` (
  `customer_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_field_name` varchar(255) NOT NULL,
  `customer_field_description` text NOT NULL,
  `customer_field_display_on_list` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer_fields_rel`
--

CREATE TABLE IF NOT EXISTS `customer_fields_rel` (
  `customer_id` bigint(20) NOT NULL,
  `customer_field_id` bigint(20) NOT NULL,
  `selected_option_id` varchar(20) NOT NULL COMMENT 'from cf_time_id',
  KEY `customer_field_idx` (`customer_id`,`customer_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer_history`
--

CREATE TABLE IF NOT EXISTS `customer_history` (
  `history_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `datetime` datetime NOT NULL,
  `user_id` int(2) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `task` varchar(255) NOT NULL,
  `form_data` text NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_ip_segment_rel`
--

CREATE TABLE IF NOT EXISTS `customer_ip_segment_rel` (
  `ip_id` bigint(20) NOT NULL,
  `ip_customer_id` bigint(20) NOT NULL,
  `ip_owner` int(1) NOT NULL,
  PRIMARY KEY (`ip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_license_rel`
--

CREATE TABLE IF NOT EXISTS `customer_license_rel` (
  `customer_id` bigint(20) NOT NULL,
  `license_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_location_rel`
--

CREATE TABLE IF NOT EXISTS `customer_location_rel` (
  `customer_id` bigint(20) NOT NULL,
  `location_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_password_rel`
--

CREATE TABLE IF NOT EXISTS `customer_password_rel` (
  `customer_id` bigint(20) NOT NULL,
  `password_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_project_rel`
--

CREATE TABLE IF NOT EXISTS `customer_project_rel` (
  `customer_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer_security_rel`
--

CREATE TABLE IF NOT EXISTS `customer_security_rel` (
  `customer_id` bigint(20) NOT NULL,
  `security_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `defaults_asset`
--

CREATE TABLE IF NOT EXISTS `defaults_asset` (
  `default_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_status` int(1) NOT NULL,
  `asset_primary_group` int(11) NOT NULL,
  `asset_primary_techie` int(99) NOT NULL,
  `asset_secondary_techie` int(99) NOT NULL,
  `type_id` int(99) NOT NULL,
  `position_id` bigint(20) NOT NULL,
  `position_u` tinyint(5) NOT NULL,
  `asset_producer` varchar(255) NOT NULL,
  `asset_unitshigh` varchar(3) NOT NULL,
  `asset_snmp_community` varchar(100) NOT NULL,
  `asset_warranty_period` tinyint(1) NOT NULL,
  `asset_owner_status` varchar(255) NOT NULL,
  `asset_supplier` varchar(255) NOT NULL,
  `asset_condition` tinyint(1) NOT NULL,
  `asset_supposed_kw` varchar(10) NOT NULL,
  `asset_consumed_kw` varchar(10) NOT NULL,
  `asset_chill_kw` varchar(10) NOT NULL,
  `asset_height` varchar(10) NOT NULL,
  `asset_length` varchar(10) NOT NULL,
  `asset_depth` varchar(10) NOT NULL,
  `asset_weight` varchar(10) NOT NULL,
  `asset_comment` text NOT NULL,
  `asset_model` varchar(255) NOT NULL,
  `asset_type_no` varchar(255) NOT NULL,
  `asset_spareparts` text NOT NULL,
  `os_type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`default_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `delete_sla_types`
--

CREATE TABLE IF NOT EXISTS `delete_sla_types` (
  `sla_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `sla_type_name` varchar(255) NOT NULL,
  `sla_type_desc` varchar(255) NOT NULL,
  `sla_type_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=active',
  `sla_type_ticket_category` tinyint(4) NOT NULL DEFAULT '0',
  `sla_type_priority` tinyint(4) NOT NULL DEFAULT '3' COMMENT '3=routine, 2=urgent, 1=emergency',
  `sla_type_connector` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1=Customer, 2=Asset, 3=circuit',
  PRIMARY KEY (`sla_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `delete_sla_type_trigger_rel`
--

CREATE TABLE IF NOT EXISTS `delete_sla_type_trigger_rel` (
  `sla_type_id` int(99) NOT NULL,
  `sla_trigger_id` int(99) NOT NULL,
  `sla_trigger_value` int(11) NOT NULL,
  `sla_trigger_entity` tinyint(4) NOT NULL COMMENT 'min, hour, percent'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `disc_storage`
--

CREATE TABLE IF NOT EXISTS `disc_storage` (
  `disc_storage_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) NOT NULL,
  `disc_storage_volumename` varchar(255) NOT NULL,
  `disc_storage_type` varchar(50) NOT NULL,
  `disc_storage_size` varchar(50) NOT NULL,
  `disc_storage_manufacturer` varchar(255) NOT NULL,
  `disc_storage_raid` tinyint(2) NOT NULL,
  `disc_storage_model` varchar(100) NOT NULL,
  `disk_prefix` tinyint(4) NOT NULL,
  PRIMARY KEY (`disc_storage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `disc_storage_ext`
--

CREATE TABLE IF NOT EXISTS `disc_storage_ext` (
  `disc_storage_ext_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) NOT NULL,
  `disc_storage_ext_system` bigint(20) NOT NULL,
  `disc_storage_ext_group` bigint(20) NOT NULL,
  `disc_storage_ext_lunsize` varchar(10) NOT NULL COMMENT 'GigaByte',
  `disc_storage_ext_lunname` varchar(100) NOT NULL,
  `disc_storage_ext_lunid` varchar(100) NOT NULL,
  `disc_storage_ext_path` varchar(100) NOT NULL,
  `disk_prefix` tinyint(4) NOT NULL,
  PRIMARY KEY (`disc_storage_ext_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE IF NOT EXISTS `domains` (
  `domain_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(255) NOT NULL,
  `domain_sufix` char(5) NOT NULL,
  `domain_ip_assigned` varchar(20) NOT NULL,
  `domain_auth_server` varchar(100) NOT NULL,
  `domain_external_link` varchar(255) NOT NULL,
  `domain_responsible_user` int(99) NOT NULL,
  `domain_expire_date` date NOT NULL,
  `asset_id` bigint(20) NOT NULL COMMENT 'should be an asset_type cluster',
  PRIMARY KEY (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Element_History`
--

CREATE TABLE IF NOT EXISTS `Element_History` (
  `change_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `change_element` varchar(255) NOT NULL,
  `change_element_id` bigint(20) NOT NULL,
  `change_datetime` datetime NOT NULL,
  `change_user_id` bigint(20) NOT NULL,
  `change_user_name` varchar(255) NOT NULL,
  `change_description` varchar(255) NOT NULL,
  `change_data` text NOT NULL,
  PRIMARY KEY (`change_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE IF NOT EXISTS `emails` (
  `email_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_address` text NOT NULL,
  PRIMARY KEY (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `enclosures`
--

CREATE TABLE IF NOT EXISTS `enclosures` (
  `enclosure_id` int(99) NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) NOT NULL,
  `enclosure_name` varchar(255) NOT NULL,
  `enclosure_manufactor` varchar(255) NOT NULL,
  `enclosure_slots` int(99) NOT NULL DEFAULT '8',
  `enclosure_rows` tinyint(1) NOT NULL DEFAULT '2',
  `enclosure_numbering_direction` tinyint(1) NOT NULL,
  `enclosure_back_rows` tinyint(1) NOT NULL,
  `enclosure_back_slots` tinyint(1) NOT NULL,
  PRIMARY KEY (`enclosure_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `enclosure_templates`
--

CREATE TABLE IF NOT EXISTS `enclosure_templates` (
  `enclosure_template_id` int(99) NOT NULL AUTO_INCREMENT,
  `enclosure_template_name` varchar(255) NOT NULL,
  `enclosure_template_manufactor` varchar(255) NOT NULL,
  `enclosure_template_slots` int(99) NOT NULL DEFAULT '8',
  `enclosure_template_rows` tinyint(1) NOT NULL DEFAULT '2',
  `enclosure_template_units` int(3) NOT NULL,
  `enclosure_numbering_direction` tinyint(1) NOT NULL,
  `enclosure_template_back_rows` tinyint(1) NOT NULL,
  `enclosure_template_back_slots` tinyint(1) NOT NULL,
  PRIMARY KEY (`enclosure_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `enclosure_template_rel`
--

CREATE TABLE IF NOT EXISTS `enclosure_template_rel` (
  `enclosure_template_id` int(99) NOT NULL,
  `enclosure_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `environments`
--

CREATE TABLE IF NOT EXISTS `environments` (
  `environment_id` int(11) NOT NULL AUTO_INCREMENT,
  `environment_name` varchar(255) NOT NULL,
  `environment_description` text NOT NULL,
  PRIMARY KEY (`environment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `environment_roles_rel`
--

CREATE TABLE IF NOT EXISTS `environment_roles_rel` (
  `environment_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `error_log`
--

CREATE TABLE IF NOT EXISTS `error_log` (
  `error_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `error_archived` int(1) NOT NULL,
  `error_hits` bigint(20) NOT NULL,
  `error_text` text NOT NULL,
  `error_firstentry` datetime NOT NULL,
  `error_lastentry` datetime NOT NULL,
  `error_sql` text NOT NULL,
  `error_mysql_data` text NOT NULL,
  `error_user` bigint(20) NOT NULL,
  `error_file` varchar(255) NOT NULL,
  PRIMARY KEY (`error_id`),
  KEY `error_log_idx` (`error_id`,`error_archived`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `escalated_maintenance`
--

CREATE TABLE IF NOT EXISTS `escalated_maintenance` (
  `esc_id` int(11) NOT NULL AUTO_INCREMENT,
  `escalation_id` int(11) NOT NULL,
  `mm_id` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `esc_acked` tinyint(4) NOT NULL,
  `esc_ack_datetime` datetime NOT NULL,
  `esc_acked_by` bigint(20) NOT NULL,
  PRIMARY KEY (`esc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `escalated_tickets`
--

CREATE TABLE IF NOT EXISTS `escalated_tickets` (
  `esc_id` int(11) NOT NULL AUTO_INCREMENT,
  `escalation_id` int(11) NOT NULL,
  `ticket_id` bigint(20) NOT NULL,
  `date_time` datetime NOT NULL,
  `esc_acked` tinyint(4) NOT NULL,
  `esc_ack_datetime` datetime NOT NULL,
  `esc_acked_by` bigint(20) NOT NULL,
  `escalation_reason` text NOT NULL,
  PRIMARY KEY (`esc_id`),
  UNIQUE KEY `esc_id` (`esc_id`,`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `escalation_settings`
--

CREATE TABLE IF NOT EXISTS `escalation_settings` (
  `esc_id` int(11) NOT NULL AUTO_INCREMENT,
  `esc_name` varchar(255) NOT NULL,
  `esc_description` text NOT NULL,
  `esc_limit_time` int(11) NOT NULL,
  `esc_limit_definition` int(11) NOT NULL COMMENT '0=seconds, 1=min, 2=hour, 3=day',
  `esc_limit_start_point` int(11) NOT NULL,
  `esc_limit_type` int(11) NOT NULL,
  `esc_impact` tinyint(4) NOT NULL,
  `esc_its_category` tinyint(4) NOT NULL,
  `esc_its_priority` tinyint(4) NOT NULL,
  `esc_its_risk` tinyint(4) NOT NULL,
  `esc_its_impact` tinyint(4) NOT NULL,
  `esc_leader` tinyint(4) NOT NULL,
  `esc_recipient` varchar(255) NOT NULL,
  `esc_sms_recipient` varchar(255) NOT NULL,
  `esc_no_sms_start_hour` time NOT NULL,
  `esc_no_sms_stop_hour` time NOT NULL,
  PRIMARY KEY (`esc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_types`
--

CREATE TABLE IF NOT EXISTS `event_types` (
  `event_type_id` int(1) NOT NULL AUTO_INCREMENT,
  `event_type_name` varchar(255) NOT NULL,
  `event_type_description` text NOT NULL,
  `event_type_icon_link` varchar(255) NOT NULL,
  `event_type_icon_color` varchar(10) NOT NULL,
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `extractions`
--

CREATE TABLE IF NOT EXISTS `extractions` (
  `e_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `e_filename` varchar(255) NOT NULL,
  `e_filedescription` varchar(255) NOT NULL,
  `e_userid` bigint(20) NOT NULL,
  `e_username` varchar(255) NOT NULL,
  `e_created_date` datetime NOT NULL,
  `e_sql` text NOT NULL,
  PRIMARY KEY (`e_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `extraction_templates`
--

CREATE TABLE IF NOT EXISTS `extraction_templates` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(255) NOT NULL,
  `template_array` text NOT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `file_data`
--

CREATE TABLE IF NOT EXISTS `file_data` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `file_agreement_id` bigint(20) NOT NULL,
  `file_customer_id` bigint(20) NOT NULL,
  `file_license_id` bigint(20) NOT NULL,
  `file_asset_id` bigint(20) NOT NULL,
  `file_ticket_id` bigint(20) NOT NULL,
  `file_ticket_registration_id` bigint(20) NOT NULL,
  `file_sla_id` bigint(20) NOT NULL,
  `file_description` varchar(255) NOT NULL,
  `file_size` varchar(20) NOT NULL,
  `upload_date` datetime NOT NULL,
  `upload_by_u_id` varchar(255) NOT NULL COMMENT 'Uploaded by (Id or emailaddress)',
  `file_search_data` text NOT NULL,
  `file_master` tinyint(99) NOT NULL,
  `file_version` tinyint(99) NOT NULL,
  `file_circuit_id` bigint(20) NOT NULL,
  `file_upt_user_id` bigint(20) NOT NULL,
  `file_supplier_id` bigint(20) NOT NULL,
  `file_md5` text NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `group_rights_rel`
--

CREATE TABLE IF NOT EXISTS `group_rights_rel` (
  `user_group_id` int(99) NOT NULL,
  `right_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hba_interfaces`
--

CREATE TABLE IF NOT EXISTS `hba_interfaces` (
  `hba_id` int(99) NOT NULL AUTO_INCREMENT,
  `hba_dual` tinyint(1) NOT NULL,
  `hba_model` varchar(255) NOT NULL,
  `hba_brand` varchar(255) NOT NULL,
  `hba_firmware` varchar(255) NOT NULL,
  `hba_wwpn1` varchar(255) NOT NULL,
  `hba_wwpn2` varchar(255) NOT NULL,
  `hba_comment` varchar(255) NOT NULL,
  PRIMARY KEY (`hba_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hba_to_asset`
--

CREATE TABLE IF NOT EXISTS `hba_to_asset` (
  `a2a_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a2a_asset_id_from` bigint(20) NOT NULL,
  `a2a_asset_id_from_interface` bigint(20) NOT NULL,
  `a2a_asset_id_to` bigint(20) NOT NULL,
  PRIMARY KEY (`a2a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `icann_list`
--

CREATE TABLE IF NOT EXISTS `icann_list` (
  `icann_id` int(99) NOT NULL AUTO_INCREMENT,
  `icann_short` varchar(10) NOT NULL,
  `icann_description` varchar(100) NOT NULL,
  PRIMARY KEY (`icann_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `impact_types`
--

CREATE TABLE IF NOT EXISTS `impact_types` (
  `impact_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `impact_type_name` varchar(100) NOT NULL,
  `impact_type_description` text NOT NULL,
  PRIMARY KEY (`impact_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `install_data`
--

CREATE TABLE IF NOT EXISTS `install_data` (
  `install_date` datetime NOT NULL,
  `install_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `interfaces`
--

CREATE TABLE IF NOT EXISTS `interfaces` (
  `interface_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `interface_order` tinyint(1) NOT NULL DEFAULT '1',
  `interface_type` int(99) NOT NULL,
  `interface_snmp_version` varchar(3) NOT NULL COMMENT 'v1,v2c or v3',
  `interface_name` varchar(255) NOT NULL,
  `interface_ip_address` varchar(40) NOT NULL,
  `interface_ip_cidr` varchar(3) NOT NULL,
  `interface_switchlayer` int(11) NOT NULL,
  `interface_vlan` bigint(20) NOT NULL,
  `interface_speed` int(9) NOT NULL,
  `interface_def` int(9) NOT NULL COMMENT 'KB, GB or TB',
  `interface_duplex` int(1) NOT NULL,
  `interface_comment` varchar(255) NOT NULL,
  `interface_ip_subnetmask` varchar(15) NOT NULL,
  `interface_fqdn` varchar(255) NOT NULL,
  `interface_ip_gateway` varchar(15) NOT NULL,
  PRIMARY KEY (`interface_id`),
  KEY `interface_ip_address_idx` (`interface_ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `interface_to_asset`
--

CREATE TABLE IF NOT EXISTS `interface_to_asset` (
  `a2a_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a2a_asset_id_from` bigint(20) NOT NULL,
  `a2a_asset_id_from_interface` bigint(20) NOT NULL,
  `a2a_asset_id_to` bigint(20) NOT NULL,
  `a2a_asset_id_to_port` varchar(50) NOT NULL,
  PRIMARY KEY (`a2a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ip_segments`
--

CREATE TABLE IF NOT EXISTS `ip_segments` (
  `ip_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Should be named IPSegment ID',
  `ip_level` bigint(20) NOT NULL,
  `ip_customer_id` bigint(20) NOT NULL,
  `ip_segment` varchar(40) NOT NULL,
  `ip_cidr` varchar(3) NOT NULL,
  `ip_dedicated` int(1) NOT NULL COMMENT 'CustomerSpecificSegment 0=no, 1=yes',
  `ip_routed_to_asset` bigint(20) NOT NULL COMMENT 'AssetID net is routed to',
  `ip_description` varchar(255) NOT NULL,
  `vlanid` bigint(20) NOT NULL,
  `ip_asnumber` varchar(10) NOT NULL,
  `ip_comment` varchar(255) NOT NULL,
  `ip_scanable` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=no, 1=yes',
  PRIMARY KEY (`ip_id`),
  KEY `ip_segment_idx` (`ip_segment`,`ip_cidr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `item_types`
--

CREATE TABLE IF NOT EXISTS `item_types` (
  `item_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `item_type_name` varchar(255) NOT NULL,
  `item_type_description` varchar(255) NOT NULL,
  PRIMARY KEY (`item_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `its_summary`
--

CREATE TABLE IF NOT EXISTS `its_summary` (
  `sum_id` int(11) NOT NULL AUTO_INCREMENT,
  `sum_type` tinyint(1) NOT NULL COMMENT '0fast_m,1fast_w,2fast_d,3long_m,4long_w,5long_d',
  `sum_user_id` bigint(20) NOT NULL,
  `sum_ticket_id` bigint(20) NOT NULL,
  `sum_ticket_created_date` datetime NOT NULL,
  `sum_followup_date_time` datetime NOT NULL,
  `sum_difference` blob NOT NULL,
  PRIMARY KEY (`sum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_entries`
--

CREATE TABLE IF NOT EXISTS `knowledge_entries` (
  `ke_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ke_datetime` datetime NOT NULL,
  `ke_creator` bigint(20) NOT NULL,
  `ke_description` text NOT NULL,
  `kb_issue` text NOT NULL,
  `kb_environment` text NOT NULL,
  `kb_resolution` text NOT NULL,
  `kb_cause` text NOT NULL,
  `ke_solution` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0=No 1=Yes',
  `ke_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=open, 1=normal, 2=rootcause',
  `kb_counter` int(11) NOT NULL COMMENT 'Number of positive hits',
  PRIMARY KEY (`ke_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_ticket_rel`
--

CREATE TABLE IF NOT EXISTS `knowledge_ticket_rel` (
  `ke_id` bigint(20) NOT NULL,
  `ticket_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `licenses`
--

CREATE TABLE IF NOT EXISTS `licenses` (
  `license_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `license_key` varchar(255) NOT NULL,
  `license_status` int(9) NOT NULL COMMENT '0-active; 9-Deactivated',
  `license_desc` varchar(255) NOT NULL,
  `license_number` int(99) NOT NULL,
  `license_start_date` date NOT NULL,
  `license_end_date` date NOT NULL,
  `license_responsible_user` int(99) NOT NULL,
  `license_puchase_date` date NOT NULL,
  `license_type` int(11) NOT NULL,
  `license_poe_user` bigint(20) NOT NULL,
  `license_lifespan` int(11) NOT NULL,
  PRIMARY KEY (`license_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `license_application_rel`
--

CREATE TABLE IF NOT EXISTS `license_application_rel` (
  `license_id` bigint(20) NOT NULL,
  `app_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `license_supplier_rel`
--

CREATE TABLE IF NOT EXISTS `license_supplier_rel` (
  `supplier_id` int(99) NOT NULL,
  `license_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `location_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `location_type_id` int(11) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  `location_desc` varchar(255) NOT NULL,
  `location_address1` varchar(255) NOT NULL,
  `location_address2` varchar(255) NOT NULL,
  `location_pono` varchar(10) NOT NULL,
  `location_city` varchar(255) NOT NULL,
  `country_id` int(3) NOT NULL COMMENT 'refers to countries.country_id',
  `location_max_power` varchar(10) NOT NULL,
  `location_max_chill` varchar(10) NOT NULL,
  `location_max_rack_space` varchar(10) NOT NULL,
  `location_max_floor_space` varchar(10) NOT NULL,
  `location_rows` int(99) NOT NULL,
  `location_cols` int(99) NOT NULL,
  `location_usable_power` varchar(10) NOT NULL,
  `location_usable_chill` varchar(10) NOT NULL,
  `location_usable_rack_space` varchar(10) NOT NULL,
  `location_usable_floor_space` varchar(10) NOT NULL,
  `location_left_power` varchar(10) NOT NULL,
  `location_left_chill` varchar(10) NOT NULL,
  `location_left_rack_space` varchar(10) NOT NULL,
  `location_left_floor_space` varchar(10) NOT NULL,
  `location_maps_x` varchar(10) NOT NULL,
  `location_maps_y` varchar(10) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `location_types`
--

CREATE TABLE IF NOT EXISTS `location_types` (
  `location_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_type_name` varchar(255) NOT NULL,
  `location_type_description` text NOT NULL,
  PRIMARY KEY (`location_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_enabled`
--

CREATE TABLE IF NOT EXISTS `logs_enabled` (
  `logs_id` int(11) NOT NULL DEFAULT '1',
  `logs_enabled` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Used in CoreConfigurations';

-- --------------------------------------------------------

--
-- Table structure for table `mail_attachments`
--

CREATE TABLE IF NOT EXISTS `mail_attachments` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mail_data_id` bigint(20) NOT NULL,
  `mail_data_type` varchar(255) NOT NULL,
  `file_name` text NOT NULL,
  `file_md5` text NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mail_black_list`
--

CREATE TABLE IF NOT EXISTS `mail_black_list` (
  `blacklist_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blacklist_mail` varchar(255) NOT NULL,
  `blacklist_u_id` bigint(20) NOT NULL,
  `blacklist_datetime` datetime NOT NULL,
  `blacklist_hits` bigint(20) NOT NULL,
  `blacklist_last_datetime` datetime NOT NULL,
  PRIMARY KEY (`blacklist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mail_data`
--

CREATE TABLE IF NOT EXISTS `mail_data` (
  `mail_data_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mail_data_received_datetime` datetime NOT NULL,
  `mail_data_from` varchar(255) NOT NULL,
  `mail_data_to` varchar(255) NOT NULL,
  `mail_data_subject` varchar(255) NOT NULL,
  `mail_data_body` text NOT NULL,
  `mail_data_header` mediumblob NOT NULL,
  `mail_data_raw` text NOT NULL,
  `mail_data_encoding` tinyint(4) NOT NULL,
  PRIMARY KEY (`mail_data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mail_rules`
--

CREATE TABLE IF NOT EXISTS `mail_rules` (
  `rule_id` int(9) NOT NULL AUTO_INCREMENT,
  `rule_name` varchar(255) NOT NULL,
  `rule_desc` text NOT NULL,
  `rule_created_by_user_id` bigint(20) NOT NULL,
  `rule_created_date_time` datetime NOT NULL,
  `rule_action` tinyint(1) NOT NULL COMMENT 'What to do when triggered',
  `mail_action_to_data` varchar(255) NOT NULL,
  `mail_action_to_customer` varchar(255) NOT NULL,
  `mail_from` tinyint(1) NOT NULL,
  `mail_from_customer` bigint(20) NOT NULL,
  `mail_from_domain` varchar(255) NOT NULL,
  `mail_from_data` varchar(255) NOT NULL,
  `mail_to` tinyint(1) NOT NULL,
  `mail_to_customer` bigint(20) NOT NULL,
  `mail_to_data` varchar(255) NOT NULL,
  `mail_subject_tags` varchar(255) NOT NULL,
  `mail_body_tags` varchar(255) NOT NULL,
  `mail_responce` text NOT NULL,
  `rule_active` tinyint(1) NOT NULL COMMENT '0=inactive, 1=active',
  `rule_direction` tinyint(4) NOT NULL,
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mail_types`
--

CREATE TABLE IF NOT EXISTS `mail_types` (
  `mail_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `enabled` tinyint(4) NOT NULL,
  `mail_type_name` varchar(255) NOT NULL,
  `mail_type_description` text NOT NULL,
  PRIMARY KEY (`mail_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE IF NOT EXISTS `maintenance` (
  `mm_id` int(99) NOT NULL AUTO_INCREMENT,
  `mm_status` tinyint(4) NOT NULL DEFAULT '0',
  `mm_type_id` int(11) NOT NULL,
  `mm_description` varchar(255) NOT NULL,
  `mm_created_date` datetime NOT NULL,
  `mm_created_by` bigint(20) NOT NULL,
  `mm_period_start` date NOT NULL,
  `mm_period_end` date NOT NULL,
  `mm_period_hour_start` varchar(5) NOT NULL DEFAULT '07:00',
  `mm_period_hour_end` varchar(5) NOT NULL DEFAULT '17:00',
  `mm_period_contact` int(11) NOT NULL,
  `mm_period_user` int(11) NOT NULL,
  `mm_ticket_id` bigint(20) NOT NULL,
  `mm_rfc_ticket_id` bigint(20) NOT NULL,
  `mm_impact` tinyint(4) NOT NULL,
  `mm_task_title` varchar(255) NOT NULL,
  `mm_task_description` text NOT NULL,
  `mm_task_fallback` text NOT NULL,
  `mm_responsible_user` bigint(20) NOT NULL,
  `mm_implementation_user` bigint(20) NOT NULL,
  PRIMARY KEY (`mm_id`),
  KEY `mm_idx` (`mm_period_start`,`mm_period_user`,`mm_implementation_user`,`mm_responsible_user`),
  KEY `mm_mm_type_idx` (`mm_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_recurrence_settings`
--

CREATE TABLE IF NOT EXISTS `maintenance_recurrence_settings` (
  `mm_id` int(11) NOT NULL,
  `mm_reoc_interval` int(3) NOT NULL DEFAULT '0',
  `mm_reoc_interval_type` int(1) NOT NULL DEFAULT '1',
  `mm_reoc_start_date` date NOT NULL,
  `mm_reoc_start_hour` varchar(5) NOT NULL DEFAULT '00:00',
  `mm_reoc_stop_hour` varchar(5) NOT NULL DEFAULT '00:00',
  `mm_reoc_stop_date` date NOT NULL,
  PRIMARY KEY (`mm_id`),
  KEY `mm_reoc_idx` (`mm_reoc_interval`,`mm_reoc_start_date`,`mm_reoc_stop_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_types`
--

CREATE TABLE IF NOT EXISTS `maintenance_types` (
  `mm_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `mm_type_name` varchar(255) NOT NULL,
  `mm_type_desc` varchar(255) NOT NULL,
  `mm_type_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=active',
  `mm_type_recurrence` tinyint(1) NOT NULL COMMENT '0=no,1=yes',
  `mm_type_affected_systems` text NOT NULL COMMENT 'Freetext',
  `mm_type_ignore_alerts` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1=alerts,2=scripts,3=everything',
  `mm_type_warning` tinyint(4) NOT NULL DEFAULT '0',
  `mm_type_ticket_category` tinyint(4) NOT NULL DEFAULT '0',
  `mm_type_priority` tinyint(4) NOT NULL DEFAULT '3' COMMENT '3=routine, 2=urgent, 1=emergency',
  `mm_type_application` int(11) NOT NULL,
  `mm_type_backup` int(11) NOT NULL,
  `mm_type_asset` int(11) NOT NULL,
  `mm_type_asset_status` tinyint(4) NOT NULL,
  `mm_type_license` bigint(20) NOT NULL,
  `mm_type_os_type` int(11) NOT NULL,
  PRIMARY KEY (`mm_type_id`),
  KEY `mm_type_recurrence_idx` (`mm_type_recurrence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mandatory_fields`
--

CREATE TABLE IF NOT EXISTS `mandatory_fields` (
  `mandatory_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(255) NOT NULL,
  `field_page` varchar(100) NOT NULL,
  `mandatory` tinyint(4) NOT NULL,
  PRIMARY KEY (`mandatory_id`),
  KEY `mandatory_idx` (`field_name`,`field_page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mm_affected_assets_rel`
--

CREATE TABLE IF NOT EXISTS `mm_affected_assets_rel` (
  `mm_id` int(99) NOT NULL,
  `asset_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mm_affected_circuits_rel`
--

CREATE TABLE IF NOT EXISTS `mm_affected_circuits_rel` (
  `mm_id` int(99) NOT NULL,
  `circuit_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mm_affected_customers_rel`
--

CREATE TABLE IF NOT EXISTS `mm_affected_customers_rel` (
  `mm_id` int(99) NOT NULL,
  `customer_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mm_affected_locations_rel`
--

CREATE TABLE IF NOT EXISTS `mm_affected_locations_rel` (
  `mm_id` int(99) NOT NULL,
  `location_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mm_informed_customer_contacts_rel`
--

CREATE TABLE IF NOT EXISTS `mm_informed_customer_contacts_rel` (
  `mm_id` int(99) NOT NULL,
  `contact_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mm_informed_groups_rel`
--

CREATE TABLE IF NOT EXISTS `mm_informed_groups_rel` (
  `mm_id` int(99) NOT NULL,
  `group_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mm_informed_personel_rel`
--

CREATE TABLE IF NOT EXISTS `mm_informed_personel_rel` (
  `mm_id` int(99) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mm_revision_checks`
--

CREATE TABLE IF NOT EXISTS `mm_revision_checks` (
  `rev_mm_id` bigint(20) NOT NULL,
  `rev_u_id` bigint(20) NOT NULL,
  `rev_date_time` datetime NOT NULL,
  `rev_asset_id` bigint(20) NOT NULL,
  `rev_circuit_id` bigint(20) NOT NULL,
  `rev_customer_id` bigint(20) NOT NULL,
  `rev_location_id` bigint(20) NOT NULL,
  `rev_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`rev_id`),
  KEY `rev_mm_idx` (`rev_mm_id`,`rev_date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `models`
--

CREATE TABLE IF NOT EXISTS `models` (
  `model_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `model_name` varchar(255) NOT NULL,
  `model_description` text NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_manufactor` varchar(255) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `model_parts_rel`
--

CREATE TABLE IF NOT EXISTS `model_parts_rel` (
  `model_parts_id` bigint(20) UNSIGNED NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `part_id` bigint(20) UNSIGNED NOT NULL,
  `no_items` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ndocs_documents`
--

CREATE TABLE IF NOT EXISTS `ndocs_documents` (
  `document_id` int(99) NOT NULL AUTO_INCREMENT,
  `document_name` varchar(255) NOT NULL,
  `document_description` text NOT NULL,
  `document_folder_id` int(99) NOT NULL,
  `document_created_date` datetime NOT NULL,
  `document_created_by` int(99) NOT NULL,
  `document_org_id` int(99) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ndocs_files`
--

CREATE TABLE IF NOT EXISTS `ndocs_files` (
  `file_id` int(99) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `file_description` text NOT NULL,
  `file_folder_id` int(99) NOT NULL,
  `file_document_id` int(99) NOT NULL,
  `file_size` varchar(255) NOT NULL,
  `file_upload_date` datetime NOT NULL,
  `file_upload_by_id` int(99) NOT NULL,
  `file_org_id` int(99) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ndocs_folders`
--

CREATE TABLE IF NOT EXISTS `ndocs_folders` (
  `folder_id` int(99) NOT NULL AUTO_INCREMENT,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `folder_name` varchar(255) NOT NULL,
  `folder_parent` int(99) NOT NULL,
  PRIMARY KEY (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ndocs_relations`
--

CREATE TABLE IF NOT EXISTS `ndocs_relations` (
  `ndoc_id` bigint(20) NOT NULL,
  `ndoc_file_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `circuit_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nmap_hosts`
--

CREATE TABLE IF NOT EXISTS `nmap_hosts` (
  `host_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `host_scan_datetime` datetime NOT NULL,
  `host_name` varchar(255) NOT NULL,
  `host_ip` varchar(50) NOT NULL,
  `host_mac` varchar(20) NOT NULL,
  `host_os` varchar(100) NOT NULL,
  `host_status` varchar(10) NOT NULL,
  `host_response` text NOT NULL,
  PRIMARY KEY (`host_id`),
  UNIQUE KEY `host_mac` (`host_mac`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `noah_updates`
--

CREATE TABLE IF NOT EXISTS `noah_updates` (
  `feature_id` int(99) NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(255) NOT NULL,
  `feature_shown` tinyint(1) NOT NULL,
  `feature_description` text NOT NULL,
  `feature_version` varchar(10) NOT NULL,
  PRIMARY KEY (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_type_id` tinyint(1) NOT NULL,
  `order_comment` text NOT NULL,
  `order_closed_date` date NOT NULL,
  `order_closed_by` int(1) NOT NULL,
  `order_descided_status` int(11) NOT NULL,
  `order_stage_id` int(11) NOT NULL,
  `order_last_update_user` bigint(20) NOT NULL,
  `order_last_update_datetime` datetime NOT NULL,
  `order_created_by` bigint(20) NOT NULL,
  `order_created_datetime` datetime NOT NULL,
  `order_budget_responsible` bigint(20) NOT NULL,
  `order_descided_by` bigint(20) NOT NULL,
  `order_descided_datetime` datetime NOT NULL,
  `order_total_price` varchar(20) NOT NULL,
  `order_currency` int(11) NOT NULL,
  `order_finance_type` tinyint(4) NOT NULL,
  `order_delivery_address` text NOT NULL,
  `order_delivery_company_name` varchar(255) NOT NULL,
  `order_delivery_id` varchar(255) NOT NULL,
  `order_tracking_link` varchar(255) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_idx` (`order_type_id`,`order_stage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders_delivery_companies`
--

CREATE TABLE IF NOT EXISTS `orders_delivery_companies` (
  `company_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `delivery_company_name` varchar(256) NOT NULL,
  `default_company` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders_rel`
--

CREATE TABLE IF NOT EXISTS `orders_rel` (
  `order_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `ticket_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_asset_rel`
--

CREATE TABLE IF NOT EXISTS `order_asset_rel` (
  `asset_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_backup`
--

CREATE TABLE IF NOT EXISTS `order_backup` (
  `order_backup_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_backup_ip` int(20) UNSIGNED NOT NULL,
  `order_backup_type` int(1) NOT NULL COMMENT 'sql, exchange or file',
  `order_backup_size` varchar(20) NOT NULL,
  `order_backup_fqdn` varchar(255) NOT NULL,
  PRIMARY KEY (`order_backup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_backup_rel`
--

CREATE TABLE IF NOT EXISTS `order_backup_rel` (
  `order_id` bigint(20) NOT NULL,
  `order_backup_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_circuit_rel`
--

CREATE TABLE IF NOT EXISTS `order_circuit_rel` (
  `order_id` bigint(20) NOT NULL,
  `circuit_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_customer_rel`
--

CREATE TABLE IF NOT EXISTS `order_customer_rel` (
  `order_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_history`
--

CREATE TABLE IF NOT EXISTS `order_history` (
  `change_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `change_element` varchar(255) NOT NULL,
  `change_element_id` bigint(20) NOT NULL,
  `change_datetime` datetime NOT NULL,
  `change_user_id` bigint(20) NOT NULL,
  `change_user_name` varchar(255) NOT NULL,
  `change_description` varchar(255) NOT NULL,
  `change_data` text NOT NULL,
  PRIMARY KEY (`change_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_lines`
--

CREATE TABLE IF NOT EXISTS `order_lines` (
  `line_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `line_status` int(11) NOT NULL,
  `line_no_items` varchar(10) NOT NULL,
  `line_item_name` varchar(100) NOT NULL,
  `line_item_description` varchar(255) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `line_expected_delivery_date` date NOT NULL,
  `line_purchasing_user_id` bigint(20) NOT NULL,
  `line_receiving_user_id` bigint(20) NOT NULL,
  `line_invoice_number` varchar(40) NOT NULL,
  `line_expected_price` varchar(20) NOT NULL,
  PRIMARY KEY (`line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_lines_purchased`
--

CREATE TABLE IF NOT EXISTS `order_lines_purchased` (
  `olp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `olp_line_id` bigint(20) NOT NULL,
  `olp_order_id` bigint(20) NOT NULL,
  `olp_no_purchased_items` int(11) NOT NULL,
  `olp_purchased_datetime` datetime NOT NULL,
  `olp_line_purchased_by` bigint(20) NOT NULL,
  `olp_line_comment` text NOT NULL,
  PRIMARY KEY (`olp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_lines_received`
--

CREATE TABLE IF NOT EXISTS `order_lines_received` (
  `olr_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `olr_line_id` bigint(20) NOT NULL,
  `olr_order_id` bigint(20) NOT NULL,
  `olr_no_received_items` int(11) NOT NULL,
  `olr_received_datetime` datetime NOT NULL,
  `olr_line_received_by` bigint(20) NOT NULL,
  `olr_line_comment` text NOT NULL,
  `olr_invoice` varchar(255) NOT NULL,
  PRIMARY KEY (`olr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_lines_rel`
--

CREATE TABLE IF NOT EXISTS `order_lines_rel` (
  `line_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_project_rel`
--

CREATE TABLE IF NOT EXISTS `order_project_rel` (
  `order_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_server`
--

CREATE TABLE IF NOT EXISTS `order_server` (
  `order_server_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_server_ip` int(20) UNSIGNED NOT NULL,
  `order_server_ram` varchar(9) NOT NULL,
  `order_server_localdisk` varchar(9) NOT NULL,
  `order_server_storage_adapter` tinyint(1) NOT NULL,
  `order_server_cpu` tinyint(1) NOT NULL,
  PRIMARY KEY (`order_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_server_rel`
--

CREATE TABLE IF NOT EXISTS `order_server_rel` (
  `order_id` bigint(20) NOT NULL,
  `order_server_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_stages`
--

CREATE TABLE IF NOT EXISTS `order_stages` (
  `stage_id` int(11) NOT NULL AUTO_INCREMENT,
  `stage_name` varchar(255) NOT NULL,
  `stage_description` text NOT NULL,
  PRIMARY KEY (`stage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_storage`
--

CREATE TABLE IF NOT EXISTS `order_storage` (
  `order_storage_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_storage_placement` int(1) NOT NULL COMMENT 'archive or best performance',
  `order_storage_type` int(1) NOT NULL COMMENT 'sql, exchange or file',
  `order_storage_size` varchar(20) NOT NULL,
  PRIMARY KEY (`order_storage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_storage_rel`
--

CREATE TABLE IF NOT EXISTS `order_storage_rel` (
  `order_id` bigint(20) NOT NULL,
  `order_storage_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `os_types`
--

CREATE TABLE IF NOT EXISTS `os_types` (
  `os_types_id` int(99) NOT NULL AUTO_INCREMENT,
  `os_types_name` varchar(255) NOT NULL,
  `os_types_version` varchar(255) NOT NULL,
  PRIMARY KEY (`os_types_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `parts`
--

CREATE TABLE IF NOT EXISTS `parts` (
  `part_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `part_type_id` int(11) NOT NULL COMMENT '0=part, 1=sparepart',
  `part_name` varchar(255) NOT NULL,
  `part_description` text NOT NULL,
  `part_number` varchar(255) NOT NULL,
  `location_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `part_cost` varchar(20) NOT NULL,
  `part_in_stock` varchar(20) NOT NULL COMMENT 'Howmuchinstock',
  `part_currency` int(11) NOT NULL,
  `part_currency_string` varchar(255) NOT NULL COMMENT 'Conversion currencynumber',
  PRIMARY KEY (`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `parts_specifics`
--

CREATE TABLE IF NOT EXISTS `parts_specifics` (
  `part_id` bigint(20) NOT NULL,
  `part_serialnumber` varchar(255) NOT NULL,
  `part_model` int(11) NOT NULL,
  `part_condition` int(11) NOT NULL COMMENT '0=new, 1=used, 2=commision'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `part_order_rel`
--

CREATE TABLE IF NOT EXISTS `part_order_rel` (
  `part_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `part_types`
--

CREATE TABLE IF NOT EXISTS `part_types` (
  `part_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `part_type_name` varchar(255) NOT NULL,
  `part_type_description` text NOT NULL,
  PRIMARY KEY (`part_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `passwords`
--

CREATE TABLE IF NOT EXISTS `passwords` (
  `password_id` int(99) NOT NULL AUTO_INCREMENT,
  `password_sec_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'security clearence',
  `password_login` varchar(255) NOT NULL,
  `password_text` text NOT NULL,
  `password_type` int(1) NOT NULL,
  `password_description` text NOT NULL,
  PRIMARY KEY (`password_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `password_types`
--

CREATE TABLE IF NOT EXISTS `password_types` (
  `pwd_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `pwd_type_name` varchar(255) NOT NULL,
  `pwd_type_description` varchar(255) NOT NULL,
  PRIMARY KEY (`pwd_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `portal_rights`
--

CREATE TABLE IF NOT EXISTS `portal_rights` (
  `portal_right_id` int(11) NOT NULL AUTO_INCREMENT,
  `portal_identifier` varchar(255) NOT NULL COMMENT 'What will be matched upon at the Portal',
  `portal_right_name` varchar(255) NOT NULL,
  `portal_right_description` varchar(255) NOT NULL,
  PRIMARY KEY (`portal_right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ports`
--

CREATE TABLE IF NOT EXISTS `ports` (
  `port_id` varchar(20) NOT NULL,
  `port_status` int(1) NOT NULL COMMENT '0-down 1-up',
  `port_description` varchar(255) NOT NULL,
  `port_alias` varchar(255) NOT NULL,
  `port_speed` varchar(10) NOT NULL,
  `port_asset_id` bigint(20) NOT NULL,
  PRIMARY KEY (`port_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

CREATE TABLE IF NOT EXISTS `positions` (
  `position_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `position_name` varchar(255) NOT NULL,
  `position_desc` varchar(255) NOT NULL,
  `position_xy` varchar(4) NOT NULL,
  `position_height` tinyint(9) NOT NULL DEFAULT '0' COMMENT 'Given in Units',
  `position_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Status: 0 = Empty; 1=reserved/used; 2=Blank',
  `location_id` bigint(20) NOT NULL COMMENT 'refers to locaitons.location_id',
  `position_max_weight` varchar(10) NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `position_customer_rel`
--

CREATE TABLE IF NOT EXISTS `position_customer_rel` (
  `position_id` bigint(20) NOT NULL,
  `location_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `customer_position_xy` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_owner` bigint(20) NOT NULL,
  `project_leader` bigint(20) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `project_description` text NOT NULL,
  `project_estimated_duration` varchar(10) NOT NULL,
  `project_estimated_duration_entity` int(1) NOT NULL,
  `project_received_date` date NOT NULL,
  `project_deadline` date NOT NULL,
  `project_creator` bigint(20) NOT NULL,
  `project_created_datetime` datetime NOT NULL,
  `project_opened_by` bigint(20) NOT NULL,
  `project_opened_datetime` datetime NOT NULL,
  `project_closed_by` bigint(20) NOT NULL,
  `project_closed_datetime` datetime NOT NULL,
  `project_lastupdate_datetime` datetime NOT NULL,
  `project_lastupdate_by` bigint(20) NOT NULL,
  `project_status` int(11) NOT NULL,
  `project_finance_note` varchar(255) NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_documents`
--

CREATE TABLE IF NOT EXISTS `project_documents` (
  `project_document_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL,
  `project_document_name` varchar(255) NOT NULL,
  `project_document_filename` varchar(255) NOT NULL,
  `project_document_datetime` datetime NOT NULL,
  PRIMARY KEY (`project_document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_predefined_tasks`
--

CREATE TABLE IF NOT EXISTS `project_predefined_tasks` (
  `pt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pt_type` int(11) NOT NULL,
  `pt_name` varchar(255) NOT NULL,
  `pt_description` text NOT NULL,
  `pt_creator` bigint(20) NOT NULL,
  `pt_created_datetime` datetime NOT NULL,
  `pt_expected_process_time` int(1) NOT NULL,
  `pt_expected_process_entity` tinyint(4) NOT NULL,
  `pt_assigned_user` bigint(20) NOT NULL,
  `pt_assigned_group` int(11) NOT NULL,
  PRIMARY KEY (`pt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_skills_rel`
--

CREATE TABLE IF NOT EXISTS `project_skills_rel` (
  `project_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_level` int(11) NOT NULL,
  `skill_resources` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_stati`
--

CREATE TABLE IF NOT EXISTS `project_stati` (
  `project_stati_id` int(1) NOT NULL AUTO_INCREMENT,
  `project_stati_name` varchar(255) NOT NULL,
  `project_stati_description` text NOT NULL,
  `project_stati_icon_link` varchar(255) NOT NULL,
  `project_stati_icon_color` varchar(10) NOT NULL,
  PRIMARY KEY (`project_stati_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_stati_comments`
--

CREATE TABLE IF NOT EXISTS `project_stati_comments` (
  `stati_comment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL,
  `stati_comment_text` text NOT NULL,
  `stati_comment_user` bigint(20) NOT NULL,
  `stati_comment_datetime` datetime NOT NULL,
  PRIMARY KEY (`stati_comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_tasks`
--

CREATE TABLE IF NOT EXISTS `project_tasks` (
  `pt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pt_id_parent` varchar(20) NOT NULL,
  `pt_parent` bigint(20) NOT NULL,
  `pt_type` int(11) NOT NULL,
  `pt_name` varchar(255) NOT NULL,
  `pt_description` text NOT NULL,
  `pt_priority` tinyint(4) NOT NULL DEFAULT '3',
  `pt_color` varchar(11) NOT NULL,
  `pt_creator` bigint(20) NOT NULL,
  `pt_created_datetime` datetime NOT NULL,
  `pt_start_date` date NOT NULL,
  `pt_end_date` date NOT NULL,
  `pt_expected_process_time` int(1) NOT NULL,
  `pt_expected_process_entity` tinyint(4) NOT NULL,
  `pt_estimated_durance` varchar(10) NOT NULL,
  `pt_assigned_user` bigint(20) NOT NULL,
  `pt_assigned_group` int(11) NOT NULL,
  PRIMARY KEY (`pt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_task_rel`
--

CREATE TABLE IF NOT EXISTS `project_task_rel` (
  `pt_dummy_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL,
  `pt_id` bigint(20) NOT NULL,
  `ticket_id` bigint(20) NOT NULL,
  PRIMARY KEY (`pt_dummy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_templates`
--

CREATE TABLE IF NOT EXISTS `project_templates` (
  `project_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_owner` bigint(20) NOT NULL,
  `project_leader` bigint(20) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `project_description` text NOT NULL,
  `project_estimated_duration` varchar(10) NOT NULL,
  `project_estimated_duration_entity` int(1) NOT NULL,
  `project_creator` bigint(20) NOT NULL,
  `project_created_datetime` datetime NOT NULL,
  `project_lastupdate_datetime` datetime NOT NULL,
  `project_lastupdate_by` bigint(20) NOT NULL,
  `project_status` int(11) NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_template_tasks`
--

CREATE TABLE IF NOT EXISTS `project_template_tasks` (
  `pt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pt_id_parent` varchar(20) NOT NULL,
  `pt_parent` bigint(20) NOT NULL,
  `pt_type` int(11) NOT NULL,
  `pt_name` varchar(255) NOT NULL,
  `pt_description` text NOT NULL,
  `pt_creator` bigint(20) NOT NULL,
  `pt_created_datetime` datetime NOT NULL,
  `pt_start_date` date NOT NULL,
  `pt_end_date` date NOT NULL,
  `pt_expected_process_time` int(1) NOT NULL,
  `pt_expected_process_entity` tinyint(4) NOT NULL,
  `pt_estimated_durance` varchar(10) NOT NULL,
  `pt_assigned_user` bigint(20) NOT NULL,
  `pt_assigned_group` int(11) NOT NULL,
  PRIMARY KEY (`pt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_template_task_rel`
--

CREATE TABLE IF NOT EXISTS `project_template_task_rel` (
  `project_id` bigint(20) NOT NULL,
  `pt_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `response_types`
--

CREATE TABLE IF NOT EXISTS `response_types` (
  `tor_id` int(11) NOT NULL AUTO_INCREMENT,
  `tor_name` varchar(255) NOT NULL,
  `tor_desc` text NOT NULL,
  PRIMARY KEY (`tor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tor means type of response';

-- --------------------------------------------------------

--
-- Table structure for table `rights`
--

CREATE TABLE IF NOT EXISTS `rights` (
  `right_id` int(99) NOT NULL AUTO_INCREMENT,
  `right_name` varchar(255) NOT NULL,
  `right_filename` varchar(255) NOT NULL,
  `right_short` varchar(4) NOT NULL,
  `right_desc` varchar(255) NOT NULL,
  `right_group_id` int(11) NOT NULL,
  PRIMARY KEY (`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rights_group`
--

CREATE TABLE IF NOT EXISTS `rights_group` (
  `right_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `right_group_name` varchar(255) NOT NULL,
  PRIMARY KEY (`right_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rights_template_rel`
--

CREATE TABLE IF NOT EXISTS `rights_template_rel` (
  `template_id` int(99) NOT NULL,
  `right_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `scrum_ticket_stati`
--

CREATE TABLE IF NOT EXISTS `scrum_ticket_stati` (
  `ticket_stati_id` int(11) NOT NULL,
  `scrum_part` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `security_types`
--

CREATE TABLE IF NOT EXISTS `security_types` (
  `security_id` int(11) NOT NULL AUTO_INCREMENT,
  `security_name` varchar(40) NOT NULL,
  `security_description` varchar(255) NOT NULL,
  PRIMARY KEY (`security_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE IF NOT EXISTS `skills` (
  `skill_id` int(11) NOT NULL AUTO_INCREMENT,
  `skill_name` varchar(255) NOT NULL,
  `skill_description` text NOT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sla`
--

CREATE TABLE IF NOT EXISTS `sla` (
  `sla_id` int(99) NOT NULL AUTO_INCREMENT,
  `sla_active` int(11) NOT NULL DEFAULT '0' COMMENT '0=inactive, 1=active',
  `sla_default` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1=Default',
  `sla_ticket_type` int(11) NOT NULL,
  `sla_connector` tinyint(4) NOT NULL,
  `sla_name` varchar(255) NOT NULL,
  `sla_end_date` date NOT NULL,
  `sla_description` varchar(255) NOT NULL,
  `sla_ticket_category` int(11) NOT NULL,
  `sla_ticket_breach_time` int(5) NOT NULL COMMENT 'how long before a ticket is breached',
  `sla_ticket_breach_warning_time` int(11) NOT NULL,
  `sla_time_to_resolve` varchar(5) NOT NULL COMMENT 'minutes',
  `sla_time_to_start_processing` varchar(5) NOT NULL COMMENT 'minutes',
  `sla_created_date` datetime NOT NULL,
  `sla_created_by` bigint(20) NOT NULL,
  `sla_period_start` tinyint(4) NOT NULL,
  `sla_period_end` tinyint(4) NOT NULL,
  `sla_period_hour_start` varchar(5) NOT NULL DEFAULT '07:00',
  `sla_period_hour_end` varchar(5) NOT NULL DEFAULT '17:00',
  `sla_period_contact` int(11) NOT NULL,
  `sla_period_user` int(11) NOT NULL,
  `sla_priority` int(11) NOT NULL,
  PRIMARY KEY (`sla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sla_asset_rel`
--

CREATE TABLE IF NOT EXISTS `sla_asset_rel` (
  `asset_id` bigint(20) NOT NULL,
  `sla_id` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sla_breaches`
--

CREATE TABLE IF NOT EXISTS `sla_breaches` (
  `breach_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `breach_timer_stop` tinyint(1) NOT NULL DEFAULT '0',
  `breach_timer_stop_by` int(11) NOT NULL,
  `breach_timer_stop_date` datetime NOT NULL,
  `breach_end` datetime NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `ticket_id` bigint(20) NOT NULL,
  `sla_id` int(11) NOT NULL,
  `sla_breach_reason` tinyint(4) NOT NULL,
  `breach_warning_stop` tinyint(4) NOT NULL DEFAULT '0',
  `breach_warning_datetime` datetime NOT NULL,
  `breach_warning_user` bigint(20) NOT NULL,
  `breach_warning_contact` bigint(20) NOT NULL,
  PRIMARY KEY (`breach_id`),
  KEY `sla_asset_idx` (`asset_id`,`customer_id`,`ticket_id`,`sla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sla_circuit_rel`
--

CREATE TABLE IF NOT EXISTS `sla_circuit_rel` (
  `circuit_id` bigint(20) NOT NULL,
  `sla_id` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sla_customer_rel`
--

CREATE TABLE IF NOT EXISTS `sla_customer_rel` (
  `customer_id` bigint(20) NOT NULL,
  `sla_id` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sla_responsibleuser_rel`
--

CREATE TABLE IF NOT EXISTS `sla_responsibleuser_rel` (
  `sla_id` int(9) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sla_stop_stati_rel`
--

CREATE TABLE IF NOT EXISTS `sla_stop_stati_rel` (
  `sla_id` int(11) NOT NULL,
  `stati_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `storage_disk_group`
--

CREATE TABLE IF NOT EXISTS `storage_disk_group` (
  `dg_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) NOT NULL,
  `dg_name` varchar(255) NOT NULL,
  `dg_disktype` tinyint(1) NOT NULL COMMENT 'fata,sata etc',
  `dg_diskspeed` tinyint(1) NOT NULL COMMENT '7,10,15K',
  `dg_raidtype` tinyint(1) NOT NULL COMMENT '0-10',
  `dg_size` varchar(10) NOT NULL COMMENT 'Size in Gb',
  `dg_prefix` tinyint(4) NOT NULL,
  PRIMARY KEY (`dg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `storage_io_disk_rel`
--

CREATE TABLE IF NOT EXISTS `storage_io_disk_rel` (
  `io_id` int(11) NOT NULL,
  `dg_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `storage_io_group`
--

CREATE TABLE IF NOT EXISTS `storage_io_group` (
  `io_id` int(11) NOT NULL AUTO_INCREMENT,
  `io_name` varchar(255) NOT NULL,
  `io_connection_type` tinyint(4) NOT NULL,
  PRIMARY KEY (`io_id`),
  KEY `storage_io_idx` (`io_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `supplier_id` int(99) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_addr1` varchar(255) NOT NULL,
  `supplier_addr2` varchar(255) NOT NULL,
  `supplier_zip` varchar(10) NOT NULL,
  `supplier_city` varchar(255) NOT NULL,
  `supplier_phone` varchar(40) NOT NULL,
  `supplier_email` varchar(255) NOT NULL,
  `supplier_www` varchar(255) NOT NULL,
  `supplier_alias` varchar(255) NOT NULL,
  `supplier_comment` text NOT NULL,
  `supplier_created_date` date NOT NULL,
  `supplier_created_by_user_id` bigint(20) NOT NULL,
  `supplier_www_site` varchar(255) NOT NULL,
  `supplier_www_login` varchar(255) NOT NULL,
  `supplier_www_pwd` varchar(255) NOT NULL,
  `supplier_customer_no` varchar(255) NOT NULL,
  `supplier_onduty_phone` varchar(255) NOT NULL,
  `supplier_onduty_hours` varchar(255) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_application_rel`
--

CREATE TABLE IF NOT EXISTS `supplier_application_rel` (
  `supplier_id` bigint(20) NOT NULL,
  `app_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_contact_rel`
--

CREATE TABLE IF NOT EXISTS `supplier_contact_rel` (
  `supplier_id` int(99) NOT NULL,
  `contact_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_export_settings`
--

CREATE TABLE IF NOT EXISTS `supplier_export_settings` (
  `export_data_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL,
  `export_site_uri_ip` varchar(255) NOT NULL,
  `export_site_port` varchar(5) NOT NULL,
  `export_api_token` text NOT NULL,
  `export_data_description` text NOT NULL,
  PRIMARY KEY (`export_data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_items`
--

CREATE TABLE IF NOT EXISTS `supplier_items` (
  `item_id` int(99) NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint(20) NOT NULL,
  `item_sec_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'security clearence',
  `item_field1` varchar(255) NOT NULL,
  `item_field2` varchar(255) NOT NULL,
  `item_type` int(1) NOT NULL,
  `item_field3` varchar(255) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `switchlayers`
--

CREATE TABLE IF NOT EXISTS `switchlayers` (
  `switchlayerid` bigint(20) NOT NULL AUTO_INCREMENT,
  `switchlayer_name` varchar(100) NOT NULL,
  `switchlayer_description` varchar(255) NOT NULL,
  PRIMARY KEY (`switchlayerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `switchlayer_customer_rel`
--

CREATE TABLE IF NOT EXISTS `switchlayer_customer_rel` (
  `switchlayerid` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `switchlayer_vlan_rel`
--

CREATE TABLE IF NOT EXISTS `switchlayer_vlan_rel` (
  `switchlayerid` bigint(20) NOT NULL,
  `vlanid` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `system_license`
--

CREATE TABLE IF NOT EXISTS `system_license` (
  `license_id` int(9) NOT NULL AUTO_INCREMENT,
  `license_key` varchar(255) NOT NULL,
  `license_name` varchar(255) NOT NULL,
  PRIMARY KEY (`license_id`),
  UNIQUE KEY `license_name` (`license_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `tag_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  `tag_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tag_user_id` bigint(20) NOT NULL,
  `tag_description` text NOT NULL,
  `tag_category` tinyint(4) NOT NULL COMMENT 'tagcat_id',
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tag_categories`
--

CREATE TABLE IF NOT EXISTS `tag_categories` (
  `tagcat_id` int(11) NOT NULL AUTO_INCREMENT,
  `tagcat_name` varchar(255) NOT NULL,
  `tagcat_description` text NOT NULL,
  PRIMARY KEY (`tagcat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tag_ticket_rel`
--

CREATE TABLE IF NOT EXISTS `tag_ticket_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

CREATE TABLE IF NOT EXISTS `templates` (
  `template_id` int(99) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(255) NOT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE IF NOT EXISTS `tickets` (
  `ticket_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `public_token` text NOT NULL COMMENT 'ticket_id and key',
  `customer_id` bigint(20) NOT NULL,
  `mail_data_id` bigint(20) NOT NULL COMMENT 'ID from Mail received crontab_imap_ticket.php',
  `ticket_status` int(1) NOT NULL COMMENT '1=open, 2=active, 3=closed,4=spam',
  `maintenance_id` int(99) NOT NULL,
  `ticket_level` bigint(20) NOT NULL DEFAULT '0' COMMENT '0:top level, else incident_id',
  `ticket_title` varchar(255) NOT NULL,
  `ticket_desc` text NOT NULL,
  `ticket_priority` int(1) NOT NULL,
  `ticket_ext_priority` tinyint(1) NOT NULL COMMENT 'customers priority',
  `ticket_internal_comment` text NOT NULL,
  `ticket_external_id` varchar(255) NOT NULL,
  `ticket_created_date` datetime NOT NULL,
  `ticket_created_by_user_id` int(99) NOT NULL,
  `ticket_onbehalfof` bigint(20) NOT NULL,
  `ticket_created_by_contact_id` bigint(20) NOT NULL,
  `ticket_closed_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ticket_closing_user` bigint(20) NOT NULL COMMENT 'Who closed the case',
  `ticket_current_user_id` bigint(20) NOT NULL COMMENT 'Who has the case now!?',
  `ticket_current_group_id` int(99) NOT NULL COMMENT 'Which group has the incident now?',
  `ticket_latest_update_datetime` datetime NOT NULL,
  `ticket_latest_update_by_userid` bigint(20) NOT NULL,
  `ticket_latest_update_followup` text NOT NULL,
  `ticket_notify_creator_on_close` int(1) NOT NULL,
  `ticket_type_id` int(9) NOT NULL,
  `ticket_sub_type_id` int(99) NOT NULL,
  `ticket_category_id` int(99) NOT NULL,
  `ticket_urgency` tinyint(1) NOT NULL DEFAULT '3' COMMENT '3=low, 2=average, 1=high',
  `ticket_impact` tinyint(1) NOT NULL DEFAULT '3' COMMENT '3=low, 2=average, 1=high',
  `ticket_risk` tinyint(4) NOT NULL,
  `ticket_fallback` text NOT NULL,
  `ticket_reason` tinyint(4) NOT NULL COMMENT 'Reason for creating RFC ',
  `ticket_rfc_execution_date` datetime NOT NULL,
  `await_ticket_id` int(11) NOT NULL,
  `wf_task_id` bigint(20) NOT NULL,
  `ticket_responsible_user` bigint(20) NOT NULL,
  `ticket_sender_email` varchar(255) NOT NULL,
  `ticket_deadline` date NOT NULL,
  `ticket_start_date` date NOT NULL,
  `ticket_end_date` date NOT NULL,
  `ticket_finance_note` varchar(255) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `ticket_status` (`ticket_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `tickets`
--
DELIMITER $$
CREATE TRIGGER `before_tickets_create` AFTER INSERT ON `tickets` FOR EACH ROW BEGIN
          INSERT INTO `audit_tickets`
          SET audit_action = 'create', audit_datetime = NOW(),
                ticket_id = ticket_id,public_token = public_token,customer_id = customer_id,mail_data_id = mail_data_id,ticket_status = ticket_status,maintenance_id = maintenance_id,ticket_level = ticket_level,ticket_title = ticket_title,ticket_desc = ticket_desc,ticket_priority = ticket_priority,ticket_ext_priority = ticket_ext_priority,ticket_internal_comment = ticket_internal_comment,ticket_external_id = ticket_external_id,ticket_created_date = ticket_created_date,ticket_created_by_user_id = ticket_created_by_user_id,ticket_created_by_contact_id = ticket_created_by_contact_id,ticket_closed_date = ticket_closed_date,ticket_closing_user = ticket_closing_user,ticket_current_user_id = ticket_current_user_id,ticket_current_group_id = ticket_current_group_id,ticket_latest_update_datetime = ticket_latest_update_datetime,ticket_latest_update_by_userid = ticket_latest_update_by_userid,ticket_notify_creator_on_close = ticket_notify_creator_on_close,ticket_type_id = ticket_type_id,ticket_sub_type_id = ticket_sub_type_id,ticket_category_id = ticket_category_id,ticket_urgency = ticket_urgency,ticket_impact = ticket_impact,ticket_risk = ticket_risk,ticket_fallback = ticket_fallback,ticket_reason = ticket_reason,ticket_rfc_execution_date = ticket_rfc_execution_date,await_ticket_id = await_ticket_id,wf_task_id = wf_task_id,ticket_responsible_user = ticket_responsible_user,ticket_sender_email = ticket_sender_email,ticket_deadline = ticket_deadline,ticket_finance_note = ticket_finance_note;
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_tickets_delete` BEFORE DELETE ON `tickets` FOR EACH ROW BEGIN
          INSERT INTO `audit_tickets`
          SET audit_action = 'delete', audit_datetime = NOW(),
                ticket_id = OLD.ticket_id,public_token = OLD.public_token,customer_id = OLD.customer_id,mail_data_id = OLD.mail_data_id,ticket_status = OLD.ticket_status,maintenance_id = OLD.maintenance_id,ticket_level = OLD.ticket_level,ticket_title = OLD.ticket_title,ticket_desc = OLD.ticket_desc,ticket_priority = OLD.ticket_priority,ticket_ext_priority = OLD.ticket_ext_priority,ticket_internal_comment = OLD.ticket_internal_comment,ticket_external_id = OLD.ticket_external_id,ticket_created_date = OLD.ticket_created_date,ticket_created_by_user_id = OLD.ticket_created_by_user_id,ticket_created_by_contact_id = OLD.ticket_created_by_contact_id,ticket_closed_date = OLD.ticket_closed_date,ticket_closing_user = OLD.ticket_closing_user,ticket_current_user_id = OLD.ticket_current_user_id,ticket_current_group_id = OLD.ticket_current_group_id,ticket_latest_update_datetime = OLD.ticket_latest_update_datetime,ticket_latest_update_by_userid = OLD.ticket_latest_update_by_userid,ticket_notify_creator_on_close = OLD.ticket_notify_creator_on_close,ticket_type_id = OLD.ticket_type_id,ticket_sub_type_id = OLD.ticket_sub_type_id,ticket_category_id = OLD.ticket_category_id,ticket_urgency = OLD.ticket_urgency,ticket_impact = OLD.ticket_impact,ticket_risk = OLD.ticket_risk,ticket_fallback = OLD.ticket_fallback,ticket_reason = OLD.ticket_reason,ticket_rfc_execution_date = OLD.ticket_rfc_execution_date,await_ticket_id = OLD.await_ticket_id,wf_task_id = OLD.wf_task_id,ticket_responsible_user = OLD.ticket_responsible_user,ticket_sender_email = OLD.ticket_sender_email,ticket_deadline = OLD.ticket_deadline,ticket_finance_note = OLD.ticket_finance_note;
        END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_tickets_update` BEFORE UPDATE ON `tickets` FOR EACH ROW BEGIN
          INSERT INTO `audit_tickets`
          SET audit_action = 'update', audit_datetime = NOW(),
                ticket_id = OLD.ticket_id,public_token = OLD.public_token,customer_id = OLD.customer_id,mail_data_id = OLD.mail_data_id,ticket_status = OLD.ticket_status,maintenance_id = OLD.maintenance_id,ticket_level = OLD.ticket_level,ticket_title = OLD.ticket_title,ticket_desc = OLD.ticket_desc,ticket_priority = OLD.ticket_priority,ticket_ext_priority = OLD.ticket_ext_priority,ticket_internal_comment = OLD.ticket_internal_comment,ticket_external_id = OLD.ticket_external_id,ticket_created_date = OLD.ticket_created_date,ticket_created_by_user_id = OLD.ticket_created_by_user_id,ticket_created_by_contact_id = OLD.ticket_created_by_contact_id,ticket_closed_date = OLD.ticket_closed_date,ticket_closing_user = OLD.ticket_closing_user,ticket_current_user_id = OLD.ticket_current_user_id,ticket_current_group_id = OLD.ticket_current_group_id,ticket_latest_update_datetime = OLD.ticket_latest_update_datetime,ticket_latest_update_by_userid = OLD.ticket_latest_update_by_userid,ticket_notify_creator_on_close = OLD.ticket_notify_creator_on_close,ticket_type_id = OLD.ticket_type_id,ticket_sub_type_id = OLD.ticket_sub_type_id,ticket_category_id = OLD.ticket_category_id,ticket_urgency = OLD.ticket_urgency,ticket_impact = OLD.ticket_impact,ticket_risk = OLD.ticket_risk,ticket_fallback = OLD.ticket_fallback,ticket_reason = OLD.ticket_reason,ticket_rfc_execution_date = OLD.ticket_rfc_execution_date,await_ticket_id = OLD.await_ticket_id,wf_task_id = OLD.wf_task_id,ticket_responsible_user = OLD.ticket_responsible_user,ticket_sender_email = OLD.ticket_sender_email,ticket_deadline = OLD.ticket_deadline,ticket_finance_note = OLD.ticket_finance_note;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_approvers_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_approvers_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `approver_1` bigint(20) NOT NULL,
  `approver_2` bigint(20) NOT NULL,
  `user_approvement1` int(1) NOT NULL DEFAULT '0' COMMENT '1=approved, 2=not approved',
  `user_approvement2` int(1) NOT NULL,
  `approvement_datetime1` datetime NOT NULL,
  `approvement_datetime2` datetime NOT NULL,
  UNIQUE KEY `ticket_approvers_idx` (`ticket_id`),
  KEY `ticket_approvers_approver_idx` (`approver_1`,`approver_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ticket_approvers_rel';

-- --------------------------------------------------------

--
-- Table structure for table `ticket_assets_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_assets_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  KEY `ticket_asset_rel_asset_idx` (`asset_id`),
  KEY `ticket_asset_rel_ticket_idx` (`ticket_id`),
  KEY `t_as_idx` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_categories`
--

CREATE TABLE IF NOT EXISTS `ticket_categories` (
  `ticket_category_id` int(9) NOT NULL AUTO_INCREMENT,
  `ticket_category_name` varchar(255) NOT NULL,
  `ticket_category_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`ticket_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_circuits_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_circuits_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `circuit_id` bigint(20) NOT NULL,
  KEY `ticket_circuit_rel_ticket_idx` (`ticket_id`),
  KEY `ticket_circuit_rel_circuit_idx` (`circuit_id`),
  KEY `t_ci_idx` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_deadline_breaches`
--

CREATE TABLE IF NOT EXISTS `ticket_deadline_breaches` (
  `breach_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) NOT NULL,
  `breach_datetime` datetime NOT NULL,
  `unbreach_datetime` datetime NOT NULL,
  PRIMARY KEY (`breach_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_email_reporting`
--

CREATE TABLE IF NOT EXISTS `ticket_email_reporting` (
  `report_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_status` tinyint(1) NOT NULL,
  `report_label` varchar(255) CHARACTER SET utf8 NOT NULL,
  `number_of_tickets` mediumint(8) UNSIGNED NOT NULL,
  `repeat_period` int(10) UNSIGNED NOT NULL,
  `chosen_repeat_period` tinyint(1) UNSIGNED NOT NULL,
  `repeat_periodicaly_number_of_days` int(10) UNSIGNED NOT NULL,
  `repeat_monthly_day_of_month` int(10) UNSIGNED NOT NULL,
  `repeat_start_date` varchar(255) CHARACTER SET utf8 NOT NULL,
  `one_time_period` int(2) UNSIGNED NOT NULL COMMENT 'number declares time period',
  `one_time_start_decision` tinyint(1) NOT NULL,
  `one_time_start_date` varchar(255) CHARACTER SET utf8 NOT NULL,
  `at_job_number` int(10) UNSIGNED NOT NULL,
  `report_last_run` date NOT NULL,
  `report_next_run` date NOT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_email_reporting_addresses`
--

CREATE TABLE IF NOT EXISTS `ticket_email_reporting_addresses` (
  `email_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(320) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`email_id`),
  KEY `report_idx` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_email_reporting_filter_assets`
--

CREATE TABLE IF NOT EXISTS `ticket_email_reporting_filter_assets` (
  `filter_asset_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `chosen_asset` int(99) UNSIGNED NOT NULL,
  PRIMARY KEY (`filter_asset_id`),
  KEY `report_filter_asset_idx` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_email_reporting_filter_customers`
--

CREATE TABLE IF NOT EXISTS `ticket_email_reporting_filter_customers` (
  `filter_customer_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `chosen_customer` int(99) UNSIGNED NOT NULL,
  PRIMARY KEY (`filter_customer_id`),
  KEY `report_filter_customers_idx` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_email_reporting_filter_user`
--

CREATE TABLE IF NOT EXISTS `ticket_email_reporting_filter_user` (
  `filter_user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `chosen_user` int(99) UNSIGNED NOT NULL,
  PRIMARY KEY (`filter_user_id`),
  KEY `report_filter_user_idx` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_email_reporting_include_type`
--

CREATE TABLE IF NOT EXISTS `ticket_email_reporting_include_type` (
  `include_type_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `close_to_SLA` tinyint(1) UNSIGNED NOT NULL,
  `breached_SLA` tinyint(1) UNSIGNED NOT NULL,
  `active_tickets` tinyint(4) UNSIGNED NOT NULL,
  `open_tickets` tinyint(1) UNSIGNED NOT NULL,
  `closed_tickets` tinyint(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`include_type_id`),
  KEY `report_type_idx` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_email_reporting_repeat_weekly`
--

CREATE TABLE IF NOT EXISTS `ticket_email_reporting_repeat_weekly` (
  `week_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `Monday` int(1) UNSIGNED NOT NULL,
  `Tuesday` int(1) UNSIGNED NOT NULL,
  `Wednesday` int(1) UNSIGNED NOT NULL,
  `Thursday` int(1) UNSIGNED NOT NULL,
  `Friday` int(1) UNSIGNED NOT NULL,
  `Saturday` int(1) UNSIGNED NOT NULL,
  `Sunday` int(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`week_id`),
  KEY `report_weekly_idx` (`report_id`,`week_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_events`
--

CREATE TABLE IF NOT EXISTS `ticket_events` (
  `ticket_event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) NOT NULL,
  `ticket_event_status` int(11) NOT NULL COMMENT 'open, close aso',
  `ticket_event_user_id` bigint(20) NOT NULL,
  `ticket_event_data` text NOT NULL,
  `ticket_event_datetime` datetime NOT NULL,
  `ticket_event_from` varchar(100) NOT NULL,
  PRIMARY KEY (`ticket_event_id`),
  KEY `ticket_event_idx` (`ticket_id`),
  KEY `ticket_event_user_idx` (`ticket_event_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_followups`
--

CREATE TABLE IF NOT EXISTS `ticket_followups` (
  `followup_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `followup_body` text NOT NULL,
  `followup_internal_comment` text NOT NULL,
  `followup_created_date_time` datetime NOT NULL,
  `followup_closed_date_time` datetime NOT NULL,
  `followup_user_id` int(99) NOT NULL COMMENT 'u_id of followupper ;-)',
  `followup_current_user_id` bigint(20) NOT NULL,
  `followup_current_group_id` int(99) NOT NULL,
  `followup_additional_time` varchar(5) NOT NULL COMMENT 'extra time used in the setup 99h:99m',
  `followup_additional_time_invoiced` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=not marked, 1=marked as sent for invoice',
  `followup_cc_user` bigint(20) NOT NULL,
  `followup_status` int(1) NOT NULL COMMENT 'time start_stop 1=updated, 2=acked, 3=closed, 4=start time, 5=stop time',
  `followup_edited_date_time` datetime NOT NULL,
  `followup_edited_by` bigint(20) NOT NULL,
  `followup_from_email` varchar(255) NOT NULL,
  `followup_time_since_last_followup` varchar(20) NOT NULL,
  `followup_additional_time_invoiceable` int(1) NOT NULL,
  `followup_additional_time_project_id` int(11) NOT NULL,
  `followup_additional_time_activity_id` int(11) NOT NULL,
  `followup_to_email` varchar(255) NOT NULL,
  PRIMARY KEY (`followup_id`),
  KEY `followup_current_user_idx` (`followup_current_user_id`),
  KEY `followup_from_email_idx` (`followup_from_email`),
  KEY `followup_user_idx` (`followup_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_followups_contact_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_followups_contact_rel` (
  `followup_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_followups_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_followups_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `followup_id` bigint(20) NOT NULL,
  `followup_sequence` bigint(20) NOT NULL COMMENT 'sequence related to ticket',
  `reminder_to` varchar(5) NOT NULL,
  `reminder_from_date` date NOT NULL,
  `exchange_event_id` varchar(255) NOT NULL,
  `reminder_from_time` varchar(5) NOT NULL,
  `reminder_to_date` date NOT NULL,
  `reminder_to_time` varchar(5) NOT NULL,
  `kb_solution` bigint(20) NOT NULL DEFAULT '0' COMMENT 'KB Id',
  `kb_solution_check` int(11) NOT NULL DEFAULT '0',
  KEY `ticket_followups_rel_ticket_idx` (`ticket_id`,`followup_id`),
  KEY `ticket_followups_rel_kb_solution_idx` (`kb_solution`),
  KEY `t_fol_idx` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_invoice_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_invoice_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `followup_id` bigint(20) NOT NULL,
  `invoice_text` varchar(255) NOT NULL,
  `invoice_project_id` int(11) NOT NULL,
  `invoice_text_datetime` datetime NOT NULL,
  `invoice_text_user_id` bigint(20) NOT NULL,
  `invoice_finance_result_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_mail_data_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_mail_data_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `mail_data_id` bigint(20) NOT NULL,
  `dummy_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`dummy_id`),
  KEY `mail_data_idx` (`mail_data_id`),
  KEY `mail_data_ticket_idx` (`ticket_id`),
  KEY `t_mail_idx` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_oat_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_oat_rel` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `asset_oat_id` bigint(20) NOT NULL,
  `oat_id` int(10) UNSIGNED NOT NULL,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `asset_id` int(10) UNSIGNED NOT NULL,
  `asset_status` int(10) UNSIGNED NOT NULL,
  `person_to_confirm` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_parts_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_parts_rel` (
  `ticket_id` bigint(20) NOT NULL,
  `part_id` bigint(20) NOT NULL,
  `no_items` int(11) NOT NULL DEFAULT '0',
  `part_serials` text NOT NULL COMMENT 'json_list_of_serialnumbers',
  KEY `ticket_id` (`ticket_id`),
  KEY `part_id` (`part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_registrations_data`
--

CREATE TABLE IF NOT EXISTS `ticket_registrations_data` (
  `trd_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trd_deleted` tinyint(1) NOT NULL COMMENT '1=deleted',
  `trd_ticket_id` bigint(20) NOT NULL,
  `trd_created_date` datetime NOT NULL,
  `trd_created_by_user` bigint(20) NOT NULL,
  `trd_edited_by_user` bigint(20) NOT NULL,
  `trd_edited_date` datetime NOT NULL,
  `trd_input_type` int(11) NOT NULL,
  `trd_hours_type` int(11) NOT NULL,
  `trd_transport_type` int(11) NOT NULL,
  `trd_purchase_type` int(11) NOT NULL,
  `trd_hours_data` varchar(255) NOT NULL,
  `trd_transport_data` varchar(255) NOT NULL,
  `trd_purchase_data` varchar(255) NOT NULL,
  `trd_currency_id` tinyint(4) NOT NULL,
  `trd_hours_comment` text NOT NULL,
  `trd_transport_comment` text NOT NULL,
  `trd_purchase_comment` text NOT NULL,
  `trd_hours_invoiceable` tinyint(4) NOT NULL DEFAULT '0',
  `trd_transport_invoiceable` tinyint(4) NOT NULL DEFAULT '0',
  `trd_purchase_invoiceable` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`trd_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_sla_data_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_sla_data_rel` (
  `tsla_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) NOT NULL,
  `sla_id` int(11) NOT NULL,
  `breach_timer_stop` int(11) NOT NULL,
  `ticket_created_datetime` datetime NOT NULL,
  `sla_warning_minutes` int(11) NOT NULL,
  `sla_breach_minutes` int(11) NOT NULL,
  `sla_breach_datetime` datetime NOT NULL,
  `sla_breach_warning_datetime` datetime NOT NULL,
  PRIMARY KEY (`tsla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_stati`
--

CREATE TABLE IF NOT EXISTS `ticket_stati` (
  `ticket_stati_id` int(11) NOT NULL AUTO_INCREMENT,
  `locked_record` int(11) NOT NULL,
  `ticket_stati_name` varchar(255) NOT NULL,
  `ticket_stati_description` varchar(255) NOT NULL,
  `ticket_stati_color` varchar(10) NOT NULL,
  PRIMARY KEY (`ticket_stati_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_sub_types`
--

CREATE TABLE IF NOT EXISTS `ticket_sub_types` (
  `ticket_sub_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `ticket_type_id` int(99) NOT NULL,
  `ticket_sub_type_name` varchar(255) NOT NULL,
  `ticket_sub_type_description` text NOT NULL,
  PRIMARY KEY (`ticket_sub_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_s_a_f`
--

CREATE TABLE IF NOT EXISTS `ticket_s_a_f` (
  `ticket_s_a_f_id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_s_a_f_name` varchar(255) NOT NULL,
  `ticket_s_a_f_description` varchar(255) NOT NULL,
  `ticket_s_a_f_type` int(11) NOT NULL,
  `ticket_s_a_f_length` varchar(10) NOT NULL,
  `ticket_s_a_f_validate` int(11) NOT NULL,
  `ticket_s_a_f_required` tinyint(1) NOT NULL,
  PRIMARY KEY (`ticket_s_a_f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='subtype additional fields';

-- --------------------------------------------------------

--
-- Table structure for table `ticket_s_a_f_data`
--

CREATE TABLE IF NOT EXISTS `ticket_s_a_f_data` (
  `ticket_s_a_f_data_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) NOT NULL,
  `ticket_s_a_f_id` bigint(20) NOT NULL,
  `ticket_s_a_f_data_value` text NOT NULL,
  PRIMARY KEY (`ticket_s_a_f_data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_s_a_f_rel`
--

CREATE TABLE IF NOT EXISTS `ticket_s_a_f_rel` (
  `ticket_sub_type_id` int(11) NOT NULL,
  `ticket_s_a_f_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_throttle_temp_table`
--

CREATE TABLE IF NOT EXISTS `ticket_throttle_temp_table` (
  `throttle_email` varchar(255) NOT NULL,
  `throttle_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `throttle_email_counter` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `throttle_email_idx` (`throttle_email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_types`
--

CREATE TABLE IF NOT EXISTS `ticket_types` (
  `ticket_type_id` int(99) NOT NULL AUTO_INCREMENT,
  `ticket_type_name` varchar(255) NOT NULL,
  `ticket_type_desc` varchar(255) NOT NULL,
  `locked_record` tinyint(4) NOT NULL DEFAULT '0',
  `ticket_type_approvers` tinyint(4) NOT NULL COMMENT 'Approvers needed?',
  `wf_task_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ticket_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_user_followers`
--

CREATE TABLE IF NOT EXISTS `ticket_user_followers` (
  `ticket_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `urgency_types`
--

CREATE TABLE IF NOT EXISTS `urgency_types` (
  `urgency_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `urgency_type_name` varchar(100) NOT NULL,
  `urgency_type_description` text NOT NULL,
  PRIMARY KEY (`urgency_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `u_id` int(99) NOT NULL AUTO_INCREMENT,
  `u_token` varchar(255) NOT NULL,
  `u_last_login` blob NOT NULL,
  `u_user_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=active, 1=inactive, 2=ldapinactive, 7=ldap_user_general, 8 equals deactivated by ldap, 9 equals deactived user',
  `u_user_type` int(1) NOT NULL DEFAULT '1' COMMENT '1, bruger - 2, admin, 3 - readonly user, 4=ldap_user_no_license',
  `u_sec_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'security status',
  `template_id` int(99) NOT NULL,
  `u_name` varchar(255) NOT NULL,
  `u_pwd` text NOT NULL,
  `u_pwd_date` date NOT NULL,
  `u_login_time` datetime NOT NULL,
  `u_old_login_time` datetime NOT NULL,
  `u_created_by_id` bigint(20) NOT NULL,
  `u_created_date` datetime NOT NULL,
  `u_deactivated_by_id` bigint(20) NOT NULL,
  `u_deactivated_date` datetime NOT NULL,
  `u_realname` varchar(255) NOT NULL,
  `u_jobtitle` varchar(255) NOT NULL,
  `u_address` varchar(255) NOT NULL,
  `u_pono` varchar(10) NOT NULL,
  `u_city` varchar(255) NOT NULL,
  `u_phonenumber` varchar(40) NOT NULL,
  `u_mobilenumber` varchar(40) NOT NULL,
  `u_email` varchar(100) NOT NULL,
  `u_employment_start_date` date NOT NULL,
  `u_employment_end_date` date NOT NULL,
  `u_leader` int(99) NOT NULL COMMENT 'user id',
  `u_use_tabs` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Yes, 1=No',
  `u_comment` varchar(255) NOT NULL,
  `u_mail_signature` text NOT NULL COMMENT 'Signature used in replys in ITS',
  `image_link` varchar(255) NOT NULL,
  `u_frontpage` varchar(255) NOT NULL,
  `u_tor` int(11) DEFAULT NULL COMMENT 'user type of response',
  `sidebar` tinyint(1) NOT NULL DEFAULT '0',
  `u_user_role` int(11) NOT NULL,
  `u_finance_id` varchar(10) NOT NULL,
  `u_finance_note` varchar(255) NOT NULL,
  `u_update_acked` tinyint(1) NOT NULL,
  `site_language` varchar(4) NOT NULL,
  `u_feed_my_tickets_notifications` int(11) NOT NULL,
  `u_read_feed` int(11) NOT NULL,
  `u_feed_all_tickets_notifications` int(11) NOT NULL,
  `u_feed_my_tickets_channel` tinyint(4) NOT NULL DEFAULT '1',
  `u_feed_general_channel` tinyint(4) NOT NULL DEFAULT '1',
  `u_feed_all_tickets_channel` tinyint(4) NOT NULL DEFAULT '0',
  `u_feed_push_general_notification` int(11) NOT NULL,
  `u_feed_active_channel` int(10) NOT NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `u_name` (`u_name`),
  KEY `users_idx` (`u_user_mode`,`u_user_type`,`u_sec_status`,`u_leader`,`u_user_role`),
  KEY `u_idx` (`u_id`,`u_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users_search_history`
--

CREATE TABLE IF NOT EXISTS `users_search_history` (
  `search_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `search_value` varchar(255) NOT NULL,
  PRIMARY KEY (`search_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_assigned_assets`
--

CREATE TABLE IF NOT EXISTS `user_assigned_assets` (
  `u_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL,
  `assigned_datetime` datetime NOT NULL,
  `returned_datetime` datetime NOT NULL,
  `returned_to` bigint(20) NOT NULL COMMENT 'user_id of recepient',
  `assigned_by` bigint(20) NOT NULL COMMENT 'user_id of assignee'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_calendar_events`
--

CREATE TABLE IF NOT EXISTS `user_calendar_events` (
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `exchange_event_id` varchar(255) NOT NULL,
  `event_type_id` int(11) NOT NULL,
  `event_description` text NOT NULL,
  `event_location` varchar(255) NOT NULL,
  `event_created_by` bigint(20) NOT NULL,
  `event_created_datetime` datetime NOT NULL,
  `event_user_id` int(11) NOT NULL,
  `event_date_start` date NOT NULL,
  `event_date_end` date NOT NULL,
  `event_time_start` varchar(5) NOT NULL,
  `event_time_end` varchar(5) NOT NULL,
  `event_allday` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_frames`
--

CREATE TABLE IF NOT EXISTS `user_frames` (
  `user_id` bigint(20) NOT NULL,
  `window_id` int(9) NOT NULL,
  KEY `user_frames_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_functions`
--

CREATE TABLE IF NOT EXISTS `user_functions` (
  `user_function_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_function_name` varchar(255) NOT NULL,
  `user_function_description` text NOT NULL,
  `user_function_amount` int(11) NOT NULL,
  PRIMARY KEY (`user_function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_functions_rel`
--

CREATE TABLE IF NOT EXISTS `user_functions_rel` (
  `u_id` bigint(20) NOT NULL,
  `user_function_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE IF NOT EXISTS `user_groups` (
  `user_group_id` int(99) NOT NULL AUTO_INCREMENT,
  `user_group_name` varchar(255) NOT NULL,
  `user_group_short` varchar(4) NOT NULL,
  `user_group_desc` varchar(255) NOT NULL,
  `user_group_leader` bigint(20) NOT NULL,
  PRIMARY KEY (`user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_group_skills_rel`
--

CREATE TABLE IF NOT EXISTS `user_group_skills_rel` (
  `skill_id` int(99) NOT NULL,
  `user_group_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_group_template_rel`
--

CREATE TABLE IF NOT EXISTS `user_group_template_rel` (
  `template_id` int(99) NOT NULL,
  `user_group_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_job_titles`
--

CREATE TABLE IF NOT EXISTS `user_job_titles` (
  `user_job_title_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_job_title_name` varchar(255) NOT NULL,
  `user_job_title_description` text NOT NULL,
  PRIMARY KEY (`user_job_title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_provided_items`
--

CREATE TABLE IF NOT EXISTS `user_provided_items` (
  `upt_id` int(9) NOT NULL AUTO_INCREMENT,
  `upt_name` varchar(255) NOT NULL,
  `upt_type` varchar(255) NOT NULL,
  `upt_serial` varchar(255) NOT NULL,
  `upt_start_date` date NOT NULL,
  `upt_end_date` date NOT NULL,
  `upt_waranty_end_date` date NOT NULL,
  `upt_comment` varchar(255) NOT NULL,
  `upt_asset_id` bigint(20) NOT NULL,
  PRIMARY KEY (`upt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_quick_menus`
--

CREATE TABLE IF NOT EXISTS `user_quick_menus` (
  `user_id` bigint(20) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_rights_rel`
--

CREATE TABLE IF NOT EXISTS `user_rights_rel` (
  `user_id` int(99) NOT NULL,
  `right_id` int(99) NOT NULL,
  KEY `user_rights_idx` (`user_id`,`right_id`),
  KEY `u_right_idx` (`user_id`,`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE IF NOT EXISTS `user_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  `role_description` text NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_security_rel`
--

CREATE TABLE IF NOT EXISTS `user_security_rel` (
  `user_id` bigint(20) NOT NULL,
  `security_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE IF NOT EXISTS `user_sessions` (
  `session_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_user_id` bigint(20) NOT NULL,
  `session_user_name` varchar(255) NOT NULL,
  `session_page_start` varchar(100) NOT NULL,
  `session_page_end` varchar(100) NOT NULL,
  `session_page_name` text NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE IF NOT EXISTS `user_settings` (
  `dummy_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `u_id` bigint(20) NOT NULL,
  `u_search_in` text NOT NULL COMMENT 'array of elements ',
  `u_calendar` int(11) NOT NULL,
  `site_language` varchar(2) NOT NULL,
  `u_followup_direction` int(11) NOT NULL,
  `ticket_update_response` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=yes, 1=no',
  `page_return_to` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dummy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_skills_rel`
--

CREATE TABLE IF NOT EXISTS `user_skills_rel` (
  `user_id` bigint(20) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_level` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_upt_rel`
--

CREATE TABLE IF NOT EXISTS `user_upt_rel` (
  `user_id` bigint(20) NOT NULL,
  `upt_id` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_user_group_rel`
--

CREATE TABLE IF NOT EXISTS `user_user_group_rel` (
  `user_id` bigint(20) NOT NULL,
  `user_group_id` int(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_working_hours`
--

CREATE TABLE IF NOT EXISTS `user_working_hours` (
  `user_id` int(99) UNSIGNED NOT NULL,
  `start_work_hours` time DEFAULT NULL,
  `end_work_hours` time DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_working_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='user working hours management table';

-- --------------------------------------------------------

--
-- Table structure for table `vip_asset_rel`
--

CREATE TABLE IF NOT EXISTS `vip_asset_rel` (
  `vip_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a2v_asset_id_to` bigint(20) NOT NULL COMMENT 'Asset Marked as VIP',
  `a2v_asset_id_from` bigint(20) NOT NULL COMMENT 'Asset connected to VIP',
  `a2v_asset_id_from_interface` bigint(20) NOT NULL,
  PRIMARY KEY (`vip_id`),
  KEY `vip_asset_idx` (`a2v_asset_id_to`),
  KEY `a2v_idx` (`a2v_asset_id_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vlans`
--

CREATE TABLE IF NOT EXISTS `vlans` (
  `vlanid` bigint(20) NOT NULL AUTO_INCREMENT,
  `vlan_id` bigint(20) NOT NULL,
  `vlan_name` varchar(100) NOT NULL,
  `vlan_description` varchar(255) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  PRIMARY KEY (`vlanid`),
  KEY `vlan_id` (`vlan_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vpns`
--

CREATE TABLE IF NOT EXISTS `vpns` (
  `vpn_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vpn_name` varchar(255) NOT NULL,
  `vpn_type` int(11) NOT NULL,
  `vpn_local_ip` varchar(100) NOT NULL,
  `vpn_remote_ip` varchar(100) NOT NULL,
  `vpn_ip_segment` varchar(100) NOT NULL,
  `vpn_P1_Neg_mode` int(11) NOT NULL,
  `vpn_P1_HMAC` int(11) NOT NULL,
  `vpn_P1_auth` int(11) NOT NULL,
  `vpn_P1_group` int(11) NOT NULL,
  `vpn_P1_lifetime` varchar(10) NOT NULL,
  `vpn_P1_encryption` int(11) NOT NULL,
  `vpn_P2_protocol` int(11) NOT NULL,
  `vpn_P2_encryption` int(11) NOT NULL,
  `vpn_P2_HMAC` int(11) NOT NULL,
  `vpn_P2_lifetime` varchar(10) NOT NULL,
  `vpn_P2_transport` int(11) NOT NULL,
  `vpn_cryptodomain` text NOT NULL,
  `vpn_pfs` int(11) NOT NULL COMMENT 'PerfectForwardSecurity',
  `vpn_psk` text NOT NULL,
  `vpn_comment` text NOT NULL,
  PRIMARY KEY (`vpn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vpn_assets_rel`
--

CREATE TABLE IF NOT EXISTS `vpn_assets_rel` (
  `vpn_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vpn_customer_rel`
--

CREATE TABLE IF NOT EXISTS `vpn_customer_rel` (
  `vpn_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wf_events`
--

CREATE TABLE IF NOT EXISTS `wf_events` (
  `wf_event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `wf_event_id_parent` varchar(20) NOT NULL,
  `wf_event_parent` int(11) NOT NULL,
  `wf_event_dependency` tinyint(1) NOT NULL,
  `wf_task_id` bigint(20) NOT NULL,
  `wf_event_creator` bigint(20) NOT NULL,
  `wf_event_created_datetime` datetime NOT NULL,
  `wf_event_name` varchar(255) NOT NULL,
  `wf_event_description` text NOT NULL,
  `wf_event_expected_process_time` varchar(255) NOT NULL,
  `wf_event_expected_process_entity` tinyint(4) NOT NULL,
  `wf_event_priority` tinyint(4) NOT NULL,
  `wf_event_assigned_user` bigint(20) NOT NULL,
  `wf_event_assigned_group` int(11) NOT NULL,
  PRIMARY KEY (`wf_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wf_tasks`
--

CREATE TABLE IF NOT EXISTS `wf_tasks` (
  `wf_task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `wf_task_name` varchar(255) NOT NULL,
  `wf_task_description` text NOT NULL,
  `wf_task_creator` bigint(20) NOT NULL,
  `wf_task_created_datetime` datetime NOT NULL,
  `wf_task_active` tinyint(4) NOT NULL,
  `wf_task_approved_by` bigint(20) NOT NULL,
  `wf_task_approved_date` datetime NOT NULL,
  `wf_task_approved_status` tinyint(4) NOT NULL,
  `wf_task_status` tinyint(4) NOT NULL,
  PRIMARY KEY (`wf_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wf_ticket_checks`
--

CREATE TABLE IF NOT EXISTS `wf_ticket_checks` (
  `wf_ticket_check_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `wf_ticket_check_task_id` bigint(20) NOT NULL,
  `wf_ticket_check_event_id` int(11) NOT NULL,
  `wf_ticket_check_checked` varchar(255) NOT NULL,
  `wf_ticket_check_datetime` datetime NOT NULL,
  PRIMARY KEY (`wf_ticket_check_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wf_ticket_rel`
--

CREATE TABLE IF NOT EXISTS `wf_ticket_rel` (
  `wf_ticket_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `wf_ticket_master_ticket_id` bigint(20) NOT NULL,
  `wf_ticket_ticket_id` bigint(20) NOT NULL,
  `wf_ticket_priority` tinyint(4) NOT NULL,
  `wf_ticket_event_id_parent` varchar(10) NOT NULL,
  `wf_ticket_dependency` bigint(20) NOT NULL,
  `wf_ticket_execute_date` date NOT NULL,
  `wf_ticket_master_sub` tinyint(4) NOT NULL,
  `wf_ticket_ticket_status` int(11) NOT NULL,
  `wf_ticket_stage` tinyint(4) NOT NULL,
  `wf_ticket_checks` text NOT NULL,
  `wf_task_id` bigint(20) NOT NULL,
  PRIMARY KEY (`wf_ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

INSERT IGNORE INTO `users` (`u_id`, `u_user_mode`, `u_user_type`, `u_sec_status`, `u_name`, `u_pwd`,`u_realname`) VALUES
(1, 2, 4, 0, 'admin', 'r0dgr0d', 'Administrator');

--

--
-- Constraints for table `ticket_email_reporting_addresses`
--
ALTER TABLE `ticket_email_reporting_addresses`
  ADD CONSTRAINT `ticket_email_reporting_addresses_ibfk_4` FOREIGN KEY (`report_id`) REFERENCES `ticket_email_reporting` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_email_reporting_filter_assets`
--
ALTER TABLE `ticket_email_reporting_filter_assets`
  ADD CONSTRAINT `ticket_email_reporting_filter_assets_ibfk_3` FOREIGN KEY (`report_id`) REFERENCES `ticket_email_reporting` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_email_reporting_filter_customers`
--
ALTER TABLE `ticket_email_reporting_filter_customers`
  ADD CONSTRAINT `ticket_email_reporting_filter_customers_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `ticket_email_reporting` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_email_reporting_filter_user`
--
ALTER TABLE `ticket_email_reporting_filter_user`
  ADD CONSTRAINT `ticket_email_reporting_filter_user_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `ticket_email_reporting` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_email_reporting_include_type`
--
ALTER TABLE `ticket_email_reporting_include_type`
  ADD CONSTRAINT `ticket_email_reporting_include_type_ibfk_5` FOREIGN KEY (`report_id`) REFERENCES `ticket_email_reporting` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket_email_reporting_repeat_weekly`
--
ALTER TABLE `ticket_email_reporting_repeat_weekly`
  ADD CONSTRAINT `fk_ticket_email_reporting_repeat_weekly` FOREIGN KEY (`report_id`) REFERENCES `ticket_email_reporting` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

