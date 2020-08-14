select
vrs.Name0 AS [HostName],
vrs.Active0 AS[Active],
vrs.AD_Site_Name0 AS [AD Site],
vrs.User_Name0 AS [User],
os.Caption0 AS[Operating_System_Name],
os.BuildNumber0 AS[OS Build],
a.Assignment_UniqueID as [DeploymentID],
a.AssignmentName as [DeploymentName],
a.StartTime as Available,
a.EnforcementDeadline as Deadline,
sn.StateName as LastEnforcementState,
wsus.LastErrorCode as 'LasErrorCode',
wsus.LastScanTime as 'LastWSUSScan',
DateDiff(D, wsus.LastScanTime, GetDate()) as 'LastWSUSScan Age',
wks.LastHWScan,
DateDiff(D, wks.LastHwScan, GetDate()) as 'LastHWScan Age'
from v_CIAssignment a
join v_AssignmentState_Combined assc on a.AssignmentID=assc.AssignmentID
join v_StateNames sn on assc.StateType = sn.TopicType and sn.StateID=isnull(assc.StateID,0)
join v_R_System vrs on vrs.ResourceID = assc.ResourceID
Join v_GS_OPERATING_SYSTEM os on os.ResourceID=vrs.ResourceID
join v_GS_WORKSTATION_STATUS wks on wks.ResourceID = assc.ResourceID
join v_UpdateScanStatus wsus on wsus.ResourceID = assc.ResourceID
where a.AssignmentName = 'Deployment Name'
