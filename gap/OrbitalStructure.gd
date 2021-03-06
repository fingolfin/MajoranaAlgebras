
#! @Chapter Orbital Structures
#!
#! The functions for orbital structures are based on recent work in permutation
#! group algorithms. An orbital structure contains information about orbits and
#! stabilisers of a group acting on a set for the purposes of quickly
#! determining representatives, canonising elements, and transversal elements
#! (directed) orbitals (orbits of ordered pairs of elements of the domain), and
#! undirected orbitals, i.e. orbits of sets of size two.
#!
#! @Section Examples
#! To create an orbital structure we need generators for a group, a set, and an
#! action
#! @BeginExample
#! gap> os := OrbitalStructure([
#! > (1,13,4,14,5)(2,10,12,9,8)(3,7,15,6,11)(16,17,18,20,19),
#! > (1,2,3)(4,6,5)(7,10,13)(8,12,14)(9,11,15)(16,18,21)(17,19,20) ],
#! > [1..21],
#! > OnPoints);;
#! gap> OrbitalRepresentative(os, [16,15]);
#! [ 16, 1 ]
#! gap> c := OrbitalCanonizingElement(os, [16, 15]);
#! (1,10,9,5,15)(2,7,6,8,4)(3,13,14,11,12)(17,20,18,19,21)
#! gap> OnTuples(c, [16,15]);
#! [ 16, 1 ]
#! gap> UnorderedOrbitalRepresentative(os, [16,2]);
#! [ 1, 16 ]
#! gap> c := UnorderedOrbitalCanonizingElement(os, [16,15]);
#! (1,15)(2,4)(3,12)(5,10)(7,8)(11,13)(17,21)(19,20)
#! gap> OnSets(c, Set([16,15]));
#! [ 1, 16 ]
#! gap> AllOrbitalRepresentatives(os)
#! [ [ 1, 1 ], [ 1, 2 ], [ 1, 3 ], [ 1, 4 ], [ 1, 5 ], [ 1, 6 ], [ 1, 16 ],
#!   [ 1, 18 ], [ 1, 20 ], [ 16, 1 ], [ 16, 2 ], [ 16, 3 ], [ 16, 16 ], [ 16, 17 ] ]
#! gap> AllUnorderedOrbitalRepresentatives(os)
#! [ [ 1, 1 ], [ 1, 2 ], [ 1, 4 ], [ 1, 5 ], [ 1, 6 ], [ 1, 16 ], [ 1, 18 ],
#!   [ 1, 20 ], [ 16, 16 ], [ 16, 17 ] ]
#! @EndExample
#!
DeclareCategory( "IsOrbitalStructure", IsObject );
BindGlobal("OrbitalStructureFamily", NewFamily("OrbitalStructureFamily", IsObject ) );
DeclareRepresentation("IsOrbitalStructureRep", IsOrbitalStructure and IsComponentObjectRep, [] );
BindGlobal("OrbitalStructureType", NewType(OrbitalStructureFamily, IsOrbitalStructureRep ) );


#! @Arguments gens, domain, act
#! @Returns An orbital structure
#! @Description
#! Given generators, a set, and an action function create an orbital structure.
#! An orbital structure contains a list of orbits of the group generated by
#! <A>gens</A> on <A>domain</A>, a hashmap that maps any element of <A>domain</A>
#! to the index of its orbit in the list of orbits. We choose the smallest element of
#! each orbit as representative.
#! For each orbit, the orbital structure also contains the stabilizer of the chosen
#! orbit representative, together with all orbits of that stabilizer on <A>domain</A>
#! with chosen representatives.
DeclareGlobalFunction( "OrbitalStructure" );
DeclareGlobalFunction( "OS_OrbitRepresentative" );
DeclareGlobalFunction( "OS_CanonisingElement" );
DeclareGlobalFunction( "OS_CanonisingElementAndRepresentative" );
DeclareGlobalFunction( "OS_StabilizerOf" );



#! @Arguments os, pair
#! @Returns pair
#! @Description
#! Given an orbital structure <A>os</A> and a pair <A>pair</A>
#! of elements of the domain that <A>os</A> is defined on,
#! returns a canonical representative of <A>pair</A> in its orbit
#! of ordered pairs.
DeclareGlobalFunction( "OrbitalRepresentative" );

#! @Arguments os
#! @Description
#! Return the set of canonical representatives of orbits
#! of pairs under the action of the orbital structure.
DeclareGlobalFunction( "AllOrbitalRepresentatives" );

#! @Arguments os, pair
#! @Returns a group element
#! @Description
#! Given an orbital structure <A>os</A> and the pair <A>pair</A>
#! returns an element <M>g</M> of the group that maps <A>pair</A> to
#! <C>OrbitalRepresentative(os, pair)</C>.
DeclareGlobalFunction( "OrbitalCanonizingElement" );
DeclareGlobalFunction( "OrbitalCanonizingElementInverse" );

#! @Arguments os, pair
#! @Returns an iterator
#! @Description
#! Given an orbital structure <A>os</A> and a pair <A>pair</A>,
#! returns an iterator that produces an element <C>g</C> for every
#! element <C>e</C> in the orbit such that 
#! <C>OnTuples(OrbitalRepresentative(os, pair), g) = e</C>.
DeclareGlobalFunction( "OrbitalTransversalIterator" );

#! @Arguments os, pair
#! @Returns pair
#! @Description
#! Given an orbital structure <A>os</A> and a pair <A>pair</A>
#! of elements of the domain that <A>os</A> is defined on,
#! returns a canonical representative of <A>pair</A> in its orbit
#! of sets.
DeclareGlobalFunction( "UnorderedOrbitalRepresentative" );

#! @Arguments os
#! @Description
#! Return the set of canonical representatives of orbits
#! of sets of size two under the action of the orbital structure.
DeclareGlobalFunction( "AllUnorderedOrbitalRepresentatives" );

#! @Arguments os, pair
#! @Returns an iterator
#! @Description
#! Given an orbital structure <A>os</A> and a pair <A>pair</A>,
#! returns an iterator that produces an element <C>g</C> for every
#! element <C>e</C> in the orbit such that
#! <C>OnSets(UnorderedOrbitalRepresentative(os, pair), g) = e</C>.
DeclareGlobalFunction( "UnorderedOrbitalTransversalIterator" );

#! @Arguments os, pair
#! @Returns a group element
#! @Description
#! Given an orbital structure <A>os</A> and the pair <A>pair</A>
#! returns an element <M>g</M> of the group that maps <A>pair</A> to
#! <C>UnorderedOrbitalRepresentative(os, pair)</C>.
DeclareGlobalFunction( "UnorderedOrbitalCanonizingElement" );
DeclareGlobalFunction( "UnorderedOrbitalCanonizingElementInverse" );
