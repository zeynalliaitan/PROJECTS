--Suppliers cedvelinin yaradilmasi

CREATE TABLE suppliers( supplier_id NUMBER primary key,
suplier_name varchar2(25) not null,
contact_name varchar2(25) not null,
phone_number varchar2(20) not null,
email varchar2(25),
address varchar2(30) not null
);

CREATE SEQUENCE suppliers_sq;

insert into suppliers VALUES ( suppliers_sq.NEXTVAL,
'B MMC',
'Nigar Ceyhun',
'+944705587469',
'nigarceyhun@gmail.com',
'Feteli Xan Xoyski 23' );

CREATE OR replace trigger tg_suppliers_sq
before insert on suppliers
for each row
begin
select suppliers_sq.nextval into :new.supplier_id from
dual;
end;
/ 

CREATE OR REPLACE PROCEDURE insert_suppliers( p_suplier_name in suppliers.suplier_name%type,
p_contact_name in suppliers.contact_name%type,
p_phone_number in suppliers.phone_number%type,
p_email in suppliers.email%type,
p_address in suppliers.address%type
) is
begin
insert into suppliers (
    suplier_name,
    contact_name,
    phone_number,
    email,
    address
) VALUES ( p_suplier_name,
           p_contact_name,
           p_phone_number,
           p_email,
           p_address ) ;
commit;end ;
/

EXECUTE insert_suppliers('A MMC', 'Əliyev Aydın', '+994509669447', 'aliyevaydin@gmail.com', '28 May');

EXECUTE insert_suppliers('C MMC', 'Əli Seferov', '+994552369874', 'elisefer@gmail.com', 'Qara Qarayev 73');

EXECUTE insert_suppliers('D MMC', 'Necefova İnara', '+994772158746', 'inara.nadjaf@gmail.com', 'Rustam Rustamov 69');
select*from suppliers;
  
  
---Categories cedvelinin yaradilmasi

CREATE TABLE Categories(
category_id number primary key,
category_name varchar2(30) not null,
category_desc varchar2(50) not null
);

create sequence categories_sq;

CREATE OR replace trigger tg_categories_sq
before insert on Categories 
for each row
begin
select categories_sq.nextval into :new.category_id from dual;
end;
/

create or replace procedure insert_categories(
p_category_name in categories.category_name%type,
p_category_desc in categories.category_desc%type
) is
begin
insert into categories (
    category_name,
    category_desc
) VALUES ( p_category_name,
           p_category_desc ) ;
commit;

end;
/

EXECUTE insert_categories('Elektronika', 'Smartfon və Komputer');

EXECUTE insert_categories('Geyim', 'Qadı və kişi geyimləri');

EXECUTE insert_categories('Sports and Outdoors', 'Çöl və idman geyimləri');

EXECUTE insert_categories('Gözellik ve şəxsi qulluq', 'Kosmetika,dəriyə,şəxsi baxım');

EXECUTE insert_categories('Ev və mətbəx', 'Ev və mətbəx əşyaları,mebellər');

select*from categories;

--Sales cedvelinin yaradilmasi

CREATE TABLE sales( sale_id NUMBER PRİMARY KEY , SALE_DATE DATE NOT NULL);
CREATE SEQUENCE sales_sq;

CREATE OR replace trigger tg_sales_sq
before insert on sales 
for each row
begin
select sales_sq.nextval into :new.sale_id from
dual;

end;
/

CREATE OR REPLACE PROCEDURE insert_sales( p_sale_date in sales.sale_date%type
) is
begin
insert into sales ( SALE_DATE ) VALUES ( p_sale_date ) ; COMMİT ;
end;
/

EXECUTE insert_sales(TO_DATE('10.12.2024', 'dd.mm.yyyy'));

EXECUTE insert_sales(TO_DATE('27.12.2024', 'dd.mm.yyyy'));

EXECUTE insert_sales(TO_DATE('14.10.2024', 'dd.mm.yyyy'));

EXECUTE insert_sales(TO_DATE('20.12.2024', 'dd.mm.yyyy'));

EXECUTE insert_sales(TO_DATE('03.09.2024', 'dd.mm.yyyy'));

EXECUTE insert_sales(TO_DATE('03.09.2024', 'dd.mm.yyyy'));

SELECT
    *
FROM
    sales;

---------------
--Products cedvelinin yaradilmasi

CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL,
    category_id NUMBER,
    price NUMBER(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

create sequence products_sq;

CREATE OR replace trigger tg_products_sq
before insert on products 
for each row
begin
select products_sq.nextval into :new.product_id from
dual;

end;
/

CREATE OR REPLACE PROCEDURE insert_products( p_product_name in products.product_name%type,
p_category_id in products.category_id%type,
p_price in products.price%type
) is
begin
insert into products (
    product_name,
    category_id,
    price
) VALUES ( p_product_name,
           p_category_id,
           p_price ) ;
commit;end ;
/

EXECUTE insert_products('Tv LG', 8, 1529.99);

EXECUTE insert_products('iphone 15 pr max', 4, 3259.99);

EXECUTE insert_products('Ziyafət geyimi', 5, 45.00);

EXECUTE insert_products('İdman ayaqqabisi', 6, 125.99);

EXECUTE insert_products('Əl kremi', 7, 7.00);

EXECUTE insert_products('Komputer mouse', 4, 25);

EXECUTE insert_products('Soyuducu', 8, 1400);

EXECUTE insert_products('Şalvar', 5, 30.00);

EXECUTE insert_products('Hoodie', 6, 85.99);
select*from products;

----Purchases cedvelinin yaradilmasi

CREATE TABLE purchases (
    purchase_id    NUMBER PRIMARY KEY,
    supplier_id    NUMBER,
    purchase_date  DATE NOT NULL,
    FOREIGN KEY ( supplier_id )
        REFERENCES suppliers ( supplier_id )
);

create sequence purchases_sq;

CREATE OR replace trigger tg_purchases_sq
before insert on purchases 
for each row
begin
select purchases_sq.nextval into :new.purchase_id from
dual;

end;
/

CREATE OR REPLACE PROCEDURE insert_purchases( p_supplier_id in purchases.supplier_id%type,
p_purchase_date in purchases.purchase_date%type
) is
begin
insert into purchases (
    supplier_id,
    purchase_date
) VALUES ( p_supplier_id,
           p_purchase_date ) ;
commit;end ;
/
select*from suppliers;
SELECT
    *
FROM
    purchases;

EXECUTE insert_purchases(3, TO_DATE('07.11.2024', 'dd.mm.yyyy'));

EXECUTE insert_purchases(4, TO_DATE('15.10.2024', 'dd.mm.yyyy'));

EXECUTE insert_purchases(5, TO_DATE('04/03/2024', 'dd.mm.yyyy'));

EXECUTE insert_purchases(1, TO_DATE('04/03/2024', 'dd.mm.yyyy'));
-------------------------
----purchase_items cedvelinin yaradilmasi

CREATE TABLE purchase_items (
    purchase_item_id NUMBER PRIMARY KEY,
    purchase_id NUMBER,
    product_id NUMBER,
    quantity NUMBER NOT NULL,
    unit_price NUMBER(10, 2) NOT NULL,
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

create sequence purchase_items_sq;

CREATE OR replace trigger tg_purchase_items_sq
before insert on purchase_items
for each row
begin
select purchase_items_sq.nextval into :new.purchase_item_id from
dual;

end;
/

CREATE OR REPLACE PROCEDURE insert_purchase_item( p_purchase_id in purchase_items.purchase_id%type,
p_product_id in purchase_items.product_id%type,
p_quantity in purchase_items.quantity%type,
p_unit_price in purchase_items.unit_price%type
) is
begin
insert into purchase_items (
    purchase_id,
    product_id,
    quantity,
    unit_price
) VALUES ( p_purchase_id,
           p_product_id,
           p_quantity,
           p_unit_price ) ;
commit;end ;
/

select*from purchases;

EXECUTE insert_purchase_item(1, 3, 4, 1529.99);

EXECUTE insert_purchase_item(2, 5, 2, 125.99);

EXECUTE insert_purchase_item(4, 9, 1, 85.99);

EXECUTE insert_purchase_item(3, 7, 5, 1400);

EXECUTE insert_purchase_item(2, 2, 10, 1529.99);

EXECUTE insert_purchase_item(4, 2, 4, 1529.99);

EXECUTE insert_purchase_item(3, 2, 4, 1529.99);
-----------------------
---sale_items cedvelinin yaradilmasi

CREATE TABLE sale_items (
    sale_item_id NUMBER PRIMARY KEY,
    sale_id NUMBER,
    product_id NUMBER,
    quantity NUMBER NOT NULL,
    unit_price NUMBER(10, 2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

create sequence sale_items_sq;

CREATE OR replace trigger tg_sale_items_sq
before insert on sale_items
for each row
begin
select sale_items_sq.nextval into :new.sale_item_id from
dual;

end;
/

CREATE OR REPLACE PROCEDURE insert_sale_items( p_sale_id in sale_items.sale_id%type,
p_product_id in sale_items.product_id%type,
p_quantity in sale_items.quantity%type,
p_unit_price in sale_items.unit_price%type
) is
begin
insert into sale_items (
    sale_id,
    product_id,
    quantity,
    unit_price
) VALUES ( p_sale_id,
           p_product_id,
           p_quantity,
           p_unit_price ) ;
commit;end ;
/

EXECUTE insert_sale_items(1, 3, 4, 1529.99);

EXECUTE insert_sale_items(2, 5, 2, 125.99);

EXECUTE insert_sale_items(4, 9, 1, 85.99);

EXECUTE insert_sale_items(3, 7, 5, 1400);

EXECUTE insert_sale_items(5, 2, 1, 3259.99);

