function enumerates(){
	#macro Window new WindowUtil()
	#macro Music new MusicUtil()
	#macro SFX new SFXUtil()
	
	enum WINDOW_TYPE {
		NORMAL,
		FULLSCREEN
	}
	
	enum ANIMATION_TYPE {
		SHAKY,
		PARTLY_SHAKING,
		WAVY
	}
}