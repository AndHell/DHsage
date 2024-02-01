################################
#                              #
# Diffie-Hellmann Key-exchange #
#   using a Elliptic Curves    #
#                              #
################################

###########
#         # 
#  SETUP  #
#         #
###########

# We again start by picking a prime p
p = next_prime(2^8)
# and generate of FiniteField of prime order 
FF = FiniteField(p)

# But now, rather than working within the FiniteField direcly
# we generate an ElliticCurve over this Field
# 
# An EllipticCurve is an equation of the following form
#
#  y² = x³ + a*x² + b
# 
# (or some variation of this)
# to see how such an curve looks you can use
# sage:  plot(EllipticCurve([0,1]))
# play around by using diffrent values instead of 0 and 1 to get different curves.
#
# for an ElliticCurve over a FiniteField,
# we now consider only solutions that satisfy this equation with elements from the Field,
# e.G. where (x,y) are both in FF.
# such an pair (x,y) is called a point on the Elliptic Curve
#
# you can use the following statement to show such a set of points
# sage:  plot(EllipticCurve(FiniteField(23), [0,1]))

E = EllipticCurve(FF, [0,1])
print(E)

# in the next step we again obtain an generator form the Curve
# this a now a point (x,y) that can generate all other points on the E!
# But this time, we use repeated addition to do so (e.G. 3*P = P+P+P);
# E = {1*P, 2*+, 3*P, ..., P*n}
P = E.gen(0)
print("BASE: ", P)

# (for completness: 
#  EllipticCurves also have a "point at infinity",
#  but we can ignore this here)

# and again:
# The "important" part of this EllipticCurve structure is:
# Computing H = n*P is fast and easy
# However, given a point H, finding this "n" is super hard
#
# The benefit of EllipticCurves is,
# the prime p can be much smaller
# p ~ 2^256 vs 2^3072 as before

##################
#                # 
#  Key-Exchange  #
#                #
##################

# the key-exchange it self now is nearly the same as before.
# but not Alice and Bob compute a*P and b*P instead

###### ALICE
a = randrange(p)
A = a*P
print("ALICE    secret: ", a, "\t public: ", A)

###### BOB
b = randrange(p) 
B = b*P
print("BOB      secret: ", b, "\t public: ", B)

# Shared
print("SHARED Alice:  ", a*B)
print("SHARED Bob:    ", b*A)

# and agian;
# This works as this steps are
# "commutative"
print("(ab)P:         ", (a*b)*P)

