
delimiter $$
create function Rroga(paga decimal, kuota decimal)
returns decimal
begin 
	return paga + paga * kuota;
end $$
delimiter $$

alter table Doktori add column ProvojaPunes integer;
update Doktori
set ProvojaPunes=8
where DID=19;

select * from Doktori;


delimiter $$
CREATE TRIGGER Rroga AFTER INSERT ON Doktori
FOR EACH ROW
DECLARE @DID INT = new.DID;
DECLARE @dProvojaPunes INT = new.ProvojaPunes;
DECLARE @dTitulli varchar(100) = new.dTitulli;
IF(@ProvojaPunes < 5)
BEGIN
	select * from Doktori
    where DID=@DID
    inner join Grada on gTitulli=dTitulli
    UPDATE Grada 
    SET gPaga = REPLACE(SELECT gPaga FROM grada WHERE gTitulli = @dTitulli) 
    where gTitulli=dTitulli;
    UPDATE column gPaga = (SELECT gPaga FROM grada WHERE gTitulli = @dTitulli);
END IF;
IF(@ProvojaPunes >= 5 && @ProvojaPunes < 10)
BEGIN
    UPDATE column gPaga = SELECT Rroga((SELECT gPaga FROM grada WHERE gTitulli = @dTitulli), 0.2);
END IF;
ELSE IF(ProvojaPunes > 10)
BEGIN
     UPDATE column dPaga = SELECT Rroga((SELECT gPaga FROM grada WHERE gTitulli = @dTitulli), 0.3);
END IF;
delimiter $$

delimiter $$
CREATE TRIGGER Rroge AFTER INSERT ON Doktori
FOR EACH ROW
IF(new.ProvojaPunes > 7)
BEGIN
    UPDATE Grada 
    SET gPaga = Rroga(gPaga, 0.2))
    WHERE gTitulli=new.dTitulli;
END IF;
delimiter $$














zdshhhhhhhhhhhhhhh