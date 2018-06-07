use FSMonitor

update FSMonitor.dbo.tfiles
set success = 1
where id in (
  SELECT f.id
  FROM FSMonitor.dbo.tfiles f
    left join FSMonitor.dbo.TXML_DATA node on node.tfile_id = f.id
    left join FSMonitor.dbo.TXML_DATA izv on izv.txml_data_id = node.id and izv.type = 'Element' and izv.name = N'ИЗВЦБКОНТР'
    left join FSMonitor.dbo.TXML_DATA rez on rez.txml_data_id = izv.id and rez.type = 'Attribute' and rez.name = N'КодРезПроверки' 
  where CAST(f.date AS DATE) = CAST(getdate() AS DATE) and f.success = 0 and f.name like 'IZVTUB%.xml' and node.type = 'Element' and node.name = N'Файл' and rez.value = '01'
)

update FSMonitor.dbo.tfiles
set success = 1
where id in (
  SELECT f.id
  FROM FSMonitor.dbo.tfiles f
    left join FSMonitor.dbo.TXML_DATA node on node.tfile_id = f.id and node.type = 'Element' and node.name = N'UV'
    left join FSMonitor.dbo.TXML_DATA rez on rez.txml_data_id = node.id
  where CAST(f.date AS DATE) = CAST(getdate() AS DATE) and f.success = 0 and f.name like 'UVARH550P%.xml' and rez.type = 'Element' and rez.name = N'REZ_ARH' and rez.value = N'принят'
)

update FSMonitor.dbo.tfiles
set success = 1
where id in (
  SELECT f.id
  FROM FSMonitor.dbo.tfiles f
    left join FSMonitor.dbo.TXML_DATA node on node.tfile_id = f.id and node.type = 'Element' and node.name = N'UV'
    left join FSMonitor.dbo.TXML_DATA rez on rez.txml_data_id = node.id
  where CAST(f.date AS DATE) = CAST(getdate() AS DATE) and f.success = 0 and f.name like 'UV[AB]N10123__________.xml' and rez.type = 'Element' and rez.name = N'REZ_ARH' and rez.value = N'принят'
)
