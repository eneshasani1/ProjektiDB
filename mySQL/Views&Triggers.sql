-- Terminet e anluara gjate vitit 2019 
create view Terminet_e_anuluara as
select count(*)as "Terminet e anuluara"
from terminet
where tAnuluar=TRUE and (tKoha>='2019-01-01' and tKoha<'2020-01-01');

select * from Terminet_e_anuluara;
drop view Terminet_e_anuluara;
select * from terminet where tAnuluar=TRUE;

-- Daten kur eshte bere intervenimi shoferi i automjetit dhe lloji i automjetit qe eshte perdor gjat intervenimit
create view Perdorja_e_automjetiti as
(select i.iDataKoha as "Data e Perdorimit",s.sEmri as Emri,s.sMbiemri as Mbiemri,a.amModeli as Modeli
from intervenimet i 
inner join ambulanca a on i.iAmID=a.AmID
inner join stafi s on i.iShoferi=s.SID
where a.amModeli='VW'
union
select i.iDataKoha as "Data e Perdorimit",s.sEmri as Emri,s.sMbiemri as Mbiemri,a.amModeli as Modeli
from intervenimet i 
inner join ambulanca a on i.iAmID=a.AmID
inner join stafi s on i.iShoferi=s.SID
where a.amModeli='Mercedes'
union
select i.iDataKoha as "Data e Perdorimit",s.sEmri as Emri,s.sMbiemri as Mbiemri,a.amModeli as Modeli
from intervenimet i 
inner join ambulanca a on i.iAmID=a.AmID
inner join stafi s on i.iShoferi=s.SID
where a.amModeli='Toyota');
drop view Perdorja_e_automjetit;
select * from Perdorja_e_automjetit;
-- triger 
-- Rid trigger
delimiter $$
create trigger Punesimi before insert on doktori
for each row
begin
if new.dReparti<101 or new.dReparti>=120
then signal sqlstate '45000'
set message_text='RID e repartit duhet të jetë  më e madhe se 100 dhe më  vogël se 121';
end if;
end $$
delimiter $$
drop trigger Punesimi;
select* from doktori;

INSERT INTO Doktori (dEmri,dMbiemri,dNrPersonal,dTitulli,dRruga,AID,dTelMobil,dTelFix,dEmail,dReparti)
 values ( 'Hakim','Shala', '1174599921', 'Subspecializant', 'Ahmet Laqi', 1, '049666653', '+38138485552', 'hakim.shala@gmail.com', 100);
 INSERT INTO Doktori (dEmri,dMbiemri,dNrPersonal,dTitulli,dRruga,AID,dTelMobil,dTelFix,dEmail,dReparti)
 values( 'Luljta','Azemi', '117459975', 'Specilist', 'Ahmet Kaqiku', 3, '049786653', '+38138484352', 'lulelule1@gmail.com', 130);
   INSERT INTO Doktori (dEmri,dMbiemri,dNrPersonal,dTitulli,dRruga,AID,dTelMobil,dTelFix,dEmail,dReparti)
 values ( 'Besa','Ferizi', '1174599898', 'Subspecializant', 'Astrit Bytyci', 2, '049498653', '+38139835552', 'bessaferizi@gmail.com', 101);
delete from doktori where DID=20;
 
 create table intervenimet_audit(
 IID integer auto_increment primary key,
 iAmID integer,
 iShoferi integer,
 iSSN integer,
 iDataKoha date,
 iAID integer,
 InsertDatetime datetime,
 InsertUser varchar(200),
 Action varchar(20));
 drop table intervenimet_audit;
 delimiter $$
 create trigger intervenimeauditInsert before insert on intervenimet
 for each row 
 begin 
 insert  into intervenimet_audit()
 values(new.IID,new.iAmID,new.iShoferi,new.iSSN,new.iDataKoha,new.iAID,now(),current_user(),'Insert');
 end$$
 delimiter $$ 
 drop trigger intervenimet_audit;
 
 select* from intervenimet_audit;
 truncate intervenimet_audit;
 INSERT INTO Intervenimet(iAmID,iShoferi,iSSN,iDataKoha,iAID)
 VALUES (3,5,10,'2021-9-10',3);
 delete from intervenimet where IID=13;
 truncate intervenimet;
 
 -- query per gjetjen e 2 (emri dhe mbiemri) me te gjate te pacienteve qe fillojn me shkronjen A
 select SSN,concat(pEmri,' ',pMbiemri) as "Emri dhe Mbimri",length(concat(pEmri,' ',pMbiemri)) as Length
 from pacienti
 where pEmri  like 'V%'
order by Length desc
 LIMIT 2;
-- view per pacienta qe munen me dhuru gjak gr. te gjakut 0+ dhe qe skan smundje kronike --
create view Dhuruesit_e_gjakut as
			select pEmri as Emri,pMbiemri as Mbiemri,pGrupiGjakut as 'Grupi Gjakut',pSemundjetKronike from Pacienti 
			where pGrupiGjakut like '0%' and pSemundjetKronike is null ;
 
 
