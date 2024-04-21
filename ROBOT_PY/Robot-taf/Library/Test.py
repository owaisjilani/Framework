def reverse_string(input_string):
    return input_string[::-1]

# Example usage:
original_string = "Hello, world!"
reversed_string = reverse_string(original_string)
print("Original string:", original_string)
print("Reversed string:", reversed_string)


def sumOfList(nestedList):
    totalSum=0
    for lst in nestedList:
        if isinstance(lst, list):
             totalSum+=sumOfList(lst)
        else:
             totalSum+=lst

    return totalSum


listEle = [1,[2,3,4],[5,6,[7]]]
print(sumOfList(listEle))

def reverse_str(input_string):
    return input_string[::2]

original_string = "Hello, world!"
reversed_string = reverse_str(original_string)
print("Original string:", original_string)
print("Reversed string:", reversed_string)