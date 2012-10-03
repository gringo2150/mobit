<?php

class MBGroup extends DataObject {

	public static $db = array(
		"Name" => "Text"
	);
	
	public static $has_one = array(
		"Company" => "MBCompany"
	);
	
	public static $has_many = array(
		"Handsets" => "MBHandset",
		"Users" => "MBUser"
	);
	
	public static $has_many_many = array(
		"Templates" => "MBTemplate"
	);

}

?>
