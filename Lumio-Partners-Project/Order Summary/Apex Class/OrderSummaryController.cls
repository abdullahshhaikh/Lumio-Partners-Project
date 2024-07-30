public with sharing class OrderSummaryController {
    @AuraEnabled(cacheable=true)
    public static List<OrderWrapper> getAllOrderSummaries() {
        List<Order> orders = [
            SELECT Id, OrderNumber, Account.Name, Total_Quantity__c,
                   (SELECT Id, Product2.Name, Quantity FROM OrderItems)
            FROM Order
        ];

        List<OrderWrapper> orderWrappers = new List<OrderWrapper>();
        for (Order order : orders) {
            List<OrderItemWrapper> orderItems = new List<OrderItemWrapper>();
            for (OrderItem oi : order.OrderItems) {
                orderItems.add(new OrderItemWrapper(oi.Id, oi.Product2.Name, oi.Quantity));
            }
            orderWrappers.add(new OrderWrapper(order.Id, order.OrderNumber, order.Account.Name, order.Total_Quantity__c, orderItems));
        }

        return orderWrappers;
    }

    public class OrderWrapper {
        @AuraEnabled public Id orderId;
        @AuraEnabled public String orderNumber;
        @AuraEnabled public String customerName;
        @AuraEnabled public Decimal totalQuantity;
        @AuraEnabled public List<OrderItemWrapper> orderItems;

        public OrderWrapper(Id orderId, String orderNumber, String customerName, Decimal totalQuantity, List<OrderItemWrapper> orderItems) {
            this.orderId = orderId;
            this.orderNumber = orderNumber;
            this.customerName = customerName;
            this.totalQuantity = totalQuantity;
            this.orderItems = orderItems;
        }
    }

    public class OrderItemWrapper {
        @AuraEnabled public Id orderItemId;
        @AuraEnabled public String productName;
        @AuraEnabled public Decimal quantity;

        public OrderItemWrapper(Id orderItemId, String productName, Decimal quantity) {
            this.orderItemId = orderItemId;
            this.productName = productName;
            this.quantity = quantity;
        }
    }
}