/*
	DARK SOULS OVERHAUL

	Contributors to this file:
		Sean Pesce	-	C++


	ParamDef/NewParamDef.h

	New Parameters from NewParam.paramdef


	References:
		- (Author?) ParamDefs Sheet
		  https://docs.google.com/spreadsheets/d/1KukblWL61We64-gNIyaAShga9h8RTXYmyFs98eQhY4E/

		- Kushisushi's ParamDefs Sheet
		  https://docs.google.com/spreadsheets/d/1QX6i93H4_jGZ0So9mArDECnuv1lfkaJQhXOzkDuxdkE/edit#gid=2133439974

*/

#pragma once

#ifndef _DS1_OVERHAUL_NEW_PARAM_DEF_FILE_H_
	#define _DS1_OVERHAUL_NEW_PARAM_DEF_FILE_H_


#include "GameParamDef.h"


// New parameter
typedef struct NewParameter : public Param {
	@TODO
} NewParam;



// New parameter definitions file
class NewParamDef : public GameParamDef {


public:
	static NewParamDef& get_instance()
	{
		static NewParamDef instance;
		return instance;
	}
	
	NewParam *data()
	{
		return (NewParam*)GameParamDef::data();
	}

	NewParam *get(int index)
	{
		return (NewParam*)GameParamDef::get(index);
	}


	// @TODO: Member data specific to this class
	
private:
	NewParamDef()
		: GameParamDef(/* @TODO: NULL, 0xdata_start_offset, param_count, sizeof(NewParam), "scan_pattern", "NewParam", "title" */)
	{
	}
	
public:
	NewParamDef(NewParamDef const&) = delete;
	void operator=(NewParamDef const&) = delete;
};







#endif // _DS1_OVERHAUL_NEW_PARAM_DEF_FILE_H_