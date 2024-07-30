public class OrderItemTriggerHandler {
    
    public void updateTotalQuantityForOrder(List<OrderItem> orderList){
        // Map to store the total quantities for each Order
        Map<Id, Decimal> orderQuantities = new Map<Id, Decimal>();
        
        // Iterate through the inserted OrderItems
        for (OrderItem oi : orderList) {
            // Initialize the quantity for the Order if not already
            if (!orderQuantities.containsKey(oi.OrderId)) {
                orderQuantities.put(oi.OrderId, 0);
            }
            // Add the quantity of the current OrderItem to the total quantity of the Order
            orderQuantities.put(oi.OrderId, orderQuantities.get(oi.OrderId) + oi.Quantity);
        }
        
        // Query existing OrderItems for the Orders to get the complete quantity
        List<Order> ordersToUpdate = new List<Order>();
        for (Id orderId : orderQuantities.keySet()) {
            AggregateResult[] groupedResults = [SELECT SUM(Quantity) totalQuantity FROM OrderItem WHERE OrderId = :orderId];
            Decimal totalQuantity = (Decimal)groupedResults[0].get('totalQuantity');
            // Create Order records to update the Total_Quantity__c field
            ordersToUpdate.add(new Order(
                Id = orderId,
                Total_Quantity__c = totalQuantity
            ));
        }
        
        // Update the Orders with the new total quantities
        update ordersToUpdate;
    }
    
}