plugin simpleObject Cube_plugin
name:"Cube"
classID:#(145345,543211)
category:"Standard Primitives"
(
	local i_cube,i_box
	
	parameters main rollout:params
	(
		edge_size 	type:#worldUnits 	ui:edge_size 	default:0
		depth 		type:#worldUnits 	ui:depth 		default:0
	)

	rollout params "Parameters"
	(
		spinner edge_size "Edge Size" type:#worldunits range:[0,1000,0]
		spinner depth "Depth" type:#worldunits range:[0,1000,0]
	)

	on buildMesh do
	(
		local size = edge_size
		
		if i_cube == undefined do
		(
			i_cube = createInstance box
		)
		i_cube.length=size
		i_cube.width=size
		i_cube.height=size
		i_cube.lengthsegs = 3
		i_cube.widthsegs = 3
		i_cube.heightsegs = 3
		setMesh mesh i_cube.mesh
		for m in 1 to 6 do
		(
			for n in (1+(m-1)*18) to (18*m) do (setFaceMatID mesh n m)
		)
		for n in 1 to (getNumFaces mesh) by 2 do (extrudeFace mesh #{n,n+1} depth 20 dir:#common)
	)

	tool create
	(
		on mousePoint click do
		case click of
		(
			1: nodeTM.translation = gridPoint
			3: #stop
		)
		on mouseMove click do
		case click of
		(
			2: (edge_size = abs gridDist.y)
			3: depth = abs gridDist.z
		)
	)
)

clearlistener()