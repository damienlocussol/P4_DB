
CREATE SEQUENCE public.customer_id_seq;

CREATE TABLE public.customer (
                id INTEGER NOT NULL DEFAULT nextval('public.customer_id_seq'),
                firstname VARCHAR(100) NOT NULL,
                lastname VARCHAR(100) NOT NULL,
                login VARCHAR(100) NOT NULL,
                password VARCHAR(100) NOT NULL,
                CONSTRAINT customer_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.customer_id_seq OWNED BY public.customer.id;

CREATE SEQUENCE public.adress_id_seq;

CREATE TABLE public.adress (
                id INTEGER NOT NULL DEFAULT nextval('public.adress_id_seq'),
                customer_id INTEGER NOT NULL,
                numero VARCHAR(1000) NOT NULL,
                street VARCHAR(300) NOT NULL,
                adress_code INTEGER NOT NULL,
                city VARCHAR(200) NOT NULL,
                building VARCHAR(100),
                floor INTEGER,
                door VARCHAR(100),
                digicode VARCHAR(100),
                phone1 INTEGER NOT NULL,
                phone2 INTEGER,
                email VARCHAR NOT NULL,
                position NUMERIC NOT NULL,
                CONSTRAINT adress_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.adress_id_seq OWNED BY public.adress.id;

CREATE SEQUENCE public.category_id_seq;

CREATE TABLE public.category (
                id INTEGER NOT NULL DEFAULT nextval('public.category_id_seq'),
                name VARCHAR(100) NOT NULL,
                CONSTRAINT category_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;

CREATE SEQUENCE public.bike_id_seq;

CREATE TABLE public.bike (
                id INTEGER NOT NULL DEFAULT nextval('public.bike_id_seq'),
                is_checked BOOLEAN NOT NULL,
                date_revision DATE NOT NULL,
                status BOOLEAN NOT NULL,
                CONSTRAINT bike_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.bike_id_seq OWNED BY public.bike.id;

CREATE TABLE public.delivery_man (
                ss_number INTEGER NOT NULL,
                firstname VARCHAR(100) NOT NULL,
                lastname VARCHAR(100) NOT NULL,
                status VARCHAR(100) NOT NULL,
                position NUMERIC NOT NULL,
                bike_id INTEGER NOT NULL,
                CONSTRAINT delivery_man_pk PRIMARY KEY (ss_number)
);


CREATE SEQUENCE public.product_id_seq;

CREATE TABLE public.product (
                id INTEGER NOT NULL DEFAULT nextval('public.product_id_seq'),
                name VARCHAR(100) NOT NULL,
                date_product DATE NOT NULL,
                quantity INTEGER NOT NULL,
                price NUMERIC NOT NULL,
                category_id INTEGER NOT NULL,
                CONSTRAINT product_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;

CREATE TABLE public.delivery_bag (
                product_id INTEGER NOT NULL,
                delivery_man_ss_number INTEGER NOT NULL,
                quantity INTEGER NOT NULL,
                CONSTRAINT delivery_bag_pk PRIMARY KEY (product_id, delivery_man_ss_number)
);


CREATE SEQUENCE public.order_book_id_seq;

CREATE TABLE public.order_book (
                id INTEGER NOT NULL DEFAULT nextval('public.order_book_id_seq'),
                date_order DATE NOT NULL,
                status VARCHAR(100) NOT NULL,
                total_price NUMERIC NOT NULL,
                time_start TIMESTAMP NOT NULL,
                time_end TIMESTAMP,
                customer_id INTEGER NOT NULL,
                adress_id INTEGER NOT NULL,
                CONSTRAINT order_book_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.order_book_id_seq OWNED BY public.order_book.id;

CREATE TABLE public.order_wait (
                order_book_id INTEGER NOT NULL,
                ss_number INTEGER NOT NULL,
                CONSTRAINT order_wait_pk PRIMARY KEY (order_book_id, ss_number)
);


CREATE TABLE public.order_content (
                product_id INTEGER NOT NULL,
                order_book_id INTEGER NOT NULL,
                quantity INTEGER NOT NULL,
                CONSTRAINT order_content_pk PRIMARY KEY (product_id, order_book_id)
);


ALTER TABLE public.order_book ADD CONSTRAINT customer_order_fk
FOREIGN KEY (customer_id)
REFERENCES public.customer (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.adress ADD CONSTRAINT customer_adress_fk
FOREIGN KEY (customer_id)
REFERENCES public.customer (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_book ADD CONSTRAINT adress_order_book_fk
FOREIGN KEY (adress_id)
REFERENCES public.adress (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.product ADD CONSTRAINT category_product_fk
FOREIGN KEY (category_id)
REFERENCES public.category (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.delivery_man ADD CONSTRAINT bike_delivery_man_fk
FOREIGN KEY (bike_id)
REFERENCES public.bike (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.delivery_bag ADD CONSTRAINT delivery_man_delivery_bag_fk
FOREIGN KEY (delivery_man_ss_number)
REFERENCES public.delivery_man (ss_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_wait ADD CONSTRAINT delivery_man_order_wait_fk
FOREIGN KEY (ss_number)
REFERENCES public.delivery_man (ss_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.delivery_bag ADD CONSTRAINT product_delivery_bag_fk
FOREIGN KEY (product_id)
REFERENCES public.product (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_content ADD CONSTRAINT product_order_content_fk
FOREIGN KEY (product_id)
REFERENCES public.product (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_content ADD CONSTRAINT order_order_content_fk
FOREIGN KEY (order_book_id)
REFERENCES public.order_book (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.order_wait ADD CONSTRAINT order_book_order_wait_fk
FOREIGN KEY (order_book_id)
REFERENCES public.order_book (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
