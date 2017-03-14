gap> a:=(1,2)(3,4)(5,6);; b:=(1,4)(2,3);; c:=(2,4);;
gap> G:=Group(a,b,c);;
gap> T1:=[a,b,c,a*b,(1,4)(2,3)(5,6),(1,2)(4,3),(1,3)];;
gap> MajoranaRepresentation(G,T1);
[ [ [ "1A", "4A", "4A", "2B", "2B", "1A", "2B", "2A", "2B", "2A", "1A", "2A", 
          "2B", "1A" ], "Error", "Fusion of 0,0 eigenvectors does not hold", 
      1, [ 1, -4, 0, -4, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0 ], 
      [ [ 0, 0, 1, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 1/64, 3/64, 0, 0, 3/64, 1/64, -3/64, 0 ], 
          [ 3/64, 0, 3/64, 0, 1/64, 0, 1/64, 0, -3/64 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 1/8, -1/8, 1/8, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, -1/8, 1/8, 1/8, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 1/8, -1/8, 0, 1/8, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 1, 0, 0, 0, 0, 0 ], 
          [ 0, -1/8, 5/16, 0, 0, -1/8, -1/16, 3/16, 0 ], 
          [ -1/8, 0, 5/16, 0, -1/8, 0, -1/16, 0, 3/16 ], 
          [ 0, -1/16, -1/8, 0, 0, 5/16, -1/8, 3/16, 0 ], false, false, 
          [ 5/16, 0, -1/8, 0, -1/16, 0, -1/8, 0, 3/16 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 1, 0 ], false, false, 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 1 ], false ], 
      [ 
          [ (1,2)(3,4)(5,6), (1,4)(2,3), (2,4), (1,3)(2,4)(5,6), (1,4)(2,3)(5,6),
              (1,2)(3,4), (1,3), (1,2,3,4), (1,2,3,4)(5,6) ], 
          [ (1,2)(3,4)(5,6), (1,4)(2,3), (2,4), (1,3)(2,4)(5,6), 
              (1,4)(2,3)(5,6), (1,2)(3,4), (1,3), (1,2,3,4), (1,4,3,2), 
              (1,2,3,4)(5,6), (1,4,3,2)(5,6) ], 
          [ [ 11, 10, 3, 12, 13, 7, 3, 19, 20 ], 
              [ 10, 6, 2, 8, 7, 9, 2, 17, 18 ], 
              [ 3, 2, 1, 5, 3, 2, 4, 15, 16 ], 
              [ 12, 8, 5, 14, 12, 8, 5, 23, 25 ], 
              [ 13, 7, 3, 12, 11, 10, 3, 19, 20 ], 
              [ 7, 9, 2, 8, 10, 6, 2, 17, 18 ], 
              [ 3, 2, 4, 5, 3, 2, 1, 15, 16 ], 
              [ 19, 17, 15, 23, 19, 17, 15, 21, 22 ], 
              [ 20, 18, 16, 25, 20, 18, 16, 22, 24 ] ], 
          [ [ (), (2,4), (), (), (), (), (1,2)(3,4), (), () ], 
              [ (2,4), (2,4), (2,4), (2,4), (2,4), (2,4), (1,2,3,4), 
                  (1,2,3,4), (1,2,3,4) ], 
              [ (), (2,4), (), (), (2,4), (), (), (), () ], 
              [ (), (2,4), (), (), (2,4), (), (1,2)(3,4), (), () ], 
              [ (2,4), (2,4), (2,4), (2,4), (2,4), (), (1,2,3,4), (1,2,3,4), 
                  (1,2,3,4) ], [ (), (), (), (), (), (), (1,2)(3,4), (), () ],
              [ (1,2)(3,4), (1,2,3,4), (1,2)(3,4), (1,2)(3,4), (1,2,3,4), 
                  (1,2)(3,4), (1,2)(3,4), (1,2,3,4), (1,2,3,4) ], 
              [ (), (1,2,3,4), (), (), (1,2,3,4), (), (1,2,3,4), (), () ], 
              [ (), (1,2,3,4), (), (), (1,2,3,4), (), (1,2,3,4), (), () ] ], 
          [ 1, 2, 3, 4, 5, 6, 7, 8, 8, 9, 9 ], [  ] ] ] ]
gap> T2:=[a,b,c,a*b,(1,4)(2,3)(5,6),(1,2)(4,3),(1,3),(1,3)(5,6),(2,4)(5,6)];;
gap> MajoranaRepresentation(G,T2);
[ [ [ "1A", "2B", "4A", "4A", "2B", "2A", "2A", "1A", "4A", "4A", "2B", "2A", 
          "1A", "2B", "2A", "2B", "2A", "1A", "2A", "2B", "1A" ], "Error", 
      "Fusion of 0,0 eigenvectors does not hold", 1, 
      [ 1, -4, 0, -4, 0, 0, 0, 0, 0, 0, 0 ], 
      [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], 
      [ [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 1/64, 3/64, 0, 0, 3/64, 1/64, 0, 0, -3/64, 0 ], 
          [ 3/64, 0, 3/64, 0, 1/64, 0, 1/64, 0, 0, 0, -3/64 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 1/8, -1/8, 0, 0, 0, 1/8, 0, 0, 0 ], 
          [ 0, 0, 1/8, 1/8, 0, 0, 0, -1/8, 0, 0, 0 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ], 
          [ 0, 1/64, 0, 0, 0, 3/64, 0, 1/64, 3/64, 0, -3/64 ], 
          [ 3/64, 0, 0, 0, 1/64, 0, 0, 1/64, 3/64, -3/64, 0 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 1/8, 0, 0, -1/8, 0, 1/8, 0, 0 ], 
          [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 1/8, -1/8, 1/8, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, -1/8, 1/8, 1/8, 0, 0, 0, 0, 0 ], 
          [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 1/8, -1/8, 0, 1/8, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], 
          [ 0, -1/8, 5/16, 0, 0, -1/8, -1/16, 0, 0, 3/16, 0 ], 
          [ -1/8, 0, 5/16, 0, -1/8, 0, -1/16, 0, 0, 0, 3/16 ], 
          [ -1/8, 0, 0, 0, -1/8, 0, 0, -1/16, 5/16, 3/16, 0 ], 
          [ 0, -1/8, 0, 0, 0, -1/8, 0, -1/16, 5/16, 0, 3/16 ], 
          [ 0, -1/16, -1/8, 0, 0, 5/16, -1/8, 0, 0, 3/16, 0 ], 
          [ 0, -1/16, 0, 0, 0, 5/16, 0, -1/8, -1/8, 0, 3/16 ], 
          [ 5/16, 0, 0, 0, -1/16, 0, 0, -1/8, -1/8, 3/16, 0 ], 
          [ 5/16, 0, -1/8, 0, -1/16, 0, -1/8, 0, 0, 0, 3/16 ], 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ], false, false, 
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ], false ], 
      [ 
          [ (1,2)(3,4)(5,6), (1,4)(2,3), (2,4), (1,3)(2,4)(5,6), (1,4)(2,3)(5,6),
              (1,2)(3,4), (1,3), (1,3)(5,6), (2,4)(5,6), (1,2,3,4), 
              (1,2,3,4)(5,6) ], 
          [ (1,2)(3,4)(5,6), (1,4)(2,3), (2,4), (1,3)(2,4)(5,6), 
              (1,4)(2,3)(5,6), (1,2)(3,4), (1,3), (1,3)(5,6), (2,4)(5,6), 
              (1,2,3,4), (1,4,3,2), (1,2,3,4)(5,6), (1,4,3,2)(5,6) ], 
          [ [ 18, 17, 4, 19, 20, 14, 4, 10, 10, 28, 29 ], 
              [ 17, 13, 3, 15, 14, 16, 3, 9, 9, 26, 27 ], 
              [ 4, 3, 1, 7, 4, 3, 5, 6, 2, 22, 23 ], 
              [ 19, 15, 7, 21, 19, 15, 7, 12, 12, 32, 34 ], 
              [ 20, 14, 4, 19, 18, 17, 4, 10, 10, 28, 29 ], 
              [ 14, 16, 3, 15, 17, 13, 3, 9, 9, 26, 27 ], 
              [ 4, 3, 5, 7, 4, 3, 1, 2, 6, 22, 23 ], 
              [ 10, 9, 6, 12, 10, 9, 2, 8, 11, 24, 25 ], 
              [ 10, 9, 2, 12, 10, 9, 6, 11, 8, 24, 25 ], 
              [ 28, 26, 22, 32, 28, 26, 22, 24, 24, 30, 31 ], 
              [ 29, 27, 23, 34, 29, 27, 23, 25, 25, 31, 33 ] ], 
          [ [ (), (2,4), (), (), (), (), (1,2)(3,4), (1,2)(3,4), (), (), () ],
              [ (2,4), (2,4), (2,4), (2,4), (2,4), (2,4), (1,2,3,4), 
                  (1,2,3,4), (2,4), (1,2,3,4), (1,2,3,4) ], 
              [ (), (2,4), (), (), (2,4), (), (), (), (), (), () ], 
              [ (), (2,4), (), (), (2,4), (), (1,2)(3,4), (1,2)(3,4), (), (), 
                  () ], 
              [ (2,4), (2,4), (2,4), (2,4), (2,4), (), (1,2,3,4), (1,2,3,4), 
                  (2,4), (1,2,3,4), (1,2,3,4) ], 
              [ (), (), (), (), (), (), (1,2)(3,4), (1,2)(3,4), (), (), () ], 
              [ (1,2)(3,4), (1,2,3,4), (1,2)(3,4), (1,2)(3,4), (1,2,3,4), 
                  (1,2)(3,4), (1,2)(3,4), (1,2)(3,4), (1,2)(3,4), (1,2,3,4), 
                  (1,2,3,4) ], 
              [ (1,2)(3,4), (1,2,3,4), (), (1,2)(3,4), (1,2,3,4), (1,2)(3,4), 
                  (1,2)(3,4), (1,2)(3,4), (1,2)(3,4), (1,2,3,4), (1,2,3,4) ], 
              [ (), (2,4), (), (), (2,4), (), (1,2)(3,4), (), (), (), () ], 
              [ (), (1,2,3,4), (), (), (1,2,3,4), (), (1,2,3,4), (1,2,3,4), 
                  (), (), () ], 
              [ (), (1,2,3,4), (), (), (1,2,3,4), (), (1,2,3,4), (1,2,3,4), 
                  (), (), () ] ], 
          [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 11, 11 ], [  ] ] ] ]
