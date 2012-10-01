<?php

class MBCompany extends DataObject {

	public static $db = array(
		"Name" => "Text",
		"RegisteredNo" => "Text",
		"VATNo" => "Text",
		"Subscriptions" => "Int",
		"CostPerLicense" => "Float"
	);
	
	public static $has_one = array(
		"RegisteredAddress" => "MBAddress",
		"BillingAddress" => "MBAddress"
	);
	
	public static $has_many = array(
		"Handsets" => "MBHandset",
		//"Users" => "MBUser",
		"Groups" => "MBGroup",
		"Templates" => "MBTemplate"
	);
	
	function getCMSFields_forPopup() {
		return new FieldSet(
			new TextField("Name", "Company Name:"),
			new TextField("RegisteredNo", "Registered Company Number:"),
			new TextField("VATNo", "VAT Number:"),
			new TextField("Subscriptions", "Number of Subscriptions"),
			new TextField("CostPerLicense", "Unit cost (£) per license:")
		);
	}

}

?>
