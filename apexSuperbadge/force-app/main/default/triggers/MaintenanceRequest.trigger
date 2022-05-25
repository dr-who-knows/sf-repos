trigger MaintenanceRequest on Case (after update) {
    
    if (Trigger.isAfter){
        MaintenanceRequestTriggerHelper.getCycleDays(Trigger.New);
    }
}