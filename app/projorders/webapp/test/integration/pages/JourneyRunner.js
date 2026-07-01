sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"projorders/test/integration/pages/OrdersList",
	"projorders/test/integration/pages/OrdersObjectPage",
	"projorders/test/integration/pages/OrderItemsObjectPage"
], function (JourneyRunner, OrdersList, OrdersObjectPage, OrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('projorders') + '/test/flpSandbox.html#projorders-tile',
        pages: {
			onTheOrdersList: OrdersList,
			onTheOrdersObjectPage: OrdersObjectPage,
			onTheOrderItemsObjectPage: OrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

