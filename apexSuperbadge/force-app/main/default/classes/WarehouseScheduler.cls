global class WarehouseScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        EquipmentCalloutToWarehouse.getEquipment();
        String cronExpr = '0 1 * * *';
        System.schedule('EquipmentFromWarehouseSync', cronExpr, new WarehouseScheduler());
    }
}