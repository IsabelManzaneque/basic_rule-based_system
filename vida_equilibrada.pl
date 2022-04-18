%---------------------------------------%
%                                       %
%    Autora: Isabel Manzaneque Núñez    %
%    Tema:   Una vida equilibrada       %
%    Curso:  2021/2022                  % 
%                                       %
%---------------------------------------%


% Constantes
social.
laboral.
salud.
ocio.
finanzas.
ambiental.
personal.
malo.
regular.
bueno.

% Hechos sin variables
faceta(social).                  
faceta(laboral).
faceta(salud).
faceta(ocio).
faceta(finanzas).
faceta(ambiental).
faceta(personal).

calidad_vida(malo).
calidad_vida(regular).
calidad_vida(bueno).

perfil(1,malo).
perfil(2,regular).
perfil(3,bueno).

moraleja(malo,'Tus resultados indican que tienes una mala calidad de vida, tienes que pensar en que es realmente importante').
moraleja(regular,'Tus resultados indican que no tienes una mala calidad de vida, aunque ciertos aspectos podrian mejorarse').
moraleja(bueno,'Tus resultados indican que tienes una excelente calidad de vida! sigue aprovechandola al maximo! ').

% Predicado para limpiar la pantalla
clear :- write('\033[2J').

% Predicado dinamico para guardar el nombre del usuario
:- dynamic(nombre/1).
insertaN(Nombre) :- HechoN = nombre(Nombre), asserta(HechoN).

% Predicado dinamico para guardar el índice de masa corporal del usuario
:- dynamic(bmi/1).
insertaB(Bmi) :- HechoB = bmi(Bmi), asserta(HechoB).

% Predicados dinamicos para guardar las puntuaciones de cada faceta
:-dynamic perfil_faceta/2.
perfil_faceta(0,social).
perfil_faceta(0,laboral).
perfil_faceta(0,salud).
perfil_faceta(0,ocio).
perfil_faceta(0,finanzas).
perfil_faceta(0,ambiental).
perfil_faceta(0,personal).

% Consultas asociadas a las facetas que se realizarán al usuario
consulta(social,'Tengo un amplio circulo de seres queridos con los que puedo contar para los buenos y malos momentos, ya sea familia o amigos').
consulta(laboral,'Tengo un trabajo que me gusta en el que se me respeta y valora').
consulta(salud,'Tengo una buena salud, tanto fisica como mental. Mi dieta es equilibrada, duermo unas 8 horas al dia y hago regularmente ejercicio').
consulta(ocio,'Dedico una suficiente cantidad tiempo a realizar actividades que disfruto').
consulta(finanzas,'Tengo ahorros y gano lo suficiente como para vivir comodamente').
consulta(ambiental,'Vivo en una casa que cubre todas mis necesidades basicas y en la que soy feliz').
consulta(personal,'En general, y a pesar de tener mejores y peores momentos, soy feliz y estoy orgulloso de mi mismo').

% Conclusiones a los resultados obtenidos por el usuario
conclusion(social,1,'La soledad puede ser muy perjudicial para tu salud. Tienes que hacer un mayor esfuerzo en crear y mantener relaciones').
conclusion(social,2,'No tener un circulo muy amplio puede ayudarnos a conectar con nosotros mismos, pero no olvides que los humanos somos criaturas sociales!').
conclusion(social,3,'Eres muy afortunado de tener tanta gente que te quiere, cuidalos mucho pues valen mas que el oro').
conclusion(laboral,1,'Pasamos muchas horas de nuestra vida en el trabajo y no tiene sentido gastarlas en algo que no nos hace felices. Es hora de cambiar!').
conclusion(laboral,2,'Aunque no estes mal en el trabajo, en ocasiones es sano buscar nuevos retos o cambiar de aires. Piensa si esto podria beneficiarte').
conclusion(laboral,3,'Un trabajo que te hace sentirte feliz y realizado es un tesoro. Sigue creciendo en tu vida laboral sin olvidarte de disfrutar tu tiempo libre').
conclusion(salud,1,'Si tu salud esta tan deteriorada y no has acudido ya a un medico, pide cita cuanto antes para que encontrar la ayuda que necesitas').
conclusion(salud,2,'No tienes una mala salud, pero podria ser mejor. Recuerda atender tanto a tus necesidades fisicas como mentales.').
conclusion(salud,3,'Mens sana in corpore sano. Sigue asi!').
conclusion(ocio,1,'El no hacer nada que te haga sentir feliz y relajado puede conducir a la depresion. Dedica al menos una hora de tu dia a hacer algo que te apetezca').
conclusion(ocio,2,'No debes sentirte culpable de disfrutar un poco de vez en cuando, seras mas eficiente si tu mente esta descansada').
conclusion(ocio,3,'Continua disfrutando de tu tiempo libre sin olvidar completamente tus responsabilidades').
conclusion(finanzas,1,'El dinero no lo es todo, pero es basico para sobrevivir. Ahorra una pequena cantidad todos los meses o busca un nuevo trabajo mejor pagado').
conclusion(finanzas,2,'Se responsable con tu dinero pero date un capricho de vez en cuando tambien').
conclusion(finanzas,3,'Me alegro de que tus finanzas vayan tan bien!. Has pensado en invertir en obras de caridad?').
conclusion(ambiental,1,'La necesidad de sentirse feliz y seguro en el hogar es basica. Si este no es tu caso, te recomiendo que te mudes cuanto antes').
conclusion(ambiental,2,'Tu casa cubre tus necesidades basicas pero le sigue faltando algo? has probado el feng shui?').
conclusion(ambiental,3,'Tu casa es tu santuario. Esto es fantastico, pero recuerda hacer actividades al aire libre tambien!').
conclusion(personal,1,'Todos nos sentimos asi de vez en cuando, pero si esto afectando tu dia a dia, por favor busca ayuda y habla con un profesional').
conclusion(personal,2,'Notas que hay algo carente en tu vida. Intenta seguir las recomendaciones que se te han dado para mejorarla. La meditacion es muy buena tambien').
conclusion(personal,3,'Yo estoy orgullosa de ti tambien <3').

% Predicados con variables para ir sumando y estableciendo las puntuaciones
anadir(T,L,[T|L]).              

sumar_puntos([],0).             
sumar_puntos([T|R],Suma):-      
    sumar_puntos(R,R2),         
    Suma is R2+T.

evaluar_puntuacion(Suma,Perfil):-
    Suma>=8,Suma=<12,Perfil=malo,calidad_vida(Perfil);
    Suma>=13,Suma=<18,Perfil=regular,calidad_vida(Perfil);
    Suma>=19,Suma=<24,Perfil=bueno,calidad_vida(Perfil).

borrar_puntuacion:-puntuacion(Puntuacion),
    retract(puntuacion(Puntuacion)),assert(puntuacion([])).

:-dynamic puntuacion/1.
puntuacion([]).
elemento(_).              


% Predicado que arranca el programa reiniciando las puntuaciones y mostrando el menú principal;
main:-borrar_puntuacion,menu.  

% Menú principal en el que se pregunta su nombre al usuario y se da la opción de comenzar o salir
menu:-  clear,nl,nl,               
        write('                                         @@                                  \n'),                 
        write('                                        @@@@                                 \n'),              
        write('                                         @@                                  \n'),            
        write('                     /@,,(%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%/,,@ /             \n'),             
        write('                      ,                 @@@@                 ,               \n'),               
        write('                     , ,               @@@@@@               , ,              \n'),                   
        write('                    ,   ,              @@@@@@              ,   ,             \n'),               
        write('                   &     #              @@@@              #     #            \n'),                                       
        write('                  ,       %             @@@@             %       ,           \n'),                                   
        write('                 *&@@@@@@@@&*           @@@@           *&@@@@@@@@&*          \n'),            
        write('                                        @@@@                                 \n'),             
        write('                                        @@@@                                 \n'),            
        write('                                       @@@@@@                                \n'),            
        write('                                     ,@@@@@@@@*                              \n'),             
        write('                                 &@@@@@@@@@@@@@@@@&                          \n\n'),
	format('~nTener equilibrio en nuestra vida es algo muy importante para estar sanos y felices,'),
        format('~npero en ocasiones puede resultar dificil saber cuales son las facetas de nuestra'),  
        format('~nvida que requieren mas atencion y como mejorarlas. Hoy vamos a explorar las tuyas!'),
	format('~n~nIntroduce tu nombre en minusculas: '), read(Nombre), insertaN(Nombre),   
        format('~nMuy bien, ~w, vamos a comenzar calculando tu indice de masa corporal y despues', [Nombre]), 
        format('~nvas a responder a una series de cuestiones. Comenzamos?~n'),
        format('~n1)ADELANTE'),format('~n2)CERRAR'),
        format('~nElegir opcion: '),read(O),elegir(O).   
        elegir(1):-calculaBMI(), test.                             
        elegir(2):-halt.


% Predicado que calcula y guarda el índice de masa corporal del usuario
% Se obtienen más o menos puntos en función de cómo de saludable es este     

calculaBMI():-    
   
       elemento(X),
       puntuacion(Puntuacion), 
       format('~nIntroduce tu altura en metros (ej: 1.60): '), read(A), 
       format('Introduce tu peso en kilos (ej: 55): '), read(P),            
       bmi(P,A,Bmi),       
       msg(Bmi, Msg, X),
       anadir(X,Puntuacion,Nueva_puntuacion),
       retract(puntuacion(Puntuacion)), 
       assert(puntuacion(Nueva_puntuacion)),  
       format('~nTu indice de masa corporal es: ~2f. ~s~n', [Bmi,Msg]).      
       
       bmi(P,A,Bmi) :- Bmi is P/(A*A), insertaB(Bmi).
       msg(Bmi, "Tu IMC es muy bajo. Nuestro cuerpo necesita energia para funcionar, necesitas alimentarte mejor y ganar peso.", 1) :- Bmi =< 18.5.  
       msg(Bmi, "Tienes un peso muy saludable", 3) :- 18.5 < Bmi, Bmi =< 25.0.
       msg(Bmi, "Tienes algo de sobrepeso, intenta hacer algo mas de ejercicio y consumir menos calorias", 2) :- 25.0 < Bmi, Bmi =< 30.0.
       msg(Bmi, "Sufres de obesidad. Esto conlleva numerosos peligros para tu salud, pide cita con tu medico", 1) :- 30 < Bmi.


% Arranca la parte de test. Realiza consultas y evaluaciones de las facetas a consultar y evaluar
% Por último realiza la suma de puntos y muestra las conclusiones finales

test:-format('~nAhora, responde si estas de acuerdo, algo de acuerdo o en desacuerdo con las siguientes afirmaciones:~n'), 
       consultar(social),                              
       consultar(laboral),
       consultar(salud),
       consultar(ocio),                                                      
       consultar(finanzas), 
       consultar(ambiental),
       consultar(personal),
       evaluar(social),                                 
       evaluar(laboral),
       evaluar(salud),
       evaluar(ocio),
       evaluar(finanzas),
       evaluar(ambiental),
       evaluar(personal),
       puntuacion(Puntuacion),
       sumar_puntos(Puntuacion,Suma),
       evaluar_puntuacion(Suma,Perfil),
       format('~n~nTienes ~w puntos, tu calidad de vida es de un perfil ~w~n',[Suma,Perfil]),
       moraleja(Perfil,Moraleja),
       format('~w',[Moraleja]),
       reiniciar.


% Predicado consultar que recibe una faceta como parámetro. Actualiza la puntuación de la faceta

consultar(Faceta):-                                      

       faceta(Faceta),                                  
       perfil_faceta(0,Faceta),                          
       consulta(Faceta,Consulta),                        
       format('~n~w~n',[Consulta]),                       
       format('~n1) Desacuerdo~n'),                              
       format('2) Algo deacuerdo~n'),
       format('3) Deacuerdo~n'),read(Seleccion),              
       retract(perfil_faceta(0,Faceta)),                  
       assert(perfil_faceta(Seleccion,Faceta)),          
       puntuacion(Puntuacion),                            
       elemento(Seleccion),                               
       anadir(Seleccion,Puntuacion,Nueva_puntuacion),     
       retract(puntuacion(Puntuacion)),                   
       assert(puntuacion(Nueva_puntuacion)).             


% Predicado consultar que recibe una faceta como parámetro. Actualiza el perfil de la faceta
% y escoje una conclusión en función de si es malo, regular o bueno

evaluar(Faceta):-                                      

       faceta(Faceta),                                    
       perfil_faceta(N,Faceta),                           
       perfil(N,Perfil),                                  
       conclusion(Faceta,N,Conclusion),                   
       format('~n~nEn la faceta "~w" tienes un perfil ~w',[Faceta,Perfil]),
       format('~nUna recomendacion en esta aspecto es: ~w',[Conclusion]), 
       retract(perfil_faceta(N,Faceta)),                 
       assert(perfil_faceta(0,Faceta)).


% Da al usuario la opción de reiniciar el programa o finalizar

reiniciar():-

      nombre(Nombre),
      format('~n~nEspero que que estos resultados te ayuden a encontrar tu equilibrio, ~w', [Nombre]),    
      format('~nTe gustaria reiniciar el programa? (si / no)'),  	
      format('~nElegir opcion: '),read(O),opcion(O).   
      opcion(si):-main.                             
      opcion(no):-halt.


