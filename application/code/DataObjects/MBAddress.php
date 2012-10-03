<?php

class MBAddress extends DataObject {

	public static $db = array(
		"Line1" => "Text",
		"Line2" => "Text",
		"City" => "Text",
		"Region" => "Text",
		"PostCode" => "Text"
	);

}

?>
