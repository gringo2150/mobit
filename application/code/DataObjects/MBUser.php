<?php

class MBUser extends DataObjectDecorator {

	public static $db = array(
		"PhoneNumber" => "Text"
	);
	
	public static $has_one = array(
		//"Company" => "MBCompany"
	);
	
	public static $has_many = array(
		"Groups" => "MBGroup"
	);

}

?>
