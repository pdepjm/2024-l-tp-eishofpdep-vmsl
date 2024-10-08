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
    juegaCon(_,Civilizacion),
    forall(civilizacionAlcanzoTecnologia(Civilizacion2, Tecnologia),civilizacionAlcanzoTecnologia(Civilizacion, Tecnologia)).


% 6)
/*Modelar lo necesario para representar las distintas unidades de cada jugador de la forma más conveniente 
para resolver los siguientes puntos. Incluir los siguientes ejemplos: */
/*
jinete(caballo, 90).
jinete(camello, 80).

piquero(escudo, 1, Vida).
piquero(escudo, 2, Vida).
piquero(escudo, 3, Vida).
piquero(sinEscudo, 1, 50).
piquero(sinEscudo, 2, 65).
piquero(sinEscudo, 3, 70).

campeon(Vida).
*/

%Ana tiene un jinete a caballo, un piquero con escudo de nivel 1, y un piquero sin escudo de nivel 2.
unidad(ana, piquero(sinEscudo, 2)).
unidad(ana, piquero(escudo, 1)).
unidad(ana, jinete(caballo)).

%Beto tiene un campeón de 100 de vida, otro de 80 de vida, un piquero con escudo nivel 1 y un jinete a camello.
unidad(beto, campeon(100)).
unidad(beto, campeon(80)).
unidad(beto, piquero(escudo, 1)).
unidad(beto, jinete(camello)).

%Carola tiene un piquero sin escudo de nivel 3 y uno con escudo de nivel 2.
unidad(carola, piquero(escudo, 2)).
unidad(carola, piquero(sinEscudo, 3)).

%Dimitri no tiene unidades.


% 7)
%Conocer la unidad con más vida que tiene un jugador, teniendo en cuenta que:
/*Los jinetes a camello tienen 80 de vida y los jinetes a caballo tienen 90.
Cada campeón tiene una vida distinta.
Los piqueros sin escudo de nivel 1 tienen vida 50, los de nivel 2 tienen vida 65 y los de nivel 3 tienen 70 de vida.
Los piqueros con escudo tienen 10% más de vida que los piqueros sin escudo.
En los ejemplos, la unidad más “viva” de Ana es el jinete a caballo, pues tiene 90 de vida, y ninguno de sus dos piqueros tiene tanta vida.*/
unidadConMasVida(Jugador, Unidad):-
    unidad(Jugador, Unidad),
    forall(unidad(Jugador, Unidades), not((vidaUnidad(Unidades, VidasUni), vidaUnidad(Unidad, Vida), VidasUni > Vida))).

% vidaUnidad(Unidad, Vida).

% Vida Jinetes
vidaUnidad(jinete(camello), 80).
vidaUnidad(jinete(caballo), 90).
% Vida Campeones
vidaUnidad(campeon(Vida), Vida).
% Vida Piqueros
vidaUnidad(piquero(escudo, Nivel), Vida):-
    vidaPiqueroConEscudo(piquero(escudo, Nivel), Vida).
% Piqueros sin escudos
vidaUnidad(piquero(sinEscudo, 1), 50).
vidaUnidad(piquero(sinEscudo, 2), 65).
vidaUnidad(piquero(sinEscudo, 3), 70).
% Piqueros con escudo
vidaPiqueroConEscudo(piquero(escudo, Nivel), Vida):-
    vidaUnidad(piquero(sinEscudo, Nivel), VidaSinEscudo),
    Vida is VidaSinEscudo * (1.1).


% 8)
/*Queremos saber si una unidad le gana a otra. Las unidades tienen una ventaja por tipo sobre otras. 
Cualquier jinete le gana a cualquier campeón, cualquier campeón le gana a cualquier piquero 
y cualquier piquero le gana a cualquier jinete, pero los jinetes a camello le ganan a los a caballo.
En caso de que no exista ventaja entre las unidades, se compara la vida (el de mayor vida gana). 
Este punto no necesita ser inversible. Por ejemplo, un campeón con 95 de vida le gana a otro con 50, 
pero un campeón con 100 de vida no le gana a un jinete a caballo.*/

gana(jinete(_), campeon(_)).
gana(campeon(_), piquero(_, _)).
gana(piquero(_, _), jinete(_)).
gana(jinete(camello), jinete(caballo)).

leGana(Ganador,Perdedor):-
    gana(Ganador,Perdedor).

leGana(Ganador, Perdedor):-
    not(gana(Perdedor, Ganador)),
    vidaUnidad(Ganador, Vida1),
    vidaUnidad(Perdedor, Vida2),
    Vida1 > Vida2.

gana(piquero(Tipo1, Nivel1), piquero(Tipo2, Nivel2)):-
    vidaUnidad(piquero(Tipo1, Nivel1), Vida1),
    vidaUnidad(piquero(Tipo2, Nivel2), Vida2),
    Vida1 > Vida2.

% 9)
/*Saber si un jugador puede sobrevivir a un asedio. Esto ocurre si tiene más piqueros con escudo que sin escudo.
En los ejemplos, Beto es el único que puede sobrevivir a un asedio, pues tiene 1 piquero con escudo y 0 sin escudo.*/

/*cuenta_piqueros(Jugador, Tipo, Cantidad) :-
    unidad(Jugador, Unidades),
    findall(P, (member(P, Unidades), P = piquero(Tipo, _, _)), Lista),
    length(Lista, Cantidad).

sobreviveAsedio(Jugador):-
    unJugador(Jugador),
    cuenta_piqueros(Jugador, escudo, CantConEscudo),
    cuenta_piqueros(Jugador, sinEscudo, CantSinEscudo),
    CantConEscudo > CantSinEscudo.*/

contarPiqueros(Jugador,Escudo,SinEscudo):-
    findall(Unidad, (unidad(Jugador,Unidad), Unidad = piquero(escudo,_)), ListaEscudo),
    findall(Unidad, (unidad(Jugador,Unidad), Unidad = piquero(sinEscudo,_)), ListaSinEscudo),
    length(ListaEscudo, Escudo),
    length(ListaSinEscudo, SinEscudo).

sobreviveAsedio(Jugador):-
    contarPiqueros(Jugador, Escudo, SinEscudo),
    Escudo > SinEscudo.

% 10) Árbol de tecnologías
/* a) Se sabe que existe un árbol de tecnologías, que indica dependencias entre ellas. Hasta no desarrollar una, no se puede desarrollar la siguiente. 
    Modelar el siguiente árbol de ejemplo: */
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


/* b) Saber si un jugador puede desarrollar una tecnología, que se cumple cuando ya desarrolló todas sus dependencias (las directas y las indirectas). 
Considerar que pueden existir árboles de cualquier tamaño. En el ejemplo, beto puede desarrollar el molino (pues no tiene dependencias) pero no la 
herrería (porque ya la tiene), y ana puede desarrollar fundición (pues tiene forja y herrería). */

puedeDesarrollar(Jugador, Tecnologia):-
    unJugador(Jugador),
    unaTecnologia(Tecnologia),
    not(desarrolloTecnologia(Jugador, Tecnologia)),
    findall(T, (unaTecnologia(T), dependenciaDirecta(Tecnologia, T)), Lista),
    forall((unaTecnologia(X), member(X, Lista)), desarrolloTecnologia(Jugador, X)).

% Bonus
% 11) a) 
/*Encontrar un orden válido en el que puedan haberse desarrollado las tecnologías para que un jugador llegue a desarrollar todo lo que tiene. Se espera una 
relación de jugador con lista de tecnologías.
Ejemplo: Un orden válido para Ana es: herreria, emplumado, forja, láminas. Otro orden válido sería herreria, forja, láminas, emplumado. 
Pero seguro que Ana no desarrolló primero la forja, porque antes necesitaría la herrería.
Recordar que debe funcionar para cualquier árbol y no sólo para el de el ejemplo. Y recordar que debe ser completamente inversible.*/

%encuentra todas las tecnologias que un jugador desarrolló y las recopila en una lista.
tecnologiasDesarrolladas(Jugador,Tecnologias):-
    findall(Tecnologia,desarrolloTecnologia(Jugador,Tecnologia),Tecnologias).

%usando tecnologiasDesarrolladas obtiene la lista de todas las tecnologias desarrolladas del jugador y encuentra orden válido de desarrollo, se arma con construirOrden.
ordenValido(Jugador,Tecs):-
    tecnologiasDesarrolladas(Jugador,Tecnologias),
    construirOrden(Tecnologias, [], Orden),
    reverse(Tecs,Orden).
    

%caso base, si la lista está vacía el orden construido es el mismo que el orden Parcial acumulado.
construirOrden([],Orden,Orden). 

%caso en el que se puede agregar una tecnología a la lista Parcial. 
construirOrden([Tecnologia | Restantes], LParcial, Orden):-
    puedeAgregar(Tecnologia, LParcial),
    construirOrden(Restantes, [Tecnologia|LParcial], Orden).

%caso en el que no se puede agregar tecnología a la lista.
construirOrden([Tecnologia|Restantes], LParcial, Orden) :-
    not(puedeAgregar(Tecnologia, LParcial)),
    construirOrden(Restantes, LParcial, Orden).

puedeAgregar(Tecnologia, LLParcial) :-
    forall(requiere(Tecnologia, Dependencia),
    member(Dependencia, LLParcial)).

% b) 
% ¿Qué sucede cuando se consulta si existe un orden válido para Dimitri? ¿Por qué?
/*Cuando se consulta si existe un orden válido para Dimitri la respuesta es "Orden = [laminas, emplumado, forja, herreria] ;
ya que Dimitri ya desarrolló herrería.*/

% 12)
/*
Dado un jugador defensor, encontrar el ejército que debo crear para ganarle a todo su ejército. El ejército atacante debe tener el 
mismo tamaño, y suponer que las batallas son uno contra uno, cada integrante atacante ataca a un integrante defensor.
Ejemplo: Para ganarle al ejército de Carola (que es un piquero sin escudo de nivel 3 y uno con escudo de nivel 2) hacen falta dos 
campeones de cualquier vida, o dos piqueros con escudo nivel 3, o campeón y un piquero con escudo nivel 3, etc.
Recordar que debe ser completamente inversible.
*/
% ejercitoGanador(JugadorDefensor, EjercitoAtacante).
ejercitoGanador(JugadorDefensor, EjercitoAtacante):-
    unJugador(JugadorDefensor),
    ejercitoDefensor(JugadorDefensor, EjercitoDefensor),
    unidadGanadora(EjercitoDefensor, EjercitoAtacante).

unidadGanadora([UnidadDef | RestoDef], [UnidadAtq | RestoAtq]):-
    gana(UnidadAtq, UnidadDef),
    unidadGanadora(RestoDef, RestoAtq).

unidadGanadora([], []).
    
ejercitoDefensor(JugadorDefensor, EjercitoDefensor):-
    findall(Unidad, unidad(JugadorDefensor, Unidad), EjercitoDefensor).
    

