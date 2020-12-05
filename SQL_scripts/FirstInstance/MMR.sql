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

--Creating MMR
BEGIN
 DBMS_REPCAT.CREATE_MASTER_REPGROUP(
 gname => '"GROUP2"',
 qualifier => '',
 group_comment => '');
END;
/

BEGIN
 DBMS_REPCAT.CREATE_MASTER_REPOBJECT(
 gname => '"GROUP2"',
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
 gname => '"GROUP2"');
END;
/

BEGIN
 DBMS_REPCAT.SUSPEND_MASTER_ACTIVITY(
 gname => '"GROUP2"');
END;
/

BEGIN
 DBMS_REPCAT.ADD_MASTER_DATABASE(
 gname => '"GROUP2"',
master => 'WYPOZYCZALNIA_MICHAL');
END;
/
