# AbstractDT-and-ConcreteDT

## IntSet
**Assignment 5 - Question1**

Implement the immutable class intSet using an array to represent a set of integers in the range 1-1000. It should support public methods like - 

* isMember(int x) - check whether x is a member of the set and return a boolean value

* size() - return the size of the set

* isSubSet(intSet s) - check whether s is a subset of the set

* getComplement()  - return the complement set, you can assume that 1..1000 is the universal set

* union(intSet s1, intSet s2) - return the union of s1 and s2

You may use private helper methods. 


## Polynomial operations
#### Assignment 5 - Question 2

Implement the immutable class Poly using an array to represent single variable polynomial. Note that you should be storing only those terms of polynomial that have non zero coefficient. You can assume that the coefficients are integers

It should support methods like - 

* evaluate(float) - return the value of the polynomial for the given value of the variable

* degree() - return the degree of the polynomial

* addPoly(Poly p1, Poly p2) - return the sum of the polynomials p1 and p2

* multiplyPoly(Poly p1, Poly p2) - return the product of polynomials p1 and p2

You may use private helper methods. addPoly() and multiplyPoly() can make assumptions about size of the resulting polynomial to decide about the size of the array to be created.

