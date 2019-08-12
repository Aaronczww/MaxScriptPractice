function fn_createCube =
(
	local i_cube = box width:30 height:30 length:30 lengthsegs:3 widthsegs:3 heightsegs:3 name:"Cube"

	convertTo i_cube Editable_Poly
	for n in 1 to (polyop.getNumFaces i_cube) do
	(
		polyop.setFaceSelection i_cube n
		i_cube.bevelFaces 0.5 -0.5
	)
	for n in 1 to (polyop.getNumFaces i_cube) do
	(
		local i_pos = polyop.getFaceCenter i_cube n
		
		polyop.setFaceSelection i_cube n
		i_cube.EditablePoly.setMaterialIndex 7 1
		if i_pos.x > 15.4 do (i_cube.EditablePoly.setMaterialIndex 1 1)
		if i_pos.x < -15.4 do (i_cube.EditablePoly.setMaterialIndex 2 1)
		if i_pos.y > 15.4 do (i_cube.EditablePoly.setMaterialIndex 3 1)
		if i_pos.y < -15.4 do (i_cube.EditablePoly.setMaterialIndex 4 1)
		if i_pos.z > 30 do (i_cube.EditablePoly.setMaterialIndex 5 1)
		if i_pos.z < 0 do (i_cube.EditablePoly.setMaterialIndex 6 1)
	)
)

fn_createCube()