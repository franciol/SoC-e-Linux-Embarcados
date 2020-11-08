#ifndef DRIVER_H_
#define DRIVER_H_

int motor_init(unsigned int *p_motor);

int motor_halt(unsigned int *p_motor);

int motor_en(unsigned int *p_motor);

int motor_dir(unsigned int *p_motor, unsigned int dir);

int motor_vel(unsigned int *p_motor, unsigned int spd);

#endif
