namespace company.sales; 
using {Country, managed, cuid, sap.common.CodeList} from '@sap/cds/common';

entity Products: cuid{
    name: String(50);
    description:String(255);
    barcode:String(50);
    category:String(100);
    brand: String(50);
    price:Decimal(15,2);
    countInStock:Integer;
}

entity Orders: managed, cuid{
    number: String(20);
    customer: Association to Customers;
    amount: Decimal(15,2);
    currency:String(3);  
    status:Association to Statuses;
    requestedDeliveryDate: Date;
    deliveryDate: Date;
    shippingAddress: String;
    shippingFee: Decimal(15,2);
    totalAmount: Decimal(15,2);
    items: Composition of many OrderItems on items.parentOrder = $self;
}

entity OrderItems: cuid{
    number: String(20);
    product: Association to Products;
    parentOrder: Association to Orders;
    quantity: Integer;
    price: Decimal(15,2);
}

entity Customers: cuid {
    firstName : String(100);
    lastName  : String(100);
    email     : String(255);
}

@cds.odata.valuelist
entity Statuses: CodeList{
    key code : String(20);
}

