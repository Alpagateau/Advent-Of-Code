f = open("test.txt").read()

lines = f.split("\n")
nlines = []

for i in range(len(lines)):
    if lines[i] == "":
        continue
    nlines += [[ int(v) for v in lines[i].split(" ") ]]

deriv = []
for i in range(len(nlines)):
    deriv += [[]]
    for j in range(len(nlines[i])-1):
       deriv[-1] += [nlines[i][j] - nlines[i][j+1]] 


def unsafeScore(L):
    sc = 0
    sign = 0
    if L[0] > 0:
        sign = 1
    else:
        sign = -1
    for i in range(len(L)):
        if L[i]*sign < 1:
            sc += 1
            print("Found a zéro")
        if L[i]*sign >= 3:
            sc += 1
    return sc

def count(L):
    s = 0
    for i in range(len(L)):
        if L[i] <= 1:
            s += 1
    return s
print(count( [ unsafeScore(i) for i in deriv]))
