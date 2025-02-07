import re

# Step 1: Read the code from a file
with open('dredger.lua', 'r') as file:
    code = file.read()

# Step 2: Find two characters not present in the code
def find_unused_chars(code, num_chars):
    # Using Unicode Private Use Area characters to minimize conflicts
    candidate_chars = [chr(i) for i in range(0xE000, 0xF8FF + 1) if chr(i) not in code]
    if len(candidate_chars) < num_chars:
        raise ValueError('Not enough unused characters available.')
    return candidate_chars[:num_chars]

char1, char2 = find_unused_chars(code, 2)

print(char1, char2)
# Step 3: Use regex to look for 'hr_version\s*=\s*{[^}]*}' and fix if able
def fix_hr_version(code):
    pattern = r'(hr_version\s*=\s*{)'
    matches = list(re.finditer(pattern, code))
    for match in matches:
        print("Matched")
        start = match.end()
        brace_count = 1
        index = start
        while index < len(code) and brace_count > 0:
            if code[index] == '{':
                brace_count += 1
            elif code[index] == '}':
                brace_count -= 1
            index += 1
        if brace_count != 0:
            # Unbalanced braces detected, append a closing brace
            code = code[:index] + '}' + code[index:]
    return code

code = fix_hr_version(code)

with open('dredger-temp1.lua', 'w') as file:
    file.write(code)

# Step 4: Replace all '{[^}]*}' with '<char1>$1<char2>' and repeat the process
def replace_braces(code, char1, char2):
    pattern = r'\{([^{}]*)\}'
    while re.search(pattern, code):
        code = re.sub(pattern, f'{char1}\\1{char2}', code)
    return code

code = replace_braces(code, char1, char2)
with open('dredger-temp2.lua', 'w') as file:
    file.write(code)

# Step 5: Replace '<char1>' back to '{' and '<char2>' back to '}'
code = code.replace(char1, '{').replace(char2, '}')

# Write the processed code to a new file
with open('dredger.lua', 'w') as file:
    file.write(code)
