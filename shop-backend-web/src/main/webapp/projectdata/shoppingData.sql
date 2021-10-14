--  商品种类
create table product_types(
     id bigserial not null unique,
     name varchar(200),
     status int /*类型状态1,启用 0.禁用*/
);

alter table product_types add constraint p_type_pk primary key (id);


-- 商品表
create table products(
    id bigserial not null unique,
    name varchar(200),
    price bigint,
    info varchar(200),
    image  varchar(200),
    product_type_id  int
);
alter table products add constraint product_pk primary key (id);
alter table products add constraint p_p_type_fk foreign key (product_type_id) references product_types(id);


--  客户表
create table customers(
    id bigserial not null unique,
    name varchar(20),
    login_name varchar (20),
    password varchar(50),
    phone varchar (20),
    address varchar (30),
    is_valid int, --用户状态
    register_date timestamp
);

alter table customers add constraint customer_pk primary key (id);

--  订单表
create table orders(
    id bigserial not null unique,
    order_no varchar (300), --uuid生成
    customer_id int,
    price bigint,
    create_data timestamp
);
alter table orders add constraint order_pk primary key (id);
alter table orders add constraint order_customer_fk foreign key (customer_id) references customers(id);

--  订单明细表
create table items(
    id bigserial not null unique,
    product_id int,
    price   bigint,
    order_id int
);
alter table items add constraint item_pk primary key (id);
alter table items add constraint item_product_fk foreign key (product_id) references products(id);
alter table items add constraint item_order_fk foreign key (order_id) references orders(id);

--  管理员表
create table administrators(
    id bigserial not null unique,
    name varchar (50),
    login_name varchar (50),
    password varchar (50),
    phone varchar (50),
    email varchar (100),
    is_valid int, --管理员状态，1表示有效，0表示无效
    create_date timestamp ,
    role_id int --管理员权限，1表示超级管理员，2表示商品管理员
);
alter table administrators add constraint admin_pk primary key (id);
alter table administrators add constraint admin_role_fk foreign key (role_id) references roles(id);

create table roles(
    id bigserial not null unique,
    name varchar(50)
);
alter table roles add constraint role_pk primary key (id);

alter table administrators add constraint admin_pk primary key (id);

--测试数据
insert into product_types values (1,'食品',1);
insert into product_types values (2,'衣服',0);
insert into product_types values (3,'数码',1);
insert into product_types values (4,'生活用品',1);
insert into product_types values (5,'家装',0);
insert into product_types values (6,'旅游',1);
insert into product_types values (7,'运动',1);
insert into product_types values (8,'电器',1);
insert into product_types values (9,'家具',0);
insert into product_types values (10,'配饰',1);
insert into product_types values (11,'裤子',1);
insert into product_types values (12,'包包',1);
insert into product_types values (13,'鞋子',0);
insert into product_types values (14,'内衣',1);
insert into product_types values (15,'裙子',1);

insert into administrators values (1,'admin','admin','123','13988888888','admin@gmail.com',1,now(),1);
insert into administrators values (2,'tom','tom','123','13999999999','tom@gmail.com',1,now(),0);
