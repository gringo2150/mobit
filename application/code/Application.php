<?php

class Application extends Page {
	
	public static $db = array(
	);
	
	public static $has_one = array(
	);
	
}

class Application_Controller extends Page_Controller {
	
	public function init() {
		parent::init();

		// Note: you should use SS template require tags inside your templates
		// instead of putting Requirements calls here.  However these are
		// included so that our older themes still work
		Requirements::themedCSS("layout"); 
		//Requirements::themedCSS("typography"); 
		//Requirements::themedCSS("form"); 
	}
		
	/**
	 * Author: David Sloane
	 *
	 * Creates a new company record on the system
	 */
	 
	function addCompany(){
		$data = $_POST;
		$company = new MBCompany();
		
		// store registered address.
		$radd = new MBAddress();
		$radd->Line1 = isset($data['Address1Line1']) ? $data['Address1Line1'] : "";
		$radd->Line2 = isset($data['Address1Line2']) ? $data['Address1Line2'] : "";
		$radd->City = isset($data['Address1City']) ? $data['Address1City'] : "";
		$radd->Region = isset($data['Address1Region']) ? $data['Address1Region'] : "";
		$radd->PostCode = isset($data['Address1PostCode']) ? $data['Address1PostCode'] : "";
		$radd->write();
		$company->RegisteredAddressID = $radd->ID;
		
		// store billing address.
		$badd = new MBAddress();
		$badd->Line1 = isset($data['Address2Line1']) ? $data['Address2Line1'] : "";
		$badd->Line2 = isset($data['Address2Line2']) ? $data['Address2Line2'] : "";
		$badd->City = isset($data['Address2City']) ? $data['Address2City'] : "";
		$badd->Region = isset($data['Address2Region']) ? $data['Address2Region'] : "";
		$badd->PostCode = isset($data['Address2PostCode']) ? $data['Address2PostCode'] : "";
		$badd->write();
		$company->BillingAddressID = $badd->ID;
		
		// store rest of data.
		$company->Name = isset($data['Name']) ? $data['Name'] : "";
		$company->RegisteredNo = isset($data['RegisteredNo']) ? $data['RegisteredNo'] : "";
		$company->VATNo = isset($data['VATNo']) ? $data['VATNo'] : "";
		$company->Subscriptions = isset($data['Subscriptions']) ? $data['Subscriptions'] : "";
		$company->CostPerLicense = isset($data['CostPerLicense']) ? $data['CostPerLicense'] : "";
		$company->write();
		
		if (Director::is_ajax()) {
			return '{"success":true}';
		} else {
			// some non ajax confirmation here...
		}
	}
	
	function listCompanies() {
		$companies = DataObject::get("MBCompany");
		$f = new JSONDataFormatter(); 
		$json = '{"results":"0"}';
		if ($companies) {
			$json = '{"results":"' . $companies->Count() . '", "rows":[';
			foreach ($companies as $c) {
				$json .= $f->convertDataObject($c) . ',';
			}
			$json = substr($json, 0, -1);
			$json .= ']}';
		}
		if (Director::is_ajax()) {
			return $json;
		} else {
			// some non ajax confirmation here...
		}
	}
	
	function addForm() {
		$data = $_POST;
		$template = new MBTemplate();
		
		$template->Name = isset($data['Name']) ? $data['Name'] : "";
		$template->Enabled = true;
		$template->EmailOnSubmit = isset($data['EmailOnSubmit']) ? true : false;
		$template->LogLocation = isset($data['LogLocation']) ? true : false;
		$template->RequireGroupingRef = isset($data['RequireGroupingRef']) ? true : false;
		$template->write();
		
		// fields...
		$num = isset($data['numFields']) ? (int)$data['numFields'] : 0;
		for ($i = 0; $i < $num; $i++) {
			$name = $data["fieldName_" . ($i+1)];
			$type = $data["fieldType_" . ($i+1)];
			$meta = isset($data["fieldMeta_" . ($i+1)]) ? $data["fieldMeta_" . ($i+1)] : "";
			
			switch($type){
				case 'text':
					$field = new MBTemplateTextField();
					break;
				case 'number':
					$field = new MBTemplateNumberField();
					break;
				case 'date':
					$field = new MBTemplateDateField();
					break;
				case 'checkbox':
					$field = new MBTemplateCheckBoxField();
					break;
				case 'combo':
					$field = new MBTemplateComboField();
					$field->write();
					$options = explode(",", $meta);
					foreach($options as $o){
						$co = new MBComboOption();
						$co->Name = $o;
						$co->Value = $o;
						$co->TemplateComboFieldID = $field->ID;
						$co->write();
					}
					break;
				case 'image':
					$field = new MBTemplateImageField();
					$field->NumImages = (int)$meta;
					break;
			}
			$field->Name = $name;
			$field->TemplateID = $template->ID;
			$field->write();
		}
		
		if (Director::is_ajax()) {
			return '{"success":true}';
		} else {
			// some non ajax confirmation here...
		}
	}
	
	function listForms() {
		$forms = DataObject::get("MBTemplate");
		$f = new JSONDataFormatter(); 
		$json = '{"results":"0"}';
		if ($forms) {
			$json = $f->convertDataObjectSet($forms);
		}
		if (Director::is_ajax()) {
			return $json;
		} else {
			// some non ajax confirmation here...
			return $json;
		}
	}
	
}

?>
