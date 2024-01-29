ells = [3,5,7]
p = 4*prod(ells)-1

Start = EllipticCurve(FiniteField(p), [0,0,0,1,0])

def keygen():
    return [randrange(6) for _ in range(len(ells))]

def CSIDH(A_in, pk_in):
    A = A_in
    pk = pk_in.copy()
    while sum(pk) != 0:
        P = A.random_point()
        P = 4*P
        for i,_ in enumerate(ells):
            if pk[i] == 0:
                continue

            cof = prod(ells) / ells[i]
            K = cof*P
            if K.is_zero():
                continue

            phi = A.isogeny(K)
            A = phi.codomain()
            P = phi(P)
            pk[i] -= 1

    return A


# Start
print("Base: ", Start)

# Alice
sk_a = keygen()
A = CSIDH(Start, sk_a) 
print("ALICE  secret: ", sk_a, " | public:" ,A)


# Bob
sk_b = keygen()
B = CSIDH(Start, sk_b) 
print("BOB    secret: ", sk_b, " | public:" ,B)

# shared 
sB = CSIDH(A, sk_b)
sA = CSIDH(B, sk_a)
print("SHARED Alice: ", sA)
print("SHARED Bob:   ", sB)
print(sB == sA)
