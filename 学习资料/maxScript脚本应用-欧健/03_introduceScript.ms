--float 浮点型常量
100. 
.123
--Integer 整形常量
100
--string 字符常量
abc
"abc"
--time 时间常量，单位有m|s|f|t分别对应分，秒，帧，滴，一秒钟相当于4800滴。
2.5s
17.25f
1m30m5f2t
--color 颜色常量，color <r> <g> <b> [ <a> ] r是红色通道，g是绿色通道，b是蓝色通道，a是alfa通道。
color 255 255 0
red
--booleanClass 布尔常量，只有两种值，true(真)，false(假)。
true
on
--undefined 未定义
--Name ，Point2 ，Point3 ， Ray ，Quat ，AngleAxis ，EulerAngles ，Matrix3 ，BigMatrix ，Box2 ，BitArray ，ArrayParameter 

/*表达式

+ 数学中的加号，如1+1，a+b
- 数学中的减号，如2-1，a-b
* 数学中的乘号，如5*6，a*b
/ 数学中的除号，如4/2，a/b
^ 数学中的幂运算，如2^6即2的6次方
as 强制类型转换，如 2.54 as integer
+=

sin 45
pi
*/

/*比较
==
!=
>
<
返回值为true 或 false
*/


/*
变量
sum = (1+2+3)*100
box01 = $
*/


--Node
theSphere = sphere radius:20
selection
objects
--array 一组数据。
b = box()
showproperties b
b.name
b.pos.x



$.scale = [1.5,1.5,1]
$.rotation.z_rotation = -30 
rotate $ (angleaxis 30 [0,0,1]) --将选择物体在z轴旋转30度

--for循环  减少重复劳动力
for i in selection do i.name += "_rename"

for i in objects where(classof i != boneGeometry) do i.pos = [0,0,0] 

if(classof i != boneGeometry) then(i.pos = [0,0,0])

--控制器
theSphere = sphere radius:20
theHelix = helix height:200 pos:[200,200,0]
theSphere.position.controller = path path:theHelix

/*
box01 = box()
animate on
(
	at time 0f
	(box01.pos = [-100,0,0])
	at time 50f
	(box01.pos = [0,0,0])
	at time 100f
	(box01.pos = [100,0,0])
)
--$.controller.scale.keys[2].value
*/

/*
rollout
*/