#define SIZE_TOT 256
#define NUM_OF_FLOATS SIZE_TOT/(sizeof(float)*8)
#include "immintrin.h"
float formula1(float *x, unsigned int length){
    float sum = 0;
    __m256 loaded; // var to load from memory the vectors
    __m256 bottom_mul = _mm256_set1_ps(1.0);
    __m256 ONE_ARRAY = _mm256_set1_ps(1.0);
    __m256 top_addition = _mm256_setzero_ps();
    for (int i = 0; i < length; i+=NUM_OF_FLOATS) {
        //load current 8 floats
        loaded = _mm256_load_ps(x);
        bottom_mul = _mm256_mul_ps(bottom_mul, _mm256_fmadd_ps(loaded,loaded,ONE_ARRAY)); //calculate Pi Xk^2 +1

    }

    return 0;
}