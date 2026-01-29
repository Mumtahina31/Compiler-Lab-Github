from collections import defaultdict

productions = defaultdict(list)
first = defaultdict(set)
follow = defaultdict(set)

non_terminals = []
terminals = set()
start_symbol = ""

def compute_first(symbol):
    if symbol in terminals:
        return {symbol}

    if first[symbol]:
        return first[symbol]

    for prod in productions[symbol]:
        if prod == "@":
            first[symbol].add("@")
        else:
            for ch in prod:
                ch_first = compute_first(ch)
                first[symbol].update(ch_first - {"@"})
                if "@" not in ch_first:
                    break
            else:
                first[symbol].add("@")

    return first[symbol]

def compute_follow():
    follow[start_symbol].add("$")

    changed = True
    while changed:
        changed = False
        for head in productions:
            for prod in productions[head]:
                for i, B in enumerate(prod):
                    if B in non_terminals:
                        before = len(follow[B])

                        if i + 1 < len(prod):
                            beta = prod[i + 1]
                            follow[B].update(first[beta] - {"@"})
                            if "@" in first[beta]:
                                follow[B].update(follow[head])
                        else:
                            follow[B].update(follow[head])

                        if len(follow[B]) > before:
                            changed = True

def is_ll1():
    for nt in non_terminals:
        prods = productions[nt]

        for i in range(len(prods)):
            for j in range(i + 1, len(prods)):
                p1, p2 = prods[i], prods[j]

                first1 = set()
                first2 = set()

                if p1 == "@":
                    first1.add("@")
                else:
                    first1 |= compute_first(p1[0])

                if p2 == "@":
                    first2.add("@")
                else:
                    first2 |= compute_first(p2[0])

                if (first1 - {"@"}) & (first2 - {"@"}):
                    return False

                if "@" in first1 and (first2 & follow[nt]):
                    return False
                if "@" in first2 and (first1 & follow[nt]):
                    return False

    return True

n = int(input("Number of productions : "))
print("Enter productions :")

for i in range(n + 1):
    p = input().replace(" ", "")
    if "=" not in p:
        continue

    lhs, rhs = p.split("=")

    if lhs not in non_terminals:
        non_terminals.append(lhs)

    if i == 0:
        start_symbol = lhs

    productions[lhs].append(rhs)

    for ch in rhs:
        if not ch.isupper() and ch != "@":
            terminals.add(ch)

for nt in non_terminals:
    compute_first(nt)

compute_follow()

if is_ll1():
    print("Grammar is LL (1)")
else:
    print("Grammar is not LL (1)")
