public with sharing class MaintenanceRequestTriggerHelper {
    public MaintenanceRequestTriggerHelper() {
    }

    public static void nextRoutineMaintenance(List<Case> requests){
        List<Case> newCases = new List<Case>();
        Map<String,Integer> idCycleDaysMap = getCycleDays(requests);

        for(Case c:requests){
            if (c.Status =='Closed'){
                if (c.Type =='Repair' || c.Type=='Routine Maintenance' ){
                    Case newCase = new Case();
                    newCase.Status = 'New';
                    newCase.Type = 'Routine Maintenance';
                    newCase.Origin = 'Web';
                    newCase.Date_Reported__c = Date.today();
                    newCase.Vehicle__c = c.Vehicle__c;
                    newCase.Equipment__c = c.Equipment__c;
                    if (idCycleDaysMap.get(c.Id) != null)
                        newCase.Date_Due__c = Date.today + idCycleDaysMap.get(c.Id);
                    else newCase.Date_Due__c = Date.today;
                newCases.add(newCase);                }
            }
        }
        insert(newCases);
    }

    public static Map<String,Integer> getCycleDays(List<Case> requests){
        Map<String,Integer> idCycleDaysMap = new Map<String,Integer>();
        Map<Id, Case> caseKeys = new Map<Id,Case> (requests);

        
    }   

 

}
