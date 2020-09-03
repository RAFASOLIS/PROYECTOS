
/**EJERCICIO1*/
/**1.0. CREAMOS LAS TABLAS ALUMNOS Y PROFESORES - CAMPOS LIBRES*/
DROP TABLE ALUMNOS;
DROP TABLE PROFESORES;
CREATE TABLE ALUMNOS(
NIF VARCHAR2(9) PRIMARY KEY,
NOMBRE VARCHAR2(50),
CURSO NUMBER(2));

CREATE TABLE PROFESORES(
NIF VARCHAR2(9) PRIMARY KEY,
NOMBRE VARCHAR2(50),
ASIGNATURA VARCHAR(30));

/**1.1. CREAR USUARIO -MIGUEL- CON PERMISOS S�LO CONECTION*/
CREATE USER MIGUEL IDENTIFIED BY "root"  
DEFAULT TABLESPACE "USERS";
-- ROLES
GRANT "OEM_ADVISOR" TO MIGUEL ;
/*1.2. CREAR USUARIO - MARTA - CON CL�SULA GRANT - PERMISOS CONEXI�N Y EDICI�N/ ELIMINACI�N TABLAS**/
CREATE USER Marta IDENTIFIED BY ROOT;
GRANT  CONNECT , CREATE TABLE TO MARTA;

/**1.3. CONCECER PERMISO SELECT A MIGUEL EN TABLA ALUMNOS*/
GRANT SELECT ON ALMUNOS TO MIGUEL;
/**1.4.EIDICI�N Y ELIMINACI�N DATOS EN TABLA ALUMNOS POR USUARIO MARTA
*/

SHOW USER;


INSERT INTO ALUMNOS VALUES('74886498X','Rafa',1);
UPDATE ALUMNOS SET NOMBRE='Pedro' WHERE NOMBRE='Rafa';
DELETE  FROM ALUMNOS;


/**EJERCICIO 2*/

/**2.1. PROCEDIMIENTO: MUESTRA A�O ACTUAL*/

create or replace PROCEDURE CURRENT_YEAR AS 
BEGIN
DBMS_OUTPUT.PUT_LINE('A�o actual '|| TO_CHAR(sysdate,'yyyy'));
  NULL;

END CURRENT_YEAR;

/*ejecutamos el procedimiento*/

 
/**2.2. PROCEDIMIENTO: SUMA 1 EN CADA EJECUCI�N  */

create or replace PROCEDURE ADD_MAS_UNO(contador  in OUT NUMBER) AS 
   
BEGIN
contador:=contador+1;
DBMS_OUTPUT.PUT_LINE('RESULTADO ' || TO_CHAR(contador));
END ADD_MAS_UNO;

/**2.3. PROCEDIMIENO: CONCATENA DOS CADENAS Y PASA A MAY�SCULAS*/

create or replace PROCEDURE CONCATENAR(cadena1 IN varchar2,cadena2 IN varchar2) AS 

cadena varchar2(100);
BEGIN
cadena:=concat(upper(cadena1),upper(cadena2));
  DBMS_OUTPUT.PUT_LINE(cadena);
END CONCATENAR;


/**2.4. BLOQUE AN�NIMO: PIDE C�DIGO EMPLEADO Y MUESTRA SALARIO ACTUAL Y SALARIO REDUCIDO 1/3*/
DECLARE
COD_EMP NUMBER(2):=&INTRODUZCA_COD_EMPLEADO;
SALARIO NUMBER(5):=1500;
BEGIN
DBMS_OUTPUT.PUT_LINE('CODIGO EMPLEADO || TO_CHAR(COD_EMP)|| 'SALARIO ACTUAL ' || TO_CHAR(SALARIO));
SALARIO:=SALARIO*(2/3);
DBMS_OUTPUT.PUT_LINE('CODIGO EMPLEADO || TO_CHAR(COD_EMP)|| 'SALARIO ACTUAL ' || TO_CHAR(SALARIO));
END;

/**2.5. FUNCI�N: MUESTRA D�A SEMANA SEG�N VALOR NUM�RICO. USO IF/ELSE*/
create or replace FUNCTION DIA_SEMANA(NUM IN NUMBER) RETURN VARCHAR2 AS 
DIA VARCHAR2(20);
BEGIN
IF NUM=1 THEN
DIA:='LUNES';
ELSIF NUM=2 THEN
DIA:='MARTES';
ELSIF NUM=3 THEN
DIA:='MI�RCOLES';
ELSIF NUM=4 THEN
DIA:='JUEVES';
ELSIF NUM=5 THEN
DIA:='VIERNES';
ELSIF NUM=6 THEN
DIA:='SABADO';
ELSIF NUM=7 THEN
DIA:='DOMINGO';
ELSE
DIA:='ERROR VALOR FUERA DE RANGO 1 - 7';
END IF;
RETURN DIA;
END DIA_SEMANA;

/**2.6. FUNCI�N: MUESTRA D�A SEMANA SEG�N VALOR NUM�RICO. USO CASE*/


create or replace FUNCTION DIA_SEMAMA_CASE(NUM NUMBER) RETURN VARCHAR2 AS 
DIA VARCHAR2(20);
BEGIN
CASE NUM
    WHEN 1 THEN DIA:='LUNES';
    WHEN 2 THEN DIA:='MARTES';
    WHEN 3 THEN DIA:='MI�RCOLES';
    WHEN 4 THEN DIA:='JUEVES';
    WHEN 5 THEN DIA:='VIERNES';
    WHEN 6 THEN DIA:='SABADO';
    WHEN 7 THEN DIA:='DOMINGO';
      ELSE DIA:='ERROR VALOR FUERA DE RANGO 1 - 7';
 END CASE;
  RETURN DIA;
END DIA_SEMAMA_CASE;

/**2.7. FUNCI�N: DEVUELVE MAYOR DE 3 N�MEROS PASAMOS POR ARGUMENTO */


create or replace FUNCTION MAYOR_TRES(A NUMBER,B NUMBER,C NUMBER) RETURN NUMBER AS 
MAYOR NUMBER:=0;
BEGIN
    IF(A<B) THEN
    MAYOR:=B;
    ELSE
    MAYOR:=A;
    END IF;
    IF(MAYOR<C) THEN
    MAYOR:=C;
    END IF;
    
  RETURN MAYOR;
END MAYOR_TRES;
/**2.8. FUNCI�N: SUMA N PRIMEROS ENTEROS.*/

create or replace FUNCTION SUMA_N(N NUMBER) RETURN NUMBER AS 
SUMA NUMBER:=0;
I INT;
BEGIN
FOR I IN 1..N LOOP
SUMA:=SUMA+I;
END LOOP;  
  RETURN SUMA;
END SUMA_N;
/**2.9. FUNCI�N: MUESTRA SI UN N�MERO ES PRIMO. RETURN 0 / 1*/

create or replace FUNCTION ES_PRIMO(N NUMBER) RETURN INT AS 
RDO INT:=1;
BEGIN
FOR I IN 2..N-1 LOOP
    IF(MOD(N,I) =0) THEN
        RDO:=0;
    END IF;
END LOOP;

  RETURN RDO;
END ES_PRIMO;
/**2.10.FUNCI�N: CALCULA SUMA DE M PRIMEROS PRIMOOS USANDO FUNCI�N DE APARTADO 2.9.*/


create or replace FUNCTION SUMA_M_PRIMOS(M NUMBER) RETURN NUMBER AS 
SUMA NUMBER:=0;
I INT:=1;
PRIMOS INT:=1;
BEGIN

WHILE (PRIMOS<M) LOOP
    IF(ES_PRIMO(I)=1) THEN
        SUMA:=SUMA+PRIMOS;
        PRIMOS:=PRIMOS+1;
        
    END IF;
    I:=I+1;
END LOOP;    
  RETURN SUMA;
END SUMA_M_PRIMOS;

/**EJERCICO 3*/
/**SOBRE FICHERO EMPRESA.SQL*/
/**3.1. BOQUE AN�NIMO - CURSOR: NUESTRA NOMBRE Y LOCALIDAD DE TODOS LOS DEPARTAMENTOS*/

SET SERVEROUTPUT ON;
DECLARE 
NOMBRE DEPT.DNOMBREBRE%TYPE;
ZONA DEPT.LUGAR%TYPE;
BEGIN

SELECT DNOMBREBRE,LUGAR INTO NOMBRE,zona FROM DEPT;
DBMS_OUTPUT.PUT_LINE(NOMBRE);
DBMS_OUTPUT.PUT_LINE(ZONA);
EXCEPTION 
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.LINE('N� filas a mostara mayor a 1. Se necesita declarar cursor expl�cto');
END;

/**NECESITAMOS DECLARAR UN CURSOR EXPL�CITO AL DEVOLVERSE M�S DE 1 FILA*/

DECLARE
CURSOR C1 IS
SELECT DNOMBREBRE,LUGAR FROM DEPT;
VNOMBRE VARCHAR2(50);
VLUGAR VARCHAR2(50);
BEGIN
OPEN C1;
LOOP
    FETCH C1 INTO VNOMBRE,VLUGAR;
    EXIT WHEN C1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('NOMBRE ' || VNOMBRE || 'ZONA ' ||VLUGAR);
    END LOOP;
    
    CLOSE C1;
    EXCEPTION 
    WHEN OTHERS THEN DMBS_OUTPUT.PUT_LINE('ERROR');
    END;

/**3.2. PROGRAMA - CURSOR : MUESTRA APELLIDOS DE EMPLEADOS DEL DEPARTAMENTO - VENTAS - */

DECLARE 
CURSOR C2 IS
SELECT APELLIDO FROM EMP INNER JOIN DEPT ON EMP.DEPT_NO = DEPT.DEPT_NO WHERE DNOMBREBRE='VENTAS';
VAPELLIDO VARCHAR2(50);
BEGIN
OPEN C2;
LOOP    
    FETCH C2 INTO VAPELLIDO;
    EXIT WHEN C2%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE('NUM FILA ' || C2%ROWCOUNT || 'APELLIDO ' ||VAPELLIDO);
 END LOOP;
CLOSE C2;
EXCEPTION 
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('ERROR');
 END;
/**3.3. PROCEDIMIENTO - CURSOR: MUESTRA APELLIDOS DE LOS EMPLEADOS SEG�N COD_DEPARTAMENTO INDICADO. DEBE INFORMAR EN CASO DE NO POSEER EMPLEADOS */

/**3.3.1. SIN USO DE ESTRUCTURA DE CONTROL DE FLUJO FOR */
declare or replace procedure PRO_CURSOR as

CURSOR C3 IS
SELECT APELLIDO FROM EMP INNER JOIN DEPT ON EMP.DEPT_NO = DEPT.DEPT_NO WHERE DEPT.DEPT_NO=&COD_DEPARTAMENTO;
VAPELLIDO VARCHAR2(50);
BEGIN
OPEN C3;
LOOP    
    FETCH C3 INTO VAPELLIDO;
    EXIT WHEN C3%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE('NUM FILA ' ||  C3%ROWCOUNT ||  'APELLIDO ' ||VAPELLIDO);
 END LOOP;
CLOSE C3;
EXCEPTION 
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('ERROR');
 END;
 
 END PRO_CURSOR:
/**3.3.2. CON USO DE ESTRUCTURA DE CONTROL DE FLUJO FOR */
/**3.4. FUNCI�N - CURSOR: CACULA N� EMPLEADOS DEL DEPARTMENTO PASADO POR PAR�METRO Y QUE COBRAN COMISI�N (>0). SIN USAR COUNT(). EN CASO DE NO EXISTIR DEPARTAMENTO ARROJA NULL. SI NO POSEE EMPLEADOS DEVOLVER� 0*/
create or replace FUNCTION NUM_EMP_COMISION (COD NUMBER)RETURN NUMBER AS 
CURSOR C4 IS
SELECT COUNT(EMP.APELLIDO) FROM EMP INNER JOIN DEPT ON EMP.DEPT_NO = DEPT.DEPT_NO WHERE (DEPT.DEPT_NO=COD) AND (EMP.COMISION>0);
NUM_EMP_COM NUMBER;

BEGIN
OPEN C4;
LOOP    
    FETCH C4 INTO NUM_EMP_COM;
    EXIT WHEN C4%NOTFOUND;
 END LOOP;  


    IF(NUM_EMP_COM>0) THEN
    RETURN NUM_EMP_COM;
    ELSE
  RETURN NULL;
  END IF;
CLOSE C4;
END NUM_EMP_COMISION;

/**EJERCICIO 4*/
/**4.1. TRIGGER - UPDATE
CREAMOS TABLA AUDIEMPLE (ID_CAMBIO, DESCRIPCION_CAMBIO,FECHA_CAMBIO)
CREAMOS TRIGGER - AUDITASUELDO - CADA VEZ QUE CAMBIA SALARIO DE UN EMPLEADO INSERTA EN TABLA AUDITAEMPLE (ID + 1, 'El salario del empleado cod antes era SalarioOld y ahora es SalarioNew',  fecha actual).
*/

DROP TABLE AUDITAEMPLE;

CREATE TABLE AUDITAEMPLE(
ID_CAMBIO NUMBER(5) PRIMARY KEY ,
DESCRIPCION_CAMBIO VARCHAR2(100),
FECHA_CAMBIO DATE);


CREATE OR REPLACE TRIGGER AUDITASUELDO 
AFTER UPDATE OF SALARIO ON EMP 
FOR EACH ROW
DECLARE
VCOUNT NUMBER(5);

BEGIN   
SELECT COUNT(*) INTO VCOUNT FROM AUDITAEMPLE;
INSERT INTO AUDITAEMPLE VALUES(VCOUNT+1,'EL SALARIO DEL EMPLEADO' || EMP_NO ||' ANTES ERA DE '||:OLD.SALARIO || ' Y AHORA ES DE ' || :NEW.SALARIO, SYSDATE);
/RAISE_APPLICATION_ERROR (-20601,'Se ha poducido un error en el trigger auditasueldo');
END;

SELECT * FROM EMP where emp_no=7369;
UPDATE EMP SET SALARIO=50000 WHERE EMP_NO=7369;
SELECT * FROM EMP where emp_no=7369;
/**INSERT INTO AUDITAEMPLE VALUES(1,'PRUEBA',SYSDATE);*/
SELECT * FROM AUDITAEMPLE;
/**4.2. TRIGGER - INSERT -  AUDIAEMPLE2 - SI SE DA DE ALTA UN EMPLEADO - Nuevo empleado con cod-emp es valor cod_emp con fecha de hoy*/



CREATE OR REPLACE TRIGGER AUDITAEMPLE
AFTER INSERT ON EMP 
FOR EACH ROW
DECLARE
VCOUNT NUMBER(5);

BEGIN   
SELECT COUNT(*) INTO VCOUNT FROM AUDITAEMPLE;
INSERT INTO AUDITAEMPLE VALUES(VCOUNT+1,'NUEVO EMPLEADO CON CODIGO ' || EMP_NO, SYSDATE);
RAISE_APPLICATION_ERROR (-20601,'Se ha poducido un error en el trigger auditaemple');
END;

INSERT INTO EMP (EMP_NO,APELLIDO,DEPT_NO) VALUES (8001,'PEREZ',20);
SELECT * FROM EMP;
SELECT * FROM AUDITAEMPLE;

/**4.3. TRIGGER - UPDATE -  SOLO SE ACTUALIZA AUDITEMPLE SI SALARIO EMPLEADO SUBE MAS DE 10%* MSG 'El salario del empleado cod_em antes era de sueldoOld y ahora es de sueldoNew*/
CREATE OR REPLACE TRIGGER AUDITASUELDO 
BEFORE UPDATE OF SALARIO ON EMP 
FOR EACH ROW
DECLARE
VCOUNT NUMBER(5);

BEGIN   
IF(:OLD.SALARIO*1.1 < :NEW.SALARIO) THEN
SELECT COUNT(*) INTO VCOUNT FROM AUDITAEMPLE2;
INSERT INTO AUDITAEMPLE VALUES(VCOUNT+1,'EL SALARIO DEL EMPLEADO' || EMP_NO ||' ANTES ERA DE '||:OLD.SALARIO || ' Y AHORA ES DE ' || :NEW.SALARIO, SYSDATE);
ELSE
RAISE_APPLICATION_ERROR (-20601,'Se ha poducido un error en el trigger auditasueldo');
END IF;
END;


SELECT * FROM EMP where emp_no=7369;
UPDATE EMP SET SALARIO=20000 WHERE EMP_NO=7369;
SELECT * FROM EMP where emp_no=7369;
SELECT * FROM AUDITAEMPLE;
/**4.4. TRIGGER - VERIFICA_UNIDADES - */

/**4.4.A.NINGUNA FILA EN TABLA DETALLE PUEDE REGISTRAR UN 
VALOR  EN -CANTIDAD- SUPERIOR A 999 - LEVANTAMOS EXCEPCI�N SIN TRATARLA
�EXISTE PROCEDIMIENTO CONCRETO SQL PARA ESTO �LTIMO? �CU�L?*/

/**4.4.B.EN CASO QUE SE PIDAN <=999 UNIDADES DEBE ACTUALIZARSE EL CAMPO CANTIDAD E IMPORTE (PRECIO * CANTIDAD).*/

CREATE OR REPLACE TRIGGER TG_IMPORTE
BEFORE UPDATE OF CANTIDAD ON DETALLE 
FOR EACH ROW
DECLARE
BEGIN   
IF(:OLD.CANTIDAD <999) THEN
UPDATE DETALLE SET CANTIDAD=:NEW.CANTIDAD, IMPORTE=:NEW.CANTIDAD*PRECIO_NUM;
ELSE
RAISE_APPLICATION_ERROR (-20601,'Se ha poducido un error en el trigger TG_IMPORTE, cantiad >999 ');

END IF;





END;

SELECT * FROM DETALLE;