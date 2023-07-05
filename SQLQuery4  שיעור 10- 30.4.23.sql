--שיעור 10- 30.4.23

--נוריד דאטה בייס חדש של מייקרוסופט
--AdventureWorks2019 --שם הדאטהבייס
--הדאטה בייס נמצא בתיקייה סי תחת תיקיית טמפ
--כשיש נקודה בשם הטבלה- זה סכמה- שזה כמו תיקייה
--הורדנו את המסםר 2 בשם הדאטה בייס שהורדנו ושמנו אותו בתיקייה סי וכך הצלחנו להגיע אליו 
--ולשים אותו בסרבר שלנו.

--נלמד פונק חדשה:
-- כדי להגיע למלל למטה נלחץ אפ אחד על השם פרס ניימ

--PARSENAME
/*
Returns the specified part of an object name.
The Part of an object that can be retrieved are the
object name, schema name, database name, and server name.

PARSENAME ('object_name', object_piece)

*/

--הפונק לוקחת סטרינג עם נקדות ואז אני אומר לו:
--תביא לי את החלק הראשון למשל (מספר 1) ואז הוא יתן את המילה הראשונה מימין!!!
--מביא את החלק הראשון מימין או השני או השלישי- לפי המספר שאני כותבת בסוגריים.

SELECT PARSENAME ('AdventureworksPDW2012.dbo.DimCustomer', 1) AS 'Object name' ;

--חייב שיהיה נקודה בין החלקים במילה הראשונה בסוגריים
--צריך להשתמש בריפלייס כדי להחליף את המינוס בנקודה

SELECT PARSENAME(replace('AdventureWorksPDW2012.dbo.DimCustomer','-', '.'),2) AS 'Schema Name';

--טוב כדי למצוא קידומת של טלפון למשל:

--'052-333-444'

SELECT PARSENAME(replace('052-333-444','-', '.'),3) AS 'Phone ex';

--נניח ניקח כתובת אייפי מסויימת
--ונרצה למצוא את החלק הרביעי (הראשון- כי זה מימין

--'ip - 10.103.51.27'
 --               חלוקה לחלקים שהאסקיואל מבין כי זה מימין לשמאל- אז זה סדר המספרים     4  3   2   1
 --לכן החלק הרביעי הוא בעצם הראשון כי זה מימין לשמאל

SELECT PARSENAME('10.103.51.27',4) AS 'ip-ex';

--ניכנס לכל האובייקטים שיש במערכת כך:
--ז"א האובייקטים שמרכיבים את בסיס הנתונים- פורנן קי, וכו

use AdventureWorks2019

select *
from sys.objects


--SCHEMA_NAME:
--sys.objects- מפה נמצא את כל האובייקטים של הדאטה בייס

--מביא לי למטה את הסכמות של השמות של כל מי שקשור לסיילס:
--סכמה ניים זה פונק שיודעת לקחת מסכימה איידי ולהוציא רק סכימה ניים
--ז"א להוציא את כל האובייקטים שמקושרות לסיילס
--לכל סכימה יש איידי וסכימה ניים יודע לקחת סכימה איידי ולהוציא ממנו שם

select name, SCHEMA_NAME(SCHEMA_ID), SCHEMA_ID
from sys.objects
where SCHEMA_NAME(SCHEMA_ID) ='Sales'

--לכל אובייקט יש סוג,טבלה זה יו למשל- זה הטטייפ
--אז למטה נמצא טבלאות של סיילס
--כי עשינו גם טייפ של יו וגם ביקשנו שהסכימה ניים תהיה סיילס
--זה תחת איזו סכימה האובייקט יושב. סכימה זה כמו תיקייה

select name, SCHEMA_NAME(SCHEMA_ID), SCHEMA_ID, type
from sys.objects
where SCHEMA_NAME(SCHEMA_ID) ='Sales'
and type = 'U'

--סימה זה כמו פולדר= כמו תיקייה- זה מאגד אובייקטים בתוך קבוצה
--לדוגמה טבלה.
--כי כך יותר קל אחכ למצוא אובייקטים
--סכימה זה ספרייה
--סכימה ניים מקבלת רק איידי

--איך יוצרים סכימה:
--קודם ניצור דאטה בייס חדש:

use master

create database test_db

use test_db

CREATE SCHEMA Chains;

--כעת נייצר טבלה בתוך לסכימה
--תחת צייס ניצור טבלה סייז

--דק זה הטייפ ז"א שיהיו 10 מספרים ואז 2 אחרי הנקודהDEC

create table Chains.Size (ChainID int, width dec (10,2))

--בגלל שיצרנו טבלה- נראה בטייפ- את האות יו שזה טבלה

select *, SCHEMA_NAME(SCHEMA_ID)
from sys.objects
where SCHEMA_NAME(SCHEMA_ID) = 'Chains'
and type = 'U'

--תרגיל:
--להביא פורנט קי שיושבים תחת פרסון
--GET all FK from [AdventureWorks2019 ] under schema person
--אפ זה הטייפ של פורטן קי

select *, SCHEMA_NAME(SCHEMA_ID)
from AdventureWorks2019.sys.objects
where SCHEMA_NAME(SCHEMA_ID) = 'Person'
and type = 'F'

--למעלה: בתוצאה- בניים זה אוביקטים בתוך סכמת פרסון
--כך נראה את כל הפורנט קי שיצרנו בתוך סכימת פרסון


--המשך התרגיל- על כל הפורנט קי של הפרסון, נמצא את האובייקט שבו כתוב בניים פסוורד
--תרגיל: נחפש את האובייקט שבו כתוב פסוורד
--נשנה את הקו תחתון לנקודה על ידי ריפלייס כי כך הפונק מבינה
--נמצא את הפסוורד
--נראה כי הפסוורד נמצא כמילה ראשונה- ז"א מספר 4
--נבין כי הניים מורכב פה מ4 נקודות- זה חלקי המשפט

select *,ParseName(Replace(name,'_','.'),3) as Wanted_Part, SCHEMA_NAME(SCHEMA_ID) as Fk 
from AdventureWorks2019.sys.objects
where SCHEMA_NAME(SCHEMA_ID)='person' 
and type = 'F' 
and ParseName(Replace(name,'_','.'),3)='password'

--תרגיל:
--נמצא את:
--כל אלה שמצד ימין- באובייקט השניה כתוב ביזנס
--השדה השני מצד ימין יש לו ביזנס
--בגלל שחיפםשנו כאלה שיש בתוך השם את המילה ביזנס אז עשינו אחוזים- כאילו באמצע המשפט

select * , SCHEMA_NAME(SCHEMA_ID) as 'schema' , PARSENAME(replace(name,'_','.'),2) as 'name wanted'
from sys.objects
where SCHEMA_NAME(SCHEMA_ID)  = 'person'
and type = 'f' and PARSENAME(replace(name,'_','.'),2) like '%business%'

--סוגי אובייקטים:

select * from sys.tables

select * from sys.views

--מציאת שדה ספציפי= עמודה ספציפית:

select * from sys.all_columns

--למשל מציאת כל הביזנס:
--כך נתמצא בטבלאות גדולות:

select * from sys.all_columns
where name like 'business%'

--תרגיל:
--מטבלת אדוונטרס וורקס- מטבלת אימייל אדרס-
--פרסון= הסכימה 
--הטבלה= אימייל אדרס
--למצוא את שלושת החלקים שלו
--בעמודת אימייל- יש שלוש חלקים נסתכל בדוגמה שורה מתחת:- קאן זה השם, האמצע זה דומיין=שם החברה, ואחרי הנקודה זה סוג החברה
--ken0@adventure-works.com אימייל לדוגמה:
--אז נביא את שלושת השדות:

use AdventureWorks2019

select *
from [Person].[EmailAddress]


select *, PARSENAME(replace(EmailAddress,'@','.'),3) as 'name',
PARSENAME(replace(EmailAddress,'@','.'),2) as 'domain',
PARSENAME(EmailAddress,1) as 'type'
from [Person].[EmailAddress]


--פונק חדשה:

--NULLIF

--אם יש התאמה של 2 ערכים- ז"א זהים אז חוזר נאל
--Returns a null value if the two specified expressions are equal.

--כאן יחזור נאל
select nullif(1,1) 

--כאן יחזור השמאלי כי אין ערכים זהים
select nullif(1,2) 

--תרגיל:
--למצוא באימפלואיז ע"י נאלאיפ את כל מי שהשם משפחה -הגודל שלו שווה לגודל של השם הפרטי
--נשתמש בוור באיז נאל כי התוצאה שאנו רוצים היא נאל- כי כשהם שווים יוצא נאל

use Northwind

select e.FirstName , e.LastName , len(e.FirstName) as FirstNameLen,
len(e.LastName) as LastNameLen
from Employees as e 
where nullif(len(e.LastName), len(e.FirstName)) is null

--תרגיל:
--עמוד 34 שאלה 15 מהחוברת
--בכל החוברת תרגילים נשתמש בדאטה בייס AdventureWorks2019 

use AdventureWorks2019

--כדי לחפש את העמודה שיש בשאלה נכתוב:

select * from sys.all_columns
where name like '%FinishedGoodsFlag%'
order by name

--כדי לחפש שם טבלה:

select * from sys.objects
where object_id = 514100872

--ואז אני רואה בניים- פרודקט. ז"א שאחרי שם הסכימה- פרודקשן יהיה כתוב פרודקט

--תשובה סופית:

SELECT p.ProductID,p.MakeFlag, p.FinishedGoodsFlag,
  nullif (p.MakeFlag, p.FinishedGoodsFlag)
 from Production.Product as p
 where p.ProductID < 10

 --פונק חדשה:

 --COALESCE
--מתעלם מהנאלים ומחזיר את הערך הראשון שאחרי הנאלים

 -- Evaluates the arguments in order and 
 -- returns the current value of the first expression that 
 -- initially doesn't evaluate to NULL.

SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value'); 

 SELECT COALESCE('First_value' , NULL, NULL, 'third_value', 'fourth_value'); 

  SELECT COALESCE( NULL, 'First_value', NULL, 'third_value', 'fourth_value');

  use Northwind
  
  --למטה המשמעות:
  --אם הריג'ן נאל- הוא יציג את פקס, אם פקס אין- יציג פון- אם פון אין- יציג 0
  --את כל ההצגות הללו הוא יעשה בשדה החדש- אם אין ריג'ן- יופיע פקס בשדה הנוסף וכו
  --לפי הסדר של מה שכתוב בסוגריים
  --אם יש פקס אז הוא יציג בשדה החדש- שדה קול- את הפקס

  select c.CustomerID, Fax, Phone, 
  coalesce( fax, phone, '0' ) as col
  from Customers as c

  --אפשר למיין לפי שדות:

   select c.CustomerID, Fax, Phone, 
  coalesce( fax, phone, '0' ) as col
  from Customers as c
  order by 2, 3, 4

  --פונק שלמדנו:

  --STUFF

 -- The STUFF function inserts a string into another string. 
 -- It deletes a specified length of characters 
 -- in the first string at the start position and then inserts the second string into the first string at the start position.
 -- STUFF ( character_expression , start , length , replace_with_expression )
 --מאיפה להתחיל, כמה לקחת וכמה להכניס- זה הסינטקס

 --למטה:
 --קח מהמקום השני 3 אותיות ותכניס אותן
 --קח את המילה כעכע
 --תתחיל מהאות השניה
 --כמה ניקח? 3 אותיות
 --ותכניס פנימה מהמילה השניה מהאות השלישית

 --הסבר:
 --במילה הראשונה שבסוגריים-  תתחיל מהאות ה2
 --ותמשיך לאורך של 3 אותיות
 --ואז תחליף באותיות שבמילה הראשונה, את כל האותיות מהמילה השניה
 SELECT STUFF('abcdef', 2, 3, 'ijklmn');

 --תרגיל- עמוד 31 שאלה 7:

 use AdventureWorks2019

select productid, name, STUFF(name,1,5,'Meital') as Fixed
from production.product
where name like 'metal%'

-- או 

select productid, name, STUFF(name,3,0,'i') as Fixed
from production.product
where name like 'metal%'

--שאלה 8 עמוד 31 סעיף א
--RN= ראנק

use AdventureWorks2019

select RANK ( ) OVER ( order by DocumentNode ) as RN , * 
from Production.Document

--שאלה 8 עמוד 31 סעיף ב
--נשתמש ב-סיטיאי- סאב קוורי וכך נביא רק את שורות שהרנק שלהם הוא 9 ו10
--נשתמש בCTE

--שלב 1:
with cte 
AS
(select RANK ( ) OVER ( order by DocumentNode ) as RN , * 
from Production.Document)
select * from cte where RN in (9,10)

--שלב 2:
--בסטף- על איזה שדה נעשה פעולה, ואז מאיפה להתחיל, ואז כמה להוציא ואז מה להכניס- את הכוכבית רפלקטור
--בגלל שזה את כל המילה אז נעשה לן

with cte
AS
(select RANK ( ) OVER ( order by  DocumentNode ) as RN , * 
 from Production.Document)
 select cte.Title  , STUFF(cte.Title ,CHARINDEX('Reflector' ,cte.Title ) , len('Reflector') , '*REFLECTOR*')
 from cte where RN in (9,10)

 --זה בדיקה שהוא מצא למעלה:

select CHARINDEX('Reflector' , 'Front Reflector Bracket and Reflector Assembly 3' )

select * from Person.EmailAddress
--Masking (התממה)
--אם אני שולח דאטה אני חייב להתממים את המידע
--כדי שמי שינסה לגנוב קובץ לא יזהה את הנתונים האמיתיים
--למשל את כל ה4 החלפתי לכוכבית
--זה סוג של הצפנה
--נניח אני שולח מספר= 01746376337
--אז אשלח את המספר כך:017$6376337
--ולמי שאני שולח הוא ידע שהחלפתי 4 ב$ י

--תרגיל:
--נחליף את ה@ לאמפרס& י
--באימייל אדרס
-- @ --> &
--נשתמש בסטפ

use AdventureWorks2019

--זה בלי להתשמש בסטפ:
select e.EmailAddress , REPLACE(e.EmailAddress , '@' ,'&'  ) from Person.EmailAddress as e

--תשובה עם סטפ STUFF
select EmailAddress,
STUFF (EmailAddress,charindex('@',EmailAddress),len('@'),'&')
from Person.EmailAddress

--פונק חדשה:

--REPLICATE
--Repeats a string value a specified number of times.
--כל מה שכותבים במילה הראשונה בסוגריים, הוא מכפיל לפי הכמות שכתוב במילה השניה בסוגריים
--אז כאן למטה הוא יכפיל שהאפס יופיע 4 פעמים
--&- נקרא אמפרסנט
select REPLICATE ('0', 4)

--תרגיל:
--בהמשך לתרגיל למעלה
--בתוצאה שקיבלנו- ז"א בעמודה שבה באימייל ה חלפנו את השטורדל ל&
-- להחליף בין התווים שלפני ה&
--כמספר התווים שנמצאילם לפני &
--נחליפם בכוכביות***
--למשל הכתובת aaron1&adventure-works.com
--תהפוך ל: ******&adventure-works.com
--בגלל שיש 6 אותיות לפני ה&
--אז נרשום במקומן 6 כוכביות
--כדי להחליף את מה שלפניו נעשה מינוס 1

--סטפ- נתחיל מההתחלה של האימייל אז נכתוב 1 כי כך זה מהאות הראשונה
--ואז צר אינדסק עד השטרודל
--ואז נחליף אז ריפליקייט של החלפה 
--מינוס אחד כי אני רוצה שיוצג השטורדל
--פלוס ה&

select *, STUFF(ea.EmailAddress, 1, CHARINDEX('@', ea.EmailAddress),
REPLICATE('*',CHARINDEX('@', ea.EmailAddress)-1)+'&')
from person.EmailAddress as ea

--למה נשים מינוס אחד?
--השטרודל הוא באות השביעית אז נעשה אחד פחות
--אם לא היינו עושים מינוסאחד אז היה רק כוכביות וישר &

--עמוד 32 תרגיל 9

select p.Name, p.ProductLine,
concat(REPLICATE('0',4) ,p.ProductLine) as LineCode
from Production.Product as p
where p.ProductLine is not null

--עמוד 32 תרגיל 10
--נראה בתשובה שיש בחוברת שיש עמודה אחת- אז נעשה קונקט כדי לחבר הכל לעמודה אחת


select CONCAT(REPLICATE('  ' , e.OrganizationLevel ), e.BusinessEntityID , '-' , e.JobTitle )
 from HumanResources.Employee as e

--עמוד 32 תרגיל 11

select s.BusinessEntityID ,  
 IIF(((s.Bonus )) = 0 , '' , REPLICATE ('*' ,len(cast(s.Bonus as int))))
 from sales.SalesPerson as s

--עמוד 32 תרגיל 12
--נזכור שהפונק אייאיפ מחזירה אחד משני ערכים, תלוי אם הביטוי הבוליאני מוערך כטרו או פולס
--IIF( boolean_expression , true_value , false_value ) --תחביר
--ביטוי בוליאני הוא ביטוי שיכול לקבל את הערכים "אמת" ו"שקר"
--נבין שאחרי הערך הבוליאני שהגדרנו שהוא 0, אז נגדיר לאחר מכן בסוגריים שהוא לא קיבל בוסנוס- כי ה האמת
--ובפולס- מרשום קיבל בונוס- כי כל מי שלא קיבל 0 אז בהכרח קיבל בונוס

 select s.BusinessEntityID , iif(s.Bonus = 0 , 'did not get bonus' , 'got bonus')
 from sales.SalesPerson as s

--עמוד 32 תרגיל 13

with cte
AS
(
SELECT CustomerID
,SalesOrderID
,OrderDate
,LAG(OrderDate)OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS "order" 
,DATEDIFF(d,LAG(OrderDate)
OVER(PARTITION BY CustomerID ORDER BY OrderDate),OrderDate) AS date1
FROM Sales.SalesOrderHeader
)
select CustomerID , IIF (max(date1) < 100 , 'GOOD' , 'BAD') 
from cte
group by CustomerID


--ניתן גם להוסיף עמודה שכותבת לנו את ההפרשים בין התאריכים של כל לקוח
--אבל זה הורס את המיון והסדר

with cte
AS
(
SELECT CustomerID
,SalesOrderID
,OrderDate
,LAG(OrderDate)OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS "order" 
,DATEDIFF(d,LAG(OrderDate)
OVER(PARTITION BY CustomerID ORDER BY OrderDate),OrderDate) AS date1
FROM Sales.SalesOrderHeader
)
select CustomerID , IIF (max(date1) < 100 , 'GOOD' , 'BAD'), date1
from cte
group by CustomerID, date1


--שיעורי בית- בחוברת- לעשות את כל השאלות של האדוונס


with cteX as(
SELECT customerid, orderdate, LEAD(orderdate, 1) OVER (partition by customerid ORDER BY orderdate) AS next_order
FROM [Sales].[SalesOrderHeader])
select customerid, 
iif(sum(IIF(datediff(D,orderdate,next_order)<100,0,1))>1,'Bad Customer','Good Customer')
from cteX
group by customerid






-- Varibale= משתנה
-- בסיס של שפת תכנות

--הצהרתי על משתנה שנקרא X
--מסוג אינט
--זה להגדיר אותו
-- ורק אחכ אני יכול לשים עליו ערך
--ואז שמנו עחליו ערך 3
--משתנה= מצביע לתא זיכרון עם ערך

DECLARE @X int  --הצהרנו על המשתנה
set @X = 3  --הצבנו בתוכו ערך


select @X --התוצאה תופיע בריזלטס למטה-  result

print @X  -- יופיע במסג' למטה בתוצאות  - messages 

--חייב להריץ הכל יחד

DECLARE @x int 
set @x = 3*150112020
print @x

--למשל:

DECLARE
@lname varchar(40),
@fname varchar(40)

set @lname = 'Elad'
set @fname = 'Shalev'

select CONCAT(@lname, ' ' , @fname)

--כל מה שלמעלה פה זה יחד- להריץ כמקשה אחת

DECLARE
@lname int,
@fname int

set @lname = 1025
set @fname = 1685

select @lname * @fname

-- התוצאה למעלה הכפילה בין המספרים

--התוצאה למטה חיברה את המספרים

DECLARE 
@lname int, 
@fname int

set @lname =1025
set @fname =1685

select (@lname + @fname )