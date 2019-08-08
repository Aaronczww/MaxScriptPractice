
/*
FileName：		场景模型检查工具.ms
Creator：		何金权
Date：			2019-08-5 10:07
Comment：		检查场景物件规范。
KnownBugs：		
FixLogs：		
*/
macroScript rol_ModelCheck 
category:"_XSJART_TOOL" 
buttonText:"模型检查" 
toolTip:" [MaxScrpit入门]模型检查"
(
    try (destroyDialog rol_ToolName) 
    catch(print("生成宏"))
    rollout rol_buttons "[MaxScript入门]模型检查" width:227 height:600
    (
        label 'label' "角色模型检查" pos:[80,4] width:81 height:20 align:#left
    	label 'lbl3' "Label" pos:[117,83] width:0 height:0 align:#left
    	button 'btn1' "Button" pos:[124,107] width:20 height:0 align:#left
    	button 'setUnitBtn' "单位统一" pos:[15,38] width:89 height:28 align:#left
    	button 'setMatIDBtn' "材质ID设置" pos:[14,83] width:89 height:28 align:#left
    	button 'setSmoothIDBtn' "光滑组id设置" pos:[14,123] width:89 height:28 align:#left
    	button 'btn7' "Button" pos:[142,46] width:0 height:0 align:#left
    	button 'btn8' "Button" pos:[152,56] width:0 height:0 align:#left
    	button 'resetXformBtn' "ResetXform,塌陷" pos:[121,38] width:94 height:28 type:#integer align:#left 
 
    	spinner 'matIDBox' "" pos:[153,93] width:41 height:16 range:[1,100,1] type:#integer align:#left
    	label 'lbl7' "setID:" pos:[121,93] width:33 height:17 align:#left
    	button 'btn10' "Button" pos:[122,147] width:20 height:0 align:#left
    	spinner 'smoothIDBox' "" pos:[153,133] width:41 height:16 range:[1,100,1] type:#integer align:#left
    	label 'lbl8' "setID:" pos:[121,133] width:33 height:17 align:#left
    	button 'weldVertBtn' "焊接顶点" pos:[14,161] width:89 height:28 align:#left
    	button 'btn13' "Button" pos:[120,189] width:20 height:0 align:#left
    	spinner 'thresholdBox' "" pos:[171,173] width:41 height:16 range:[0,1000,0] align:#left
    	label 'lbl9' "Threshold" pos:[121,173] width:49 height:17 align:#left
    	button 'clearVertBtn' "清除孤立顶点" pos:[13,200] width:190 height:20 align:#left
    	button 'AttachBtn' "Attach所选物体" pos:[14,260] width:190 height:20 align:#left
    	button 'clearBtn' "清除" pos:[46,375] width:156 height:16 align:#left
    	checkbox 'postionSpinner' "位置" pos:[104,295] width:39 height:16 align:#left
    	checkbox 'rotationSpinner' "旋转" pos:[144,295] width:39 height:16 align:#left
    	checkbox 'scaleSpinner' "缩放" pos:[185,295] width:39 height:16 align:#left
    	button 'checkBtn' "一键设置所有选项" pos:[16,322] width:200 height:22 align:#left
    	checkbox 'selectionSpinner' "选中物体" pos:[14,353] width:69 height:15 align:#left
    	checkbox 'allObjectsSpinner' "所有物体" pos:[121,353] width:69 height:15 align:#left
    	edittext 'output' "" pos:[14,400] width:194 height:181 align:#left
    	label 'lbl35' "输出:" pos:[14,376] width:31 height:19 align:#left
    	button 'clearMatBtn' "清除无关材质,设置opacitymap" pos:[13,230] width:190 height:20 align:#left
    	button 'transformSetBtn' "transform归零" pos:[15,290] width:84 height:23 align:#left

        local sceneObjects = #()
        
        --是否是几何体
        fn fn_checkGeometry_bool g =
		(
			if(superclassof g == GeometryClass) And (ClassOf g !=Targetobject) then
			(return true)
			else
			(return false)
        )
        
        fn fn_setUnit = 
        (
            units.MetricType  = #Centimeters 
            units.SystemType = #inches
            Output.text = Output.text + "设置单位成功\n"
        )
  
        
        fn fn_checkMatId Idnumber= 
        (
            try 
            (
                m_number = Idnumber as string
                for obj in sceneObjects  do
                    (
                        if(fn_checkGeometry_bool obj) then
                        (
                            ConvertToPoly obj
                            for i = 1 to polyOp.getNumFaces obj do
                            (
                                    if (polyOp.getFaceMatID obj i) > 1 then
                                    (
                                            polyOp.setFaceMatID obj i Idnumber
                                    )
                            )
                            Output.text = Output.text + obj.name + "设置材质ID为"+ m_number +"\n"
                        )
                    )
            ) 
            catch 
            (
                Output.text = Output.text + "设置材质ID失败"
            )
        )

        fn fn_checkSmoothGroup Idnumber=
        (
            try 
            (
                m_number = Idnumber as string
                for obj in sceneObjects where(fn_checkGeometry_bool obj) do
                (
                        ConvertToPoly obj
                        print(polyop.getNumFaces obj)
                        for i = 1 to polyop.getNumFaces obj do
                            (
                                if (polyOp.getFaceSmoothGroup obj i) > 1 then
                                    (
                                        polyop.setFaceSmoothGroup obj i Idnumber
                                    )
                            )
                        Output.text = Output.text + obj.name +"设置光滑组ID为"+ m_number +"\n"
                )
            )
            catch 
            (
                Output.text = Output.text + "设置光滑组ID失败"
            )
		)
        
        fn fn_removeRubbsihVert =
        (
            try
            (
                for obj in sceneObjects where(fn_checkGeometry_bool obj) do
                    (
                        convertToPoly obj
                        polyOp.deleteIsoVerts obj
                        Output.text = Output.text + "删除" + obj.name + "的孤立点\n"
                    )
            ) 
            catch 
            (
                Output.text = Output.text + "移除孤立点失败!"
            )
        )

        fn fn_RemoveNonMat = 
        (
            try 
            (
                for i=1 to MeditMaterials.count do
                    (
                        local count = 0
                        for j=1 to SceneMaterials.count do
                        (
                            if(SceneMaterials[j] != MeditMaterials[i]) then
                            (
                                    count = count + 1
                            )
                        )
                        if count == SceneMaterials.count then
                        (
                            MeditMaterials[i] = Standard()
                        )
                    )
                    Output.text = Output.text + "移除场景中的多余材质\n"
            ) 
            catch 
            (
                Output.text = Output.text + "移除场景中的多余材质失败!\n"
            )
        )

        fn fn_removeNonMatAndRestOpacity =
        (
            try 
            (
                for sceneMat in SceneMaterials do
                    (
                        if(sceneMat.opacityMap != undefined) then
                        (
                            sceneMat.opacityMap = sceneMat.diffuseMap
                        )
                    )
                    Output.text = Output.text + "重置场景的opacityMap\n" 
                    fn_RemoveNonMat()
            ) 
            catch 
            (
                Output.text = Output.text + "重置场景的opacityMap失败!\n" 
            )
        )

		fn fn_resetXForm =
		(
            try 
            (
                for obj in sceneObjects where(fn_checkGeometry_bool obj) do
                    (
                        convertToPoly obj
                        ResetXForm obj
                        convertToPoly obj
                        Output.text = Output.text + obj.name + " ResetXform,convertTopoly\n"
                    )
            ) 
            catch 
            (
                Output.text = Output.text + "ResetXform失败!"
            )
        )

        fn fn_weldVert Threshold =
        (
            try 
            (
                for obj in sceneObjects where(fn_checkGeometry_bool obj) do
                    (
                        convertToPoly obj
                        obj.WeldThreshold = Threshold
						mresult = polyop.weldVertsByThreshold obj (polyOp.getVertSelection obj)
                    )
                    Output.text = Output.text + "焊接顶点成功" + "\n" 
            ) 
            catch 
            (
               Output.text = Output.text + "焊接顶点失败!" + "\n" 
            )
        )

        fn fn_resetTransform =
        (
            try 
            (
                for obj in sceneObjects where(fn_checkGeometry_bool obj) do
                    (
                        if(postionSpinner.state) then
                        (
                            obj.position = [0,0,0]
                            Output.text = Output.text + obj.name + "重置位置" + "\n"          
                        )
                        if(scaleSpinner.state) then
                        (
                            obj.scale=[1,1,1]
                            Output.text = Output.text + obj.name + "重置缩放" + "\n"          
                        )
                        if(rotationSpinner.state) then
                        (
                            local m_rotation = quat 0 0 0 0 
                            obj.rotation = m_rotation
                            Output.text = Output.text + obj.name + "重置旋转" + "\n"          
                        ) 
                    )
            ) 
            catch 
            (
                Output.text = Output.text + "transform归零失败！"        
            )
        )

        fn fn_checkSelect_bool =
        (
            if(allObjectsSpinner.state) then
            (
                sceneObjects = objects
                return true
            )
            else if(selectionSpinner.state) then
            (
                sceneObjects = selection

                if(sceneObjects.count == 0) then
                (
                    Output.text = Output.text + "未选择物体！"        
                    return false
                )
                return true
            )
            else
            (
                Output.text = Output.text + "请设置物体选择模式！"        
                return false
            )
        )

        fn fn_attachObj =
        (
            try 
            (
                sceneObjects = selection 
                if(sceneObjects.count < 2) then
                (
                    Output.text = Output.text + "请选择附加物体!\n"
                )
                else
                (
                    for obj in sceneObjects where(fn_checkGeometry_bool obj) do
                    (
                        convertToPoly obj
                    )
                    for i=1 to sceneObjects.count do
                    (
                        if(fn_checkGeometry_bool sceneObjects[i]) and i < sceneObjects.count then
                        (
                            polyOp.attach sceneObjects[i+1] sceneObjects[i]
                        )
                    )
                    local matAry = sceneObjects[sceneObjects.count].material
                    for j=1 to matAry.count do
                    (
                        for k=(j+1) to matAry.count do
                        (
                            if(matAry[j] != undefined and matAry[k] != undefined) then
                            (
                                if(matAry[j].name == matAry[k].name) then
                                (
                                    matAry[k] = undefined
                                )
                            )
                        )
                    )
                Output.text = Output.text + "附加选择物体!\n"
                )
            ) 
            catch 
            (
                Output.text = Output.text + "附加物体失败!\n"
            )
        )

        fn fn_clearOutput =
        (
            Output.text = ""
        )

        on AttachBtn pressed do
        (
            fn_attachObj()
        )

        on clearBtn pressed do
        (
            fn_clearOutput()
        )

    	on setUnitBtn pressed do
    	(
    	    fn_setUnit()
    	)
    	on setMatIDBtn pressed do
    	(
    	    if(fn_checkSelect_bool()) then
    	    (
    	        fn_checkMatId matIDBox.value
    	    )
    	)
    	on setSmoothIDBtn pressed do
    	(
    	    if(fn_checkSelect_bool()) then
    	    (
    	        fn_checkSmoothGroup smoothIDBox.value
    	    )
    	)
    	on resetXformBtn pressed do
    	(
    	    if(fn_checkSelect_bool()) then
    	    (
    	        fn_resetXForm()
    	    )
    	
    	)
    	on weldVertBtn pressed do
    	(
    	    if(fn_checkSelect_bool()) then
    	    (
    	        fn_weldVert thresholdBox.value
    	    )
    	)
    	on clearVertBtn pressed do
    	(
    	    if(fn_checkSelect_bool()) then
    	    (
    	        fn_removeRubbsihVert()
    	    )
    	)
    	on clearMatBtn pressed do
    	(
    	    fn_removeNonMatAndRestOpacity()
        )
        
    	on transformSetBtn pressed do
    	(
    	    if(fn_checkSelect_bool()) then
    	    (
    	        fn_resetTransform()
    	    )
    	)
    	on checkBtn pressed do
    	(
    	    if(fn_checkSelect_bool()) then
    	    (
    	        fn_setUnit()
    	
    	        fn_checkSmoothGroup smoothIDBox.value
    	
    	        fn_checkMatId matIDBox.value
    	
    		    fn_resetTransform()
                
                fn_resetXForm()

    	        fn_removeRubbsihVert()
    	
    	        fn_removeNonMatAndRestOpacity()
	
                Output.text = Output.text + "设置成功!\n"
    	    ) 
        )
        
        on selectionSpinner changed theState do
        (
            allObjectsSpinner.state = false
        )
        on allObjectsSpinner changed theState do
        (
            selectionSpinner.state = false
        )
    )
    on isChecked do rol_buttons.open
    on execute do  createDialog rol_buttons
    on closeDialogs do destroyDialog rol_buttons
)

