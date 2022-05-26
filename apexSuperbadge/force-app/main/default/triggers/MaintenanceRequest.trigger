trigger MaintenanceRequest on Case (after update) {
    
    if (Trigger.isAfter){
        MaintenanceRequestTriggerHelper.nextRoutineMaintenance(Trigger.New);
    }
}