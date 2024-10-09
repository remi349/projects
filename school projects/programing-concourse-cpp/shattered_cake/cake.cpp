#include <stdio.h>

using namespace std;

int main()
{
    int W, area, number_of_rectangles, lengthi, widthi;
    while (scanf("%d", &W) == 1)
    {

        scanf("%d", &number_of_rectangles);
        area = 0;
        for (int i = 0; i < number_of_rectangles; i++)
        {
            scanf("%d", &widthi);
            scanf("%d", &lengthi);
            area += widthi * lengthi;
        }
        area = area / W;
        printf("%d\n", area);
    }
    return (0);
}