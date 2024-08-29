Select r.Customer_ID "ReceiverID", c.customer_name "Receiver Name", r.registration_status "Status", 
to_char(sum((od.Item_price * od.Item_quantity)*(1-o.discount_given)),'9999990.00') "Total Sales", 
to_char(round(sum(((od.Item_price * od.Item_quantity)*(1-o.discount_given)) * od.customer_commission),2),'9999990.00') "Commission" 
from orders o, order_details od, registration r, customer c 
where r.Customer_ID = c.customer_ID and r.Registration_ID = o.Registration_ID and o.Order_ID = od.Order_ID and o.order_date between TO_DATE('01/01/2019','DD/MM/YYYY') 
and TO_DATE('31/12/2019','DD/MM/YYYY') 
group by r.Customer_ID, c.customer_name, r.registration_status 
union 
Select s.Staff_ID, s.Staff_Name , NVL2(s.staff_fb,'STAFF','n/a') "REG_Stat", 
to_char(NVL2(TO_Number(staff_phone),0,0),'9999990.00') "Total Sales", 
to_char(round(sum(((od.Item_price * od.Item_quantity)*(1-o.discount_given)) * o.staff_commission),2),'9999990.00') "FEB Com" 
from orders o, order_details od, marketing_staff s 
where s.Staff_ID = o.Staff_ID and o.Order_ID = od.Order_ID and o.order_date between TO_DATE('01/01/2019','DD/MM/YYYY') 
and TO_DATE('31/12/2019','DD/MM/YYYY') 
group by s.Staff_ID, s.Staff_Name, s.staff_fb, staff_phone;

Select od.Order_ID, o.Order_date, od.Item_Type,To_Char(sum(od.Item_price * od.Item_quantity),'9999999999999.00') "Selling Price(SP)",  
To_char(trunc(sum(od.Item_price * od.Item_quantity)*o.discount_given,2),'99990.00') "Dis(D)",  
To_char(round(sum((od.Item_price * od.Item_quantity) * (1 - o.discount_given)),2),'9999999999.00')"Profit(SP-D=P)", To_char(round(sum((od.Item_price * od.Item_quantity)*(1-o.discount_given) * o.staff_commission),2),'99990.00') "S_COM" ,  
To_char(round(sum((od.Item_price * od.Item_quantity)*(1-o.discount_given) * od.customer_commission),2),'99990.00') "C_COM" ,  
To_char(NVL(s.shipment_cost, 0),'999999999999999990.00') "Shipment Cost(Ship)", 
To_char(round((sum((od.Item_price * od.Item_quantity) * (1 - o.discount_given)) * (1 - o.staff_commission - NVL(od.customer_commission,0)) - NVL(s.shipment_cost, 0)),2),'9999999999999999999999999.00') "Net Profit(P-SC-CC-Ship)"  
from orders o, order_details od , shipment_details s 
where o.Order_ID = od.Order_ID and o.Order_id = s.Order_id(+) 
group by od.Order_ID , o.Order_Date,  od.item_type ,o.discount_given, o.staff_commission, od.customer_commission, s.shipment_cost 
order by od.order_ID; 

Select o.order_ID, to_char((sum(od.item_quantity * p.product_weight)*1.1)/1000,'99999999999.00') "Parcel Weight", s.shipment_address, s.shipment_ID "S_ID"    
,s.shipment_code "S_Code" , ps.postage_location "location" ,ps.postage_weight_rate, to_char(ps.postage_rate,'9999.00') "Rate"   
from orders o, order_details od, product p , shipment_details s, postage ps    
where o.Order_id = od.Order_id and od.item_id = p.product_id and o.Order_ID = s.Order_ID and s.Shipment_Type = 'POSTAGE'    
and s.shipment_code = ps.postage_id and o.Order_date between TO_DATE('01/01/2019','DD/MM/YYYY')and TO_DATE('31/12/2019','DD/MM/YYYY')       
group by o.order_ID, s.shipment_ID, s.shipment_code, ps.postage_weight_rate, ps.postage_rate, shipment_address, postage_location    
union    
select od.order_ID , to_char((sum(p.product_weight*(od.item_quantity*ppd.product_quantity))*1.1)/1000,'99999999999.00') "Product Weight", s.shipment_address,    
s.shipment_ID, s.shipment_code, ps.postage_location "location", ps.postage_weight_rate, to_char(ps.postage_rate,'9999.00') "Rate"   
from product p , promotion_product_details ppd, promotion prom, order_details od, shipment_details s, postage ps    
where od.item_id = prom.promotion_ID and prom.promotion_ID = ppd.Promotion_ID and ppd.product_ID = p.product_ID    
and od.order_ID = s.order_ID and s.shipment_type = 'POSTAGE' and s.shipment_code = ps.postage_ID      
group by od.order_ID, s.shipment_Id, s.shipment_code, ps.postage_weight_rate, ps.postage_rate, shipment_address, postage_location; 

SELECT Product.Product_Name,To_Char(SUM(inventory_product_details.Product_Inventory_Quantity),'9999999999999999999')"Total Sales Quantity"  
FROM Product, Inventory_Product_Details,Inventory   
WHERE Inventory.Inventory_ID = Inventory_Product_Details.Inventory_ID    
AND Product.Product_ID  = Inventory_Product_Details.Product_ID    
AND Inventory.Inventory_Status = 'stock out'    
AND inventory.inventory_date between TO_DATE('01/01/2019','DD/MM/YYYY') and TO_DATE('31/12/2019','DD/MM/YYYY')   
group by product.product_name   
order by SUM(inventory_product_details.Product_Inventory_Quantity) DESC;

select r.Registration_ID"ID",c.Customer_Name"TERMINATED AGENT",r.Registration_Status"Status",To_Char(round(sum(od.item_price*od.item_quantity) *(1-o.discount_given),2),'9999999.99')"TOTAL SALES"   
from registration r,customer c,orders o,order_details od   
where r.registration_id=o.registration_id AND od.order_id=o.order_id AND r.customer_id=c.customer_id AND r.registration_status='AGENT' AND   
od.item_price*od.item_quantity<2000 AND o.Order_date between o.Order_Date and Add_months(o.Order_Date,3)   
group by r.Registration_ID,c.Customer_Name,r.Registration_Status,o.discount_given;

SELECT Orders.Order_Id "Order ID", Product.Product_Id "Product ID", Product.Product_Name "Product Name", To_Char(Product.Product_Price_Unit,'9999999999999999999.99') " Product Price Per Unit", Order_Details.Item_Quantity "Item Quantity", 
To_Char((Product.Product_Price_Unit*Order_Details.Item_Quantity),'999999999999999.99') As "Product Total Price" 
FROM Orders, Product, Order_Details 
WHERE Orders.Order_Id = Order_Details.Order_Id 
AND Product.Product_Id = Order_Details.Item_Id 
AND Order_Details.Item_Type = 'PRODUCT' AND Orders.Order_date between TO_DATE('01/01/2019','DD/MM/YYYY') and TO_DATE('31/12/2019','DD/MM/YYYY') 
ORDER BY Orders.Order_ID;

SELECT Orders.Order_Id, Promotion.Promotion_Id, Promotion.Promotion_Price,     
Order_Details.Item_Quantity, To_Char((Promotion.Promotion_Price*Order_Details.Item_Quantity),'99999999999999999.99')"Promotion Total Price" 
FROM Orders, Promotion, Order_Details    
WHERE Orders.Order_Id = Order_Details.Order_Id     
AND Promotion.Promotion_Id = Order_Details.Item_Id    
AND Order_Details.Item_Type = 'PROMOTION' AND Orders.Order_date between TO_DATE('01/01/2019','DD/MM/YYYY')and TO_DATE('31/12/2019','DD/MM/YYYY')      
ORDER BY Orders.Order_ID; 

SELECT Product_Name"Best-Selling Product ",total"Sold Quantity" from(  
SELECT P.Product_Name,Sum(IPS.Product_Inventory_Quantity)as total  
From Product P,Inventory_Product_Details IPS,Inventory I  
where I.Inventory_ID=IPS.Inventory_ID  
AND P.Product_ID=IPS.Product_ID  
AND I.Inventory_Status='stock out'  
AND I.inventory_date between TO_DATE('01/01/2019','DD/MM/YYYY') and TO_DATE('31/12/2019','DD/MM/YYYY')  
group by p.product_name  
order by SUM(IPS.Product_Inventory_Quantity)  
DESC)  
where rownum<=1;

SELECT Product_Name"Lowest-Selling Product ",total"Sold Quantity" from(   
SELECT P.Product_Name,Sum(IPS.Product_Inventory_Quantity)as total   
From Product P,Inventory_Product_Details IPS,Inventory I   
where I.Inventory_ID=IPS.Inventory_ID   
AND P.Product_ID=IPS.Product_ID   
AND I.Inventory_Status='stock out'   
AND I.inventory_date between TO_DATE('01/01/2019','DD/MM/YYYY') and TO_DATE('31/12/2019','DD/MM/YYYY')   
group by p.product_name   
order by SUM(IPS.Product_Inventory_Quantity)   
)   where rownum<=1; 



 