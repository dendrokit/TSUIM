#include <8051.h>
#include <string.h>


void tput(unsigned char c1) {
	SBUF=c1;
	while(!TI);
	TI=0;
}


void main() {
	int i;
	unsigned char src[]={"\xB8\xA0\xB1\xA9\xAE \xA0\xAC\xA6\xB9\xA0\xA"};
	unsigned int size;

	size = strlen(src);

	PCON=0x80;

	for(i=0; i<size; i++) {
		ACC=src[i]; 
		SCON = 0x88;
		tput (src[i]);
	}

	while(1); 
}
