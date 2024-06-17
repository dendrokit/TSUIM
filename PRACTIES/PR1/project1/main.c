#include <8051.h> 
void main() 
{
	int i,j;
	char xdata *ptr; 
	char test, nabor;
	nabor = 0x55; 
	ptr = (char xdata *) 0x100;
	P1=0x0;
	for(i=0; i<1024;i++) {
		P1 = 0x2;
		*ptr=nabor; 
		test=*ptr; 
		if(test!=nabor)
		{
			P1=0x1;
			P1=0x0;
			for(j=0;j<5;j++);
		}
		ptr++;
		P1 = 0x0;
	}
	P1 = 0x4;
}
