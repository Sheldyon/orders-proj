using OrderService as service from '../../srv/order_service';

annotate service.Orders with {
    ID @title: '{i18n>OrderID}';
    number @title: '{i18n>OrderNumber}';
    status @title: '{i18n>OrderStatus}';
    customer @title: '{i18n>Customer}';
    amount @title: '{i18n>Amount}';
    shippingFee @title: '{i18n>ShippingFee}';
    totalAmount @title: '{i18n>TotalAmount}';
    currency @title: '{i18n>Currency}';
    requestedDeliveryDate @title: '{i18n>RequestedDeliveryDate}';
    deliveryDate @title: '{i18n>DeliveryDate}';
    shippingAddress @title: '{i18n>ShippingAddress}';
    createdAt @title: '{i18n>CreatedAt}';
    modifiedAt @title: '{i18n>ModifiedAt}';
    createdBy @title: '{i18n>CreatedBy}';
    modifiedBy @title: '{i18n>ModifiedBy}';
};

annotate service.Customers with {
    firstName @title: '{i18n>FirstName}';
    lastName @title: '{i18n>LastName}';
    email @title: '{i18n>Email}';
};

annotate service.OrderItems with {
    number @title: '{i18n>ItemNumber}';
    product @title: '{i18n>Product}';
    quantity @title: '{i18n>Quantity}';
    price @title: '{i18n>Price}';
    currency @title: '{i18n>Currency}';
};

annotate service.Products with {
    name @title: '{i18n>ProductName}';
    description @title: '{i18n>ProductDescription}';
    barcode @title: '{i18n>Barcode}';
    category @title: '{i18n>Category}';
    brand @title: '{i18n>Brand}';
    price @title: '{i18n>ProductPrice}';
    countInStock @title: '{i18n>CountInStock}';
};

annotate service.Orders with @(
    UI.SelectionFields : [
        number,
        status,
        customer.firstName,
        customer.lastName,
        customer.email,
        totalAmount,
        currency,
        requestedDeliveryDate,
        deliveryDate,
        shippingAddress,
    ],
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : number },
        { $Type : 'UI.DataField', Value : status },
        { $Type : 'UI.DataField', Value : customer.firstName },
        { $Type : 'UI.DataField', Value : customer.lastName },
        { $Type : 'UI.DataField', Value : customer.email },
        { $Type : 'UI.DataField', Value : totalAmount },
        { $Type : 'UI.DataField', Value : currency },
        { $Type : 'UI.DataField', Value : requestedDeliveryDate },
        { $Type : 'UI.DataField', Value : deliveryDate },
        { $Type : 'UI.DataField', Value : shippingAddress },
    ],
    UI.DataPoint #number : {
        $Type : 'UI.DataPointType',
        Value : number,
        Title : '{i18n>OrderNumber}',
    },
    UI.DataPoint #status : {
        $Type : 'UI.DataPointType',
        Value : status,
        Title : '{i18n>OrderStatus}',
    },
    UI.HeaderFacets : [
        { $Type : 'UI.ReferenceFacet', ID : 'number', Target : '@UI.DataPoint#number' },
        { $Type : 'UI.ReferenceFacet', ID : 'status', Target : '@UI.DataPoint#status' },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>GeneralData}',
            ID : 'GeneralData',
            Target : '@UI.FieldGroup#GeneralData',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrderItems}',
            ID : 'SalesOrderItems',
            Target : 'items/@UI.LineItem#SalesOrderItems',
        },
    ],
    UI.FieldGroup #GeneralData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Value : customer.firstName },
            { $Type : 'UI.DataField', Value : customer.lastName },
            { $Type : 'UI.DataField', Value : customer.email },
            { $Type : 'UI.DataField', Value : amount },
            { $Type : 'UI.DataField', Value : shippingFee },
            { $Type : 'UI.DataField', Value : totalAmount },
            { $Type : 'UI.DataField', Value : currency },
            { $Type : 'UI.DataField', Value : requestedDeliveryDate },
            { $Type : 'UI.DataField', Value : deliveryDate },
            { $Type : 'UI.DataField', Value : shippingAddress },
            { $Type : 'UI.DataField', Value : createdAt },
            { $Type : 'UI.DataField', Value : modifiedAt },
            { $Type : 'UI.DataField', Value : createdBy },
            { $Type : 'UI.DataField', Value : modifiedBy },
        ],
    },
);

annotate service.OrderItems with @(
    UI.LineItem #SalesOrderItems : [
        { $Type : 'UI.DataField', Value : number, Label : '{i18n>ItemNumber}' },
        { $Type : 'UI.DataField', Value : product.name, Label : '{i18n>Product}' },
        { $Type : 'UI.DataField', Value : quantity, Label : '{i18n>Quantity}' },
        { $Type : 'UI.DataField', Value : price, Label : '{i18n>Price}' },
        { $Type : 'UI.DataField', Value : parentOrder.currency, Label : '{i18n>Currency}' },
    ]
);