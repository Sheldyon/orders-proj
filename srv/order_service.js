const cds = require('@sap/cds');
const { SELECT, UPDATE } = cds.ql;

module.exports = cds.service.impl(async function () {

    const { Orders, OrderItems } = this.entities;
    
    this.on('reject', async req => {

        const ID = req.params[0].ID;
        const order = await SELECT.one
            .from(Orders)
            .where({ ID });

        if (!order) {
            return req.error(404, 'Заказ не найден');
        }

        if (order.status_code !== 'IN_PROGRESS') {
            return req.error(400,'Можно отклонить только действующий заказ');
        }

        await UPDATE(Orders)
            .set({status_code: 'REJECTED'})
            .where({ID});

       return await cds.run(SELECT.one.from(Orders).where({ID}));

    });

    this.on('resolve', async req => {

        const ID = req.params[0].ID;
        const { deliveryDate } = req.data;

        if (!deliveryDate) {
            return req.error(400,'Нужно указать deliveryDate');
        }

        const order = await SELECT.one
            .from(Orders)
            .where({ ID });

        if (!order) {
            return req.error(404,'Заказ не найден');
        }

        if (order.status_code !== 'IN_PROGRESS') {
            return req.error(400,'Можно завершить только действующий заказ');
        }

        await UPDATE(Orders)
            .set({status_code: 'RESOLVED', deliveryDate})
            .where({ID});

        return await cds.run(SELECT.one.from(Orders).where({ID}));


    });

    async function calculateAmount(items) {
        let amount = 0;
        for (const item of items) {
            amount += Number(item.quantity || 0) * Number(item.price || 0);
        }
        return amount;
    }

    this.before( 'SAVE', 'Orders',
        async req => {
            const ID = req.data.ID;
            const items = await SELECT
                .from(OrderItems.drafts)
                .where({parentOrder_ID: ID});

            const amount = await calculateAmount(items);
            req.data.amount = amount;

            if(items.length===0){
                req.error(400,'Заказ не может быть пустым');
            }
        }
    );
 
    this.after('draftActivate','Orders',
        async (data, req) => {
            const ID = req.params[0].ID;
            const items = await SELECT
                .from(OrderItems)
                .where({parentOrder_ID: ID});

            const amount = await calculateAmount(items);

            await UPDATE(Orders)
                .set({amount})
                .where({ID});

        }
    );

    this.after('READ','Orders',
        data => {
            const rate = 0.85;
            const orders = Array.isArray(data) ? data : [data];

            for (const order of orders) {
                if (order.totalAmount) {
                    order.totalAmountEUR = order.totalAmount * rate;
                }
            }
        }
    );

    
});