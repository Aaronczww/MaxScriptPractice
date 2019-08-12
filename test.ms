rollout rol_buttons "Testing Buttons"
(
  button btn_theButton "Press me!" toolTip:"111111" 
  button theBorderlessButton "I am a button, too!" border:false
  on btn_theButton pressed do
    messagebox "Remember: Never press unknown buttons!"
)
createDialog rol_buttons 150 60
