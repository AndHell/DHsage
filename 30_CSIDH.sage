################################
#                              #
#         Commutative          #
#    Supersinuglar  Isogeny    #
# Diffie-Hellmann Key-exchange #
#                              #
################################


# Here we only wont go into the details
#
# Key take away should be:
# 1. we used multiplication in a Finite Group of prime order in DH.sage
# 2. then we moved to point addition an an EllipticCurves
# 3. and now we do "Isogenies" between EllipticCurves

# An Isogeny is a way to move from one EllipticCurve to another
# so now our public keys are EllipticCurves 
# and the secret keys describe a way to move between these curves

# BUT!
# if you look at the steps of the Key Exchange itself
# we still to the same as before!
# as these Isogenies are also "commutative"

###########
#         # 
#  SETUP  #
#         #
###########


ells = [3,5,7]
p = 4*prod(ells)-1

Start = EllipticCurve(FiniteField(p), [0,0,0,1,0])

# Start
print("Base: ", Start)

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


##################
#                # 
#  Key-Exchange  #
#                #
##################

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
