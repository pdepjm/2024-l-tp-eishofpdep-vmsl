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
    unJugador(Jugador),
    desarrolloTecnologia(Jugador,herreria),
    desarrolloTecnologia(Jugador,forja),
    desarrolloTecnologia(Jugador,fundicion).

expertoEnMetales(Jugador):-
    unJugador(Jugador),
    desarrolloTecnologia(Jugador,herreria),
    desarrolloTecnologia(Jugador,forja),
    juegaCon(Jugador,romanos).

% 3) 
/*
Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
En los ejemplos, los romanos son una civilización popular, pero los incas no.
*/
civilizacion(romanos).
civilizacion(incas).

civilizacionPopular(Civilizacion):-
    civilizacion(Civilizacion),
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

% Punto 10
unaTecnologia(malla).
unaTecnologia(placas).
unaTecnologia(horno).
unaTecnologia(punzon).

unaTecnologia(molino).
unaTecnologia(collera).
unaTecnologia(arado).


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
    civilizacion(Civilizacion),
    forall(unaTecnologia(Tecnologia), civilizacionAlcanzoTecnologia(Civilizacion, Tecnologia)).

% 6)
/*Modelar lo necesario para representar las distintas unidades de cada jugador de la forma más conveniente 
para resolver los siguientes puntos. Incluir los siguientes ejemplos: */
jinete(caballo, 90).
jinete(camello, 80).

piquero(escudo, 1, Vida).
piquero(escudo, 2, Vida).
piquero(escudo, 3, Vida).
piquero(sinEscudo, 1, 50).
piquero(sinEscudo, 2, 65).
piquero(sinEscudo, 3, 70).

campeon(Vida).

%Ana tiene un jinete a caballo, un piquero con escudo de nivel 1, y un piquero sin escudo de nivel 2.
unidad(ana, [jinete(caballo, 90),piquero(escudo, 1, vidaPiquero(escudo, 1, Vida)),piquero(sinEscudo, 2, 65)]).

%Beto tiene un campeón de 100 de vida, otro de 80 de vida, un piquero con escudo nivel 1 y un jinete a camello.
unidad(beto, [campeon(100), campeon(80), piquero(escudo, 1, Vida), jinete(camello, 80)]).

%Carola tiene un piquero sin escudo de nivel 3 y uno con escudo de nivel 2.
unidad(carola, [piquero(sinEscudo, 3, 70), piquero(escudo, 2, Vida)]).

%Dimitri no tiene unidades.
unidad(dimitri, []).


% 7)
%Conocer la unidad con más vida que tiene un jugador, teniendo en cuenta que:
/*Los jinetes a camello tienen 80 de vida y los jinetes a caballo tienen 90.
Cada campeón tiene una vida distinta.
Los piqueros sin escudo de nivel 1 tienen vida 50, los de nivel 2 tienen vida 65 y los de nivel 3 tienen 70 de vida.
Los piqueros con escudo tienen 10% más de vida que los piqueros sin escudo.
En los ejemplos, la unidad más “viva” de Ana es el jinete a caballo, pues tiene 90 de vida, y ninguno de sus dos piqueros tiene tanta vida.*/
unidadConMasVida(Jugador, UnidadMax):-
    unidad(Jugador, Unidades),
    findall(Vida, (member(Unidad, Unidades), vidaUnidad(Unidad,Vida)), VidaUnidades),
    max_member(VidaMax, VidaUnidades),
    findall(Unidad, (member(Unidad, Unidades), vidaUnidad(Unidad, VidaMax)), UnidadMax).


vidaUnidad(jinete(_, Vida), Vida).
vidaUnidad(campeon(Vida), Vida).
vidaUnidad(piquero(Escudo, Nivel, Vida), Vida):-
    vidaPiquero(Escudo, Nivel, Vida).

vidaPiquero(escudo, Nivel, Vida):-
    piquero(sinEscudo, Nivel, VidaSinEscudo),
    Vida is VidaSinEscudo * (1.1).

% 8)
/*Queremos saber si una unidad le gana a otra. Las unidades tienen una ventaja por tipo sobre otras. 
Cualquier jinete le gana a cualquier campeón, cualquier campeón le gana a cualquier piquero 
y cualquier piquero le gana a cualquier jinete, pero los jinetes a camello le ganan a los a caballo.
En caso de que no exista ventaja entre las unidades, se compara la vida (el de mayor vida gana). 
Este punto no necesita ser inversible. Por ejemplo, un campeón con 95 de vida le gana a otro con 50, 
pero un campeón con 100 de vida no le gana a un jinete a caballo.*/
leGanaA(jinete(_, _), campeon(_)).
leGanaA(campeon(_), piquero(_, _, _)).
leGanaA(piquero(_, _, _), jinete(_, _)).
leGanaA(jinete(camello, _), jinete(caballo, _)).

gana(Unidad1,Unidad2):-
    leGanaA(Unidad1,Unidad2). 

gana(Unidad1,Unidad2):-
    not(leGanaA(Unidad2, Unidad1)),
    vidaUnidad(Unidad1,Vida1),
    vidaUnidad(Unidad2,Vida2),
    Vida1 > Vida2.

% 9)
/*Saber si un jugador puede sobrevivir a un asedio. Esto ocurre si tiene más piqueros con escudo que sin escudo.
En los ejemplos, Beto es el único que puede sobrevivir a un asedio, pues tiene 1 piquero con escudo y 0 sin escudo.*/
cuenta_piqueros(Jugador, Tipo, Cantidad) :-
    unidad(Jugador, Unidades),
    findall(P, (member(P, Unidades), P = piquero(Tipo, _, _)), Lista),
    length(Lista, Cantidad).

sobreviveAsedio(Jugador):-
    unJugador(Jugador),
    cuenta_piqueros(Jugador, escudo, CantConEscudo),
    cuenta_piqueros(Jugador, escudo, CantSinEscudo),
    CantConEscudo > CantSinEscudo.


% 10) Árbol de tecnologías
 /* a) Se sabe que existe un árbol de tecnologías, que indica dependencias entre ellas. Hasta no desarrollar una, no se puede desarrollar la siguiente. Modelar el siguiente árbol de ejemplo: */
%  requiere(tecnologia, dependencia)
requiere(emplumado, herreria).
requiere(punzon, emplumado).
requiere(forja, herreria).

requiere(laminas, herreria).
requiere(malla, laminas).
requiere(placas, malla).

requiere(fundicion, forja).
requiere(horno, fundicion).

requiere(collera, molino).
requiere(arado, collera).

dependenciaDirecta(Tecnologia, Dependencia):-
    unaTecnologia(Tecnologia),
    unaTecnologia(Dependencia),
    requiere(Tecnologia, Dependencia).

dependenciaDirecta(Tecnologia, Subdependencia):-
    unaTecnologia(Tecnologia),
    unaTecnologia(Subdependencia),
    requiere(Tecnologia, Dependencia),
    dependenciaDirecta(Dependencia, Subdependencia).


/* b) Saber si un jugador puede desarrollar una tecnología, que se cumple cuando ya desarrolló todas sus dependencias (las directas y las indirectas). Considerar que pueden existir árboles de cualquier tamaño.
En el ejemplo, beto puede desarrollar el molino (pues no tiene dependencias) pero no la herrería (porque ya la tiene), y ana puede desarrollar fundición (pues tiene forja y herrería). */

puedeDesarrollar(Jugador, Tecnologia):-
    unJugador(Jugador),
    unaTecnologia(Tecnologia),
    not(desarrolloTecnologia(Jugador, Tecnologia)),
    findall(T, (unaTecnologia(T), dependenciaDirecta(Tecnologia, T)), Lista),
    forall((unaTecnologia(X), member(X, Lista)), desarrolloTecnologia(Jugador, X)).