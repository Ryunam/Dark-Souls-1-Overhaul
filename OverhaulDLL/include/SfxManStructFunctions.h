#pragma once
#ifndef SFXMAN_STRUCTFUNCTIONS_H
#define SFXMAN_STRUCTFUNCTIONS_H

#include <stdint.h>
#include "SfxManStruct.h"

void copy_class_14152d360(class_14152d360* to, class_14152d360* from, bool to_game);
void copy_class_14152d360_asObj(class_14152d360* to, class_14152d360* from, bool to_game);
class_14152d360* init_class_14152d360();
void free_class_14152d360(class_14152d360* to);

void copy_class_14150b808_field0x48(class_14150b808_field0x48* to, class_14150b808_field0x48* from, bool to_game);
class_14150b808_field0x48* init_class_14150b808_field0x48();
void free_class_14150b808_field0x48(class_14150b808_field0x48* to);

#endif
