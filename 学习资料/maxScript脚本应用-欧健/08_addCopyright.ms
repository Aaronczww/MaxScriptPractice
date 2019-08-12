/*
	sld_copyright = sliderManipulator()
	sld_copyright.xpos = 0.5
	sld_copyright.ypos = 1.0
	sld_copyright.hide = true
	sld_copyright.sldName = "添加一个文件说明信息"
*/

destroydialog rol_addCopyright

rollout rol_addCopyright "附加信息" width:160 height:56
(
	button btn_add "添加" pos:[16,32] width:56 height:16
	button btn_del "清空" pos:[88,32] width:56 height:16
	editText edt_addInfo "" pos:[8,8] width:144 height:16
	
	local i_name = "Copyright &copy; 2010 KingSoft. All rights reserved. "
	local i_current = LayerManager.current
	local i_layer = LayerManager.newlayerFromName "附加信息_addByScript"
	local i_ary = #()
	local sld_copyright
	
	on btn_add pressed do
	(
		if(i_layer == undefined) do
		(i_layer = LayerManager.getlayerFromName "附加信息_addByScript")
		
		i_layer.current = true
		sld_copyright = sliderManipulator()
		sld_copyright.ypos = 1.0
		sld_copyright.hide = true
		
		if(edt_addInfo.text == "") then
		(
			sld_copyright.xpos = 0.25
			sld_copyright.sldName = i_name
		)
		else
		(
			sld_copyright.xpos = 0.5
			sld_copyright.sldName = edt_addInfo.text
		)
		
		i_current.current = true
	)
	
	on btn_del pressed do
	(
		if(i_layer == undefined) do
		(i_layer = LayerManager.getlayerFromName "附加信息_addByScript")
		
		i_ary = #()
		i_layer.nodes &i_ary
	
		for i = 1 to i_ary.count do
		(delete i_ary[i])	
	)
)
createdialog rol_addCopyright

/*
几种格式：
&copy;1995-2004 Macromedia, Inc. All rights reserved.
&copy;2004 Microsoft Corporation. All rights reserved.
Copyright &copy; 2004 Adobe Systems Incorporated. All rights reserved.
&copy;1995-2004 Eric A. and Kathryn S. Meyer. All Rights Reserved.
*/
