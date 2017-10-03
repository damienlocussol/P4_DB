CREATE TABLE "public"."adress"
(
   id int PRIMARY KEY NOT NULL,
   customer_id int NOT NULL,
   numero varchar(1000) NOT NULL,
   street varchar(300) NOT NULL,
   adress_code int NOT NULL,
   city varchar(200) NOT NULL,
   building varchar(100),
   floor int,
   door varchar(100),
   digicode varchar(100),
   phone1 int NOT NULL,
   phone2 int,
   email text NOT NULL,
   position numeric(131089) NOT NULL
)
;
ALTER TABLE "public"."adress"
ADD CONSTRAINT customer_adress_fk
FOREIGN KEY (customer_id)
REFERENCES "public"."customer"(id)
;
CREATE UNIQUE INDEX adress_pk ON "public"."adress"(id)
;
CREATE TABLE "public"."bike"
(
   id int PRIMARY KEY NOT NULL,
   is_checked bool NOT NULL,
   date_revision date NOT NULL,
   status bool NOT NULL
)
;
CREATE UNIQUE INDEX bike_pk ON "public"."bike"(id)
;
CREATE TABLE "public"."category"
(
   id int PRIMARY KEY NOT NULL,
   name varchar(100) NOT NULL
)
;
CREATE UNIQUE INDEX category_pk ON "public"."category"(id)
;
CREATE TABLE "public"."customer"
(
   id int PRIMARY KEY NOT NULL,
   firstname varchar(100) NOT NULL,
   lastname varchar(100) NOT NULL,
   login varchar(100) NOT NULL,
   password varchar(100) NOT NULL
)
;
CREATE UNIQUE INDEX customer_pk ON "public"."customer"(id)
;
CREATE TABLE "public"."delivery_bag"
(
   product_id int NOT NULL,
   delivery_man_ss_number int NOT NULL,
   quantity int NOT NULL,
   CONSTRAINT delivery_bag_pk PRIMARY KEY (product_id,delivery_man_ss_number)
)
;
ALTER TABLE "public"."delivery_bag"
ADD CONSTRAINT delivery_man_delivery_bag_fk
FOREIGN KEY (delivery_man_ss_number)
REFERENCES "public"."delivery_man"(ss_number)
;
ALTER TABLE "public"."delivery_bag"
ADD CONSTRAINT product_delivery_bag_fk
FOREIGN KEY (product_id)
REFERENCES "public"."product"(id)
;
CREATE UNIQUE INDEX delivery_bag_pk ON "public"."delivery_bag"
(
  product_id,
  delivery_man_ss_number
)
;
CREATE TABLE "public"."delivery_man"
(
   ss_number int PRIMARY KEY NOT NULL,
   firstname varchar(100) NOT NULL,
   lastname varchar(100) NOT NULL,
   status varchar(100) NOT NULL,
   position numeric(131089) NOT NULL,
   bike_id int NOT NULL
)
;
ALTER TABLE "public"."delivery_man"
ADD CONSTRAINT bike_delivery_man_fk
FOREIGN KEY (bike_id)
REFERENCES "public"."bike"(id)
;
CREATE UNIQUE INDEX delivery_man_pk ON "public"."delivery_man"(ss_number)
;
CREATE TABLE "public"."order_book"
(
   id int PRIMARY KEY NOT NULL,
   date_order date NOT NULL,
   status varchar(100) NOT NULL,
   total_price numeric(131089) NOT NULL,
   time_start timestamp NOT NULL,
   time_end timestamp,
   customer_id int NOT NULL,
   adress_id int NOT NULL
)
;
ALTER TABLE "public"."order_book"
ADD CONSTRAINT adress_order_book_fk
FOREIGN KEY (adress_id)
REFERENCES "public"."adress"(id)
;
ALTER TABLE "public"."order_book"
ADD CONSTRAINT customer_order_fk
FOREIGN KEY (customer_id)
REFERENCES "public"."customer"(id)
;
CREATE UNIQUE INDEX order_book_pk ON "public"."order_book"(id)
;
CREATE TABLE "public"."order_content"
(
   product_id int NOT NULL,
   order_book_id int NOT NULL,
   quantity int NOT NULL,
   CONSTRAINT order_content_pk PRIMARY KEY (product_id,order_book_id)
)
;
ALTER TABLE "public"."order_content"
ADD CONSTRAINT product_order_content_fk
FOREIGN KEY (product_id)
REFERENCES "public"."product"(id)
;
ALTER TABLE "public"."order_content"
ADD CONSTRAINT order_order_content_fk
FOREIGN KEY (order_book_id)
REFERENCES "public"."order_book"(id)
;
CREATE UNIQUE INDEX order_content_pk ON "public"."order_content"
(
  product_id,
  order_book_id
)
;
CREATE TABLE "public"."order_ok"
(
   order_book_id int NOT NULL,
   ss_number int NOT NULL,
   CONSTRAINT order_wait_pk PRIMARY KEY (order_book_id,ss_number)
)
;
ALTER TABLE "public"."order_ok"
ADD CONSTRAINT order_book_order_wait_fk
FOREIGN KEY (order_book_id)
REFERENCES "public"."order_book"(id)
;
ALTER TABLE "public"."order_ok"
ADD CONSTRAINT delivery_man_order_wait_fk
FOREIGN KEY (ss_number)
REFERENCES "public"."delivery_man"(ss_number)
;
CREATE UNIQUE INDEX order_wait_pk ON "public"."order_ok"
(
  order_book_id,
  ss_number
)
;
CREATE TABLE "public"."product"
(
   id int PRIMARY KEY NOT NULL,
   name varchar(100) NOT NULL,
   date_product date NOT NULL,
   quantity int NOT NULL,
   price numeric(131089) NOT NULL,
   category_id int NOT NULL
)
;
ALTER TABLE "public"."product"
ADD CONSTRAINT category_product_fk
FOREIGN KEY (category_id)
REFERENCES "public"."category"(id)
;
CREATE UNIQUE INDEX product_pk ON "public"."product"(id)
;
