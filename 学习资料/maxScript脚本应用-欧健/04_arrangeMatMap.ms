/*
--重整文件视图。
fn fn_resetView_str		\
	=					\
	(
		viewport.resetallviews()
		max tool zoomextents all
		max unfreeze all
		max unhide all
		clearSelection()
	)
fn_resetView_str()

*/

--清理无关材质和贴图。	
fn fn_clearMatMap_str	\
	=					\
	(
		local aryObjects = #()
		local aryUsedMat = #()
		--local aryTotalMat = meditMaterials
		
		aryObjects = for obj in geometry where(classof obj != BoneGeometry) collect obj
		aryUsedMat = for i in aryObjects where(i.material != undefined) collect i.material

		for i = 1 to aryUsedMat.count do
		(
			meditMaterials[i] = aryUsedMat[i]
		)
		for i = (aryUsedMat.count+1) to 24 do
		(
			meditMaterials[i] = standard()
			meditMaterials[i].name = "standard_"+(i as string)
		)
	)
fn_clearMatMap_str()	

