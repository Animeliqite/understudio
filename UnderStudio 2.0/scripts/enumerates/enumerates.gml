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
	
	#macro bt_enter global.inputConfirm
	#macro bt_enter_p global.inputConfirmPress
	#macro bt_enter_r global.inputConfirmRelease
	
	#macro bt_shift global.inputCancel
	#macro bt_shift_p global.inputCancelPress
	#macro bt_shift_r global.inputCancelRelease
	
	#macro bt_control global.inputMenu
	#macro bt_control_p global.inputMenuPress
	#macro bt_control_r global.inputMenuRelease
	
	#macro bt_left global.inputLeft
	#macro bt_left_p global.inputLeftPress
	#macro bt_left_r global.inputLeftRelease
	
	#macro bt_right global.inputRight
	#macro bt_right_p global.inputRightPress
	#macro bt_right_r global.inputRightRelease
	
	#macro bt_up global.inputUp
	#macro bt_up_p global.inputUpPress
	#macro bt_up_r global.inputUpRelease
	
	#macro bt_down global.inputDown
	#macro bt_down_p global.inputDownPress
	#macro bt_down_r global.inputDownRelease
	
}