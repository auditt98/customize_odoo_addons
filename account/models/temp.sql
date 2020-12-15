create table Tb_Group(
    groupID integer GENERATED BY DEFAULT AS IDENTITY,
    groupName nvarchar2(50),
    groupDetail nvarchar2(50),
    PRIMARY KEY ( groupID )
);

create table Tb_Permissions(
    permissionID INTEGER
        GENERATED BY DEFAULT AS IDENTITY,
    permissionDetail nvarchar2(100),
    PRIMARY KEY ( permissionID )
);

create table Tb_Staff(
    staffID INTEGER
        GENERATED BY DEFAULT AS IDENTITY,
    staffName nvarchar2(50),
    staffEmail nvarchar2(50),
    staffPhone varchar(10),
    staffPassword varchar(256),
    createdAt date,
    PRIMARY KEY ( staffID),
    constraint Uni_Staff_staffEmail unique (staffEmail)
);

create table Tb_StaffGroup(
    staffGroupID integer GENERATED BY DEFAULT AS IDENTITY,
    staffID integer,
    groupID integer,
    CONSTRAINT FK_StaffGroup_Staff FOREIGN KEY (staffID)
    REFERENCES Tb_Staff(staffID),
    CONSTRAINT FK_StaffGroup_Group FOREIGN KEY (groupID)
    REFERENCES Tb_Group(groupID)
);

create table Tb_PermissionsStaff(
    staffID integer,
    permissionID integer,
    CONSTRAINT FK_PermissionsStaff_Permissions FOREIGN KEY (permissionID)
    REFERENCES Tb_Permissions(permissionID),
    CONSTRAINT FK_PermissionsStaff_Staff FOREIGN KEY (staffID)
    REFERENCES Tb_Staff(staffID)
);

create table Tb_PermissionsStaffGroup(
    permissionID integer,
    groupID integer,
    CONSTRAINT FK_PermissionsStaffGroup_Permissions FOREIGN KEY (permissionID)
    REFERENCES Tb_Permissions(permissionID),
    CONSTRAINT FK_PermissionsStaffGroup_Group FOREIGN KEY (groupID)
    REFERENCES Tb_Group(groupID)
);

CREATE TABLE Tb_Manufactory (
    manufactoryID            INTEGER
        GENERATED BY DEFAULT AS IDENTITY,
    manufactoryName          nVARCHAR2(50),
    manufactoryEmail         nVARCHAR2(50),
    manufactoryPhone         VARCHAR2(10),
    manufactoryDescription   NCLOB,
    PRIMARY KEY ( manufactoryID )
);

CREATE TABLE Tb_Supplier (
    supplierID     INTEGER
        GENERATED BY DEFAULT AS IDENTITY,
    supplierName   nvarchar2(50),
    supplierEmail nvarchar2(50),
    supplierPhone varchar(10),
    supplierAddress nvarchar2(100),
    primary key (supplierID)
    
);

create table Tb_Categories(
    categoryID integer GENERATED BY DEFAULT AS IDENTITY,
    categoryName nvarchar2(50),
    categoryDescription nclob,
    PRIMARY KEY ( categoryID )
);

create table Tb_CategoryItem(
    itemID integer GENERATED BY DEFAULT AS IDENTITY,
    itemName nvarchar2(50),
    itemDescription nclob,
    categoryID integer,
    PRIMARY KEY ( itemID ),
    CONSTRAINT FK_CategoryItem_Categories FOREIGN KEY (categoryID)
    REFERENCES Tb_Categories(categoryID)
);

create table Tb_Products(
    productID integer GENERATED BY DEFAULT AS IDENTITY,
    counts integer,
    productDescription nclob,
    retailPrice integer,
    categoryID integer,
    supplierID integer,
    manufactoryID integer,
    PRIMARY KEY ( productID ),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (categoryID)
    REFERENCES Tb_Categories(categoryID),
    CONSTRAINT FK_Products_Supplier FOREIGN KEY (supplierID)
    REFERENCES Tb_Supplier(supplierID),
    CONSTRAINT FK_Products_Manufactory FOREIGN KEY (manufactoryID)
    REFERENCES Tb_Manufactory(manufactoryID)
);

create table Tb_CategoryItemValue(
    itemValue nvarchar2(100),
    note nvarchar2(100),
    itemID integer,
    productID integer,
    CONSTRAINT FK_CategoryItemValue_CategoryItem FOREIGN KEY (itemID)
    REFERENCES Tb_CategoryItem(itemID),
    CONSTRAINT FK_CategoryItemValue_Products FOREIGN KEY (productID)
    REFERENCES Tb_Products(productID)
    
);

create table Tb_Bill(
    billID INTEGER GENERATED BY DEFAULT AS IDENTITY,
    createdAt date,
    billDescription nclob,
    totalBill number(10,3),
    createdBy integer,
    supplierID integer,
    PRIMARY KEY ( billID),
    CONSTRAINT FK_Bill_Staff FOREIGN KEY (createdBy)
    REFERENCES Tb_Staff(staffID),
    CONSTRAINT FK_Bill_Supplier FOREIGN KEY (supplierID)
    REFERENCES Tb_Supplier(supplierID)
);

create table Tb_BillDetail(
    costs number(10,3),
    counts integer,
    billID integer,
    productID integer,
    CONSTRAINT FK_BillDetail_Bill FOREIGN KEY (billID)
    REFERENCES Tb_Bill(billID),
    CONSTRAINT FK_BillDetail_Products FOREIGN KEY (productID)
    REFERENCES Tb_Products(productID)
);

create table Tb_PromotionalPrice(
    priceID integer GENERATED BY DEFAULT AS IDENTITY,
    newPrice number(10,3),
    createdAt date,
    beginTime date,
    finishTime date,
    createdBy integer,
    productID integer,
    PRIMARY KEY ( priceID ),
    CONSTRAINT FK_PromotionalPrice_Staff FOREIGN KEY (createdBy)
    REFERENCES Tb_Staff(staffID),
    CONSTRAINT FK_Promotional_Products FOREIGN KEY (productID)
    REFERENCES Tb_Products(productID)
);

create table Tb_ImageAddress(
    imageID integer GENERATED BY DEFAULT AS IDENTITY,
    imageAddress nvarchar2(100),
    imageDescription nclob,
    productID integer,
    PRIMARY KEY ( imageID ),
    CONSTRAINT FK_ImageAddress_Products FOREIGN KEY (productID)
    REFERENCES Tb_Products(productID)
);

create table Tb_Status(
    statusID integer GENERATED BY DEFAULT AS IDENTITY,
    statusName nvarchar2(50),
    PRIMARY KEY ( statusID )
);

create table Tb_Customers(
    customerID integer GENERATED BY DEFAULT AS IDENTITY, 
    customerName nvarchar2(50),
    customerEmail nvarchar2(50),
    customerPhone varchar(10),
    customerUserName nvarchar2(50),
    customerPassword varchar(256),
    createdAt date,
    PRIMARY KEY ( customerID),
    constraint Uni_Customers_customerEmail unique (customerEmail)
);

create table Tb_Orders(
    orderID integer GENERATED BY DEFAULT AS IDENTITY,
    createdAt date,
    orderDescription NCLOB,
    payBy nvarchar2(50),
    addressShipping nvarchar2(100),
    totalBill number(10,3),
    createdBy integer,
    customerID integer,
    PRIMARY KEY ( orderID ),
    CONSTRAINT FK_Orders_Staff FOREIGN KEY (createdBy)
    REFERENCES Tb_Staff(staffID),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (customerID)
    REFERENCES Tb_Customers(customerID)
    
);

create table Tb_OrdersDetail(
    costs number(10,3),
    counts integer,
    orderID integer,
    productID integer,
     CONSTRAINT FK_OrdersDetail_Orders FOREIGN KEY (orderID)
    REFERENCES Tb_Orders(orderID),
    CONSTRAINT FK_OrdersDetail_Products FOREIGN KEY (productID)
    REFERENCES Tb_Products(productID)
);

create table Tb_StatusUpdate(
    updateTime date,
    updatedBy integer,
    orderID integer,
    statusID integer,
    CONSTRAINT FK_StatusUpdate_Orders FOREIGN KEY (orderID)
    REFERENCES Tb_Orders(orderID),
    CONSTRAINT FK_StatusUpdate_Status FOREIGN KEY (statusID)
    REFERENCES Tb_Status(statusID),
    CONSTRAINT FK_StatusUpdate_Staff FOREIGN KEY (updatedBy)
    REFERENCES Tb_Staff(staffID)
);