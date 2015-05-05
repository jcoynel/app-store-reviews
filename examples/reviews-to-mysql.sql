/* Copyright (c) 2013-2015 Jules Coynel */
/* https://github.com/jcoynel/app-store-reviews */

-- --------------------------------------------------------

--
-- Table structure for table `apps`
--

DROP TABLE IF EXISTS `apps`;
CREATE TABLE IF NOT EXISTS `apps` (
  `id` int(11) unsigned NOT NULL COMMENT 'ID from the app store',
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `countries` text COLLATE utf8_unicode_ci COMMENT 'Comma separated countries or null for all',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `iphone` tinyint(1) NOT NULL DEFAULT '0',
  `ipad` tinyint(1) NOT NULL DEFAULT '0',
  `osx` tinyint(1) NOT NULL DEFAULT '0',
  `image_url` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `app_store_url` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `apps`
--

INSERT INTO `apps` (`id`, `name`, `countries`, `enabled`, `iphone`, `ipad`, `osx`, `image_url`, `app_store_url`) VALUES
(385441468, 'Debenhams', NULL, 1, 1, 0, 0, 'http://a1849.phobos.apple.com/us/r1000/072/Purple2/v4/d4/46/e6/d446e600-2935-edd9-9a66-bca9374af994/mzl.xzybmdic.53x53-50.png', 'https://itunes.apple.com/app/id385441468'),
(555731861, 'Tunes Notifier', '', 1, 0, 0, 1, 'http://a1489.phobos.apple.com/us/r1000/108/Purple/v4/b3/42/0f/b3420f4d-cb55-adbc-4304-45d8e348bf71/icon.53x53-50.png', 'https://itunes.apple.com/app/id555731861'),
(578238320, 'Mothercare', 'gb', 1, 1, 0, 0, 'http://a1853.phobos.apple.com/us/r1000/069/Purple2/v4/71/7e/fa/717efa25-1ff5-7720-1337-4e9f95bdc879/mzl.kylsixtw.53x53-50.png', 'https://itunes.apple.com/app/id578238320');

-- --------------------------------------------------------

--
-- Stand-in structure for view `comments`
--
DROP VIEW IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
`review_id` int(11) unsigned
,`app` varchar(60)
,`app_id` int(11) unsigned
,`country` varchar(50)
,`author` varchar(50)
,`version` varchar(10)
,`rate` tinyint(1)
,`title` varchar(50)
,`comment` text
);
-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`) VALUES
('ae', 'United Arab Emirates'),
('ag', 'Antigua and Barbuda'),
('ai', 'Anguilla'),
('al', 'Albania'),
('am', 'Armenia'),
('ao', 'Angola'),
('ar', 'Argentina'),
('at', 'Austria'),
('au', 'Australia'),
('az', 'Azerbaijan'),
('bb', 'Barbados'),
('be', 'Belgium'),
('bf', 'Burkina Faso'),
('bg', 'Bulgaria'),
('bh', 'Bahrain'),
('bj', 'Benin'),
('bm', 'Bermuda'),
('bn', 'Brunei'),
('bo', 'Bolivia'),
('br', 'Brazil'),
('bs', 'Bahamas'),
('bt', 'Bhutan'),
('bw', 'Botswana'),
('by', 'Belarus'),
('bz', 'Belize'),
('ca', 'Canada'),
('cg', 'Republic Of Congo'),
('ch', 'Switzerland'),
('cl', 'Chile'),
('cn', 'China'),
('co', 'Colombia'),
('cr', 'Costa Rica'),
('cv', 'Cape Verde'),
('cy', 'Cyprus'),
('cz', 'Czech Republic'),
('de', 'Germany'),
('dk', 'Denmark'),
('dm', 'Dominica'),
('do', 'Dominican Republic'),
('dz', 'Algeria'),
('ec', 'Ecuador'),
('ee', 'Estonia'),
('eg', 'Egypt'),
('es', 'Spain'),
('fi', 'Finland'),
('fj', 'Fiji'),
('fm', 'Federated States Of Micronesia'),
('fr', 'France'),
('gb', 'United Kingdom'),
('gd', 'Grenada'),
('gh', 'Ghana'),
('gm', 'Gambia'),
('gr', 'Greece'),
('gt', 'Guatemala'),
('gw', 'Guinea-Bissau'),
('gy', 'Guyana'),
('hk', 'Hong Kong'),
('hn', 'Honduras'),
('hr', 'Croatia'),
('hu', 'Hungary'),
('id', 'Indonesia'),
('ie', 'Ireland'),
('il', 'Israel'),
('in', 'India'),
('is', 'Iceland'),
('it', 'Italy'),
('jm', 'Jamaica'),
('jo', 'Jordan'),
('jp', 'Japan'),
('ke', 'Kenya'),
('kg', 'Kyrgyzstan'),
('kh', 'Cambodia'),
('kn', 'St. Kitts and Nevis'),
('kr', 'Republic Of Korea'),
('kw', 'Kuwait'),
('ky', 'Cayman Islands'),
('kz', 'Kazakstan'),
('la', 'Lao People''s Democratic Republic'),
('lb', 'Lebanon'),
('lc', 'St. Lucia'),
('lk', 'Sri Lanka'),
('lr', 'Liberia'),
('lt', 'Lithuania'),
('lu', 'Luxembourg'),
('lv', 'Latvia'),
('md', 'Republic Of Moldova'),
('mg', 'Madagascar'),
('mk', 'Macedonia'),
('ml', 'Mali'),
('mn', 'Mongolia'),
('mo', 'Macau'),
('mr', 'Mauritania'),
('ms', 'Montserrat'),
('mt', 'Malta'),
('mu', 'Mauritius'),
('mw', 'Malawi'),
('mx', 'Mexico'),
('my', 'Malaysia'),
('mz', 'Mozambique'),
('na', 'Namibia'),
('ne', 'Niger'),
('ng', 'Nigeria'),
('ni', 'Nicaragua'),
('nl', 'Netherlands'),
('no', 'Norway'),
('np', 'Nepal'),
('nz', 'New Zealand'),
('om', 'Oman'),
('pa', 'Panama'),
('pe', 'Peru'),
('pg', 'Papua New Guinea'),
('ph', 'Philippines'),
('pk', 'Pakistan'),
('pl', 'Poland'),
('pt', 'Portugal'),
('pw', 'Palau'),
('py', 'Paraguay'),
('qa', 'Qatar'),
('ro', 'Romania'),
('ru', 'Russia'),
('sa', 'Saudi Arabia'),
('sb', 'Solomon Islands'),
('sc', 'Seychelles'),
('se', 'Sweden'),
('sg', 'Singapore'),
('si', 'Slovenia'),
('sk', 'Slovakia'),
('sl', 'Sierra Leone'),
('sn', 'Senegal'),
('sr', 'Suriname'),
('st', 'Sao Tome and Principe'),
('sv', 'El Salvador'),
('sz', 'Swaziland'),
('tc', 'Turks and Caicos'),
('td', 'Chad'),
('tj', 'Tajikistan'),
('tm', 'Turkmenistan'),
('tn', 'Tunisia'),
('tr', 'Turkey'),
('tt', 'Trinidad and Tobago'),
('tw', 'Taiwan'),
('tz', 'Tanzania'),
('ua', 'Ukraine'),
('ug', 'Uganda'),
('us', 'United States'),
('uy', 'Uruguay'),
('uz', 'Uzbekistan'),
('vc', 'St. Vincent and The Grenadines'),
('ve', 'Venezuela'),
('vg', 'British Virgin Islands'),
('vn', 'Vietnam'),
('ye', 'Yemen'),
('za', 'South Africa'),
('zw', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) unsigned NOT NULL,
  `author` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate` tinyint(1) DEFAULT NULL,
  `title` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT '',
  `app` int(11) DEFAULT NULL,
  `retrieved_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `emailed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------
