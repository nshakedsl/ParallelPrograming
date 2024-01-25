#ifndef B64_C
#define B64_C
#include "libstr.h"
#include "immintrin.h"

// Create a mask to check for non-base64 characters
const __m128i BASE64_MASK = _mm_set_epi8(
    '+', '/', '0', '1', '2', '3', '4', '5',
    '6', '7', '8', '9', 'A', 'B', 'C', 'D',
    'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
    'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b',
    'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
    's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

int b64_distance(char str1[MAX_STR], char str2[MAX_STR])
{
    return 0;
}
void detect_non_base64_chars_chunck(char str[16])
{

    // Load 16 bytes into a 128-bit register
    __m128i input = _mm_loadu_si128((__m128i *)&str);

    // Compare the input with the base64 mask
    __m128i result = _mm_cmpeq_epi8(input, BASE64_MASK);

    // Check if any byte is not equal to base64
    if (!_mm_testz_si128(result, result))
    {
        printf("not base 64! !");
    }
}
void detect_non_base64_chars(char str[MAX_STR])
{

    // Process the string in 16-byte chunks
    for (int i = 0; i < MAX_STR; i += 16)
    {
        detect_non_base64_chars_chunck((__m128i *)&str[i]);
    }
}

#endif