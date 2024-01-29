p = next_prime(2^8)

FF = FiniteField(p, modulus="primitive")

G = FF.gen()
print("prime: ", p)
print("BASE:  ", G)

# Alice
a = randrange(p)
A = G^a
print("ALICE secret:",a, "| public: ", A)

# Bob
b = randrange(p)
B = G^b
print("BOB   secret:",b, "| public: ", B)

# shared
print("SHARED alice: ", B^a)
print("SHARED bob:   ", A^b)
print("G^(a*b):      ", G^(a*b))
