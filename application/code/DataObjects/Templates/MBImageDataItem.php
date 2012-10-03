<?php

class MBImageDataItem extends DataObject {

	public static $db = array(	
	);
	
	public static $has_one = array(
	);
	
	public static $has_many = array(
		"Images" => "Image"
	);

}

?>