#include <iostream>

extern "C" void Array(float a[]);

int main()
{
	float arr[11];

	Array(arr);

	std::cout << "Result: ";

	for (char i = 0; i < 11; i++)
		std::cout << arr[i] << " ";

	std::cout << '\n';

	return 0;
}
