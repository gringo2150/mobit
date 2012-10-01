<?php

class MBSubmittedReport extends DataObject {

	public static $db = array(
		"JobCode" => "Text",
		"ReportGroupName" => "Text",
		"Longitude" => "Float",
		"Latitude" => "Float",
		"OSCoordinate" => "Text",
		"Northing" => "Int",
		"Easting" => "Int"
	);
	
	public static $has_one = array(
		"Company" => "MBCompany",
		"Handset" => "MBHandset",
		"Template" => "MBTemplate"
	);
	
	public static $has_many = array(
		"DataItems" => "MBDataItem"	
	);

}

?>