parsing_table = {
    ('E', 'i'): 'TX',
    ('X', '+'): '+TX',
    ('X', '$'): '@',
    ('T', 'i'): 'i'
}

non_terminals = ['E', 'X', 'T']
def predictive_parser(input_buffer):
    stack = ['$', 'E']

    print("Stack\t\tInput\t\tAction")

    while True:
        stack_content = ''.join(stack)
        input_content = ' '.join(input_buffer)

        top = stack[-1]
        current_input = input_buffer[0]

        if top == '$' and current_input == '$':
            print(f"{stack_content}\t\t{input_content}\t\tMatch $")
            print("String Accepted")
            break

        if top == current_input:
            stack.pop()
            input_buffer.pop(0)
            print(f"{stack_content}\t\t{input_content}\t\tMatch {top}")

        elif top in non_terminals:
            key = (top, current_input)

            if key not in parsing_table:
                print("Error: String Rejected")
                break

            production = parsing_table[key]
            stack.pop()

            if production != '@':
                for sym in reversed(production):
                    stack.append(sym)

            print(f"{stack_content}\t\t{input_content}\t\t{top} -> {production}")

        else:
            print("Error: String Rejected")
            break

string_to_parse = input("String to parse : ")

tokens = string_to_parse.replace('+', ' + ').replace('$', ' $').split()

predictive_parser(tokens)
