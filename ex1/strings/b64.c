#ifndef B64_C
#define B64_C
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <immintrin.h>
#include "libstr.h"

int char_to_base64_value(char c) {
    if (c >= 'A' && c <= 'Z') {
        return c - 'A';
    } else if (c >= 'a' && c <= 'z') {
        return c - 'a' + 26;
    } else if (c >= '0' && c <= '9') {
        return c - '0' + 52;
    } else if (c == '+') {
        return 62;
    } else if (c == '/') {
        return 63;
    } else {
        // Handle invalid characters
        return -1;
    }
}

// Function to check if a character is a valid base64 character
int isValidBase64Char(char c) {
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c == '+' || c == '/';
}

// Level 1

// Function to remove non-base64 characters while maintaining the order of every other character
void removeNonBase64Chars(char str[MAX_STR]) {
    int len = strlen(str);
    int j = 0;

    for (int i = 0; i < len; i++) {
        if (isValidBase64Char(str[i])) {
            str[j++] = str[i];
        }
    }
    str[j] = '\0';
}

// Level 2
// void process_base64_string(char str[MAX_STR]) {
//     // TODO : it is OK to use ?
//     int length = strlen(str);

//     // TODO : Handle invalid input length is NOT a multiple of 4

//     // Create a const vector with powers of 64: [1, 64, 64^2, 64^3]
//     const __m128i POWERS_OF_64 = _mm_set_epi32(64 * 64 * 64, 64 * 64, 64, 1);

//     // Process the input string in chunks of 4 characters
//     for (int i = 0; i < length; i += 4) {

//         // Convert 4 base64 characters to numeric values
//         int values[4] = {
//                 char_to_base64_value(str[i]),
//                 char_to_base64_value(str[i + 1]),
//                 char_to_base64_value(str[i + 2]),
//                 char_to_base64_value(str[i + 3])
//         };

//         for (int j = 0; j < 4; j++) {
//             printf("%d ", values[j]);
//         }

//         // Load the numeric values into a 128-bit vector
//         __m128i base64_values = _mm_set_epi32(values[3], values[2], values[1], values[0]);

//         // Multiply the base64_chars vector by the powers_of_64 vector
//         __m128i result = _mm_mullo_epi32(base64_values, POWERS_OF_64);

//         // Extract the result values as a 4-element array
//         int32_t result_values[4];
//         _mm_storeu_si128((__m128i *) result_values, result);

//         // Do something with the result_values array (print, store, etc.)
//         for (int j = 0; j < 4; j++) {
//             // Example: print each result value
//             printf("%d ", result_values[j]);
//         }
//         printf("\n");
//     }
// }

int b64_distance(char str1[MAX_STR], char str2[MAX_STR]){
    removeNonBase64Chars(str1);
    removeNonBase64Chars(str2);
    printf("%s\n",str1);
    printf("%s\n",str2);
}

#endif
