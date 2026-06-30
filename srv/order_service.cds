using company.sales as sales from '../db/schema';

service OrderService{
    entity Customers @readonly as projection on sales.Customers;
    entity Products @readonly as projection on sales.Products;
    entity Orders as projection on sales.Orders;
    entity OrderItems as projection on sales.OrderItems;
}
