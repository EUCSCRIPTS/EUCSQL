 select sf.FileVersion,COUNT(netbios_name0) as 'Count' from v_R_System vrs
 join v_GS_SoftwareFile sf on sf.ResourceID = vrs.ResourceID
 where vrs.ResourceID in 
 (select ResourceID from v_GS_SoftwareFile where FileName ='chrome.exe') and sf.FileName ='chrome.exe'
 and (sf.FileVersion > '65.0.0.0' and sf.FileVersion < '70.0.0.0')
  group by Fileversion order by FileVersion desc
