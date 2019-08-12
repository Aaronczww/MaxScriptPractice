--macroScript lunchTime category:"_XSJART_TOOL" buttonText:"午饭提醒" toolTip:"吃饭提醒"
--(
unRegisterRedrawViewsCallback fn_lunchTime

function fn_lunchTime =
(
	local tipTime_h = "15"
	local tipTime_m = "28"
	local txt = "吃饭饭啦！\n\n楼下有好吃的米饭 和 可爱的MM，等着你哦～～～"
	--print localtime
	if (((filterstring ((filterstring localtime " ")[2]) ":")[1] == tipTime_h) and ((filterstring ((filterstring localtime " ")[2]) ":")[2] == tipTime_m)) then
	(
		messagebox txt
		unRegisterRedrawViewsCallback fn_lunchTime
	)
	else
	()
	
)
registerRedrawViewsCallback fn_lunchTime
--)