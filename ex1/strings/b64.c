#ifndef B64_C
#define B64_C
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <immintrin.h>
#include "libstr.h"
int char_to_base64_value(char c)
{
    if (c >= 'A' && c <= 'Z')
    {
        return c - 'A';
    }
    else if (c >= 'a' && c <= 'z')
    {
        return c - 'a' + 26;
    }
    else if (c >= '0' && c <= '9')
    {
        return c - '0' + 52;
    }
    else if (c == '+')
    {
        return 62;
    }
    else if (c == '/')
    {
        return 63;
    }
    else
    {
        // Handle invalid characters
        return -1;
    }
}

// Function to check if a character is a valid base64 character
int isValidBase64Char(char c)
{
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c == '+' || c == '/';
}
void reverseString(char str[MAX_STR], int length)
{

    for (int i = 0; i < length / 2; i++)
    {
        char temp = str[i];
        str[i] = str[length - 1 - i];
        str[length - 1 - i] = temp;
    }
}
// Level 1

// Function to remove non-base64 characters while maintaining the order of every other character
void removeNonBase64Chars(char str[MAX_STR], int len)
{
    int j = 0;

    for (int i = 0; i < len; i++)
    {
        if (isValidBase64Char(str[i]))
        {
            str[j++] = str[i];
        }
    }
    str[j] = '\0';
}

// Function to calculate powers of 64 as integers
int pow64(int exponent)
{
    int result = 1;
    for (int i = 0; i < exponent; i++)
    {
        result *= 64;
    }
    return result;
}

// Level 2
int base64_string_to_int(char str[MAX_STR], int length)
{

    int total_sum = 0;
    // Process the input string in chunks of 4 characters
    for (int i = 0; i < length; i += 4)
    {

        int values[4] = {0, 0, 0, 0};
        int powers_of_64[4] = {0, 0, 0, 0};
        values[0] = char_to_base64_value(str[i]);

        powers_of_64[0] = pow64(i);
        if (i + 1 < length)
        {
            values[1] = char_to_base64_value(str[i + 1]);
            powers_of_64[1] = 64 * powers_of_64[0];
        }
        if (i + 2 < length)
        {
            values[2] = char_to_base64_value(str[i + 2]);
            powers_of_64[2] = 64 * powers_of_64[1];
        }
        if (i + 3 < length)
        {
            values[3] = char_to_base64_value(str[i + 3]);
            powers_of_64[3] = 64 * powers_of_64[2];
        }

        // Load the numeric powers_of_64 into a 128 - bit vector
        __m128i values_vector = _mm_set_epi32(values[3], values[2], values[1], values[0]);
        __m128i powers_of_64_vector = _mm_set_epi32(powers_of_64[3], powers_of_64[2], powers_of_64[1], powers_of_64[0]);

        // Multiply the base64_chars vector by the powers_of_64 vector
        __m128i result = _mm_mullo_epi32(values_vector, powers_of_64_vector);

        // Sum the four numbers in the result vector
        __m128i sum = _mm_hadd_epi32(result, result);
        sum = _mm_hadd_epi32(sum, sum);

        // Extract the final sum as a scalar integer
        int finalSum = _mm_cvtsi128_si32(sum);
        total_sum += finalSum;
    }
    return total_sum;
}

int b64_distance(char str1[MAX_STR], char str2[MAX_STR])
{
    int len1 = strlen(str1);
    int len2 = strlen(str2);
    removeNonBase64Chars(str1, len1);
    removeNonBase64Chars(str2, len2);
    int new_length1 = strlen(str1);
    int new_length2 = strlen(str2);

    reverseString(str1, new_length1);
    reverseString(str2, new_length2);

    return base64_string_to_int(str2, new_length2) - base64_string_to_int(str1, new_length1);
}

#endif
