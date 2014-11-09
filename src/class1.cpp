#include "class1"

A2::A2(char *new_name)
{
    strcpy(name, new_name);
}

void A2::printName(void)
{
    printf("%s\n", name);
}
