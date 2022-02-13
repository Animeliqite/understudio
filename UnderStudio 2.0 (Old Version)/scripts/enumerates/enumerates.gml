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
	
}