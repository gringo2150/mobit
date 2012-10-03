<?php

class MBDataItem extends DataObject {

	public static $db = array(
		"Value" => "Text"		
	);
	
	public static $has_one = array(
		"SubmittedReport" => "MBSubmittedReport",
		"TemplateField" => "MBTemplateField"
	);
	
	public static $has_many = array(
		
	);

}

?>