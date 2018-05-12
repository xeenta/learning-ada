#include <iostream>
#include <vector>

typedef std::vector<int> int_vec;

int main()
{
    int_vec x;
    x.push_back(1);
    std::cout << x[0] << "\n";
    return 0;
}
