public with sharing class MaintenanceRequestTriggerHelper {
    public MaintenanceRequestTriggerHelper() {
    }

    public static void nextRoutineMaintenance(List<Case> requests){
        List<Case> newCases = new List<Case>();
        Map<String,Integer> caseIdToCycleDays = getCycleDays(requests);

        for(Case c:requests){
            if (c.Status =='Closed'){
                if (c.Type =='Repair' || c.Type=='Routine Maintenance' ){
                    Case newCase = new Case();
                    newCase.Status = 'New';
                    newCase.Type = 'Routine Maintenance';
                    newCase.Origin = 'Web';
                    newCase.Date_Reported__c = Date.today();
                    newCase.Vehicle__c = c.Vehicle__c;
                    newCase.Product__c = c.product__c;

                    if (caseIdToCycleDays.get(c.Id) != null)
                        newCase.Date_Due__c = Date.today() + caseIdToCycleDays.get(c.Id);
                    else newCase.Date_Due__c = Date.today();
                    
                newCases.add(newCase);               
                }
            }
        }
        insert(newCases);

    }

    public static Map<String,Integer> getCycleDays(List<Case> requests){
        Map<String,Integer> caseIdToCycleDays = new Map<String,Integer>();
        Map<Id, Case> caseKeys = new Map<Id,Case> (requests);
        List<AggregateResult> fck = [SELECT Maintenance_Request__r.Id cId, MIN(Equipment__r.Maintenance_Cycle__c) cycle
                                    FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__r.Id in :caseKeys.keySet()
                                    GROUP BY Maintenance_Request__r.Id];
        for(AggregateResult res:fck){
            Integer addDays = 0;
            if (res.get('cycle') != null)
                addDays += Integer.valueOf(res.get('cycle'));
                caseIdToCycleDays.put((String)res.get('cId'),addDays);
        }
        return caseIdToCycleDays;
        
    }   

}
