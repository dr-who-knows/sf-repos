public class EquipmentCalloutToWarehouse {
    @future(callout=true)
    public static void getEquipment() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-superbadge-apex.herokuapp.com/equipment');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200){
            List<Object> externalProducts = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> internalProducts = new List<Product2>();

            for(Object p: externalProducts){
                Map<String, Object> productMap = (Map<String,Object>) p;
                Product2 pr = new Product2();

                pr.Reaplacemant_Part__c = (boolean) productMap.get('replacement');
                pr.Cost__c = (Integer) productMap.get('cost');
                pr.Current_INventory__c = (Integer) productMap.get('quantity');
                pr.Lifespan_Months__c = (Integer) productMap.get('lifespan');
                pr.Maintenance_Cycle__c = (Integer) productMap.get('maintenanceperiod');
                pr.Warehouse_SKU__c = (String) roductMap.get('sku');
                pr.ProductCode = (String) productMap.get('_id');
                pr.Name = (String) roductMap.get('name');

                internalProducts.add(pr);
            }

            if(internalProducts.size() > 0)
            upsert internalProducts Warehouse_SKU__c; //upsert based on field value
        }

    }
}
