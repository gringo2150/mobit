<?php

class CompanyPage extends Page {
	
	public static $db = array(
	);
	
	public static $has_one = array(
	);
	
	public static $has_many = array(
		"Companies" => "MBCompany"
	);
	
	function getCMSFields() {
		$fields = parent::getCMSFields();
		$fields->addFieldToTab("Root.Content.Companies", new DataObjectManager(
			$this,
			"Companies",
			"MBCompany",
			array("Name" => "Comapny Name", "Subscriptions" => "No. Subscriptions"),
			"getCMSFields_forPopup()"
		));
		return $fields;
	}
	
}

class CompanyPage_Controller extends Page_Controller {
	
	public function init() {
		parent::init();	
	}
	
}

?>
