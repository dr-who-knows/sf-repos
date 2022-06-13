public with sharing class SatisfactionRatingTriggerHelper {
    public SatisfactionRatingTriggerHelper() {
    }

    public static void calculateAverageSatisfactionRate(List<Case> cases){

        Id accId = cases[0].AccountId;
        List<Case> allCases= [SELECT AccountId, Satisfaction_rating__c FROM Case WHERE Satisfaction_rating__c > 0 AND AccountId = :accId];
        Account acc = [SELECT ID, Average_satisfaction_rating__c FROM Account WHERE Id = :accId];
        Double sumRate =0;
        for(Case cs:allCases){
            sumRate += cs.Satisfaction_rating__c;
        }
        Double averageRate = sumRate / allCases.size();

        acc.Average_satisfaction_rating__c = averageRate;
        upsert(acc);

    }
}
