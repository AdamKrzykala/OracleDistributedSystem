--External database link creating
CREATE DATABASE LINK ORCL6
    CONNECT TO c##mnowak 
    IDENTIFIED BY mnowak5 
    USING 'orcl6.us.acme.com';
    
SELECT count(*) FROM dba_objects WHERE status = 'INVALID'
AND owner IN ('SYS', 'SYSTEM');

grant connect, resource to c##adam;
execute dbms_repcat_admin.grant_admin_any_schema('C##ADAM');
grant comment any table to c##adam;
grant lock any table to c##adam;
execute dbms_defer_sys.register_propagator('C##ADAM');

begin
 dbms_defer_sys.schedule_push(
 destination => 'WYPOZYCZALNIA_MICHAL',
 interval => 'SYSDATE + 1/(60*24)',
 next_date => sysdate,
 stop_on_error => FALSE,
 delay_seconds => 0,
 parallelism => 1);
end;
/
begin
dbms_defer_sys.schedule_purge(
 next_date => sysdate,
 interval => 'sysdate + 1/24',
 delay_seconds => 0,
 rollback_segment => '');
end;
/

BEGIN
 DBMS_REPCAT.DROP_MASTER_REPGROUP(
 gname => '"GROUP1"');
END;
/

BEGIN
 DBMS_REPCAT.DROP_MASTER_REPOBJECT(
 type => 'TABLE',
 oname => '"KLIENCI"',
 sname => '"C##ADAM"');
END;
/


--Creating MMR
BEGIN
 DBMS_REPCAT.CREATE_MASTER_REPGROUP(
 gname => '"GROUP1"',
 qualifier => '',
 group_comment => '');
END;
/

BEGIN
 DBMS_REPCAT.CREATE_MASTER_REPOBJECT(
 gname => '"GROUP1"',
 type => 'TABLE',
 oname => '"KLIENCI"',
 sname => '"C##ADAM"');
END;
/

BEGIN
 DBMS_REPCAT.GENERATE_REPLICATION_SUPPORT(
 sname => '"C##ADAM"',
 oname => '"KLIENCI"',
 type => 'TABLE',
 min_communication => TRUE,
 generate_80_compatible => FALSE);
END;
/ 

SELECT * FROM dba_repcatlog;

BEGIN
 DBMS_REPCAT.RESUME_MASTER_ACTIVITY(
 gname => '"GROUP1"');
END;
/

BEGIN
 DBMS_REPCAT.SUSPEND_MASTER_ACTIVITY(
 gname => '"GROUP1"');
END;
/
SELECT name, value, description FROM v$parameter WHERE name = 'compatible';
SELECT * FROM v$version;

execute dbms_repcat_admin.grant_admin_any_repgroup ('C##ADAM');
execute dbms_repcat_admin.grant_admin_any_repschema ('C##ADAM');

execute dbms_defer_sys.register_propagator('C##ADAM');

grant execute any procedure to C##ADAM;

execute dbms_repcat_admin.grant_admin_any_repgroup('C##ADAM');

execute dbms_repcat_admin.grant_admin_any_schema(username => '"C##ADAM"');

grant comment any table to C##ADAM;

grant lock any table to C##ADAM;

grant select any dictionary to C##ADAM;

select object_name,object_type from user_objects where object_type='DATABASE LINK';

show user;

show parameter global_names;

Alter system set global_names = true scope=both;

BEGIN
 DBMS_REPCAT.ADD_MASTER_DATABASE(
    gname => '"GROUP1"',
    master => '"ORCL6"');
END;
/
select count(*) from user_objects@WYPOZYCZALNIA_MICHAL;
