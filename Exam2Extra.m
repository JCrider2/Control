

wc = 2;

Kt = 0.707;
td = 0.005;
tn = 1/(2*3.141592653*wc);

[A,B,C,D] = tf2ss([Kt*tn 1],[td 1]);



