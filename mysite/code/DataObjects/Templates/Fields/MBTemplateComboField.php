<?php

class MBTemplateComboField extends MBTemplateField {

	public static $has_many = array(
		"Options" => "MBComboOption"
	);
	
	public static $defaults = array(
		"Type" => "Combo"
	);

}

?>
