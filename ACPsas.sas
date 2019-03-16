
data notes ;
input prenom $      maths      sciences      francais   latin   art; 
cards;
Jean      6      6      5      6.5      8
Pierre      8      8      8      8      9
André      6      7      11      9.6      11
Jacques      14      14.5      15.5      15      8
Didier      14      14      12      12.5      10
Serge      11      10      5.5      7      13
Alain      5.5      7      14      11.5      10
Eric      13      12.5      8.5      9.5      12
 ;
run;

/* PROGRAMME DE BASE */

proc princomp  data = notes out=b  vardef=n ;
var  maths sciences francais latin  art ;
run;

/* GRANDEURS RELATIVES AUX INDIVIDUS*/

data c; set b;
array k{*} prin1-prin5; 
disto=uss(of k{*}) ;
qlt1=prin1*prin1/disto;
qlt2=prin2*prin2/disto;
keep prin1-prin2 qlt1-qlt2 prenom;
run ;
proc print data=c;
id prenom;
var prin1-prin2 qlt1-qlt2;
title ‘Coordonnees et qualite de representation des individus sur les axes’ ;
run ;

/* COORDONNEES DES VARIABLES*/

proc standard 
data=b
out=bscale
mean=0
std=1;
var prin1-prin5;
run;


proc corr data=b out=d  noprob nosimple;
var prin1-prin5;
with maths sciences francais latin  art ;
run ;

/*GRAPHIQUE DES INDIVIDUS */

data indiv;
set b;
x=prin1;
y=prin2;
xsys='2';
ysys='2';
text = prenom;
run;

proc gplot data=indiv;
title " Representation des individus axe2 * axe1";
plot y*x /annotate=indiv frame href=0 vref=0 ;
symbol1 v=none;
 run;

 /* GRAPHIQUE DES VARIABLES */


data varia;
set d;
x=prin1;
y=prin2;
xsys='2';
ysys='2';
xmin=-1;
xmax=1;
ymax=1;
ymin=-1;
text = _name_;
run;

proc gplot data=varia;
title " Representation des variables axe2 * axe1";
plot y*x /annotate=varia frame href=0 vref=0 haxis=-1 to 1  vaxis=-1 to 1 ;
symbol1 v=none;
 run;
quit;
