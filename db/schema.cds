namespace my.sales;
using {Country, managed} from '@sap/cds/common';

entity Products{
    key ID : UUID;
    name: String(255);
    description:LargeString;
    barcode:String(50);
    category:String(100);
    brand: String(50);
    price:Decimal(15,2);
    countInStock:Integer;
}

entity Orders: managed{
    key ID: UUID;
    number: String(20);
    customer: Association to Customers;
    amount: Decimal(15,2);
    currency:String(3);  
    status:String(20);
    requestedDeliveryDate: Date;
    deliveryDate: Date;
    shippingAddress: String;
    shippingFee: Decimal(15,2);
    totalAmount:  Decimal(15,2);
    items: Composition of many OrderItems on items.parent = $self;
}

entity OrderItems{
    key ID: UUID;
    number: String(20);
    product: Association to Products;
    parent: Association to Orders;
    quantity: Integer;
    price: Decimal(15,2);
}

entity Customers {
    key ID : UUID;
    firstName : String(100);
    lastName  : String(100);
    email     : String(255);
}
