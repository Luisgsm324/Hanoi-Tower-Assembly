value = input()
ascii_value = ord(value)
remainders = []
result = ""
base = 2


while True:
    quocient = ascii_value//base
    remainder = ascii_value % base
    remainders.append(str(remainder))
    if quocient < base:
        remainders.append(str(quocient))
        break
    else:
        ascii_value -= base

for _ in range(len(remainders)):
    result += remainders[-1]
    remainders.pop()
print(result)
