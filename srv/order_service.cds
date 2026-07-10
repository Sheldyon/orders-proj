using company.sales as sales from '../db/schema';

service OrderService{
    entity Customers as projection on sales.Customers;
    entity Products as projection on sales.Products;

    @odata.draft.enabled
   entity Orders as projection on sales.Orders actions{
    action reject();
    action resolve(
        deliveryDate: Date not null
    );

};
    
    entity OrderItems as projection on sales.OrderItems;
    entity Statuses as projection on sales.Statuses; }