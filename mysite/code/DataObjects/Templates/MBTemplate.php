<?php

class MBTemplate extends DataObject {

	public static $db = array(
		"Name" => "Text",
		"Enabled" => "Boolean",
		"EmailOnSubmit" => "Boolean",
		"LogLocation" => "Boolean",
		"RequireGroupingRef" => "Boolean"
	);
	
	public static $has_one = array(
		"Company" => "MBCompany"
	);
	
	public static $has_many = array(
		"SubmittedReports" => "MBSubmittedReport",
		"Fields" => "MBTemplateField"
	);
	
	public static $has_many_many = array(
		"Groups" => "MBGroup",
		"Handsets" => "MBHandset"
	);

}

?>
