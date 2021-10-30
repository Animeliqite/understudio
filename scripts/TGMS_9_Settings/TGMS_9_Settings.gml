/*
	These macros allow for improved performance
	if various features are not needed
*/

// Group Scales -- Ability to change the time scales for specific groups
	// 0 = Disable -- improves performance
	// 1 = Enable [default]
	#macro TGMS_USE_GROUP_SCALES 1

// Timing Method -- Ability to set duration based on step and/or delta timing
	// 0 = Dynamic (delta & step) [default]
	// 1 = Step only  (frames)	-- improves performance
	// 2 = Delta only (seconds)	-- improves performnace
	#macro TGMS_USE_TIMING 0

// Target Support -- Ability to use instances and/or structs as targets
	// 0 = Dyanmic (instances & structs) [default]
	// 1 = Instance only (object) -- improves performance
	// 2 = Struct only			  -- improves performance
	#macro TGMS_USE_TARGETS 0




// ** ADMIN ** 
// ** !DO NOT TOUCH! **
#macro TGMS_TIMING_DYNAMIC 0
#macro TGMS_TIMING_STEP 1
#macro TGMS_TIMING_DELTA  2

#macro TGMS_TARGETS_DYNAMIC 0
#macro TGMS_TARGETS_INSTANCE 1
#macro TGMS_TARGETS_STRUCT 2
