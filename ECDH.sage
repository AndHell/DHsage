p = next_prime(2^8)

FF = FiniteField(p)

E = EllipticCurve(FF, [0,1])
print(E)

P = E.gen(0)
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

