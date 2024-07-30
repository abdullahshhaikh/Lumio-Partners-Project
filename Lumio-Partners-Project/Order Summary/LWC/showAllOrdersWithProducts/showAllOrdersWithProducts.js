import { LightningElement, wire } from 'lwc';
import getAllOrderSummaries from '@salesforce/apex/OrderSummaryController.getAllOrderSummaries';

const columns = [
    { label: 'Order Number', fieldName: 'orderNumber' },
    { label: 'Customer Name', fieldName: 'customerName' },
    { label: 'Total Quantity', fieldName: 'totalQuantity', type: 'number' },
    { label: 'Products', fieldName: 'productDetails', type: 'text' } // New column for product details
];

export default class ShowAllOrdersWithProducts extends LightningElement {
    orders = [];
    error;
    columns = columns;

    @wire(getAllOrderSummaries)
    wiredOrders({ error, data }) {
        if (data) {
            this.orders = data.map(order => ({
                orderId: order.orderId,
                orderNumber: order.orderNumber,
                customerName: order.customerName,
                totalQuantity: order.totalQuantity,
                productDetails: this.formatProductDetails(order.orderItems) // Format product details
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.orders = [];
        }
    }

    formatProductDetails(orderItems) {
        if (!orderItems || orderItems.length === 0) {
            return 'No Products'; // Handle no products case
        }
        // Create a string representation of product details
        return orderItems.map(item => `${item.productName} (Qty: ${item.quantity})`).join(', ');
    }
}