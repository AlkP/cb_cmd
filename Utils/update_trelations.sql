
use FSMonitor
go

----------------------------------
-- добавляем записи по PB1
if object_id( 'tmpPB1') is not null drop table tmpPB1

CREATE TABLE tmpPB1
   (tfile_id INT
  , tfile_id_parent INT
  )
INSERT tmpPB1
SELECT 
   pb1.id
  ,parent.id
FROM 
  TFILES pb1
left join TFILES parent
  on substring(parent.name, 1, len(parent.name) - 4) = substring(pb1.name, 5, 31)
where pb1.NAME like 'PB1[_]____3510123%' 
  and parent.id is not null
  and CAST(pb1.date AS DATE) = CAST(getdate() AS DATE)

INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT
   parent.tfile_id, parent.tfile_id_parent, 'ies1'
FROM 
  tmpPB1 parent
left join TRELATIONS ee
  on (ee.TFILE_ID = parent.TFILE_ID and ee.TFILE_ID_PARENT = parent.TFILE_ID_PARENT and ee.TYPE = 'ies1')
where ee.id is null

if object_id( 'tmpPB1') is not null drop table tmpPB1
----------------------------------


----------------------------------
-- добавляем записи по IES2
if object_id( 'tmpIES2') is not null drop table tmpIES2

CREATE TABLE tmpIES2
   (tfile_id INT
  , tfile_id_parent INT
  )
INSERT tmpIES2
SELECT
   ies2.id
  ,parent.id
FROM 
  TFILES ies2
left join TFILES parent
  on substring(parent.name, 1, len(parent.name) - 4) = substring(ies2.name, 6, 31)
where (ies2.NAME like '____[_]____3510123%' or ies2.NAME like 'PB2[_]____3510123%')
  and parent.id is not null
  and CAST(ies2.date AS DATE) = CAST(getdate() AS DATE)
INSERT tmpIES2
SELECT
   ies2.id
  ,parent.id
FROM 
  TFILES ies2
left join TFILES parent
  on substring(parent.name, 1, len(parent.name) - 4) = substring(ies2.name, 5, 31)
where (ies2.NAME like '____[_]____3510123%' or ies2.NAME like 'PB2[_]____3510123%')
  and parent.id is not null
  and CAST(ies2.date AS DATE) = CAST(getdate() AS DATE)


INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT
   parent.tfile_id, parent.tfile_id_parent, 'ies2'
FROM 
  tmpIES2 parent
left join TRELATIONS ee
  on (ee.TFILE_ID = parent.TFILE_ID and ee.TFILE_ID_PARENT = parent.TFILE_ID_PARENT and ee.TYPE = 'ies2')
where ee.id is null

if object_id( 'tmpIES2') is not null drop table tmpIES2
----------------------------------


----------------------------------
-- добавляем записи по IES1_KWTFCB
if object_id( 'tmpIES1_KWTFCB') is not null drop table tmpIES1_KWTFCB

CREATE TABLE tmpIES1_KWTFCB
   (tfile_id INT
  , tfile_id_parent INT
  )
INSERT tmpIES1_KWTFCB
SELECT
   ies1_kwtfcb.id
  ,parent.id
FROM 
  TFILES ies1_kwtfcb
left join TFILES parent
  on 'KWTFCB_' + substring(parent.name, 1, len(parent.name) - 4) = substring(ies1_kwtfcb.name, 1, len(ies1_kwtfcb.name) - 4)
where ies1_kwtfcb.NAME like 'KWTFCB[_]PB1[_]____3510123%'
  and parent.id is not null
  and CAST(ies1_kwtfcb.date AS DATE) = CAST(getdate() AS DATE)

INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT 
  parent.TFILE_ID, parent.TFILE_ID_PARENT, 'ies1_kwtfcb'  
FROM 
  tmpIES1_KWTFCB parent
left join TRELATIONS ee
  on (ee.TFILE_ID = parent.TFILE_ID and ee.TFILE_ID_PARENT = parent.TFILE_ID_PARENT and ee.TYPE = 'ies1_kwtfcb')
where ee.id is null

if object_id( 'tmpIES1_KWTFCB') is not null drop table tmpIES1_KWTFCB
----------------------------------



----------------------------------
-- добавляем записи по IES2_KWTFCB
if object_id( 'tmpIES2_KWTFCB') is not null drop table tmpIES2_KWTFCB

CREATE TABLE tmpIES2_KWTFCB
   (tfile_id INT
  , tfile_id_parent INT
  )
INSERT tmpIES2_KWTFCB
SELECT
   ies2_kwtfcb.id
  ,parent.id
FROM 
  TFILES ies2_kwtfcb
left join TFILES parent
  on 'KWTFCB_' + substring(parent.name, 1, len(parent.name) - 4) = substring(ies2_kwtfcb.name, 1, len(ies2_kwtfcb.name) - 4)
where (ies2_kwtfcb.NAME like 'KWTFCB[_]PB2[_]____3510123%' or ies2_kwtfcb.NAME like 'KWTFCB[_]____[_]____3510123%')
  and parent.id is not null
  and CAST(ies2_kwtfcb.date AS DATE) = CAST(getdate() AS DATE)


INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT 
  parent.TFILE_ID, parent.TFILE_ID_PARENT, 'ies2_kwtfcb'  
FROM 
  tmpIES2_KWTFCB parent
left join TRELATIONS ee
  on (ee.TFILE_ID = parent.TFILE_ID and ee.TFILE_ID_PARENT = parent.TFILE_ID_PARENT and ee.TYPE = 'ies2_kwtfcb')
where ee.id is null

if object_id( 'tmpIES2_KWTFCB') is not null drop table tmpIES2_KWTFCB
----------------------------------



----------------------------------
-- добавляем записи по AFN/AFD
if object_id( 'tmpIZVTUB') is not null drop table tmpIZVTUB

CREATE TABLE tmpIZVTUB
   (tfile_id INT
  , tfile_id_parent INT
  )
INSERT tmpIZVTUB
SELECT
   izvtub.id
  ,parent.id
FROM TFILES izvtub
left join TFILES parent
  on substring(izvtub.name, 1, len(izvtub.name) - 4) = 'IZVTUB_' + substring(parent.name, 1, len(parent.name) - 4)
where izvtub.NAME like 'IZVTUB[_]AF_[_]3510123[_]%'
  and parent.id is not null
  and CAST(izvtub.date AS DATE) = CAST(getdate() AS DATE)


INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT
   parent.tfile_id, parent.tfile_id_parent, 'izvtub'
FROM 
  tmpIZVTUB parent
left join TRELATIONS ee
  on (ee.TFILE_ID = parent.TFILE_ID and ee.TFILE_ID_PARENT = parent.TFILE_ID_PARENT and ee.TYPE = 'izvtub')
where ee.id is null

if object_id( 'tmpIZVTUB') is not null drop table tmpIZVTUB
----------------------------------



----------------------------------
-- добавляем записи по S[BF][EFPR]
if object_id( 'tmpKWT311P') is not null drop table tmpKWT311P

CREATE TABLE tmpKWT311P
   (tfile_id INT
  , tfile_id_parent INT
  , ftype VARCHAR(20)
  )
INSERT tmpKWT311P
SELECT
   kwt311p.id
  ,parent.id
  ,LOWER (substring(kwt311p.name, 1, 3))
FROM 
  TFILES kwt311p
left join TFILES parent
  on substring(parent.name, 4, len(parent.name) - 7) = substring(kwt311p.name, 4, len(kwt311p.name) - 7)
where (kwt311p.NAME like 'S[BF][EFPR]__3510123%[_]___.xml')
  and (parent.NAME like 'S[BF]C__3510123%[_]___.xml')
  and parent.id is not null
  and CAST(kwt311p.date AS DATE) = CAST(getdate() AS DATE)


INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT
   parent.tfile_id, parent.tfile_id_parent, parent.ftype
FROM
  tmpKWT311P parent
left join TRELATIONS ee
  on (ee.TFILE_ID = parent.TFILE_ID and ee.TFILE_ID_PARENT = parent.TFILE_ID_PARENT and ee.TYPE = parent.FTYPE)
where ee.id is null

if object_id( 'tmpKWT311P') is not null drop table tmpKWT311P
----------------------------------



-- добавляем записи по CB_ES550P_
if object_id( 'tmpCB550P') is not null drop table tmpCB550P

CREATE TABLE tmpCB550P
   (name VARCHAR (250)
  , tfile_id INT
  , name_parent VARCHAR (250)
  , tfile_id_parent INT
  , type VARCHAR (20)
  )
INSERT tmpCB550P
SELECT
   p550.name
  ,p550.id
  ,parent.name
  ,parent.id
  ,'550_uv'
FROM TFILES p550
left join TFILES parent
  on substring(p550.name, 1, len(p550.name) - 4) = 'UV_2490_0000_' + substring(parent.name, 1, len(parent.name) - 4)
left join TRELATIONS ee
  on (ee.TFILE_ID = p550.id and ee.TFILE_ID_PARENT = parent.id and ee.TYPE = '550_uv')
where p550.name like 'UV[_]2490[_]0000[_]CB[_]ES550P[_]%'
  and parent.id is not null
  and ee.id is null
  and CAST(p550.date AS DATE) = CAST(getdate() AS DATE)


INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT
   tfile_id, tfile_id_parent, type
from
  tmpCB550P

if object_id( 'tmpCB550P') is not null drop table tmpCB550P


-- добавляем записи по UV550_ARH
if object_id( 'tmpUV550arh') is not null drop table tmpUV550arh

CREATE TABLE tmpUV550arh
   (name VARCHAR (250)
  , tfile_id INT
  , name_parent VARCHAR (250)
  , tfile_id_parent INT
  , type VARCHAR (20)
  )
INSERT tmpUV550arh
SELECT
   p550_arjout.name
  ,p550_arjout.id
  ,parent.name
  ,parent.id
  ,'550_uvArh'
FROM TFILES p550_arjout
left join TFILES parent
  on substring(p550_arjout.name, 1, len(p550_arjout.name) - 4) = 'UV' + substring(parent.name, 1, len(parent.name) - 4)
left join TRELATIONS ee
  on (ee.TFILE_ID = p550_arjout.id and ee.TFILE_ID_PARENT = parent.id and ee.TYPE = '550_uvArh')
where p550_arjout.name like 'UVARH550P[_]2490[_]0000[_]%'
  and parent.id is not null
  and ee.id is null
  and CAST(p550_arjout.date AS DATE) = CAST(getdate() AS DATE)


INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT
   tfile_id, tfile_id_parent, type
from
  tmpUV550arh

if object_id( 'tmpUV550arh') is not null drop table tmpUV550arh


-- добавляем записи по UV[AB]N10123
if object_id( 'tmpUV311arh') is not null drop table tmpUV311arh

CREATE TABLE tmpUV311arh
   (name VARCHAR (250)
  , tfile_id INT
  , name_parent VARCHAR (250)
  , tfile_id_parent INT
  , type VARCHAR (20)
  )
INSERT tmpUV311arh
SELECT
   p311_arjout.name
  ,p311_arjout.id
  ,parent.name
  ,parent.id
  ,'311_uvArh'
FROM TFILES p311_arjout
left join TFILES parent
  on substring(p311_arjout.name, 1, len(p311_arjout.name) - 4) = 'UV' + substring(parent.name, 1, len(parent.name) - 4)
left join TRELATIONS ee
  on (ee.TFILE_ID = p311_arjout.id and ee.TFILE_ID_PARENT = parent.id and ee.TYPE = '311_uvArh')
where p311_arjout.name like 'UV[AB]N10123__________.xml'
  and parent.id is not null
  and ee.id is null
  and CAST(p311_arjout.date AS DATE) = CAST(getdate() AS DATE)


INSERT INTO TRELATIONS (TFILE_ID, TFILE_ID_PARENT, TYPE)
SELECT
   tfile_id, tfile_id_parent, type
from
  tmpUV311arh

if object_id( 'tmpUV311arh') is not null drop table tmpUV311arh
go
