// 325655058 ofir gurvits
// 323082867 Shaked Solomon
#define SIZE_TOT 256

#include "immintrin.h"
#include "math.h"
float formula1(float *x, unsigned int length) {
    float sum;
    float bot_mul = 1, top_sum = 0, placeholder[8];
    __m256 loaded; // var to load from memory the vectors
    __m256 bottom_mul = _mm256_set1_ps(1.0);
    __m256 ONE_ARRAY = _mm256_set1_ps(1.0);
    __m256 top_addition = _mm256_setzero_ps();
    int i;
    for (i = 0; length - i > 8; i += 8) {
        //load current 8 floats
        loaded = _mm256_loadu_ps(x + i);
        bottom_mul = _mm256_mul_ps(bottom_mul, _mm256_fmadd_ps(loaded, loaded, ONE_ARRAY)); //calculate Pi Xk^2 +1
        top_addition = _mm256_add_ps(top_addition, _mm256_sqrt_ps(loaded)); // calculate sigma sqrt(Xk)
    }
    //store the resulting values of the bottom to bot_mul
    _mm256_storeu_ps(placeholder, bottom_mul);
    bot_mul = placeholder[0] * placeholder[1] * placeholder[2] * placeholder[3] * placeholder[4] * placeholder[5] *
              placeholder[6] * placeholder[7];
    _mm256_storeu_ps(placeholder, top_addition);
    top_sum = placeholder[0] + placeholder[1] + placeholder[2] + placeholder[3] + placeholder[4] + placeholder[5] +
              placeholder[6] + placeholder[7];

    //sum all leftover elements
    for (; i < length; ++i) {
        bot_mul *= (x[i] * x[i]) + 1;
        top_sum += sqrtf(x[i]);
    }

    top_sum = cbrtf(top_sum);
    sum = top_sum / bot_mul + 1;
    sum = sqrtf(sum);
    return sum;
}