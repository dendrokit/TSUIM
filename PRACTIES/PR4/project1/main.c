#include <8051.h>


void msec (int x) 
{	
	while(x-- > 0) 
	{
		TH0 = (-10000) >> 8;
		TL0 = -10000;
		TR0 = 1;
		TF0 = 0;
		TR0 = 0;
	}
}


void main() 
{
	int i;
	unsigned char array[4];
	unsigned int T[4] = {5, 2, 2, 5};
	unsigned int times = 4;
	
	for (i=0; i<times; i++) {
		T[i] *= 40;
	}	

	TMOD = 0x1; 
	array[0] = 0x5; 
	array[1] = 0xA;
	array[2] = 0x50;
	array[3] = 0xA0;
	P1 = 0x0;
	msec(2);

	for(i=0;i<times;i++) {
		P1 = array[i]; 
		msec(T[i]); 
	}
	P1 = 0x0;
	while(1);
}
