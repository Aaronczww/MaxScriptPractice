macroScript rolMCRTest
category:"_XSJART_TOOL" 
buttonText:"Test" 
toolTip:"TestToolTip"
(
	rollout rol_buttons "Testing Buttons"
	(
	  button btn_theButton "Press me!" toolTip:"111111" 
	  button theBorderlessButton "I am a button, too!" border:false
	  on btn_theButton pressed do
		messagebox "Remember: Never press unknown buttons!"
	)
	on isChecked do rol_buttons.open
	on execute do  createDialog rol_buttons
	on closeDialogs do destroyDialog rol_buttons
)

