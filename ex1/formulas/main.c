#include "formulas.h"
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>


#define NUM_TESTS 100
#define MAX_LENGTH 10000
#define MAX_ERROR 0.0001
#define MIN_VAL 0.0001
#define MAX_VAL 0.009

int is_close(float f1, float f2) {
    return f1 - f2 <= MAX_ERROR && f2 - f1 <= MAX_ERROR;
}


float formula1_test(float *x, unsigned int length) {
    float sum = 0;
    float product = 1;
    for (int k = 0; k < length; k++) {
        sum += sqrtf(x[k]);
        product *= (x[k] * x[k] + 1);
    }
    return sqrtf(1 + cbrtf(sum) / product);

}

float formula2_test(float *x, float *y, unsigned int length) {
    float sum = 0;
    float sum2 = 0;
    for (int k = 0; k < length; k++) {
        float product = 1;
        for (int i = 0; i < length; i++) {
            product *= (x[i]*x[i] + y[i]*y[i] - 2*x[i]*y[i] + 1);
        }
        if (sum == 0){
            //printf("the product is %f\n",product);
        }
        sum += (x[k]*y[k])/product;
        sum2 += (x[k]*y[k]);
    }
    //printf("the top sum is %f\n", sum2);
    return sum;
}


int main(void) {
    srand(time(NULL));
    float *x = malloc(sizeof(float) * MAX_LENGTH);
    float *y = malloc(sizeof(float) * MAX_LENGTH);

    for (int i = 0; i < NUM_TESTS; i++) {
        unsigned int length = (rand() % MAX_LENGTH) + 1;
        length = length/4;
        length = length*4;
        for (unsigned int k = 0; k < length; k++) {
            x[k] = (((float)rand())/((float)RAND_MAX)) * (MAX_VAL - MIN_VAL) + MIN_VAL;
            y[k] = (((float)rand())/((float)RAND_MAX)) * (MAX_VAL - MIN_VAL) + MIN_VAL;
        }
        clock_t start, end;
        double cpu_time_used;

        start = clock();
        float form1 = formula1(x, length);
        end = clock();
        cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
        printf("[Test %d:] form1 runtime: %f\n", i + 1, cpu_time_used);
        start = clock();
        float test1 = formula1_test(x, length);
        end = clock();
        cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
        printf("[Test %d:] test1 runtime: %f\n", i + 1, cpu_time_used);
        start = clock();
        float form2 = formula2(x, y, length);
        end = clock();
        cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
        printf("[Test %d:] form2 runtime: %f\n", i + 1, cpu_time_used);
        start = clock();
        float test2 = formula2_test(x, y, length);
        end = clock();
        cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
        printf("[Test %d:] test2 runtime: %f\n", i + 1, cpu_time_used);

        if (!is_close(form1, test1)) {
            printf("[Test %d:] failed formula 1: form1 %f , test1: %f\n", i + 1, form1, test1);
            return 0;
        }
        printf("[Test %d:] passed formula 1: form1 %f , test1: %f\n", i + 1, form1, test1);

        if (!is_close(form2, test2)) {
            printf("[Test %d:]failed formula 2: form2 %f , test2: %f\n", i + 1, form2, test2);
            return 0;
        }
        printf("[Test %d:] passed formula 2: form2 %f , test2: %f\n", i + 1, form2, test2);
    }


    printf("test completed successfully\n");
    free(x);
    free(y);
}