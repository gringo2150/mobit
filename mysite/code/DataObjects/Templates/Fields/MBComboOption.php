<?php

class MBComboOption extends DataObject {

	public static $db = array(
		"Name" => "Text",
		"Value" => "Text"
	);
	
	public static $has_one = array(
		"TemplateComboField" => "MBTemplateComboField"
	);

}

?>
