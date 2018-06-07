
' Пример: UV_550.vbs CB_ES550P_20170815_002.XML d:\from\ c:\to\

' objArgs(0) - Имя файла
' objArgs(1) - Каталог вх
' objArgs(2) - Каталог исх

Dim i
DIM returnValue
Const RegNumber = "XXXX_XXXX"               'рег номер организации и филиала
Const FIO = "Пасенко Алексей Владимирович"        'указать оператора
Const TelNumber = "+X XXX XXX-XX-XX"    'указать телефон

Set objArgs = WScript.Arguments
Set FSO = CreateObject("Scripting.FileSystemObject")
Set File = FSO.GetFile(objArgs(1)&objArgs(0))


Function IIf(expr, truepart, falsepart)
	IIf = falsepart
	If expr Then IIf = truepart
end Function

If LCase(fso.GetExtensionName(file)) = "xml" Then   
  i=0 
  Set xmlDoc = CreateObject("Microsoft.XMLDOM")
  Set xmlParser = CreateObject("Msxml2.DOMDocument.6.0")
  xmlParser.appendChild(xmlParser.createProcessingInstruction("xml", "version='1.0' encoding='UTF-8'"))
  Set rootNode = xmlParser.appendChild(xmlParser.createElement("KVIT"))
  Set subNode = rootNode.appendChild(xmlParser.createElement("IDNOR"))
  subNode.text = RegNumber  'рег номер организации и филиала
  Set subNode = rootNode.appendChild(xmlParser.createElement("ES"))
  subNode.text = File.name
  Set subNode = rootNode.appendChild(xmlParser.createElement("SIZE_ES"))
  subNode.text = File.Size
  Set subNode = rootNode.appendChild(xmlParser.createElement("DATE_ES"))
  subNode.text = IIf(day(File.DateCreated)>9,"","0")&day(File.DateCreated)&"/"&IIf(month(File.DateCreated)>9,"","0")&month(File.DateCreated)&"/"&year(File.DateCreated)
  Set subNode = rootNode.appendChild(xmlParser.createElement("RECNO_ES"))
'прогоняем один раз для посчета количества записей
  If xmlDoc.Load(objArgs(1) + file.name) Then 'если документ загрузился без ошибок
    'берем все узлы    
    Set colNodes = xmlDoc.selectNodes("//НомерЗаписи")     
    For Each objNode In colNodes    	
	i=i+1	
    Next
  Else
    returnValue = 1
    WScript.Quit(returnValue)
  End If 
  Set newAttr = xmlParser.createAttribute("nRec")
  newAttr.value = i
  subNode.setAttributeNode(newAttr)
  If xmlDoc.Load(objArgs(1) + file.name) Then 'если документ загрузился без ошибок
    'берем все узлы    
    Set colNodes = xmlDoc.selectNodes("//НомерЗаписи")     
    For Each objNode In colNodes    
	Set subNode1 = subNode.appendChild(xmlParser.createElement("ES_REC"))
	Set newAttr1 = xmlParser.createAttribute("IdInfoOR")
	newAttr1.value = objNode.text
	subNode1.setAttributeNode(newAttr1)
	Set subNode2 = subNode1.appendChild(xmlParser.createElement("REZ_ES"))	
	subNode2.text = "0"
    Next
  Else
    returnValue = 1
    WScript.Quit(returnValue)
  End If
  Set subNode = rootNode.appendChild(xmlParser.createElement("DATE_KVIT"))
  subNode.text = IIf(day(Date)>9,"","0")&day(Date)&"/"&IIf(month(Date)>9,"","0")&month(Date)&"/"&year(Date)
  Set subNode = rootNode.appendChild(xmlParser.createElement("TIME_KVIT"))
  subNode.text = IIf(hour(Now)>9,"","0")&hour(Now)&":"&IIf(Minute(Now)>9,"","0")&Minute(Now)&":"&IIf(Second(Now)>9,"","0")&Second(Now)
  Set subNode = rootNode.appendChild(xmlParser.createElement("OPER"))
  subNode.text = FIO 
  Set subNode = rootNode.appendChild(xmlParser.createElement("TEL_OPER"))
  subNode.text = TelNumber
  xmlParser.save(objArgs(2)+ "UV_" +RegNumber +"_"&File.name)
End If
returnValue = 0
WScript.Quit(returnValue)