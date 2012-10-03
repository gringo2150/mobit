<?php

class MBTemplateField extends DataObject {

	public static $db = array(
		"Name" => "Text",
		"Type" => "Text"
	);
	
	public static $has_one = array(
		"Template" => "MBTemplate"
	);

}

?>
