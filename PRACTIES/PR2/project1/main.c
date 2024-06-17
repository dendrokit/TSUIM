#include <8051.h>

void main() {
	unsigned char i, j; 
	unsigned char massiv [11] = {
		0xC0, 
		0xF9,
		0xA4,
		0xB0,
		0x99,
		0x92,
		0x82,
		0xF8,
		0x80,
		0x90,
		0xFF};

	P2 = massiv [10];
	P3 = 0x0;
	i = 0;

	do {
		if (P3 == 0x1) {
			P2 = massiv[i];
			i++;
			for(j = 0; j < 30; j++);
			if (i > 9) {
				i = 0;
			}
			P3 = 0x0;
		}
	} while(1);
}