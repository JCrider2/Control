


function [A B] = dutchRoll(Data, u)

    A = [Data.Yb/u Data.Yp/u -(1-Data.Yr/u);
        Data.Lb Data.Lp Data.Lr;
        Data.Nb Data.Np Data.Nr];
    B = [0 Data.Ydr/u;
        Data.Lda Data.Ldr;
        Data.Nda Data.Ndr];
end