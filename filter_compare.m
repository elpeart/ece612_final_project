wp = [0.3 0.5];
ws = [0.2 0.6];
rp = 1;
rs = 100;

[n, Wn] = buttord(wp, ws, rp, rs);
[b, a] = butter(n, Wn);
freqz(b, a)
title('Butter')

[nc, Wnc] = cheb1ord(wp, ws, rp, rs);
[bc, ac] = cheby1(nc, rp, Wnc);
figure;
freqz(bc, ac)
title('cheby1')

[nc2, Wnc2] = cheb2ord(wp, ws, rp, rs);
[bc2, ac2] = cheby1(nc2, rs, Wnc2);
figure;
freqz(bc2, ac2)
title('cheby2')

[ne, Wne] = ellipord(wp, ws, rp, rs);
[be, ae] = ellip(ne, rp, rs, Wne);
figure;
freqz(be, ae)
title('ellipse')