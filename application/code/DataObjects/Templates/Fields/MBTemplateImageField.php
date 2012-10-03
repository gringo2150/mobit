<?php

class MBTemplateImageField extends MBTemplateField {

	public static $db = array(
		"NumImages" => "Int"
	);
	
	public static $defaults = array(
		"Type" => "Image"
	);

}

?>
