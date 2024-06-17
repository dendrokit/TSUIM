#include <8051.h> 

void shift_left() {
	P0 = 0x4;
	P2 = 0x1;
	P2 = 0x0;
}

void print_letter(unsigned char ch) {
	P0 = ch;
	P2 = 0x3; 
	P2 = 0x2;
}

void move_cursor(unsigned int position) {
	P0 = position; 
	P2 = 0x1; 
	P2 = 0x0;
}

void print(unsigned char *str, unsigned int size, unsigned int position, unsigned int absolute_pos) {
	unsigned char space = ' ';
	unsigned int i;
	
	if (position < 8) {
		move_cursor(0x80 + position);
	}
	else {
		move_cursor(0xC0 + position - 8);
	}

	if (absolute_pos >= size) {
		for (i=size; i>0; i--) {
			print_letter(str[i-1]);
		}
		print_letter(space);
	}
	else {
		for (i=size; i>0; i--) {
			if (absolute_pos >= size - i) {
				print_letter(str[i-1]);
			}
		}
	}
}

void main() { 
	unsigned int i, j; 
	unsigned char *str="Advert";
	unsigned int size;
	
	for (size=0; str[size] != '\0'; ++size);

	P0 = 0x38; 
	P2 = 0x1;
	P2 = 0x0;
	
	shift_left();

	while(1) {
		for (i=0; i<16; i++) {
			print(str, size, i, j);
			j++;
		}
	}
}
