Drop table product cascade constraints;
Drop table marketing_staff cascade constraints;
Drop table promotion cascade constraints;
Drop table promotion_product_details cascade constraints;
Drop table customer cascade constraints;
Drop table registration cascade constraints;
Drop table delivery cascade constraints;
Drop table postage cascade constraints;
Drop table inventory cascade constraints;
Drop table inventory_product_details cascade constraints;
Drop table shipment_details cascade constraints;
Drop table orders cascade constraints;
Drop table order_details cascade constraints;

CREATE TABLE product
(Product_ID varchar2(10),
Product_Price_Unit NUMBER(10,2),
Product_Type varchar2(30),
Product_Name varchar2(30),
Product_Total_Quantity NUMBER(10),
Product_Weight NUMBER(5,2),
CONSTRAINT P_Product_ID_pk PRIMARY KEY (Product_ID));

CREATE TABLE marketing_staff
(Staff_ID varchar2(10),
Staff_Name varchar2(30),
Staff_FB varchar2(30),
Staff_IC varchar2(14),
Staff_Address varchar2(100),
Staff_Phone varchar2(15),
CONSTRAINT MS_Staff_ID_pk PRIMARY KEY (Staff_ID));

CREATE TABLE customer
(Customer_ID varchar2(10),
Customer_Name varchar2(30),
Customer_Address varchar2(100),
Customer_Phone_No varchar2(15),
Customer_FB varchar2(30),
Customer_IC varchar2(14),
Customer_Email varchar2(60),
Customer_Status varchar2(10),
CONSTRAINT C_Customer_ID_pk PRIMARY KEY (Customer_ID));

CREATE TABLE registration
(Registration_ID varchar2(10),
Customer_ID varchar2(10),
Staff_ID varchar2(10),
Registration_Status varchar2(10) constraint REG_Status_cc check ((registration_status = 'DROPSHIP') 
or (registration_status = 'AGENT') or (registration_status = 'CLIENT')),
Registration_Date DATE,
Commission_Rate NUMBER(10,2),
CONSTRAINT REG_Registration_ID_pk PRIMARY KEY (Registration_ID),
CONSTRAINT REG_Customer_ID_fk FOREIGN KEY (Customer_ID) REFERENCES customer (Customer_ID),
CONSTRAINT REG_Staff_ID_fk FOREIGN KEY (Staff_ID) REFERENCES marketing_staff (Staff_ID));

CREATE TABLE promotion
(Promotion_ID varchar2(10),
Promotion_Price NUMBER(10,2),
CONSTRAINT P_Promotion_ID_pk PRIMARY KEY (Promotion_ID));

CREATE TABLE Promotion_Product_Details
(Promotion_Product_ID varchar2(10),
Promotion_ID varchar2(10),
Product_ID varchar2(10),
Product_Quantity NUMBER(5),
CONSTRAINT PDD_Promotion_Product_ID_pk PRIMARY KEY (Promotion_Product_ID),
CONSTRAINT PDD_Promotion_ID_fk FOREIGN KEY (Promotion_ID) REFERENCES promotion (Promotion_ID),
CONSTRAINT PDD_Product_ID_fk FOREIGN KEY (Product_ID) REFERENCES product (Product_ID));

CREATE TABLE delivery
(Delivery_ID varchar2(10),
Delivery_Location varchar2(30),
Delivery_Rate NUMBER(10,2),
CONSTRAINT D_Delivery_ID_pk PRIMARY KEY (Delivery_ID));

CREATE TABLE postage
(Postage_ID varchar2(10),
Postage_Location varchar2(20),
Postage_Rate NUMBER(10,2),
Postage_Weight_Rate VARCHAR2(15),
CONSTRAINT P_Postage_ID_pk PRIMARY KEY (Postage_ID));

CREATE TABLE inventory
(Inventory_ID varchar2(10),
Inventory_Status varchar2(10) constraint I_Status_cc check ((Inventory_Status = 'stock in')
or (Inventory_Status = 'stock out')),
Inventory_Date DATE,
CONSTRAINT I_Inventory_ID_pk PRIMARY KEY (Inventory_ID));

CREATE TABLE inventory_product_details
(Inventory_Product_ID varchar2(10),
Product_ID varchar2(10),
Inventory_ID varchar2(10),
Product_Inventory_Quantity NUMBER(5),
CONSTRAINT IPD_Inventory_Product_ID_pk PRIMARY KEY (Inventory_Product_ID),
CONSTRAINT IPD_Product_ID_fk FOREIGN KEY (Product_ID) REFERENCES product (Product_ID),
CONSTRAINT IPD_Inevntory_ID_fk FOREIGN KEY (Inventory_ID) REFERENCES inventory (Inventory_ID));

CREATE TABLE orders
(Order_ID varchar2(10),
Staff_ID varchar2(5),
Order_Date DATE,
Registration_ID varchar2(10),
Discount_Given NUMBER(5,2),
Inventory_ID varchar2(10),
Staff_Commission NUMBER (10,3),
CONSTRAINT O_Order_ID_pk PRIMARY KEY (Order_ID),
CONSTRAINT O_Staff_ID_fk FOREIGN KEY (Staff_ID) REFERENCES marketing_staff (Staff_ID),
CONSTRAINT O_Registration_ID_fk FOREIGN KEY (Registration_ID) REFERENCES registration (Registration_ID),
CONSTRAINT O_Inventory_ID_fk FOREIGN KEY (Inventory_ID) REFERENCES inventory (Inventory_ID));

CREATE TABLE shipment_details
(Shipment_ID varchar2(10),
Order_ID varchar2(10),
Shipment_Cost NUMBER(10,2),
Shipment_Type varchar2(10)constraint S_Type_cc check ((Shipment_Type = 'DELIVERY') 
or (Shipment_Type = 'POSTAGE')),
Shipment_Date DATE,
Shipment_Code varchar2(10) constraint S_Code_cc check ((Shipment_Code like 'PS%') 
or (Shipment_Code like 'D%')),
Shipment_Address varchar2(100),
CONSTRAINT SD_Shipment_ID_pk PRIMARY KEY (Shipment_ID),
CONSTRAINT SD_Order_ID_fk FOREIGN KEY (Order_ID) REFERENCES orders (Order_ID));

CREATE TABLE order_details
(Order_Details_ID varchar2(10),
Item_ID varchar2(10) constraints OD_Item_ID_cc check ((Item_ID like 'P%') or (Item_ID like 'PRO%')),
Order_ID varchar2(10),
Item_Quantity NUMBER (5),
Item_Price NUMBER(10,2),
Customer_Commission NUMBER(10,2),
Item_Type VARCHAR2(10) constraints OD_Item_Type_cc check ((Item_Type = 'PRODUCT') 
or (Item_Type = 'PROMOTION')),
CONSTRAINT OD_Details_ID_pk PRIMARY KEY (Order_Details_ID),
CONSTRAINT OD_Order_ID_fk FOREIGN KEY (Order_ID) REFERENCES orders (Order_ID));

column discount_given format 0.00;
column staff_commission format 0.00;
column item_price format 999.99;
column customer_commission format 990.00;
column postage_rate format 999.99;
column delivery_rate format 9999.99;
column product_price_unit format 999.99
column customer_address format A75;
column customer_email format A20;
column customer_fb format A15;
column registration_status format A20; 
column commission_rate format 0.90; 
column promotion_price format 900.00;
column promotion_id format A20;
column delivery_id format A20;
column postage_weight_rate format A20;
column order_date format A10;
column registration_id format A15;
column inventory_id format A15;
column shipment_details format A80;
column shipment_type format A15;
column shipment_id format A15;
column shipment_cost format 999.99;
column order_details_id format A16;
column customer_phone_no format A20
column customer_id format A15;
column customer_status format A20;
column shipment_date format A20;
column shipment_code format A20;
column inventory_id format A15;
column inventory_status format A20;
column inventory_date format A20;
column inventory_id format A15;
column inventory_product_id format A30;
column promotion_product_id format A20;
column staff_id format A15;

set linesize 2000;
set pagesize 2000;

INSERT INTO product 
VALUES ('P001', 11.50, 'Ready to eat', 'Nasi Briyani Gam Ayam', 660, 250.00); 

INSERT INTO product 
VALUES ('P002', 17.60, 'Ready to cook', 'Nasi Briyani Gam', 660, 535.00); 

INSERT INTO product 
VALUES ('P003', 4.20, 'Paste', 'Pes Kari Kepala Ikan', 789, 120.00); 

INSERT INTO product 
VALUES ('P004', 2.00, 'Other', 'Tepung Goreng Ayam', 600, 100.00); 

INSERT INTO product 
VALUES ('P005', 4.00, 'Ready to eat', 'Nasi Putih', 850, 250.00); 

INSERT INTO product 
VALUES ('P006', 6.50, 'Ready to eat', 'Kari Ayam', 420, 140.00); 

INSERT INTO product 
VALUES ('P007', 7.10, 'Ready to eat', 'Kari Daging', 500, 140.00); 

INSERT INTO product 
VALUES ('P008', 10.00, 'Ready to eat', 'Sambal Sotong Kering', 600, 180.00); 

INSERT INTO product 
VALUES ('P009', 5.50, 'Ready to eat', 'Sambal Tumis Ikan Bilis', 921, 140.00); 

INSERT INTO product 
VALUES ('P010', 9.20, 'Ready to eat', 'Nasi Goreng Ayam', 880, 250.00); 

INSERT INTO product 
VALUES ('P011', 9.20, 'Ready to eat', 'Nasi Goreng Daging', 520, 250.00); 

INSERT INTO product 
VALUES ('P012', 9.20, 'Ready to eat', 'Nasi Goreng Seafood', 210, 250.00); 

INSERT INTO product 
VALUES ('P013', 9.20, 'Ready to eat', 'Nasi Goreng Udang', 660, 250.00); 

INSERT INTO product 
VALUES ('P014', 9.20, 'Ready to eat', 'Nasi Goreng Kampung', 440, 250.00); 

INSERT INTO product 
VALUES ('P015', 9.20, 'Ready to eat', 'Nasi Goreng Ikan Masin', 610, 250.00); 

INSERT INTO product 
VALUES ('P016', 6.50, 'Ready to eat', 'Tomyam Ayam', 500, 140.00); 

INSERT INTO product 
VALUES ('P017', 9.20, 'Ready to eat', 'Nasi Briyani Gam Kambing', 610, 250.00); 

INSERT INTO product 
VALUES ('P018', 5.20, 'Ready to eat', 'Nasi Goreng', 660, 250.00); 

INSERT INTO product 
VALUES ('P019', 20.80, 'Ready to eat', 'Rendang Dendeng', 456, 240.00); 

INSERT INTO product 
VALUES ('P020', 20.80, 'Ready to eat', 'Rendang Minang', 500, 240.00); 

INSERT INTO marketing_staff
VALUES ('S001', 'Jackson Wang', 'Jaxkson_W', '560211-45-4575', '376 Jalan Tun Razak, 50400 Kuala Lumpur, Malaysia', '0124443222');

INSERT INTO marketing_staff
VALUES ('S002', 'Carls Lews', 'Carls_Lw', '980721-43-0245', 'Jalan Sutera Tanjung 8/3, Taman Sutera Utama, 81300 Skudai, Johor', '0124569822');

INSERT INTO marketing_staff
VALUES ('S003', 'Lebron James', 'J.Lebron', '560214-44-0051', '1 Kompleks Niaga Utama Jln 3/82B Bangsar Utama Malays, 59000 Kuala Lumpur', '0124545454');

INSERT INTO marketing_staff
VALUES ('S004', 'Toh Kok Ming', 'KM_Toh', '560211-90-0747', '7 Sungai Mas Plaza Jln Batu 5 Wilayah Persekutuan, 51200 Ipoh', '0122020223');

INSERT INTO marketing_staff
VALUES ('S005', 'Kyrie Erving', 'Kye_Erving','901205-11-3745', '38 Jalan 36/48 Taman Sentul Jaya, 51000, Kuala Lumpur', '0126767667');

INSERT INTO marketing_staff
VALUES ('S006', 'Eric Wilson', 'Eric_Wilson', '000829-13-8472', '18 Jalan Salim Taman Jaya, 43000, Kuala Lumpur', '0183472392');

INSERT INTO marketing_staff
VALUES ('S007', 'Michael Jordan', 'Michael_Jordan', '000923-12-4753', '66 Jalan SL1/2 Bukit Bintang, 51000, Kuala Lumpur', '0129472742');

INSERT INTO marketing_staff
VALUES ('S008', 'Marcus Tan', 'Marcus_Tan', '000123-03-8242', '321 Jalan Wong King Taman Bunga, 49000, Kuala Lumpur', '0124721823');

INSERT INTO marketing_staff
VALUES ('S009', 'Zoe Lim', 'Zoe_Lim', '000128-13-0284', '3 Taman Mentul Maju, 50400, Kuala Lumpur', '0148182742');

INSERT INTO marketing_staff
VALUES ('S010', 'Wong Nak Sung', 'W_NK', '000411-13-8242', '92 Jalan Ipoh Taman Eco, 96000, Sarawak', '0197472813');

INSERT INTO customer 
VALUES ('C001', 'John', '2A, Jalan 5, Taman Cheras Indah, 56100 Kuala Lumpur', '011-2344567', 'John_Boy', '567554-45-6688', 'john@gmail.com', 'Single');
  
INSERT INTO customer 
VALUES ('C002', 'Sam', '51, Jalan Perdana 2/24, Pandan Perdana, 55300 Selangor', '011-1122334', 'Sam_BB', '123331-23-5534', 'sam@gmail.com', 'Married'); 
  
INSERT INTO customer 
VALUES ('C003', 'James', '12, Jalan Penang, Taman Canning, 31400 Ipoh, Negeri Perak', '011-4455667', 'James_Bond', '976677-02-3455', 'james@gmail.com', 'Single'); 
  
INSERT INTO customer 
VALUES ('C004', 'Max', '28, Jalan Serindit 1e, Bandar Puchong Jaya, 47100 Puchong, Selangor', '011-7889967', 'Max_Mad', '112233-45-6688', 'max@gmail.com', 'Married'); 
 
INSERT INTO customer 
VALUES ('C005', 'Jordan','35, Lengkok Caunter, Taman Free School, 10460 Kepong 51200 ,Kuala Lumpur ', '011-2311111', 'Jordan_Jr', '561234-55-6688', 'jordan@gmail.com', 'Single'); 
  
INSERT INTO customer 
VALUES ('C006', 'Jack', 'Jalan 13, Kampung Baru Sepang Jaya, 43900 Sepang, Selangor', '011-0002267', 'Jack', '178317-56-6688', 'jack@gmail.com', 'Single'); 
  
INSERT INTO customer 
VALUES ('C007', 'Daniel', 'Jalan Angsa Mas 2, Kampung Tualang, 76100 Durian Tunggal, Melaka', '011-9393939', 'Danale', '567554-33-3333', 'daniel@gmail.com', 'Married');   

INSERT INTO customer 
VALUES ('C008', 'Bob', 'Jalan Sakeh Baru 6, Taman Sakeh Baru, 84000 Sepang, Kuala Lumpur', '011-9119117', 'Bob_Builder', '991131-34-7466', 'bob@gmail.com', 'Single'); 

INSERT INTO customer  
VALUES ('C009', 'Jax', 'Taman Salak Selatan, 57000 Kuala Lumpur, Federal Territory of Kuala Lumpur', '011-6867653', 'Jax_Jax', '910922-33-6688', 'jax@gmail.com', 'Single'); 

INSERT INTO customer 
VALUES ('C010', 'Jamie', '1-9, Jalan Dedap, Pekan Dengkil, 43800 Dengkil, Selangor', '011-0011011', 'Jamieeee', '001122-56-6898', 'jamie@gmail.com', 'Married'); 

column registration_status format A20; 
column commission_rate format 0.90; 

INSERT INTO registration 
VALUES ('R001', 'C001', 'S001', 'CLIENT', TO_DATE ('01/02/2019', 'DD/MM/YYYY'), 0.00);  

INSERT INTO registration 
VALUES ('R002', 'C001', 'S003', 'DROPSHIP', TO_DATE ('05/02/2019', 'DD/MM/YYYY'), 0.20); 

INSERT INTO registration 
VALUES ('R003', 'C002', 'S002', 'AGENT', TO_DATE ('26/02/2019', 'DD/MM/YYYY'), 0.30); 

INSERT INTO registration 
VALUES ('R004', 'C003', 'S006', 'CLIENT', TO_DATE ('15/04/2019', 'DD/MM/YYYY'), 0.00); 

INSERT INTO registration 
VALUES ('R005', 'C004', 'S008' , 'AGENT', TO_DATE ('27/06/2019', 'DD/MM/YYYY'), 0.30); 
  
INSERT INTO registration 
VALUES ('R006', 'C005', 'S007' , 'DROPSHIP', TO_DATE ('05/07/2019', 'DD/MM/YYYY'), 0.20);  

INSERT INTO registration 
VALUES ('R007', 'C006', 'S010', 'DROPSHIP', TO_DATE ('01/08/2019', 'DD/MM/YYYY'), 0.20);

INSERT INTO registration 
VALUES ('R008', 'C007', 'S004', 'CLIENT', TO_DATE ('05/08/2019', 'DD/MM/YYYY'), 0.00);  

INSERT INTO registration 
VALUES ('R009', 'C008', 'S001', 'CLIENT', TO_DATE ('05/09/2019', 'DD/MM/YYYY'), 0.00); 

INSERT INTO registration 
VALUES ('R010', 'C009', 'S010', 'AGENT', TO_DATE ('20/09/2019', 'DD/MM/YYYY'), 0.30); 

INSERT INTO registration
VALUES ('R011', 'C010', 'S009', 'AGENT', TO_DATE ('30/09/2019', 'DD/MM/YYYY'), 0.30); 

INSERT INTO registration  
VALUES ('R012', 'C002', 'S005', 'DROPSHIP', TO_DATE ('07/10/2019', 'DD/MM/YYYY'), 0.20);
 
INSERT INTO promotion
VALUES ('PRO001', 50.00);

INSERT INTO promotion
VALUES ('PRO002', 50.00);

INSERT INTO promotion
VALUES ('PRO003', 250.00);

INSERT INTO promotion
VALUES ('PRO004', 80.00);

INSERT INTO promotion
VALUES ('PRO005', 250.00);

INSERT INTO promotion_product_details
VALUES ('PP001', 'PRO001', 'P006', 1);

INSERT INTO promotion_product_details
VALUES ('PP002', 'PRO001', 'P007', 2); 

INSERT INTO promotion_product_details
VALUES ('PP003', 'PRO001', 'P008', 1); 

INSERT INTO promotion_product_details
VALUES ('PP004', 'PRO001', 'P016', 1); 

INSERT INTO promotion_product_details
VALUES ('PP005', 'PRO001', 'P009', 2); 

INSERT INTO promotion_product_details
VALUES ('PP006', 'PRO001', 'P005', 2);


INSERT INTO promotion_product_details
VALUES ('PP007', 'PRO002', 'P010', 1);

INSERT INTO promotion_product_details
VALUES ('PP008', 'PRO002', 'P011', 1);

INSERT INTO promotion_product_details
VALUES ('PP009', 'PRO002', 'P012', 1);

INSERT INTO promotion_product_details
VALUES ('PP010', 'PRO002', 'P013', 1);

INSERT INTO promotion_product_details
VALUES ('PP011', 'PRO002', 'P014', 1);

INSERT INTO promotion_product_details
VALUES ('PP012', 'PRO002', 'P015', 1);


INSERT INTO promotion_product_details
VALUES ('PP013', 'PRO003', 'P001', 5);

INSERT INTO promotion_product_details
VALUES ('PP014', 'PRO003', 'P017', 2);

INSERT INTO promotion_product_details
VALUES ('PP015', 'PRO003', 'P018', 6);

INSERT INTO promotion_product_details
VALUES ('PP016', 'PRO003', 'P008', 3);

INSERT INTO promotion_product_details
VALUES ('PP017', 'PRO003', 'P019', 4);

INSERT INTO promotion_product_details
VALUES ('PP018', 'PRO003', 'P006', 2);

INSERT INTO promotion_product_details
VALUES ('PP019', 'PRO003', 'P007', 2);

INSERT INTO promotion_product_details
VALUES ('PP020', 'PRO003', 'P009', 4);

INSERT INTO promotion_product_details
VALUES ('PP021', 'PRO003', 'P016', 2);

INSERT INTO promotion_product_details
VALUES ('PP022', 'PRO003', 'P005', 4);


INSERT INTO promotion_product_details
VALUES ('PP023', 'PRO004', 'P001', 2);

INSERT INTO promotion_product_details
VALUES ('PP024', 'PRO004', 'P018', 2);

INSERT INTO promotion_product_details
VALUES ('PP025', 'PRO004', 'P008', 1);

INSERT INTO promotion_product_details
VALUES ('PP026', 'PRO004', 'P019', 1);

INSERT INTO promotion_product_details
VALUES ('PP027', 'PRO004', 'P006', 1);

INSERT INTO promotion_product_details
VALUES ('PP028', 'PRO004', 'P009', 2);


INSERT INTO promotion_product_details 
VALUES ('PP029', 'PRO005', 'P001', 5);

INSERT INTO promotion_product_details 
VALUES ('PP030', 'PRO005', 'P017', 2);

INSERT INTO promotion_product_details 
VALUES ('PP031', 'PRO005', 'P018', 6);

INSERT INTO promotion_product_details 
VALUES ('PP032', 'PRO005', 'P008', 3);

INSERT INTO promotion_product_details 
VALUES ('PP033', 'PRO005', 'P020', 4);

INSERT INTO promotion_product_details 
VALUES ('PP034', 'PRO005', 'P006', 2);

INSERT INTO promotion_product_details 
VALUES ('PP035', 'PRO005', 'P007', 2);

INSERT INTO promotion_product_details 
VALUES ('PP036', 'PRO005', 'P009', 4);

INSERT INTO promotion_product_details 
VALUES ('PP037', 'PRO005', 'P016', 2);

INSERT INTO promotion_product_details 
VALUES ('PP038', 'PRO005', 'P005', 4);

column delivery_id format A20;

INSERT INTO delivery  
VALUES('D001', 'CHERAS', 10.00);    

INSERT INTO delivery  
VALUES('D002', 'SHAH ALAM', 8.00);  
  
INSERT INTO delivery  
VALUES('D003', 'KAWASAN LAIN KL', 8.00);  

INSERT INTO delivery   
VALUES('D004', 'SETAPAK', 9.00);  

INSERT INTO delivery  
VALUES('D005', 'SEPANG', 50.00);  

column postage_weight_rate format A20;

INSERT INTO postage    
VALUES ('PS001', 'KLANG VALLEY', 273.798, '245.01-246.00');   

INSERT INTO postage    
VALUES ('PS002', 'SARAWAK', 20.88, '1.05-1.50');  

INSERT INTO postage    
VALUES ('PS003', 'SABAH', 110.66, '8.01-8.50');    

INSERT INTO postage    
VALUES ('PS004', 'SARAWAK', 52.15, '3.51-4.00');  

INSERT INTO postage   
VALUES ('PS005', 'SARAWAK', 45.90, '3.01-3.50');   

INSERT INTO postage    
VALUES ('PS006', 'SABAH', 129.43, '9.51 - 10.00');  

INSERT INTO postage   
VALUES ('PS007', 'PENINSULAR MALAYSIA', 274.91, '245.01-246.00');   

INSERT INTO postage   
VALUES ('PS008', 'PENINSULAR MALAYSIA', 18.76, '8.01-9.00');  

INSERT INTO postage   
VALUES ('PS009', 'SABAH', 16.85, '0.00-1.00');  

INSERT INTO postage    
VALUES ('PS010', 'PENINSULAR MALAYSIA', 15.58, '5.01-6.00'); 


INSERT INTO inventory 
VALUES ('I001', 'stock out', TO_DATE('10/02/2019','DD/MM/YYYY')); 

INSERT INTO inventory 
VALUES ('I002', 'stock out', TO_DATE('22/02/2019','DD/MM/YYYY'));  

INSERT INTO inventory 
VALUES ('I003', 'stock in', TO_DATE('25/02/2019','DD/MM/YYYY')); 

INSERT INTO inventory 
VALUES ('I004', 'stock out', TO_DATE('26/02/2019','DD/MM/YYYY'));   

INSERT INTO inventory 
VALUES ('I005', 'stock out', TO_DATE('15/04/2019','DD/MM/YYYY')); 

INSERT INTO inventory 
VALUES ('I006', 'stock in', TO_DATE('15/04/2019','DD/MM/YYYY'));  

INSERT INTO inventory 
VALUES ('I007', 'stock out', TO_DATE('14/06/2019', 'DD/MM/YYYY'));  

INSERT INTO inventory 
VALUES ('I008', 'stock out', TO_DATE('27/06/2019', 'DD/MM/YYYY'));  

INSERT INTO inventory 
VALUES ('I009', 'stock out', TO_DATE('05/07/2019', 'DD/MM/YYYY'));
 
INSERT INTO inventory 
VALUES ('I010', 'stock out', TO_DATE('01/08/2019','DD/MM/YYYY'));  

INSERT INTO inventory 
VALUES ('I011', 'stock out', TO_DATE('05/08/2019', 'DD/MM/YYYY')); 

INSERT INTO inventory 
VALUES ('I012','stock out', TO_DATE('05/09/2019', 'DD/MM/YYYY')); 

INSERT INTO inventory 
VALUES ('I013','stock out', TO_DATE('20/09/2019', 'DD/MM/YYYY')); 

INSERT INTO inventory 
VALUES ('I014','stock out', TO_DATE('30/09/2019', 'DD/MM/YYYY')); 

INSERT INTO inventory 
VALUES ('I015','stock out', TO_DATE('07/10/2019', 'DD/MM/YYYY')); 


INSERT INTO inventory_product_details 
VALUES('IP001', 'P001', 'I001', 75); 

INSERT INTO inventory_product_details 
VALUES('IP002', 'P003', 'I001', 47); 

INSERT INTO inventory_product_details 
VALUES('IP003','P011','I001', 41); 

INSERT INTO inventory_product_details 
VALUES('IP004','P001','I002', 35); 

INSERT INTO inventory_product_details 
VALUES('IP005','P005','I002', 53); 

INSERT INTO inventory_product_details 
VALUES('IP006','P016','I002', 34); 

INSERT INTO inventory_product_details 
VALUES('IP007', 'P001', 'I003', 230);

INSERT INTO inventory_product_details 
VALUES('IP008', 'P006', 'I004', 39); 

INSERT INTO inventory_product_details 
VALUES('IP009' ,'P007', 'I004', 78); 

INSERT INTO inventory_product_details 
VALUES ('IP010', 'P008',  'I004', 39);

INSERT INTO inventory_product_details  
VALUES ('IP011', 'P016',  'I004', 39);

INSERT INTO inventory_product_details 
VALUES ('IP012','P009',  'I004', 78);

INSERT INTO inventory_product_details 
VALUES ('IP013', 'P005',  'I004', 78);

INSERT INTO inventory_product_details 
VALUES('IP014', 'P004', 'I005', 67); 

INSERT INTO inventory_product_details 
VALUES('IP015', 'P016', 'I005', 37); 

INSERT INTO inventory_product_details 
VALUES('IP016', 'P017', 'I006', 450); 

INSERT INTO inventory_product_details 
VALUES('IP017', 'P005', 'I006', 278); 
 
INSERT INTO inventory_product_details 
VALUES('IP018', 'P001', 'I007', 144); 

INSERT INTO inventory_product_details 
VALUES('IP019', 'P006', 'I007', 63);

INSERT INTO inventory_product_details 
VALUES('IP020', 'P007', 'I007', 36);

INSERT INTO inventory_product_details 
VALUES('IP021', 'P008', 'I007', 81);

INSERT INTO inventory_product_details 
VALUES('IP022', 'P009', 'I007', 126);

INSERT INTO inventory_product_details 
VALUES('IP023', 'P010', 'I007', 30);

INSERT INTO inventory_product_details 
VALUES('IP024', 'P011', 'I007', 30);

INSERT INTO inventory_product_details 
VALUES('IP025', 'P012', 'I007', 30);

INSERT INTO inventory_product_details 
VALUES('IP026', 'P013', 'I007', 30);

INSERT INTO inventory_product_details 
VALUES('IP027', 'P014', 'I007', 30);

INSERT INTO inventory_product_details 
VALUES('IP028', 'P015', 'I007', 30);

INSERT INTO inventory_product_details 
VALUES('IP029', 'P016', 'I007', 36);

INSERT INTO inventory_product_details 
VALUES('IP030', 'P017', 'I007', 36);

INSERT INTO inventory_product_details 
VALUES('IP031', 'P018', 'I007', 162);

INSERT INTO inventory_product_details 
VALUES('IP032', 'P019', 'I007', 99);

INSERT INTO inventory_product_details 
VALUES('IP033', 'P005', 'I007', 72);

INSERT INTO inventory_product_details 
VALUES('IP034', 'P007', 'I008', 50);

INSERT INTO inventory_product_details 
VALUES('IP035', 'P010', 'I009', 2);

INSERT INTO inventory_product_details 
VALUES('IP036', 'P011', 'I009', 2);

INSERT INTO inventory_product_details 
VALUES('IP037', 'P012', 'I009', 2);

INSERT INTO inventory_product_details 
VALUES('IP038', 'P013', 'I009', 2);

INSERT INTO inventory_product_details 
VALUES('IP039', 'P014', 'I009', 2);

INSERT INTO inventory_product_details 
VALUES('IP040', 'P015', 'I009', 2);

INSERT INTO inventory_product_details 
VALUES('IP041', 'P008', 'I010', 10);

INSERT INTO inventory_product_details 
VALUES('IP042', 'P009', 'I010', 15);

INSERT INTO inventory_product_details 
VALUES('IP043', 'P005', 'I010', 16);

INSERT INTO inventory_product_details 
VALUES('IP044', 'P010', 'I011', 76); 

INSERT INTO inventory_product_details 
VALUES('IP045', 'P011', 'I011', 76);

INSERT INTO inventory_product_details 
VALUES('IP046', 'P012', 'I011', 76);

INSERT INTO inventory_product_details 
VALUES('IP047', 'P013', 'I011', 76);

INSERT INTO inventory_product_details 
VALUES('IP048', 'P014', 'I011', 76);

INSERT INTO inventory_product_details 
VALUES('IP049', 'P015', 'I011', 76);

INSERT INTO inventory_product_details 
VALUES('IP050', 'P006', 'I011', 18);

INSERT INTO inventory_product_details 
VALUES('IP051', 'P007', 'I011', 36);

INSERT INTO inventory_product_details 
VALUES('IP052', 'P008', 'I011', 18);

INSERT INTO inventory_product_details 
VALUES('IP053', 'P016', 'I011', 18);

INSERT INTO inventory_product_details 
VALUES('IP054', 'P009', 'I011', 36);

INSERT INTO inventory_product_details 
VALUES('IP055', 'P005', 'I011', 36);

INSERT INTO inventory_product_details 
VALUES('IP056', 'P008', 'I012', 150);

INSERT INTO inventory_product_details 
VALUES('IP057', 'P014', 'I012', 120);

INSERT INTO inventory_product_details 
VALUES('IP058', 'P019', 'I012', 120);

INSERT INTO inventory_product_details 
VALUES('IP059', 'P020', 'I013', 150);

INSERT INTO inventory_product_details 
VALUES('IP060', 'P001', 'I014', 350);

INSERT INTO inventory_product_details 
VALUES('IP061', 'P017', 'I014', 140);

INSERT INTO inventory_product_details 
VALUES('IP062', 'P018', 'I014', 420);

INSERT INTO inventory_product_details 
VALUES('IP063', 'P008', 'I014', 210);

INSERT INTO inventory_product_details 
VALUES('IP064', 'P020', 'I014', 280);

INSERT INTO inventory_product_details 
VALUES('IP065', 'P006', 'I014', 140);

INSERT INTO inventory_product_details 
VALUES('IP066', 'P007', 'I014', 140);

INSERT INTO inventory_product_details 
VALUES('IP067', 'P009', 'I014', 280);

INSERT INTO inventory_product_details 
VALUES('IP068', 'P016', 'I014', 140);

INSERT INTO inventory_product_details 
VALUES('IP069', 'P005', 'I014', 280);

INSERT INTO inventory_product_details 
VALUES('IP070', 'P005', 'I015', 30);

column order_date format A10;
column registration_id format A15;
column inventory_id format A15;

INSERT INTO orders
VALUES ('O001', 'S001', TO_DATE ('10/02/2019', 'DD/MM/YYYY'), 'R002', 0.05, 'I001',0.03); 

INSERT INTO orders 
VALUES ('O002', 'S005', TO_DATE ('22/02/2019', 'DD/MM/YYYY'), 'R002', 0.05, 'I002',0.03); 

INSERT INTO orders 
VALUES ('O003', 'S003', TO_DATE ('26/02/2019', 'DD/MM/YYYY'), 'R003', 0.07, 'I004',0.016); 

INSERT INTO orders 
VALUES ('O004', 'S005', TO_DATE ('15/04/2019', 'DD/MM/YYYY'), 'R004', 0.0, 'I005',0.20); 

INSERT INTO orders 
VALUES ('O005', 'S002', TO_DATE ('14/06/2019', 'DD/MM/YYYY'), 'R004', 0.09, 'I007',0.16); 

INSERT INTO orders 
VALUES ('O006', 'S008', TO_DATE ('27/06/2019', 'DD/MM/YYYY'), 'R005', 0.0, 'I008',0.02); 

INSERT INTO orders 
VALUES ('O007', 'S009', TO_DATE ('05/07/2019', 'DD/MM/YYYY'), 'R006', 0.0, 'I009',0.024); 

INSERT INTO orders 
VALUES ('O008', 'S008', TO_DATE ('01/08/2019', 'DD/MM/YYYY'), 'R007', 0.0, 'I010',0.03); 

INSERT INTO orders 
VALUES ('O009', 'S003', TO_DATE ('05/08/2019', 'DD/MM/YYYY'), 'R008', 0.12, 'I011',0.16); 

INSERT INTO orders
VALUES ('O010', 'S003', TO_DATE ('05/09/2019', 'DD/MM/YYYY'), 'R009', 0.09, 'I012',0.20); 

INSERT INTO orders
VALUES ('O011', 'S007', TO_DATE ('20/09/2019', 'DD/MM/YYYY'), 'R010', 0.07, 'I013',0.02); 

INSERT INTO orders
VALUES ('O012', 'S005', TO_DATE ('30/09/2019', 'DD/MM/YYYY'), 'R011', 0.12, 'I014',0.016);

INSERT INTO orders
VALUES ('O013', 'S008', TO_DATE ('07/10/2019', 'DD/MM/YYYY'), 'R012', 0.00, 'I015',0.03);

INSERT INTO shipment_details
VALUES ('SP_001', 'O001', 10.00 , 'DELIVERY' , TO_DATE('10/02/2019', 'DD/MM/YYYY'), 'D001' ,
'2A, Jalan 5, Taman Cheras Indah, 56100 Kuala Lumpur');

INSERT INTO shipment_details
VALUES ('SP_002', 'O002', 8.00, 'DELIVERY' , TO_DATE('22/02/2019', 'DD/MM/YYYY'),'D002',
'No 5, Jalan Kristal L7/L, 40000 Seksyen 7, Shah Alam,Selangor');

INSERT INTO shipment_details
VALUES ('SP_003', 'O004', 8, 'DELIVERY' , TO_DATE('15/04/2019', 'DD/MM/YYYY'),'D003',
'Jalan Penang, Taman Canning, 57100 Kuala Lumpur, Wilayah Persekutan');

INSERT INTO shipment_details
VALUES ('SP_004', 'O005', 266.33 , 'POSTAGE' , TO_DATE('14/06/2019', 'DD/MM/YYYY'),'PS007',
'51, Jalan Perdana 2/24, Pandan Perdana, 55300 Selangor');

INSERT INTO shipment_details
VALUES ('SP_005', 'O007', 45.90, 'POSTAGE' , TO_DATE('05/07/2019', 'DD/MM/YYYY'),'PS005',
'Jalan Penang, Taman Canning, 57100 Kuala Lumpur, Wilayah Persekutan');

INSERT INTO shipment_details
VALUES ('SP_006', 'O008', 18.76, 'POSTAGE', TO_DATE('01/08/2019', 'DD/MM/YYYY'),'PS008',
'765 ,JALAN KOTA KENARI 4/5KOTA KENARI, 09000,KULIM KEDAH ');

INSERT INTO shipment_details
VALUES ('SP_007', 'O011', 50.00, 'DELIVERY', TO_DATE('20/09/2019', 'DD/MM/YYYY'),'D005',
'Jalan Sakeh Baru 6, Taman Sakeh Baru, 84000 Sepang, Kuala Lumpur');

INSERT INTO shipment_details
VALUES ('SP_008', 'O012', 50.00, 'DELIVERY', TO_DATE('30/09/2019', 'DD/MM/YYYY'),'D005',
'Jalan Sakeh Baru 6, Taman Sakeh Baru, 84000 Sepang, Kuala Lumpur');

INSERT INTO shipment_details
VALUES ('SP_009', 'O013', 18.76 , 'POSTAGE', TO_DATE('07/10/2019', 'DD/MM/YYYY'),'PS008',
'NO 15,Lorong 11, Taman Melati, 08000,Sungai Petani, Kedah');


INSERT INTO order_details   
VALUES('OD001', 'P001' , 'O001' , 75 , 11.50, 0.20,'PRODUCT');    

INSERT INTO order_details   
VALUES('OD002', 'P003' , 'O001', 47, 4.20, 0.20 , 'PRODUCT'); 

INSERT INTO order_details    
VALUES('OD003', 'P011', 'O001', 41, 9.20, 0.20 ,'PRODUCT'); 

INSERT INTO order_details    
VALUES('OD004', 'P001' , 'O002' , 35 , 11.50, 0.20, 'PRODUCT');   

INSERT INTO order_details   
VALUES('OD005', 'P005' , 'O002' , 53, 4.00, 0.20 , 'PRODUCT');  

INSERT INTO order_details   
VALUES('OD006', 'P016' , 'O002' , 34 , 6.50, 0.20 , 'PRODUCT'); 

INSERT INTO order_details   
VALUES('OD007', 'PRO001' , 'O003' , 39 , 50.00, 0.26, 'PROMOTION');     

INSERT INTO order_details   
VALUES('OD008', 'P004' , 'O004', 67 , 2.00, 0.0 , 'PRODUCT');    

INSERT INTO order_details    
VALUES('OD009', 'P016' , 'O004' , 37 , 6.50, 0.0 , 'PRODUCT'); 

INSERT INTO order_details    
VALUES('OD010', 'PRO004' , 'O005' , 27, 80.00, 0.0 , 'PROMOTION');   

INSERT INTO order_details    
VALUES('OD011', 'PRO002' , 'O005' , 30 , 50.00, 0.0, 'PROMOTION');    

INSERT INTO order_details   
VALUES('OD012', 'PRO003' , 'O005' , 18 , 250.00, 0.0, 'PROMOTION');

INSERT INTO order_details    
VALUES('OD013', 'P007' , 'O006' , 50 , 7.10, 0.30 ,'PRODUCT'); 

INSERT INTO order_details   
VALUES('OD014', 'PRO002' , 'O007' , 2 , 50.00, 0.16, 'PROMOTION'); 
   
INSERT INTO order_details   
VALUES('OD015', 'P008' , 'O008' , 10 , 10.00,0.20, 'PRODUCT'); 

INSERT INTO order_details   
VALUES('OD016', 'P009' , 'O008' , 15 , 5.50, 0.20, 'PRODUCT'); 

INSERT INTO order_details   
VALUES('OD017', 'P005' , 'O008' , 16, 4.00, 0.20, 'PRODUCT');  

INSERT INTO order_details   
VALUES('OD018', 'PRO002' , 'O009' , 76 , 50.00, 0.00 , 'PROMOTION'); 

INSERT INTO order_details   
VALUES('OD019', 'PRO001' , 'O009' , 18 , 50.00, 0.00 , 'PROMOTION'); 

INSERT INTO order_details   
VALUES('OD020', 'P008' , 'O010' , 150 , 10.00, 0.00, 'PRODUCT');    

INSERT INTO order_details     
VALUES('OD021', 'P014' , 'O010' , 120 , 9.20, 0.00, 'PRODUCT');     

INSERT INTO order_details   
VALUES('OD022', 'P019' , 'O010' ,120 , 20.80,0.00 , 'PRODUCT');   

INSERT INTO order_details   
VALUES('OD023', 'P020' , 'O011' ,150 , 20.80,0.30 , 'PRODUCT');     

INSERT INTO order_details   
VALUES('OD024', 'PRO005' ,'O012' ,70, 250.00 ,0.26 , 'PROMOTION');     

INSERT INTO order_details   
VALUES('OD025', 'P005' , 'O013' ,30 , 4.00 ,0.20 , 'PRODUCT');

