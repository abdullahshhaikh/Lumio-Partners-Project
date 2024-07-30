trigger OrderitemTrigger on OrderItem (after insert) {
	
    //This block will run when trigger event type is after insert
    if(Trigger.isInsert && Trigger.isAfter){
        OrderItemTriggerHandler classInstance = new OrderItemTriggerHandler();
        classInstance.updateTotalQuantityForOrder(Trigger.New);
    }
    
}