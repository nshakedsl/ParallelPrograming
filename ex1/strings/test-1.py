
def naive_b64(string):
    x = 0
    for c in string:
        if 'A' <= c and c <= 'Z':
            x = 64 * x + ord(c) - ord('A')
        elif 'a' <= c and c <= 'z':
            x = 64 * x + ord(c) - ord('a') + 26
        elif '0' <= c and c <= '9':
            x = 64 * x + ord(c) - ord('0') + 52
        elif c == '+':
            x = 64 * x + 62
        elif c == '/':
            x = 64 * x + 63
    return x

import random
import string
from subprocess import run, PIPE
import os


def generate_mixed_string(length):
    base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    
    # Generate 5 characters from Base64
    base64_part = ''.join(random.choice(base64_chars) for _ in range(random.randint(0,5)))
    
    # Generate the remaining characters that are not in Base64
    non_base64_chars = ''.join(c for c in (string.ascii_letters + string.digits+string.punctuation) if c not in base64_chars)
    non_base64_part_length = length - 5
    non_base64_part = ''.join(random.choice(non_base64_chars) if len(non_base64_chars)>1 else (string.ascii_letters + string.digits+string.punctuation) for _ in range(non_base64_part_length))
    
    # Combine Base64 and non-Base64 parts and shuffle
    if(non_base64_part+base64_part == ''):
        return ''
    return ''.join(random.sample(non_base64_part+base64_part,len(non_base64_part+base64_part)))

def generate_random_string(length):
    # Generate a random string of ASCII characters with the specified length
    return ''.join(random.choice(string.ascii_letters + string.digits + string.punctuation) for _ in range(length))

def naive_hamming(s1,s2):
    # Calculate the hamming distance between two strings that not have the same length
    diff = abs(len(s1) - len(s2))
    for i in range(min(len(s1),len(s2))):
        if s1[i] != s2[i]:
            diff += 1
    return diff

import subprocess

def print_test_details(s1,s2,output, naive_output):
    print('s1 = '+s1)
    print('s2 = '+s2)
    print('Your output : '+output)
    print('Correct output : '+naive_output)
    if (output == naive_output):
        print("✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓")

def hamming_distance(print_output):
    try:
        s1 = generate_random_string(random.randint(1,254))
        s2 = generate_random_string(random.randint(1,254))
        input_data = "1\n%s\n%s\n3\n" % (s1,s2)
        # Call the hammin_dist.s file using subprocess
        read, write = os.pipe()
        os.write(write, input_data.encode('utf-8'))
        os.close(write)

        output = subprocess.check_output(['./main'], stdin=read)
        output = output.decode('utf-8').split('\n')[5].split(' ')[1]
        naive_output = str(naive_hamming(s1,s2))
        if(naive_output != output):
            print('❌❌❌❌❌❌❌❌❌❌❌❌❌ found error ❌❌❌❌❌❌❌❌❌❌❌❌❌')
            print('Error details : s1 = '+s1)
            print('Error details : s2 = '+s2)
            print('Your output : '+output)
            print('Correct output : '+naive_output)
        elif print_output is True:
            print_test_details(s1,s2,output,naive_output)

    except subprocess.CalledProcessError as e:
        # Handle errors
        print("Error:", e)

def b64(print_output):
    try:
        s1 = generate_mixed_string(245)
        s2 = generate_mixed_string(245)
        input_data = "2\n%s\n%s\n3\n" % (s1,s2)
        # Call the hammin_dist.s file using subprocess
        read, write = os.pipe()
        os.write(write, input_data.encode('utf-8'))
        os.close(write)

        output = subprocess.check_output(['./main'], stdin=read)
        output = output.decode('utf-8').split('\n')[5].split(' ')[1]
        naive_output = str(naive_b64(s2)-naive_b64(s1))
        if(naive_output != output):
            print('XXXXXXXXXXXXXXXXXXXXXXXXXXX found error XXXXXXXXXXX')
            print('Error details : s1 = '+s1)
            print('Error details : s2 = '+s2)
            print('Your output : '+output)
            print('Correct output : '+naive_output)
        elif print_output is True:
            print_test_details(s1,s2,output,naive_output)

    except subprocess.CalledProcessError as e:
        # Handle errors
        print("Error:", e)

# get input for function
def get_input():
    # Get the input from the user
    print("Enter the function number")
    print("1. Hamming distance")
    print("2. Base64")
    return int(input())

# get input for number of tests
def get_number_of_tests():
    # Get the input from the user
    print("Enter the number of tests")
    return int(input())

def want_output():
    print("Do you want to see the output (if no, only errors will be printed)? (Y/N)")
    return input().upper() == "Y"

# Get the input from the user
function = get_input()
number_of_tests = get_number_of_tests()
output = want_output()
if function == 1:
    for i in range(number_of_tests):
        hamming_distance(output)
elif function == 2:
    for i in range(number_of_tests):
        b64(output)