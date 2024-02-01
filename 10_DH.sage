################################
#                              #
# Diffie-Hellmann Key-exchange #
#     using a Finite Group     #
#        of prime order        #
#                              #
################################


###########
#         # 
#  SETUP  #
#         #
###########

# We start by picking a prime 
p = next_prime(2^8)

# We generate a FiniteField of prime order p
# Normaly one uses a multiplicativ Group for this
#
# This is an "object" where every multiplication is done with modulo p
# e.g. the reminder after devision by p
# For example 3 * 4 = 5 mod 7 as 3*4 = 12 = 1*7 + 55
#
# For the example with p = 7,
# this object contains all numbers from 0 to 6

FF = FiniteField(p, modulus="primitive")

# From our FiniteField we obtain a generator
# this is an element that can generate every element
# with repeated multiplication, e.G. G^3 = G*G*G
# FF = {G^1, G^2, G^3, ..., G^n = 1}
G = FF.gen()
print("prime: ", p)
print("BASE:  ", G)

# The "important" part of this group structure is:
# Computing H = G^n is fast and easy
# However, given a H, finding "n" is super hard
# (for large p!!! e.g. p = next_prime(2^3072))

##################
#                # 
#  Key-Exchange  #
#                #
##################

###### ALICE
#
# Alice frist creates an secret key
# this key "a" needs to stay hidden and Alice should never share it
# Alice picks "a" as an random number between 0 and p
a = randrange(p)

# Alice can now compute her public key
# this is the key "A" she can share publicly with Bob
# this "A" is computed using the generator G of our group
# as state above, G^a gives us, again, an element from our group
# as the secret key "a" is random, A=G^a is also an random element
A = G^a
print("ALICE secret:",a, "| public: ", A)

###### BOB
#
# Bob does the same as Alice
# but with a secret key "b"
b = randrange(p)
# and public key "B"
B = G^b
print("BOB   secret:",b, "| public: ", B)

###### SHARED
#
# Alice and Bob now share their public keys
#    A <-> B
# so Alice now knows Bobs "B"
# To compute the shared secret key
# Alice uses her secret "a" to compute "B^a"
print("SHARED alice: ", B^a)

# and as Bob has Alice's "A", 
# he can do the same step using his "b"
print("SHARED bob:   ", A^b)

# This works as this steps are
# "commutative"
# that is, it does not matter in which order
# this following steps are computed
print("G^(a*b):      ", G^(a*b))
print("G^(b*a):      ", G^(b*a))
