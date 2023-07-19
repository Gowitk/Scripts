s = input("Enter a string: ")
for x in range(0, len(s), 4):
    print(s[x+3]+s[x+2]+s[x+1]+s[x], end=' ')
