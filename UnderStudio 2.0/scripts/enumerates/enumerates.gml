function enumerates(){
	enum WINDOW_TYPE {
		NORMAL,
		FULLSCREEN
	}
	
	enum ANIMATION_TYPE {
		SHAKY,
		PARTLY_SHAKING,
		WAVY
	}
	
	#macro BT_ENTER global.inputConfirm
	#macro BT_ENTER_P global.inputConfirmPress
	#macro BT_ENTER_R global.inputConfirmRelease
	
	#macro BT_SHIFT global.inputCancel
	#macro BT_SHIFT_P global.inputCancelPress
	#macro BT_SHIFT_R global.inputCancelRelease
	
	#macro BT_CONTROL global.inputMenu
	#macro BT_CONTROL_P global.inputMenuPress
	#macro BT_CONTROL_R global.inputMenuRelease
	
	#macro BT_LEFT global.inputLeft
	#macro BT_LEFT_P global.inputLeftPress
	#macro BT_LEFT_R global.inputLeftRelease
	
	#macro BT_RIGHT global.inputRight
	#macro BT_RIGHT_P global.inputRightPress
	#macro BT_RIGHT_R global.inputRightRelease
	
	#macro BT_UP global.inputUp
	#macro BT_UP_P global.inputUpPress
	#macro BT_UP_R global.inputUpRelease
	
	#macro BT_DOWN global.inputDown
	#macro BT_DOWN_P global.inputDownPress
	#macro BT_DOWN_R global.inputDownRelease
	
}