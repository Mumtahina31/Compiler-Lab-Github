input_string = ""
index = 0

def match(expected):
    global index
    if index < len(input_string) and input_string[index] == expected:
        print(f" Match {expected}")
        index += 1
    else:
        print(" String Rejected")
        exit(0)

def T():
    print(" T = i")
    if input_string[index] == 'i':
        match('i')
    else:
        print(" String Rejected")
        exit(0)

def X():
    global index
    if input_string[index] == '+':
        print(" X = + TX")
        match('+')
        T()
        X()
    else:
        print(" X = @")

def E():
    print(" E = TX")
    T()
    X()

input_string = input("Enter string to parse : ")
print("\nParsing string :", input_string)

E()

if input_string[index] == '$':
    print(" String Accepted")
else:
    print(" String Rejected")
