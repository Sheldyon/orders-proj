using my.sales as my from '../db/schema';

service OrderService{
    entity Customers @readonly as projection on my.Customers;
    entity Products @readonly as projection on my.Products;
    entity Orders as projection on my.Orders;
    entity OrderItems as projection on my.OrderItems;
}
