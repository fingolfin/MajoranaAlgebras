InstallGlobalFunction( MAJORANA_TauShapes,

    function(tau)
    
    local G, d, orbs, shape, i, x, D, o1, o2, n, gph, comps, binaries, unknowns3X, j, k, shapeslist;    
        
    G := Group(tau);
    d := Size(tau);
    
    orbs := MAJORANA_OrbitalsT(G, [1..d]);
    
    shape := [];
        
    for i in [1 .. Size(orbs.pairreps)] do 
    
        x := orbs.pairreps[i];
    
        D := Group(tau{x});
        
        o1 := Orbit(D, x[1]);
        o2 := Orbit(D, x[2]);
        
        if x[1] in o2 then 
            n := Size(o1);
            
            if n = 1 then 
                Add( shape,  "1A" );
            elif n = 3 then 
                Add( shape,  "3X" );
            elif n = 5 then 
                Add( shape,  "5A" );
            else
                Error("This is not a valid tau map");
            fi;
        else
            n := Size(o1) + Size(o2);
            
            if n = 2 then   
                Add( shape,  "2X" );
            elif n = 4 then 
                Add( shape,  "4X" );
            elif n = 6 then 
                Add( shape,  "6A" );                                
            else
                Error("This is not a valid tau map");
            fi;
        fi;
    od;
    
    # Inclusions of 2A and 3A in 6A algebras
    
    for i in [1..Size(orbs.pairreps)] do
        if shape[i][1] = '6' then 
        
            for x in [orbs.pairreps[i], Reversed(orbs.pairreps[i])] do 
        
                k := orbs.pairorbit[x[1]][x[1]^tau[x[2]]];
                
                shape[k] := "3A";
            
                k := orbs.pairorbit[x[1]][x[2]^(tau[x[1]]*tau[x[2]])];
                
                shape[k] := "2A";
            od;
        fi;
    od;
    
    # Inclusions of 2X into 4X
    
    gph := NullMat(Size(orbs.pairreps), 0);
    
    for i in [1..Size(orbs.pairreps)] do 
        if shape[i][1] = '4' then 
        
            for x in [orbs.pairreps[i], Reversed(orbs.pairreps[i])] do
                Add(gph[i], orbs.pairorbit[x[1]][x[1]^tau[x[2]]]);
            od;
        fi;
    od;
    
    gph := List(gph, DuplicateFreeList);
    
    comps := AutoConnectedComponents(gph);
    
    comps := Filtered(comps, x -> ForAny(shape{x}, y -> y in ["2X", "4X"] ) );
    
    # Put in any known (4B, 2A) pairs
    
    for x in comps do 
        if ForAny(shape{x}, y -> y[2] = 'A') then 
            for i in x do 
                if shape[i][1] = '2' then 
                    shape[i] := "2A";
                else
                    shape[i] := "4B";
                fi;
            od;
        fi;
    od;
    
    unknowns3X := Filtered([1..Size(shape)], i -> shape[i] = "3X");
    
    binaries := AsList(FullRowSpace(GF(2), Size(comps) + Size(unknowns3X) ));
    
    shapeslist := [];
    
    for i in [1..Size(binaries)] do
    
        for j in [1 .. Size(comps)] do 
            
            if binaries[i][j] = 1*Z(2) then
                for k in comps[j] do 
                    if shape[k][1] = '2' then 
                        shape[k] := "2A";
                    else
                        shape[k] := "4B";
                    fi;
                od;
            else
                for k in comps[j] do 
                    if shape[k][1] = '2' then 
                        shape[k] := "2B";
                    else
                        shape[k] := "4A";
                    fi;
                od;
            fi;
        od;
        
        for j in [1 .. Size(unknowns3X)] do
            
            if binaries[i][Size(comps) + j] = 1*Z(2) then
                shape[unknowns3X[j]] := "3A";
            else
                shape[unknowns3X[j]] := "3C";
            fi;
        od;
        
        Add(shapeslist,ShallowCopy(shape));
        
    od;
    
    orbs.orbitals := List(orbs.orbitals, x -> List( x, y -> tau{y} ) ) ;
    
    return rec( group       := Group(tau),
                tau         := tau,
                shapes      := shapeslist,
                orbitals    := orbs.orbitals,
                involutions := tau,
                pairreps    := orbs.pairreps,
                pairorbit   := orbs.pairorbit,
                pairconj    := orbs.pairconj,
                pairconjelts := orbs.pairconjelts     );
    
    end );

InstallGlobalFunction( MAJORANA_TauRecordCoords, 

    function(i, j, rep, algebras)
    
    local k, subrep, g, n, dim, emb, pos, shape, list, im, x;
    
    k := rep.setup.pairorbit[i][j];
    
    shape := rep.shape[k];
    
    subrep := algebras.(shape);
    
    g := subrep.group;
    
    n := Size(subrep.involutions);
    
    emb := [1..n]*0;;
    
    if n in [3,5] then
        for k in [1 .. n] do 
            pos := Position(subrep.setup.coords, g.1^((g.1*g.2)^k));
            emb[pos] := i^((rep.tau[i]*rep.tau[j])^k);
        od;
    elif n in [2,4,6] then 
        for k in [0 .. n/2 - 1] do 
            pos := Position(subrep.setup.coords, g.1^((g.1*g.2)^k));
            emb[pos] := i^((rep.tau[i]*rep.tau[j])^k);
            pos := Position(subrep.setup.coords, g.2^((g.1*g.2)^k));
            emb[pos] := j^((rep.tau[i]*rep.tau[j])^k);
        od;
    fi;
    
    rep.setup.embeddings[i][j] := emb;

    # Add new basis vectors
    
    dim := Size(subrep.setup.coords);
    
    for k in [n + 1 .. dim] do 
        
        list := Positions(subrep.setup.poslist, k);
        
        if shape = "5A" then
            Append(list, Positions(subrep.setup.poslist, -k));
        fi;
        
        im := List(subrep.setup.longcoords{list}, x -> SortedList(emb{x}));
        
        x := First(im, y -> y in rep.setup.longcoords);
        
        if x = fail then 
            Add(rep.setup.coords, im[1]);
            pos := Size(rep.setup.coords);
            
            Append(rep.setup.longcoords, im);
            
            if shape = "5A" then
                Append(rep.setup.poslist, List([1..5], y -> pos));
                Append(rep.setup.poslist, List([1..5], y -> -pos));
            else
                Append(rep.setup.poslist, List(im, y -> pos));
            fi;
        else
            im := Filtered(im, y -> not y in rep.setup.longcoords);
            pos := rep.setup.poslist[Position(rep.setup.longcoords, x)];
                        
            Append(rep.setup.longcoords, im); 
            Append(rep.setup.poslist, List(im, y -> pos));
        fi;
    od;
    
    end );
            
InstallGlobalFunction( MAJORANA_TauSetUp,

    function(input, index)
    
    local rep, t, gens, x, i, j, k, s, dim, pos, emb, shape, subrep;
    
    t := Size(input.tau);
    
    rep         := rec( group       := input.group,
                        tau         := input.tau,
                        involutions := input.tau,
                        shape       := input.shapes[index] );
                        
    rep.setup   := rec( coords          := [1..t],
                        longcoords      := [1..t],
                        poslist         := [1..t],
                        pairorbit       := input.pairorbit,
                        pairconj        := input.pairconj,
                        pairconjelts    := input.pairconjelts   );
                        
    gens := List(rep.tau, ListPerm);
    
    for i in [1..t] do 
        Append(gens[i], [Size(gens[i]) + 1 .. t]);
    od;

    x := MAJORANA_Orbits(gens, t, rep.setup);

    rep.setup.conjelts := x.conjelts;
    rep.setup.orbitreps := x.orbitreps;
    
    # rep.setup.pairconjelts := List(rep.setup.pairconjelts, x -> ListPerm(x, t));

    rep.setup.embeddings := NullMat(t, t);;
    
    for i in [1..t] do
        for j in [i + 1 .. t] do 
            k := input.pairorbit[i][j];
            if rep.shape[k] in ["4B", "6A"] then 
                MAJORANA_TauRecordCoords( i, j, rep, MAJORANA_DihedralAlgebras);
            fi;
         od;
    od;
    
    for i in [1..t] do
        for j in [i + 1 .. t] do 
            k := input.pairorbit[i][j];
            if not rep.shape[k] in ["4B", "6A"] then 
                MAJORANA_TauRecordCoords( i, j, rep, MAJORANA_DihedralAlgebras);
            fi;
         od;
    od;
    
    dim := Size(rep.setup.coords);
    
    rep.setup.nullspace := rec( heads := [1..dim]*0, vectors := SparseMatrix(0, dim, [], [], Rationals));
    
    rep.setup.pairorbit := NullMat(dim,dim);
    rep.setup.pairconj  := NullMat(dim,dim);
    
    for i in [1..t] do 
        for j in [1..t] do 
            rep.setup.pairorbit[i][j] := input.pairorbit[i][j];
            rep.setup.pairconj[i][j]  := input.pairconj[i][j];
        od;
    od;
    
    rep.setup.pairreps  := ShallowCopy(input.pairreps);
    rep.setup.pairconjelts := List(input.pairconjelts, x -> MAJORANA_FindPerm(x, rep, rep));

    gens := GeneratorsOfGroup(input.group);
    gens := List(gens, x -> MAJORANA_FindPerm(x, rep, rep));

    x := MAJORANA_Orbits(gens, t, rep.setup);

    rep.setup.conjelts := x.conjelts;
    rep.setup.orbitreps := x.orbitreps;

    MAJORANA_Orbitals(gens, t, rep.setup);
    
    s := Size(rep.setup.pairreps);
    
    rep.algebraproducts := List([1..s], x -> false);
    rep.innerproducts   := List([1..s], x -> false);
    rep.evecs           := NullMat(t,3);
    rep.nullspace := SparseMatrix(0, dim, [], [], Rationals);

    # Set up eigenvector matrix

    for j in [1..t] do
        if j in rep.setup.orbitreps then
            for k in [1..3] do
                rep.evecs[j][k] := SparseMatrix(0, dim, [], [], Rationals);
            od;
        else
            for k in [1..3] do
                rep.evecs[j][k] := false;
            od;
        fi;
    od;

    # Check for any 2A algebras coming from the more axes func
    
    if IsBound(input.algebras2A) then 
        for i in Filtered( [1 .. Size(rep.shape)], k -> rep.shape[k] = "2A" ) do 
            x := First(input.algebras2A, y -> Size( Intersection(y, input.pairreps[i])) = 2 );
            
            j := PositionProperty(x, y -> not y in input.pairreps[i]);
            
            rep.algebraproducts[i] := SparseMatrix(1, dim, [ x ] , [[1/8, 1/8, 1/8]], Rationals);
            rep.algebraproducts[i]!.entries[j] := -1/8;
            
            for k in Filtered( input.pairreps, x -> x in rep.setup.orbitreps) do
                
                
                ### TODO Add evecs from these 2A algebras
                
            od;
        od;
    fi;

    # Embed dihedral algebras
    
    for i in [1..t] do 
        for j in [i + 1 .. t] do 
    
            shape := rep.shape[rep.setup.pairorbit[i][j]];
            subrep := MAJORANA_DihedralAlgebras.(shape);
            emb := rep.setup.embeddings[i][j];
            
            for k in [Size(emb) + 1 .. Size(subrep.setup.coords)] do 
                x := SortedList(emb{subrep.setup.coords[k]});
                
                pos := Position(rep.setup.longcoords, x);
                pos := rep.setup.poslist[pos];
                
                Add(emb, pos);
            od;
            
            MAJORANA_Embed(rep, subrep, emb);
            
        od;
    od;
    
    for i in rep.setup.orbitreps do
        for j in [1..3] do 
            rep.evecs[i][j] := MAJORANA_BasisOfEvecs(rep.evecs[i][j]);
        od; 
    od;
    
    for x in rep.algebraproducts do 
        if x <> false then x!.ncols := dim; fi;
    od;
    
    return rep;
    
    end );
    
InstallGlobalFunction( TauMapMajoranaRepresentation,

    function(input, index)
    
    local rep, unknowns, main;
    
    rep := MAJORANA_TauSetUp(input, index);
    
    while true do
        
        unknowns := Positions(rep.algebraproducts, false);
                                
        main := MAJORANA_MainLoop(rep);
        
        Info(InfoMajorana, 20, STRINGIFY( "There are ", Size(Positions(rep.algebraproducts, false)), " unknown algebra products ") );
        Info(InfoMajorana, 20, STRINGIFY( "There are ", Size(Positions(rep.innerproducts, false)), " unknown inner products ") );

        if not false in rep.algebraproducts then
            Info( InfoMajorana, 10, "Success" );
            return rep;
        elif ForAll(rep.algebraproducts{unknowns}, x -> x = false) then 
            Info( InfoMajorana, 10, "Fail" );
            rep.mat := main.mat; rep.vec := main.vec; rep.unknowns := main.unknowns;
            return rep;
        fi;
    od;
    
    end );
    
InstallGlobalFunction( MAJORANA_MoreAxes,

    function(input, index)
    
    local shape, list, tau, i, j, k, x, y, new, algebras2A, t;
    
    shape := input.shapes[index];
    list := [];
    tau := input.involutions;
    t := Size(tau);
    
    for i in [1 .. t] do 
        if Intersection( shape{ input.pairorbit[i] }, [ "3A", "3C", "4A", "4B", "5A", "6A" ] ) = [] then 
            Add(list, i);
        fi;
    od;
    
    algebras2A := [];
    
    for i in list do 
        for j in [i + 1 .. t] do 
        
            k := input.pairorbit[i][j];
        
            if shape[k] = "2A" then 
                
                if tau[j] <> () then 
                    Error("Non-trivial tau map - need to work out how to deal with this case!");
                fi;
                
                Add( tau, () );
                
                if input.pairreps[k] = [i,j] then 
                    Add(algebras2A, [i, j, Size(tau)] );
                fi;
            fi;
        od;
    od;
    
    new := MAJORANA_TauShapes(tau);
    
    for x in algebras2A do 
    
        for y in Combinations( x, 2) do  
        
            k := new.pairorbit[y[1]][y[2]];
            
            new.shapes := Filtered(new.shapes, x -> x[k] = "2A" );
        od;
    od;
    
    for i in [1..Size(shape)] do 
        j := Position(new.pairreps, input.pairreps[i]);
        
        new.shapes := Filtered(new.shapes, x -> shape[i] = x[j]);
    od;
    
    new.algebras2A := algebras2A; # TODO Need to implement this change in setup, i.e. use these triples to record algebra products
    
    return new;
    
    end );
    
InstallGlobalFunction( OnLists, 

    function(list, g) 
    
    return list{List([1..Size(list)], i -> i^g)}; 
    
    end );
    
InstallGlobalFunction( MAJORANA_TauRemoveDuplicateShapes,

    function(input)
    
    local t, S, positions, perms, perm, g, x, im, k, i, pos;
    
    t := Size(input.tau);
    
    positions := List(input.tau, x -> Position(input.tau, x));
    
    S := Stabilizer(SymmetricGroup(t), positions, OnLists);
    
    S := List(AsList(S), x -> ListPerm(x, t));
    
    perms := [];
    
    for g in S do 
        perm := [];
        
        for x in input.pairreps do 
            
            im := g{x};
            
            k := input.pairorbit[im[1]][im[2]];
            
            if k < 0 then Error("Maps to negative pair, not sure what to do in this case"); fi;
            
            Add(perm, k);
        od;
        
        Add(perms, perm);
    od;
    
    
    for i in [1..Size(input.shapes)] do 
        if IsBound(input.shapes[i]) then 
            for g in perms do 
                pos := Position(input.shapes, input.shapes[i]{g});
                if pos <> fail and pos <> i then 
                    Unbind(input.shapes[pos]);
                fi;
            od;
        fi;
    od;
    
    input.shapes := Compacted(input.shapes);
    
    end );
    
InstallGlobalFunction( MAJORANA_LatexRep, 

    function( list ) # Of the form [ Structure description of group, length of orbits on axes, shape, dim ]
    
    local str, group, axes, shape, dim, i, x;
    
    str := [];;
    
    group := list[1];
    axes := list[2];
    
    if IsBound(list[3]) then 
        shape := Filtered( list[3], x -> not x in ["1A", "5A"] );
    else 
        shape := [];
    fi; 
    
    dim := list[4];
    
    Append( str, STRINGIFY( group, " & " , axes[1] ) );
    
    for i in [2 .. Size(axes)] do 
        Append( str, STRINGIFY(" + ", axes[i]) );
    od;
    
    Append(str, " & ");
    
    if shape <> [] then 
        Append( str, STRINGIFY(" ( ", shape[1]  ));
                
        for x in shape{[2.. Size(shape)]} do 
            Append(str, STRINGIFY(", ", x));
        od;
        
        Append( str, ")" );
    fi;
    
    
    Append( str, STRINGIFY( " & ", dim) );
    
    return str;
    
    end );

    
InstallGlobalFunction( MAJORANA_LatexNonMinimalOutput,

    function(reps)
    
    local rep, bad, i, x, subs, row, str, dim;
    
    str := [];
    
    for rep in reps do 
    
        bad := IsMinimal3GeneratedAlgebra(rep);
        
        if bad <> true then 
        
            subs := List(bad, x -> MAJORANA_SubalgebraAxes(rep, x));
                
            row := List(subs, x -> [    StructureDescription( Group(x[1]) ),                        # Iso type of group
                                        List( Orbits( Group(x[1]), [1 .. Size(x[1])] ), Length ),   # Lengths of orbits on axes
                                        ,                                                           # No shape, fill in manually
                                        Size(x[2])      ] );                                        # Dim of alg
            
            row := DuplicateFreeList(row);
            
            #  Print the rep info on first line
            
            if MAJORANA_IsComplete(rep) then
                dim := MAJORANA_Dimension(rep);
            else
                dim := STRINGIFY( MAJORANA_Dimension(rep), " ? ");
            fi;
            
            Append( str, MAJORANA_LatexRep( [ StructureDescription(rep.group), 
                                            List( Orbits(rep.group, [1.. Size(rep.involutions)]), Length),
                                            rep.shape,
                                            dim       ] ) );
                                            
            Append( str, " & " );
            
            # Also print first subalg on first line 
            
            Append( str, STRINGIFY( MAJORANA_LatexRep( row[1]), """ \\ """, "\n " ) );

            for i in [2 .. Size(row)] do 
               Append(str, " & & & & ");
               Append(str, MAJORANA_LatexRep( row[i] ));
               Append(str, STRINGIFY( """ \\""", " \n ") );
            od;
           
            Append(str, STRINGIFY( """&&&&&&& \\ """, "\n "));
            
        fi;
        
    od;
    
    return str;
    
    end );
