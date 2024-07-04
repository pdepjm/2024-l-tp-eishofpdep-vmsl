% TP Lógico Eish of PDEP - Grupo Vmsl - 1era entrega
% Civilizaciones y tecnologías


% 1) 
unJugador(ana).
unJugador(beto).
unJugador(carola).
unJugador(dimitri).

juegaCon(ana,romanos).
juegaCon(beto,incas).
juegaCon(carola,romanos).
juegaCon(dimitri,romanos).

desarrolloTecnologia(ana,herreria).
desarrolloTecnologia(ana,forja).
desarrolloTecnologia(ana,emplumado).
desarrolloTecnologia(ana,laminas).

desarrolloTecnologia(beto,herreria).
desarrolloTecnologia(beto,forja).
desarrolloTecnologia(beto,fundicion).

desarrolloTecnologia(carola,herreria).

desarrolloTecnologia(dimitri,herreria).
desarrolloTecnologia(dimitri,fundicion).

% 2) 
/*
Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería, forja y o bien desarrolló fundición o bien juega con los romanos.
En los ejemplos, Ana y Beto son expertos en metales, pero Carola y Dimitri no.
*/
expertoEnMetales(Jugador):-
    condicionExperto(Jugador),
    desarrolloTecnologia(Jugador,fundicion).

expertoEnMetales(Jugador):-
    condicionExperto(Jugador),
    juegaCon(Jugador,romanos).

condicionExperto(Jugador):-
    desarrolloTecnologia(Jugador,herreria),
    desarrolloTecnologia(Jugador,forja).
% 3) 
/*
Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
En los ejemplos, los romanos son una civilización popular, pero los incas no.
*/


civilizacionPopular(Civilizacion):-
    juegaCon(Jugador1,Civilizacion),
    juegaCon(Jugador2,Civilizacion),
    Jugador1 \= Jugador2.

% 4) 
/*
Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.
En los ejemplos, la herrería tiene alcance global, pues Ana, Beto, Carola y Dimitri la desarrollaron.
*/
unaTecnologia(herreria).
unaTecnologia(forja).
unaTecnologia(fundicion).
unaTecnologia(emplumado).
unaTecnologia(laminas).

tieneAlcanceGlobal(Tecnologia):-
    unaTecnologia(Tecnologia),
    forall(unJugador(Jugador), desarrolloTecnologia(Jugador, Tecnologia)).


% 5) 
/*
Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó todas las tecnologías que alcanzaron las demás. Una civilización alcanzó una tecnología cuando algún jugador de esa civilización la desarrolló.
En los ejemplos, los romanos son una civilización líder pues entre Ana y Dimitri, que juegan con romanos, ya tienen todas las tecnologías que se alcanzaron.
*/

civilizacionAlcanzoTecnologia(Civilizacion,Tecnologia):-
    unJugador(Jugador),
    juegaCon(Jugador,Civilizacion),
    desarrolloTecnologia(Jugador,Tecnologia).

esLider(Civilizacion):-
    juegaCon(_,Civilizacion),
    forall(civilizacionAlcanzoTecnologia(Civilizacion2, Tecnologia),civilizacionAlcanzoTecnologia(Civilizacion, Tecnologia)).