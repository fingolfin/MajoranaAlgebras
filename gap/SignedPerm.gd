# Signed permutations

DeclareCategory("IsSignedPerm",
                IsAssociativeElement and
                IsExtLElement and
                IsExtRElement and
                IsMultiplicativeElement and
                IsMultiplicativeElementWithOne and
                IsMultiplicativeElementWithInverse and
                IsFiniteOrderElement );

BindGlobal("SignedPermFamily", NewFamily("SignedPermFamily", IsSignedPerm));

DeclareCategoryCollections( "IsSignedPerm" );
DeclareCategoryCollections( "IsSignedPermCollection" );
InstallTrueMethod( IsGeneratorsOfMagmaWithInverses
                 , IsSignedPermCollection );

DeclareOperation( "ListSignedPerm", [ IsSignedPerm ] );
DeclareOperation( "ListSignedPerm", [ IsSignedPerm, IsPosInt] );

DeclareGlobalFunction("SignedPerm");
DeclareConstructor( "NewSignedPerm", [ IsSignedPerm, IsList ] );
DeclareConstructor( "NewSignedPerm", [ IsSignedPerm, IsPerm, IsList ] );


DeclareRepresentation("IsSignedPermRep", IsSignedPerm and IsPositionalObjectRep, []);
BindGlobal("SignedPermType", NewType(SignedPermFamily, IsSignedPermRep));

DeclareRepresentation("IsSignedPermListRep", IsSignedPerm and IsPositionalObjectRep, []);
BindGlobal("SignedPermListType", NewType(SignedPermFamily, IsSignedPermListRep));

DeclareGlobalFunction("OnPosPoints");
DeclareGlobalFunction("RandomSignedPermList");
DeclareGlobalFunction("RandomSignedPerm");
