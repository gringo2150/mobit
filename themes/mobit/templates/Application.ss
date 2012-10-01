<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<% base_tag %>
<link rel="stylesheet" type="text/css" href="themes/mobit/javascript/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="themes/mobit/javascript/ext/ux/css/RowEditor.css" />
<link rel="stylesheet" type="text/css" href="themes/mobit/css/layout.css" />
<script src="http://maps.google.com/maps?file=api&v=3&sensor=false&key=ABQIAAAAQSJNeyBi9p6lq8uwmFeleBQzLJ3iRnjTxwm7tkNvM4yTdOuNXhQ_QliBOH4oK6tJe-LgTVjsJS1aig" type="text/javascript"></script>
<script type="text/javascript" src="http://www.openlayers.org/api/OpenLayers.js"></script>
<!--<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>-->
<script type="text/javascript" src="themes/mobit/javascript/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/ext/ext-all.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/ext/ux/statusbar/StatusBar.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/ext/ux/ux-all.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/ext/ux/jsonp.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/ext/ux/GoogleMapPanel.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/ext/ux/OpenMapPanel.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/jquery.js"></script>
<script>

// ---- extend Number object with methods for converting degrees/radians

/** Converts numeric degrees to radians */
if (typeof(Number.prototype.toRad) === "undefined") {
  Number.prototype.toRad = function() {
    return this * Math.PI / 180;
  }
}

/** Converts radians to numeric (signed) degrees */
if (typeof(Number.prototype.toDeg) === "undefined") {
  Number.prototype.toDeg = function() {
    return this * 180 / Math.PI;
  }
}

Ext.onReady(function(){
	Ext.BLANK_IMAGE_URL = 'http://sitsmail.servehttp.com/mobit_new/themes/mobit/javascript/ext/resources/images/default/s.gif';
	Ext.QuickTips.init();
    
    var mainMenu = new Ext.Toolbar({
		items : [
			'->',
			'Logged in as $CurrentMember.FirstName $CurrentMember.Surname',
			'-',
			{
				text: 'Preferances',
				icon: 'themes/mobit/images/leftMenu/preferances.png',
				handler: function(){
					preferancesWindow.show();
				}
			},
			{
				text: 'Logout',
				icon: 'themes/mobit/images/leftMenu/logout.png',
				handler: function() {
					Ext.MessageBox.confirm('Confirm', 'Are you sure you want to logout?', function(button){
						if (button == 'yes') {
							location.href = 'Security/logout';
						}
					});
				}
			}
		]
	});
	
	var homeNavigation = new Ext.Toolbar({
		flex: 2,
		layout: 'vbox',
		layoutConfig: {
			align : 'stretch',
			pack  : 'start'
		},
		defaults: {
			margins:'5 5 0 5',
			height: 30
		},
		items: [

		],
		hidden: false
	});
	
	var submittedNavigation = new Ext.Toolbar({
		flex: 2,
		layout: 'vbox',
		layoutConfig: {
			align : 'stretch',
			pack  : 'start'
		},
		defaults: {
			margins:'5 5 0 5',
			height: 30
		},
		items: [

		],
		hidden: true
	});
	
	var manageFormsNavigation = new Ext.Toolbar({
		flex: 2,
		layout: 'vbox',
		layoutConfig: {
			align : 'stretch',
			pack  : 'start'
		},
		defaults: {
			margins:'5 5 0 5',
			height: 30
		},
		items: [
			new Ext.Button({
				text: 'Add Form',
				cls: 'leftButton',
				icon: 'themes/mobit/images/leftMenu/forms/form_add.png',
				handler: function() {
					addFormWindow.show();
				}
			})
		],
		hidden: true
	});
	
	var reportsNavigation = new Ext.Toolbar({
		flex: 2,
		layout: 'vbox',
		layoutConfig: {
			align : 'stretch',
			pack  : 'start'
		},
		defaults: {
			margins:'5 5 0 5',
			height: 30
		},
		items: [

		],
		hidden: true
	});
	
	var mapsNavigation = new Ext.Toolbar({
		flex: 2,
		layout: 'vbox',
		layoutConfig: {
			align : 'stretch',
			pack  : 'start'
		},
		defaults: {
			margins:'5 5 0 5',
			height: 30
		},
		items: [

		],
		hidden: true
	});
	
	var companiesNavigation = new Ext.Toolbar({
		flex: 2,
		layout: 'vbox',
		layoutConfig: {
			align : 'stretch',
			pack  : 'start'
		},
		defaults: {
			margins:'5 5 0 5',
			height: 30
		},
		items: [
			new Ext.Button({
				text: 'Add Company',
				cls: 'leftButton',
				icon: 'themes/mobit/images/leftMenu/companies/company_add.png',
				handler: function() {
					addCompanyWindow.show();
				}
			})
		],
		hidden: true
	});
	
	var mainNavPanel = new Ext.Panel({
		title: 'Navigation',
		id: 'LeftNav',
		region:'west',
		margins: '5 0 5 5',
		width: 225,
		minSize: 150,
		maxSize: 225,
		layout:'vbox',
		layoutConfig: {
			align : 'stretch',
			pack  : 'start'
		},
		items: [
			homeNavigation,
			submittedNavigation,
			reportsNavigation,
			mapsNavigation,
			companiesNavigation,
			manageFormsNavigation,
			{	
				id: 'LeftNavBottom',
				border: false, 
				layoutConfig: {
					align: 'stretch',
					pack: 'end',
					width: '100%'
				},
				items: [
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Home',
						icon: 'themes/mobit/images/leftMenu/home.png',
						handler: function() {
							var items = Ext.getCmp('CenterPanel').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							var items = Ext.getCmp('LeftNav').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							Ext.getCmp('LeftNavBottom').show();
							homePanel.show();
							homeNavigation.show();
							main.doLayout();
						}
					}),
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Submitted Forms',
						icon: 'themes/mobit/images/leftMenu/submitted_forms.png',
						handler: function() {
							var items = Ext.getCmp('CenterPanel').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							var items = Ext.getCmp('LeftNav').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							Ext.getCmp('LeftNavBottom').show();
							submittedFormsPanel.show();
							submittedNavigation.show();
							main.doLayout();
						}
					}),
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Reports',
						icon: 'themes/mobit/images/leftMenu/reports.png',
						handler: function() {
							var items = Ext.getCmp('CenterPanel').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							var items = Ext.getCmp('LeftNav').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							Ext.getCmp('LeftNavBottom').show();
							reportsPanel.show();
							reportsNavigation.show();
							main.doLayout();
						}
					}),
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Maps',
						icon: 'themes/mobit/images/leftMenu/maps.png',
						handler: function() {
							var items = Ext.getCmp('CenterPanel').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							var items = Ext.getCmp('LeftNav').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							Ext.getCmp('LeftNavBottom').show();
							mapsPanel.show();
							mapsNavigation.show();
							var lat = 53.787783;
							var lon = -1.566160;
							var latOffset = 0.01;
							var lonOffset = 0.02;
							var path = [
								mapsPanel.makeGeomPoint(lat, lon - lonOffset),
								mapsPanel.makeGeomPoint(lat + latOffset, lon),
								mapsPanel.makeGeomPoint(lat, lon + lonOffset),
								mapsPanel.makeGeomPoint(lat - latOffset, lon),
								mapsPanel.makeGeomPoint(lat, lon - lonOffset)
							];
							mapsPanel.addPolygon(
								path, 
								'#00FF00', 
								3, 
								1, 
								'#0000FF', 
								0.1
							);
							mapsPanel.geoCodeLookup('UK M62');
							mapsPanel.getCenterLatLng()
							mapsPanel.addLine(mapsPanel.makeGeomPoint(53.787783, -1.566160), mapsPanel.makeGeomPoint(53.788864, -1.666180), '#FF0000', 1, 5);
							var t = mapsPanel.distanceBetweenPoints(mapsPanel.makePoint(53.787783, -1.566160), mapsPanel.makePoint(53.788864, -1.666180));
							console.log(mapsPanel.makePoint(53.787783, -1.566160).transform(mapsPanel.getMap().getProjectionObject(), new OpenLayers.Projection("EPSG:4326")));
							var p = mapsPanel.distanceToPoint(mapsPanel.makePoint(53.787783, -1.566160), 0, 0.5);
							mapsPanel.addRegPolygon(
								mapsPanel.makeGeomPoint(53.787783, -1.566160), 
								2, 
								50, 
								0, 
								'mile', 
								'#00FF00', 
								3, 
								1, 
								'#0000FF', 
								0.1
							);
							main.doLayout();
						}
					}),
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Manage Forms',
						icon: 'themes/mobit/images/leftMenu/manage_forms.png',
						handler: function() {
							var items = Ext.getCmp('CenterPanel').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							var items = Ext.getCmp('LeftNav').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							Ext.getCmp('LeftNavBottom').show();
							manageFormsPanel.show();
							manageFormsNavigation.show();
							main.doLayout();
						}
					}),
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Manage Handsets',
						icon: 'themes/mobit/images/leftMenu/manage_handsets.png',
						handler: function() {
							$.get('home/listCompanies',function(){
								alert('got data');
							});
						}
					}),
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Manage Companies',
						icon: 'themes/mobit/images/leftMenu/company.png',
						handler: function() {
							var items = Ext.getCmp('CenterPanel').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							var items = Ext.getCmp('LeftNav').items.items;
							for (var i=0; i<items.length; i++){
								items[i].hide();
							}
							Ext.getCmp('LeftNavBottom').show();
							companiesPanel.show();
							companiesNavigation.show();
							main.doLayout();
						}
					}),
					new Ext.Button({
						cls: 'x-toolbar',
						text: 'Administration',
						icon: 'themes/mobit/images/leftMenu/admin.png',
						handler: function() {
						}
					})
				]
			}
		]	
	});
    
    var homePanel = new Ext.Panel({
    	title: 'Home',
    	layout: 'fit',
		html: '<iframe src="http://www.simple-mobile-solutions.com" height="100%" width="100%" style="border: 0px;"></iframe>',
		hidden: false,
		height: '100%',
		width: '100%',
		flex: 1
    });
	
	var submittedStore = new Ext.data.JsonStore({
		autoLoad: true,
		idProperty: 'ID',
		root: 'rows',
		totalProperty: 'results',
		fields: [
			{name: 'ID', type: 'int'},
			'Name',
			'RegistrationNo',
			'VATNo',
			'Subscriptions',
			'CostPerLicense',
			{name: 'Address1', mapping: 'RegisteredAddress.Line1'}
		],
		proxy: new Ext.data.HttpProxy({
			url: 'home/listCompanies'
		})
	});
	
    var submittedFormsGrid = new Ext.grid.GridPanel({
    	store: submittedStore,
    	border: false,
    	height: '100%',
    	colModel: new Ext.grid.ColumnModel({
        	defaults: {
				width: 120,
				sortable: true
			},
			columns: [
				new Ext.grid.RowNumberer({width: 20}),
				{id: 'ID', header: 'ID', width: 20, dataIndex: 'ID', canSearch: true, incSearch: true},
				{header: 'Company Name', dataIndex: 'Name'},
				{header: 'Company Number', dataIndex: 'RegistrationNo'},
				{header: 'VAT Number', dataIndex: 'VATNo'},
				{header: 'Subscriptions', dataIndex: 'Subscriptions'},
				{header: 'Licence Fee', dataIndex: 'CostPerLicense'},
				{header: 'Addr 1', dataIndex: 'Address1'}
			],
    	}),
		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
		loadMask: true,
		//tbar: filterBar,
		bbar: new Ext.Toolbar({
			items: [
				'Testing',
				{
					text: 'A Button'	
				}
			]
		}),
		view: new Ext.ux.grid.BufferView({
			scrollDelay: false,
			forceFit: true
		})
    });
    
    var submittedFormsPanel = new Ext.Panel({
    	title: 'Submitted Forms',
    	layout: 'fit',
		hidden: true,
		height: '100%',
		width: '100%',
		//items: submittedFormsGrid,
		flex: 1
    });
	
	var manageFormsStore = new Ext.data.JsonStore({
		autoLoad: true,
		idProperty: 'ID',
		root: 'rows',
		totalProperty: 'results',
		fields: [
			{name: 'ID', type: 'int'},
			'Name',
			'Enabled',
			'EmailOnSubmit',
			'LogLocation',
			'RequireGroupingRef'
		],
		proxy: new Ext.data.HttpProxy({
			url: 'home/listForms'
		})
	});
	
    var manageFormsGrid = new Ext.grid.GridPanel({
    	store: manageFormsStore,
    	border: false,
    	height: '100%',
    	colModel: new Ext.grid.ColumnModel({
        	defaults: {
				width: 120,
				sortable: true
			},
			columns: [
				new Ext.grid.RowNumberer({width: 20}),
				{id: 'ID', header: 'ID', width: 20, dataIndex: 'ID', canSearch: true, incSearch: true},
				{header: 'Name', dataIndex: 'Name'},
				{header: 'Enabled', dataIndex: 'Enabled'},
				{header: 'Email On Submit', dataIndex: 'EmailOnSubmit'},
				{header: 'Log Location', dataIndex: 'LogLocation'},
				{header: 'Grouping Ref', dataIndex: 'RequireGroupingRef'}
			],
    	}),
		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
		loadMask: true,
		//tbar: filterBar,
		bbar: new Ext.Toolbar({
			items: [
				'Testing',
				{
					text: 'A Button'	
				}
			]
		}),
		view: new Ext.ux.grid.BufferView({
			scrollDelay: false,
			forceFit: true
		})
    });
	
	var manageFormsPanel = new Ext.Panel({
    	title: 'Manage Forms',
    	layout: 'fit',
		hidden: true,
		height: '100%',
		width: '100%',
		items: manageFormsGrid,
		flex: 1
    });
    
    var reportsPanel = new Ext.Panel({
    	title: 'Reports',
    	layout: 'fit',
		hidden: true,
		height: '100%',
		width: '100%',
		flex: 1
    });
    
    var companiesStore = new Ext.data.JsonStore({
		autoLoad: true,
		idProperty: 'ID',
		root: 'rows',
		totalProperty: 'results',
		fields: [
			{name: 'ID', type: 'int'},
			'Name',
			'RegistrationNo',
			'VATNo',
			'Subscriptions',
			'CostPerLicense',
			{name: 'Address1', mapping: 'RegisteredAddress.Line1'}
		],
		proxy: new Ext.data.HttpProxy({
			url: 'home/listCompanies'
		})
	});
	
    var companiesGrid = new Ext.grid.GridPanel({
    	store: companiesStore,
    	border: false,
    	height: '100%',
    	colModel: new Ext.grid.ColumnModel({
        	defaults: {
				width: 120,
				sortable: true
			},
			columns: [
				new Ext.grid.RowNumberer({width: 20}),
				{id: 'ID', header: 'ID', width: 20, dataIndex: 'ID', canSearch: true, incSearch: true},
				{header: 'Company Name', dataIndex: 'Name'},
				{header: 'Company Number', dataIndex: 'RegistrationNo'},
				{header: 'VAT Number', dataIndex: 'VATNo'},
				{header: 'Subscriptions', dataIndex: 'Subscriptions'},
				{header: 'Licence Fee', dataIndex: 'CostPerLicense'},
				{header: 'Addr 1', dataIndex: 'Address1'},
			]
    	}),
		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
		loadMask: true,
		//tbar: filterBar,
		bbar: new Ext.Toolbar({
			items: [
				'Testing',
				{
					text: 'A Button'	
				}
			]
		}),
		view: new Ext.ux.grid.BufferView({
			scrollDelay: false,
			forceFit: true
		})
    });
    
    var mapsPanel = new Ext.ux.OpenMapPanel({
    	title: 'Maps',
    	border: true,
    	zoomLevel: 6,
		gmapType: 'map',
		markers: [{
			lat: 53.787783,
			lng: -1.566160,
			setCenter: true,
			marker: {title: 'Simple Mobile Solutions'},
			listeners: {
				click: function(e){
					Ext.Msg.alert('Simple Mobile Solutions', 'The Simple Mobile Solutions Head Office');
				}
			}
		}],
		hidden: true,
		listeners: {
			click: function(e, point) {
				console.log(e);
				console.log(point);
			}
		}
    });
      
    var companiesPanel = new Ext.Panel({
    	title: 'Companies',
    	layout: 'fit',
		hidden: true,
		height: '100%',
		width: '100%',
		items: companiesGrid,
		flex: 1
    });
    
    var main = new Ext.Viewport({
		layout: 'border',
		items: [{
			xtype: 'panel',
			region:'center',
			margins: '0 0 0 0',
			layout:'border',
			defaults: {
				collapsible: false,
				split: true
			},
			items: [
				mainNavPanel,
				{
    				region: 'center',
    				margins: '5 5 5 0',
					id: 'CenterPanel',
    				layout: 'hbox',
    				layoutConfig: {
						align : 'stretch'
					},
    				border: false,
					items: [
						homePanel,
						submittedFormsPanel,
						reportsPanel,
						mapsPanel,
						companiesPanel,
						manageFormsPanel
					]
				}
			],
			bbar: mainMenu
		}]
	});
	
	/****** Windows *****/
	
	var preferancesWindow = new Ext.Window({
		title: 'Preferances',
		height: 480,
		width: 640,
		closeAction: 'hide'
	});
	
	var addCompanyWindow = new Ext.Window({
		title: 'Add Company',
		height: 500,
		width: 680,
		closeAction: 'hide',
		layout: 'fit',
		items: [new Ext.FormPanel({
     	   	labelWidth: 110, // label settings here cascade unless overridden
        	url:'home/addCompany',
        	id: 'addCompanyForm',
        	//frame:true,
        	border: false,
        	//title: 'Simple Form',
        	bodyStyle:'padding:5px 5px 0',
        	width: '100%',
        	height: '100%',
			layout: 'border',
			//layoutConfig: {
			//	align: 'streach',
			//},
        	items: [{
        		xtype: 'fieldset',
        		margins: '5 5 5 5',
				//lebelWidth: 130,
        		//flex: 1,
        		region: 'north',
        		title: 'Company Details',
        		//autoHeight: true,
        		defaults: {width: 230},
        		defaultType: 'textfield',
        		height: 180,
        		items:[{
        	        fieldLabel: 'Company Name',
        	        name: 'Name',
        	        allowBlank:false
        	    },{
        	        fieldLabel: 'Company Number',
        	        name: 'RegisteredNo'
        	    },{
        	        fieldLabel: 'VAT Number',
        	        name: 'VATNo'
        	    },{
        	        fieldLabel: 'Subscriptions',
        	        name: 'Subscriptions'
        	        //vtype:'number'
        	    },{
        	        fieldLabel: 'Cost Per Licence',
        	        name: 'CostPerLicense'
        	        //vtype:'currency'
        	    }]
			},{
        	    xtype: 'panel',
        	    margins: '0 5 0 5',
        	    region: 'center',
        	    height: '50%',
        	    border: false,
        	    layout: 'border',
        	    //height: '250',
        	    layoutConfig: {
        	    	align: 'stretch',
   					pack: 'start'
        	    },
        	    items: [{
        	    	xtype: 'fieldset',
        	    	width: '46%',
        	    	region: 'west',
        	    	margins: '0 5 0 0',
        	    	//columnWidth: .5,
        	    	title: 'Registered Address',
        	    	autoHeight:true,
        	    	flex: 1,
					defaultType: 'textfield',
					items: [{
        	       		fieldLabel: 'Address Line 1',
        	       		name: 'Address1Line1'
        	    	},{
        	     	 	fieldLabel: 'Address Line 1',
        	       	 	name: 'Address1Line2'
        	    	},{
					 	fieldLabel: 'City',
						name: 'Address1City'
					},{
						fieldLabel: 'Region',
						name: 'Address1Region'
					},{
						fieldLabel: 'Postcode',
						name: 'Address1PostCode'
        	    	}]
        	    },{
        	    	xtype: 'fieldset',
        	    	width: '49%',
        	    	region: 'center',
        	    	margins: '0 0 0 5',
        	    	title: 'Billing Address',
        	    	autoHeight:true,
        	    	flex: 2,
					defaultType: 'textfield',
					items: [{
        	        	fieldLabel: 'Address Line 1',
        	        	name: 'Address2Line1'
        	    	},{
        	        	fieldLabel: 'Address Line 2',
        	        	name: 'Address2Line2'
        	    	},{
        	        	fieldLabel: 'City',
        	        	name: 'Address2City'
        	    	},{
        	        	fieldLabel: 'Region',
        	        	name: 'Address2Region'
        	    	},{
        	        	fieldLabel: 'Postcode',
        	        	name: 'Address2PostCode'
        	    	}]
        	    }]
        	}],
        	buttons: [{
        	    text: 'Save',
        	    handler: function() {
        	    	Ext.getCmp('addCompanyForm').getForm().submit({
        	    		success: function(form, action) {
        	    			addCompanyWindow.hide();
       						Ext.Msg.alert('Success', 'A new company has been created');
       						companiesStore.load();
    					}
        	    	});
        	    }
        	},{
        	    text: 'Cancel',
        	    handler: function() {
        	    	addCompanyWindow.hide();
        	    }
        	}]
    	})]
	});
	
	var Field = Ext.data.Record.create([{
        name: 'name',
        type: 'string'
    }, {
        name: 'type',
        type: 'string'
    }, {
        name: 'meta',
        type: 'string'
    }]);
	
	var fieldstore = new Ext.data.Store({
        reader: new Ext.data.JsonReader({fields: Field})
    });
	
	/*var myNewData = {results: 0, rows: []};
	var example_store = new Ext.data.Store({
		autoLoad: true,
		reader: new Ext.data.JsonReader({
			//idProperty: 'id',
			root: 'rows',
			totalProperty: 'results',
			fields: [
				'fieldName',
				'fieldType',
				'meta'
			]
		}),
		proxy: new Ext.data.MemoryProxy(myNewData)
	});*/
	
	var editor = new Ext.ux.grid.RowEditor({
        saveText: 'Save'
    });
	
	/*var example_grid = new Ext.grid.GridPanel({
    	id: 'example_grid',
    	store: example_store,
    	height: 200,
    	width: '100%',
    	border: true,
		plugins: [editor],
    	colModel: new Ext.grid.ColumnModel({
        	defaults: {
				width: 120,
				sortable: true
			},
			columns: [
				new Ext.grid.RowNumberer({width: 20}),
				{header: 'Name', dataIndex: 'fieldName'},
				{header: 'Type', dataIndex: 'fieldType', editor: {xtype: 'textfield'}},
				{header: 'Meta', dataIndex: 'meta'}
			],
    	}),
		sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
		loadMask: true,
		viewConfig: {
			forceFit: true
		}
	});*/
	
	var fieldTypeCombo = new Ext.form.ComboBox({
		typeAhead: true,
		triggerAction: 'all',
		lazyRender:true,
		mode: 'local',
		store: new Ext.data.ArrayStore({
			id: 0,
			fields: [
				'myId',
				'displayText'
			],
			data: [
				['text', 'Text'],
				['number', 'Number'],
				['date', 'Date'],
				['checkbox', 'CheckBox'],
				['combo', 'ComboBox'],
				['image', 'Images']
			]
		}),
		valueField: 'myId',
		displayField: 'displayText'
	});
	
	fieldTypeCombo.on('select', function(combo, record, index){
		metaEditField.show();
		metaEditField.reset();
	}, fieldTypeCombo);
	
	var comboRenderer = function(combo){
		return function(value){
			var record = combo.findRecord(combo.valueField, value);
			return record ? record.get(combo.displayField) : combo.valueNotFoundText;
		}
	}
	
	var metaEditField = new Ext.form.TextField({emptyText: ''});
	metaEditField.on('beforeShow', function(metaEditField){
		if (fieldTypeCombo.getValue() == 'image') {
			metaEditField.enable();
			metaEditField.emptyText = 'number of images';
		} else if (fieldTypeCombo.getValue() == 'combo') {
			metaEditField.enable();
			metaEditField.emptyText = 'options, comma separated';
		} else {
			metaEditField.disable();
			metaEditField.emptyText = '';
		}
		var r = fieldgrid.getSelectionModel().getSelections();
		if (r[0].get('meta') == '') metaEditField.reset();
		return true;
	}, metaEditField);
	
	var fieldgrid = new Ext.grid.GridPanel({
        store: fieldstore,
		height: 200,
		//layout: 'fit',
        margins: '5 0 0 0',
        plugins: [editor],
        tbar: [{
            iconCls: 'addfield-icon',
            text: 'Add Field',
            handler: function(){
                var e = new Field({
                    name: 'New Field',
                    type: 'text',
                    meta: ''
                });
                editor.stopEditing();
                fieldstore.insert(fieldstore.getCount(), e);
                fieldgrid.getView().refresh();
                fieldgrid.getSelectionModel().selectRow(fieldstore.getCount() - 1);
                editor.startEditing(fieldstore.getCount() - 1);
				//metaEditField.hide();
            }
        },{
            ref: '../removeBtn',
            iconCls: 'removefield-icon',
            text: 'Remove Field',
            disabled: true,
            handler: function(){
                editor.stopEditing();
                var s = fieldgrid.getSelectionModel().getSelections();
                fieldstore.remove(s);
				fieldgrid.getView().refresh();
            }
        }],

        columns: [
        new Ext.grid.RowNumberer(),
        {
            id: 'name',
            header: 'Field Name',
            dataIndex: 'name',
            width: 120,
            sortable: true,
            editor: {
                xtype: 'textfield',
                allowBlank: false
            }
        },{
            header: 'Field Type',
            dataIndex: 'type',
            width: 120,
            sortable: true,
            editor: fieldTypeCombo,
			renderer: comboRenderer(fieldTypeCombo)
        },{
            header: 'Meta Data',
            dataIndex: 'meta',
            width: 120,
            sortable: true,
            editor: metaEditField
        }],
		loadMask: true,
		viewConfig: {
			markDirty: false,
			forceFit: true
		}
    });
	
	fieldgrid.getSelectionModel().on('selectionchange', function(sm){
        fieldgrid.removeBtn.setDisabled(sm.getCount() < 1);
    });
	
	var compileFormSubmission = function(){
		var num = 0;
		var submit_params = new Object();
		submit_params.data = "test";
		fieldstore.each(function(r){
			num ++;
			submit_params["fieldName_" + num] = r.get('name');
			submit_params["fieldType_" + num] = r.get('type');
			submit_params["fieldMeta_" + num] = r.get('meta');
		});
		submit_params.numFields = num;
		return submit_params;
	}
	
	var addFormWindow = new Ext.Window({
		title: 'Add Form',
		height: 400,
		width: 680,
		closeAction: 'hide',
		//layout: 'fit',
        /*layoutConfig: {
            columns: 1
        },*/
		bodyStyle: "padding: 5px",
		border: false,
		items: [new Ext.FormPanel({
     	   	labelWidth: 180, // label settings here cascade unless overridden
        	url:'home/addForm',
        	id: 'addFormForm',
			//region: 'center',
			frame: true,
        	border: false,
        	bodyStyle:'padding:5px 5px 0',
			margins: '5 5 5 5',
			layoutConfig: {
				align: 'stretch',
				pack: 'start'
			},
        	items:[{
				xtype: 'fieldset',
				title: 'Form Details',
				border: true,
				defaults: {width: 230},
				layoutConfig: {
					align: 'stretch'
				},
				defaultType: 'checkbox',
				labelWidth: 80,
				items:[{
					xtype: 'textfield',
					fieldLabel: 'Form Name',
					name: 'Name',
					allowBlank:false,
				},{
					xtype: 'checkboxgroup',
					fieldLabel: 'Options',
					width: 500,
					items:[{
						boxLabel: 'Use Grouping Reference?',
						name: 'RequireGroupingRef',
					},{
						boxLabel: 'Email On Submission?',
						name: 'EmailOnSubmit',
					},{
						boxLabel: 'Log Location?',
						name: 'LogLocation',
						checked: true
					}]
        	    }]
			}/*,{
				xtype: 'fieldset',
				title: 'Fields',
				labelAlign: 'top',
				layout:'column',
				items:[{
					columnWidth:.33,
					layout: 'form',
					items: [{
						xtype:'textfield',
						fieldLabel: 'Field Name',
						id: 'IDName',
						name: 'Name',
						anchor:'-5'
					}]
				},{
					columnWidth:.33,
					layout: 'form',
					items: [{
						xtype:'textfield',
						fieldLabel: 'Type',
						id: 'IDType',
						name: 'Type',
						anchor:'-5'
					}]
				},{
					columnWidth:.33,
					layout: 'form',
					items: [{
						xtype:'textfield',
						fieldLabel: 'MetaData',
						id: 'IDMeta',
						name: 'Meta',
						anchor:'100%',
						hidden: true
					},{
						xtype: 'button',
						text: 'Add',
						handler: function() {
							var fieldName = Ext.getCmp('addFormForm').form.findField('IDName').getValue();
							var fieldType = Ext.getCmp('addFormForm').form.findField('IDType').getValue();
							var fieldMeta = Ext.getCmp('addFormForm').form.findField('IDMeta').getValue();
							var grid = Ext.getCmp('example_grid');
							var mask = grid.loadMask;
							var store = grid.getStore();
							mask.show();
							myNewData.rows.push({fieldName: fieldName, fieldType: fieldType, meta: fieldMeta});
							console.log(myNewData);
							store.proxy = new Ext.data.MemoryProxy(myNewData);
							store.load();
							mask.hide();							
						}
					}]
                }]
            }*/],
    	}),
			fieldgrid
		],
		buttons: [{
			text: 'Save',
			handler: function() {
				var subparams = compileFormSubmission();
				Ext.getCmp('addFormForm').getForm().submit({
					params: subparams,
					url: 'home/addForm',
					success: function(form, action) {
						addFormWindow.hide();
						fieldstore.removeAll();
						fieldgrid.getView().refresh();
						Ext.Msg.alert('Success', 'A new form has been created');
					}
				});
			}
		},{
			text: 'Cancel',
			handler: function() {
				addFormWindow.hide();
				fieldstore.removeAll();
				fieldgrid.getView().refresh();
			}
		}]
	});
	
});

</script>
</head>
<body style="height: 100%; width: 100%;">
</body>
</html>
