#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */
#include "driver.h"
//#define SIM

#define REG_DATA_OFFSET 1

int main(void){

  unsigned int *p_motor = (unsigned int *) 0x49000;




  printf("Teste \n");
  motor_vel(p_motor, 30000000);
  motor_init(p_motor);

  for (int i = 0; i< 20000;i++){
	  printf(motor_en(p_motor));
	  printf("\n");
  }



  return 0;
}
