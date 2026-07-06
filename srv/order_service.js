const cds = require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');
module.exports = cds.service.impl (async function(){
const {Orders}=this.entities;

this.on('reject',async (req)=>{
    const {ID}=req.data;
    const order =await SELECT.one.from(Orders).where({ID});

    if (!order){
        req.error (404, "Заказ не нацден");
         return; 
    }

    if (order.status_code !=='IN_PROGRESS'){
        req.error (400, 'Можно отклонить только действующий заказ' );
         return; 
    }

    await UPDATE(Orders).set({status_code:'REJECTED'}).where({ID});
    return await SELECT.one.from(Orders).where({ ID });
})

this.on('resolve',async (req)=>{
    const {ID, deliveryDate}=req.data;
    if (!deliveryDate) {
            req.error(400, 'Нужно указать deliveryDate');
            return;
        }
    const order =await SELECT.one.from(Orders).where({ID});

    if (!order){
        req.error (404, "Заказ не нацден");
         return; 
    }

    if (order.status_code !=='REJECTED'){
        req.error (404, 'Нельзя завершить отклоненный заказ' );
         return; 
    }

    await UPDATE(Orders).set({status_code:'RESOLVED',deliveryDate:deliveryDate}).where({ID});
    return await SELECT.one.from(Orders).where({ ID });
})
 }) 