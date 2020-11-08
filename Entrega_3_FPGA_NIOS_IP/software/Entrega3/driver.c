#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

#include "driver.h"


#define EN_OFFSET  1
#define DIR_OFFSET 2
#define SPD_OFFSET 3




int motor_init(unsigned int *p_motor)
{
	*(p_motor+EN_OFFSET) = 1;
	return 0;
}

int motor_halt(unsigned int *p_motor)
{
	*(p_motor+EN_OFFSET) = 0;
	return 0;
}

int motor_en(unsigned int *p_motor)
{
	return *(p_motor);
}

int motor_dir(unsigned int *p_motor, unsigned int dir)
{
	*(p_motor+DIR_OFFSET) = dir;
	return 0;
}

int motor_vel(unsigned int *p_motor, unsigned int spd)
{
	*(p_motor+SPD_OFFSET) = spd;
	return 0;
}
