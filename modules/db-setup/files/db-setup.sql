-- Create the role we're going to grant to all the users.
CREATE ROLE "APP_DBO";
GRANT CREATE ANY CONTEXT TO APP_DBO;
GRANT CREATE DATABASE LINK TO APP_DBO;
GRANT CREATE SESSION TO APP_DBO;
GRANT CREATE SYNONYM TO APP_DBO;
GRANT CREATE VIEW TO APP_DBO;
GRANT UNLIMITED TABLESPACE TO APP_DBO;
GRANT SELECT_CATALOG_ROLE TO APP_DBO;
GRANT RESOURCE TO APP_DBO;
GRANT CONNECT TO APP_DBO;
GRANT ALL ON SYS.DBMS_AQ TO APP_DBO;
GRANT EXECUTE ON SYS.DBMS_AQ TO APP_DBO;
-- These are only needed for PL/SQL debugging:
GRANT DEBUG ANY PROCEDURE TO APP_DBO;
GRANT DEBUG CONNECT SESSION TO APP_DBO;

/* Create tablespaces (warning: AUTOEXTEND allows the datafiles to grow
 * indefinitely). Alternatively, you can manually choose a different value for
 * the datafile sizes.

 * Errors caused by running out of space look like this:
 *   ORA-01658: unable to create INITIAL extent for segment in tablespace ...
 *   ORA-01691: unable to extend lob segment
 */

CREATE TABLESPACE EVOLUTION_DATA  DATAFILE 'tbs_data.dbf'      SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE EVOLUTION_INDEX DATAFILE 'tbs_index.dbf'     SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE EVOLUTION_CLOB  DATAFILE 'tbs_clob.dbf'      SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE EVOLUTION_XML   DATAFILE 'tbs_xml.dbf'       SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;

CREATE TABLESPACE MAIL_CLOB01     DATAFILE 'tbs_mail_clob.dbf' SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE MAIL_DATA01     DATAFILE 'tbs_mail_data.dbf' SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE MAIL_INDX01     DATAFILE 'tbs_mail_indx.dbf' SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE RPT_DATA01      DATAFILE 'tbs_mail_rpt.dbf'  SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;

-- TMS_* tablespaces are for ODM
CREATE TABLESPACE TMS_CLOB01      DATAFILE 'tbs_tms_clob.dbf'  SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE TMS_DATA01      DATAFILE 'tbs_tms_data.dbf'  SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE TMS_INDX01      DATAFILE 'tbs_tms_indx.dbf'  SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;

-- TSMS_* tablespaces are for XACT
CREATE TABLESPACE TSMS_INDX01     DATAFILE 'tbs_tsms_indx.dbf' SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE TSMS_DATA01     DATAFILE 'tbs_tsms_data.dbf' SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;
CREATE TABLESPACE TSMS_CLOB01     DATAFILE 'tbs_tsms_clob.dbf' SIZE 40M AUTOEXTEND ON MAXSIZE UNLIMITED ONLINE;

-- Evolution
CREATE USER EVOLUTION_EDEV IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT AQ_ADMINISTRATOR_ROLE,AQ_USER_ROLE,APP_DBO TO EVOLUTION_EDEV ;
ALTER USER EVOLUTION_EDEV DEFAULT ROLE AQ_ADMINISTRATOR_ROLE,AQ_USER_ROLE,APP_DBO;
ALTER USER EVOLUTION_EDEV QUOTA UNLIMITED ON EVOLUTION_CLOB;
ALTER USER EVOLUTION_EDEV QUOTA UNLIMITED ON EVOLUTION_DATA;
ALTER USER EVOLUTION_EDEV QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_EDEV QUOTA UNLIMITED ON EVOLUTION_INDEX;
ALTER USER EVOLUTION_EDEV QUOTA UNLIMITED ON EVOLUTION_XML;
GRANT EXECUTE ON SYS.DBMS_AQ TO EVOLUTION_EDEV;

-- Evolution test user
CREATE USER EVOLUTION_ETST IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT AQ_ADMINISTRATOR_ROLE,AQ_USER_ROLE,APP_DBO TO EVOLUTION_ETST ;
ALTER USER EVOLUTION_ETST DEFAULT ROLE AQ_ADMINISTRATOR_ROLE,AQ_USER_ROLE,APP_DBO;
ALTER USER EVOLUTION_ETST QUOTA UNLIMITED ON EVOLUTION_CLOB;
ALTER USER EVOLUTION_ETST QUOTA UNLIMITED ON EVOLUTION_DATA;
ALTER USER EVOLUTION_ETST QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_ETST QUOTA UNLIMITED ON EVOLUTION_INDEX;
ALTER USER EVOLUTION_ETST QUOTA UNLIMITED ON EVOLUTION_XML;

-- BP2 Mail
CREATE USER EVOLUTION_MDEV IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT APP_DBO TO EVOLUTION_MDEV ;
ALTER USER EVOLUTION_MDEV DEFAULT ROLE APP_DBO;
ALTER USER EVOLUTION_MDEV QUOTA UNLIMITED ON MAIL_DATA01;
ALTER USER EVOLUTION_MDEV QUOTA UNLIMITED ON MAIL_CLOB01;
ALTER USER EVOLUTION_MDEV QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_MDEV QUOTA UNLIMITED ON MAIL_INDX01;

-- BP2 Evo Views
CREATE USER EVOLUTION_MEDEV IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT APP_DBO TO EVOLUTION_MEDEV ;
ALTER USER EVOLUTION_MEDEV DEFAULT ROLE APP_DBO;
ALTER USER EVOLUTION_MEDEV QUOTA UNLIMITED ON MAIL_DATA01;
ALTER USER EVOLUTION_MEDEV QUOTA UNLIMITED ON MAIL_CLOB01;
ALTER USER EVOLUTION_MEDEV QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_MEDEV QUOTA UNLIMITED ON MAIL_INDX01;

-- ODM
CREATE USER EVOLUTION_TDEV IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT APP_DBO TO EVOLUTION_TDEV ;
ALTER USER EVOLUTION_TDEV DEFAULT ROLE APP_DBO;
ALTER USER EVOLUTION_TDEV QUOTA UNLIMITED ON TMS_DATA01;
ALTER USER EVOLUTION_TDEV QUOTA UNLIMITED ON TMS_CLOB01;
ALTER USER EVOLUTION_TDEV QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_TDEV QUOTA UNLIMITED ON TMS_INDX01;

-- ODM test user
CREATE USER EVOLUTION_TTST IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT APP_DBO TO EVOLUTION_TTST ;
ALTER USER EVOLUTION_TTST DEFAULT ROLE APP_DBO;
ALTER USER EVOLUTION_TTST QUOTA UNLIMITED ON TMS_DATA01;
ALTER USER EVOLUTION_TTST QUOTA UNLIMITED ON TMS_CLOB01;
ALTER USER EVOLUTION_TTST QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_TTST QUOTA UNLIMITED ON TMS_INDX01;

-- XACT
CREATE USER EVOLUTION_XDEV IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT APP_DBO TO EVOLUTION_XDEV ;
ALTER USER EVOLUTION_XDEV DEFAULT ROLE APP_DBO;
ALTER USER EVOLUTION_XDEV QUOTA UNLIMITED ON TSMS_DATA01;
ALTER USER EVOLUTION_XDEV QUOTA UNLIMITED ON TSMS_CLOB01;
ALTER USER EVOLUTION_XDEV QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_XDEV QUOTA UNLIMITED ON TSMS_INDX01;

-- XACT test user
CREATE USER EVOLUTION_XTST IDENTIFIED BY abcd1234 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT APP_DBO TO EVOLUTION_XTST ;
ALTER USER EVOLUTION_XTST DEFAULT ROLE APP_DBO;
ALTER USER EVOLUTION_XTST QUOTA UNLIMITED ON TSMS_DATA01;
ALTER USER EVOLUTION_XTST QUOTA UNLIMITED ON TSMS_CLOB01;
ALTER USER EVOLUTION_XTST QUOTA 10240K ON USERS;
ALTER USER EVOLUTION_XTST QUOTA UNLIMITED ON TSMS_INDX01;

-- Database links (don't use the "IDENTIFIED BY VALUES" syntax, or you will get an ORA-0600 error later on down the line - http://msutic.blogspot.com/2012/09/workaround-for-ora-00600-internal-error.html)
CREATE DATABASE LINK MAIL2 CONNECT TO EVOLUTION_MDEV IDENTIFIED BY abcd1234 USING 'orcl';
CREATE DATABASE LINK MAIL CONNECT TO EVOLUTION_MDEV IDENTIFIED BY abcd1234 USING 'orcl';

exit;