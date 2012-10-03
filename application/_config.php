<?php

global $project;
$project = 'application';

global $databaseConfig;
$databaseConfig = array(
	"type" => "MySQLDatabase",
	"server" => "localhost", 
	"username" => "root", 
	"password" => "", 
	"database" => "mobit_new_db",
);

// Sites running on the following servers will be
// run in development mode. See
// http://doc.silverstripe.com/doku.php?id=devmode
// for a description of what dev mode does.
Director::set_dev_servers(array(
	'localhost',
	'127.0.0.1',
	'sitsmail.servehttp.com',
));

DataObject::add_extension('Member', 'MBUser');

// This line set's the current theme. More themes can be
// downloaded from http://www.silverstripe.com/themes/
SSViewer::set_theme('mobit');

Security::setDefaultAdmin("admin", "password");

?>
