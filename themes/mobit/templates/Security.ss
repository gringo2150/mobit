<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
<head>
<% base_tag %>
<link rel="stylesheet" type="text/css" href="themes/mobit/javascript/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="themes/mobit/css/layout.css" />
<% require themedCSS(security) %> 
<script type="text/javascript" src="themes/mobit/javascript/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/ext/ext-all.js"></script>
<script type="text/javascript" src="themes/mobit/javascript/jquery.js"></script>
<script>
Ext.onReady(function(){
	var mainWidth = jQuery(window).width();
	var mainHeight = jQuery(window).height();
	mainWidth = (mainWidth -300) / 2;
	mainHeight = (mainHeight -260) / 2;
	var main = new Ext.Viewport({
		renderTo: Ext.getBody(),
		layout: 'absolute',
		items: [{
			xtype: 'panel',
			title: 'Login',
			contentEl: 'Container',
			width: 300,
			pageY: mainHeight,
			pageX: mainWidth,
			collapsible: false,
			frame: true,
			iconCls: 'login-icon'
		}]
	});
	jQuery('#Container').show();
});
</script>
</head>
<body>
	<div id="Container" style="display: none;">
		$Content
		$Form
	</div>
</body>
</html>
