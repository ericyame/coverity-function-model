#include <stdio.h>
#include <stdlib.h>
#include "helper.h"

void ** lock;
int count = 0;

void NoUnlock(int cond);

int NoMemleak()
{
    int *a;
    a = malloc(sizeof(int));
    my_free(a); // There should be no 'Resource leak' defect here
   
    return 0;
}

void NoUnlock(int cond)
{
	foo_lock(lock);
	count++;
	if (cond)
		foo_unlock(lock);
	// There should be a 'Missing unlock' defect here
}