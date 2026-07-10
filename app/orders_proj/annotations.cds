using OrderService as service from '../../srv/order_service';


annotate service.Orders with @(
    
    UI.SelectionFields : [
        number,
        status_code,
        customer.firstName,
        customer.lastName,
        totalAmount,
        currency,
        requestedDeliveryDate,
        deliveryDate,
        shippingAddress
    ],


    UI.LineItem : [

        {
            $Type : 'UI.DataField',
            Value : number,
            Label : '{i18n>OrderNumber}'
        },

        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : '{i18n>OrderStatus}'
        },

        {
            $Type : 'UI.DataField',
            Value : customer.firstName,
            Label : '{i18n>FirstName}'
        },

        {
            $Type : 'UI.DataField',
            Value : customer.lastName,
            Label : '{i18n>LastName}'
        },

        {
            $Type : 'UI.DataField',
            Value : totalAmount,
            Label : '{i18n>TotalAmount}'
        },

        {
            $Type : 'UI.DataField',
            Value : currency,
            Label : '{i18n>Currency}'
        },

        {
            $Type : 'UI.DataField',
            Value : requestedDeliveryDate,
            Label : '{i18n>RequestedDeliveryDate}'
        },

        {
            $Type : 'UI.DataField',
            Value : deliveryDate,
            Label : '{i18n>DeliveryDate}'
        },

        {
            $Type : 'UI.DataField',
            Value : shippingAddress,
            Label : '{i18n>ShippingAddress}'
        }

    ],



    UI.HeaderFacets : [

        {
            $Type : 'UI.ReferenceFacet',
            ID : 'number',
            Target : '@UI.DataPoint#number'
        },

        {
            $Type : 'UI.ReferenceFacet',
            ID : 'status',
            Target : '@UI.DataPoint#status'
        }

    ],
    UI.Identification : [

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'OrderService.reject',
            Label : 'Reject'
        },

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'OrderService.resolve',
            Label : 'Resolve'
        }

    ],



    UI.Facets : [

        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>GeneralData}',
            ID : 'GENERALDATA',
            Target : '@UI.FieldGroup#GENERALDATA'
        },


        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrderItems}',
            ID : 'ITEMS',
            Target : 'items/@UI.LineItem#GeneralData'
        }

    ],




    UI.DataPoint #number : {

        $Type : 'UI.DataPointType',
        Value : number,
        Title : '{i18n>OrderNumber}'

    },


    UI.DataPoint #status : {

        $Type : 'UI.DataPointType',
        Value : status.name,
        Title : '{i18n>OrderStatus}'

    },




    UI.FieldGroup #GENERALDATA : {

        $Type : 'UI.FieldGroupType',

        Data : [

            {
                $Type : 'UI.DataField',
                Value : customer.firstName,
                Label : '{i18n>FirstName}'
            },


            {
                $Type : 'UI.DataField',
                Value : customer.lastName,
                Label : '{i18n>LastName}'
            },


            {
                $Type : 'UI.DataField',
                Value : amount,
                Label : '{i18n>Amount}'
            },


            {
                $Type : 'UI.DataField',
                Value : shippingFee,
                Label : '{i18n>ShippingFee}'
            },


            {
                $Type : 'UI.DataField',
                Value : totalAmount,
                Label : '{i18n>TotalAmount}'
            },


            {
                $Type : 'UI.DataField',
                Value : totalAmountEUR,
                Label : 'EUR'
            },


            {
                $Type : 'UI.DataField',
                Value : currency,
                Label : '{i18n>Currency}'
            },


            {
                $Type : 'UI.DataField',
                Value : requestedDeliveryDate,
                Label : '{i18n>RequestedDeliveryDate}'
            },


            {
                $Type : 'UI.DataField',
                Value : deliveryDate,
                Label : '{i18n>DeliveryDate}'
            },


            {
                $Type : 'UI.DataField',
                Value : shippingAddress,
                Label : '{i18n>ShippingAddress}'
            },


            {
                $Type : 'UI.DataField',
                Value : createdAt,
                Label : '{i18n>CreatedAt}'
            },


            {
                $Type : 'UI.DataField',
                Value : createdBy,
                Label : '{i18n>CreatedBy}'
            },


            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
                Label : '{i18n>ModifiedAt}'
            },


            {
                $Type : 'UI.DataField',
                Value : modifiedBy,
                Label : '{i18n>ModifiedBy}'
            }

        ]

    }

);





annotate service.Orders with {

number
    @title : '{i18n>OrderNumber}'
    @readonly;

status
    @title : '{i18n>OrderStatus}'
    @readonly;

customer
    @title : '{i18n>Customer}'
    @mandatory;

amount
    @title : '{i18n>Amount}'
    @readonly;

shippingFee
    @title : '{i18n>ShippingFee}';

totalAmount
    @title : '{i18n>TotalAmount}'
    @readonly;

currency
    @title : '{i18n>Currency}'
    @readonly;

requestedDeliveryDate
    @title : '{i18n>RequestedDeliveryDate}'
    @readonly;

deliveryDate
    @title : '{i18n>DeliveryDate}'
    @readonly;

shippingAddress
    @title : '{i18n>ShippingAddress}'
    @mandatory;

createdAt
    @title : '{i18n>CreatedAt}';

createdBy
    @title : '{i18n>CreatedBy}';

modifiedAt
    @title : '{i18n>ModifiedAt}';

modifiedBy
    @title : '{i18n>ModifiedBy}';

totalAmountEUR
    @readonly;

};

annotate service.Orders with {

status @Common.ValueList : {
    Label : '{i18n>OrderStatus}',
    CollectionPath : 'Statuses',
    Parameters : [
        {
            $Type : 'Common.ValueListParameterInOut',
            LocalDataProperty : status_code,
            ValueListProperty : 'code'
        },
        {
            $Type : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'name'
        }
    ]
};

};



annotate service.Customers with {


firstName @title @mandatory:'{i18n>FirstName}';

lastName @title @mandatory:'{i18n>LastName}';

email @title : '{i18n>Email}';


};





annotate service.OrderItems with {


number @title : '{i18n>ItemNumber}';

product @title : '{i18n>Product}';

quantity @title : '{i18n>Quantity}';

price @title : '{i18n>Price}';


};






annotate service.Statuses with {


code @title : '{i18n>StatusCode}';


};






annotate service.OrderItems with @(
    

UI.LineItem #GeneralData : [

    {
        $Type : 'UI.DataField',
        Value : number,
        Label : '{i18n>ItemNumber}'
    },


    {
        $Type : 'UI.DataField',
        Value : product.name,
        Label : '{i18n>Product}'
    },


    {
        $Type : 'UI.DataField',
        Value : quantity,
        Label : '{i18n>Quantity}'
    },


    {
        $Type : 'UI.DataField',
        Value : price,
        Label : '{i18n>Price}'
    },


    {
        $Type : 'UI.DataField',
        Value : parentOrder.currency,
        Label : '{i18n>Currency}'
    }


]

);





annotate service.Statuses with @(


UI.DataPoint #code : {

    $Type : 'UI.DataPointType',
    Value : code,
    Title : '{i18n>StatusCode}'

},


UI.DataPoint #code1 : {

    $Type : 'UI.DataPointType',
    Value : code,
    Title : '{i18n>StatusCode}'

}


);