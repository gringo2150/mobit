<?php

class MBHandset extends DataObject {

	public static $db = array(
		"IMEI" => "Text",
		"PhoneNumber" => "Text",
		"OwnerFirstName" => "Text",
		"OwnerSurname" => "Text"
	);
	
	public static $has_one = array(
		"Company" => "MBCompany",
		"Group" => "MBGroup"
	);
	
	public static $has_many_many = array(
		"Templates" => "MBTemplate"
	);

}

?>
