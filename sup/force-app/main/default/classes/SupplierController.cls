public with sharing class SupplierController {

    @AuraEnabled(cacheable=true)
    public static List<Supplier__c> getSuppliersRecords(String city ){
        

        //Account acc = [SELECT BillingCity FROM Account WHERE Id= :accId];
        //String city = acc.BillingCity;
        //List<Supplier__c> sups = Database.query('SELECT Id, Name FROM Supplier__c WHERE City__c = ' 
        //                                        + city); 
        //return sups;
        return [SELECT Id, Name FROM Supplier__c WHERE City__c = :city];
    
    }
}
