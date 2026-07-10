sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"company/sales/ordersproj/test/integration/pages/OrdersList",
	"company/sales/ordersproj/test/integration/pages/OrdersObjectPage",
	"company/sales/ordersproj/test/integration/pages/OrderItemsObjectPage"
], function (JourneyRunner, OrdersList, OrdersObjectPage, OrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('company/sales/ordersproj') + '/test/flpSandbox.html#companysalesordersproj-tile',
        pages: {
			onTheOrdersList: OrdersList,
			onTheOrdersObjectPage: OrdersObjectPage,
			onTheOrderItemsObjectPage: OrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

