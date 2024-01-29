p = 2^255 - 19 

FF = FiniteField(p)

E = EllipticCurve(FF, [0,486662,0,1,0])
print(E)

P = E.lift_x(9, all)[0]
print("BASE: ", P)

# Alice
a = randrange(p)
A = a*P
print("ALICE    secret: ", a, "\t public: ", A)

# Bob
b = randrange(p) 
B = b*P
print("BOB      secret: ", b, "\t public: ", B)

# Shared
print("SHARED Alice:  ", a*B)
print("SHARED Bob:    ", b*A)
print("(ab)P:         ", (a*b)*P)

