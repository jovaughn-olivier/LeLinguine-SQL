CREATE TABLE Restaurant (
            RestaurantID        NUMBER(5, 0)    NOT NULL,
            Street              VARCHAR2(30)    NOT NULL,
            City                VARCHAR2(20)    NOT NULL,
            State               CHAR(2)         NOT NULL,
            Postal_Code         VARCHAR2(9)     NOT NULL,
            Opening_Time        VARCHAR2(30)    NOT NULL,
            Closing_Time        VARCHAR2(30)    NOT NULL,
            Seating_Capacity    NUMBER(4, 0)    NOT NULL,
            Revenue             NUMBER(8, 0)    NOT NULL,
            Expenses            NUMBER(8, 0)    NOT NULL,
CONSTRAINT Restaurant_PK PRIMARY KEY (RestaurantID)
);

CREATE TABLE Renovation (
            RenovationID        NUMBER(5, 0)    NOT NULL,
            Name                VARCHAR2(25)    NOT NULL,
            Cost                NUMBER(10, 0)   NOT NULL,
            Location            VARCHAR2(25)    NOT NULL,
            Date_Scheduled      DATE            NOT NULL,
            RestaurantID        NUMBER(5, 0)    NOT NULL,
CONSTRAINT Renovation_PK PRIMARY KEY (RenovationID),
CONSTRAINT Renovation_FK FOREIGN KEY (RestaurantID)
    REFERENCES Restaurant (RestaurantID)
);

CREATE TABLE Employee (
            EmployeeID          NUMBER(5, 0)    NOT NULL,
            First_Name          VARCHAR2(25)    NOT NULL,
            Last_Name           VARCHAR2(25)    NOT NULL,
            DOB                 DATE,
            Salary              NUMBER(10, 0)   NOT NULL,
            Date_Hired          DATE            NOT NULL,
            Phone_Number        VARCHAR2(14)    NOT NULL,
            Benefits            NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
            SupervisorID        NUMBER(5, 0),
            RestaurantID        NUMBER(5, 0)    NOT NULL,
CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID),
CONSTRAINT Employee_FK1 FOREIGN KEY (SupervisorID)
    REFERENCES Employee (EmployeeID),
CONSTRAINT Employee_FK2 FOREIGN KEY (RestaurantID)
    REFERENCES Restaurant (RestaurantID)
);

CREATE TABLE Chef (
            CEmployeeID         NUMBER(5, 0)    NOT NULL,
            Culinary_Degree      NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Chef_PK PRIMARY KEY (CEmployeeID),
CONSTRAINT Chef_FK FOREIGN KEY (CEmployeeID)
    REFERENCES Employee (EmployeeID)           
);   

CREATE TABLE Waiter (
            WEmployeeID         NUMBER(5, 0)    NOT NULL,
            Part_Or_FullTime    NUMBER(1, 0)    NOT NULL, --0 if Part Time, 1 if Full Time
CONSTRAINT Waiter_PK PRIMARY KEY (WEmployeeID),
CONSTRAINT Waiter_FK FOREIGN KEY (WEmployeeID)
    REFERENCES Employee (EmployeeID)           
);  

CREATE TABLE Supervisor (
            SEmployeeID                     NUMBER(5, 0)    NOT NULL,
            Purchase_Or_Administration      NUMBER(1, 0)    NOT NULL, --0 if Purchase, 1 if Administration
CONSTRAINT Supervisor_PK PRIMARY KEY (SEmployeeID),
CONSTRAINT Supervisor_FK FOREIGN KEY (SEmployeeID)
    REFERENCES Employee (EmployeeID)           
);

CREATE TABLE Invoice (
            InvoiceID           NUMBER(5, 0)    NOT NULL,
            BillDate            DATE            NOT NULL,
            Monthly_Mortgage    NUMBER(10, 0)   NOT NULL,
            Labor_Costs         NUMBER(10, 0)   NOT NULL,
            Water_Bill          NUMBER(10, 0)   NOT NULL,
            Electricity_Bill    NUMBER(10, 0)   NOT NULL,
            Gas_Bill            NUMBER(10, 0)   NOT NULL,
            RestaurantID        NUMBER(5, 0)    NOT NULL,
            SEmployeeID         NUMBER(5, 0)    NOT NULL,
CONSTRAINT Invoice_PK PRIMARY KEY (InvoiceID),
CONSTRAINT Invoice_FK1 FOREIGN KEY (RestaurantID)
    REFERENCES Restaurant (RestaurantID),
CONSTRAINT Invoice_FK2 FOREIGN KEY (SEmployeeID)
    REFERENCES Supervisor (SEmployeeID)
);

CREATE TABLE Kitchen (
               KitchenID        NUMBER(5, 0)    NOT NULL,
               Staff            NUMBER(2, 0)    NOT NULL, --Number of Staff
               RestaurantID     NUMBER(5, 0)    NOT NULL,
               SEmployeeID      NUMBER(5, 0)    NOT NULL,
CONSTRAINT Kitchen_PK PRIMARY KEY (KitchenID),
CONSTRAINT Kitchen_FK1 FOREIGN KEY (RestaurantID)
    REFERENCES Restaurant (RestaurantID),
CONSTRAINT Kitchen_FK2 FOREIGN KEY (SEmployeeID)
    REFERENCES Supervisor (SEmployeeID)
);
           
CREATE TABLE Kitchenware (
                ProductNo       NUMBER(5, 0)    NOT NULL,
                Type            VARCHAR2(20)    NOT NULL,
                Quantity        NUMBER(2, 0)    NOT NULL,
                KitchenID       NUMBER(5, 0)    NOT NULL,
CONSTRAINT Kitchenware_PK PRIMARY KEY (ProductNo),
CONSTRAINT Kitchenware_FK FOREIGN KEY (KitchenID)
    REFERENCES Kitchen (KitchenID)
);

CREATE TABLE Cookware (
                CProductNo      NUMBER(5, 0)    NOT NULL,
                Material        VARCHAR2(10)    NOT NULL,
CONSTRAINT Cookware_PK PRIMARY KEY (CProductNo),
CONSTRAINT Cookware_FK FOREIGN KEY (CProductNo)
    REFERENCES Kitchenware (ProductNo)
);

CREATE TABLE Equipment (
                EProductNo          NUMBER(5, 0)    NOT NULL,
                Owned_Or_Rented     NUMBER(1, 0)    NOT NULL, --0 if Owned, 1 if Rented
                Gas_Or_Electric     NUMBER(1, 0)    NOT NULL, --0 if Gas, 1 if Electric
CONSTRAINT Equipment_PK PRIMARY KEY (EProductNo),
CONSTRAINT Equipment_FK FOREIGN KEY (EProductNo)
    REFERENCES Kitchenware (ProductNo)
);

CREATE TABLE Menu (
                MenuNo              NUMBER(5, 0)    NOT NULL,
                Contents            VARCHAR2(20)    NOT NULL,
                RestaurantID        NUMBER(5, 0)    NOT NULL,
CONSTRAINT Menu_PK PRIMARY KEY (MenuNo),
CONSTRAINT Menu_FK FOREIGN KEY (RestaurantID)
    REFERENCES Restaurant (RestaurantID)
);
            
CREATE TABLE Consumable (
                ConsumableID        NUMBER(5, 0)    NOT NULL,
                Name                VARCHAR2(25)    NOT NULL,
                Price               NUMBER(4, 0)    NOT NULL,
                Calories            NUMBER(4, 0)    NOT NULL,
                CEmployeeID         NUMBER(5, 0)    NOT NULL,
                MenuNo              NUMBER(5, 0)    NOT NULL,
                WEmployeeID         NUMBER(5, 0)    NOT NULL,
CONSTRAINT Consumable_PK PRIMARY KEY (ConsumableID),
CONSTRAINT Consumable_FK1 FOREIGN KEY (CEmployeeID)
    REFERENCES Chef (CEmployeeID),
CONSTRAINT Consumable_FK2 FOREIGN KEY (MenuNo)
    REFERENCES Menu (MenuNo),
CONSTRAINT Consumable_FK3 FOREIGN KEY (WEmployeeID)
    REFERENCES Waiter (WEmployeeID)
);

CREATE TABLE Food (
                FConsumableID       NUMBER(5, 0)    NOT NULL,
                Gluten_Free         NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
                Sauce               NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Food_PK PRIMARY KEY (FConsumableID),
CONSTRAINT Food_FK FOREIGN KEY (FConsumableID)
    REFERENCES Consumable (ConsumableID)
);

CREATE TABLE Food_Cheese (
                FConsumableID       NUMBER(5, 0)    NOT NULL,
                Cheese              VARCHAR2(10)    NOT NULL,
CONSTRAINT Food_Cheese_PK PRIMARY KEY (FConsumableID, Cheese),
CONSTRAINT Food_Cheese_FK FOREIGN KEY (FConsumableID)
    REFERENCES Food (FConsumableID)
);

CREATE TABLE Food_Course (
                FConsumableID       NUMBER(5, 0)    NOT NULL,
                Course              VARCHAR2(10)    NOT NULL,
CONSTRAINT Food_Course_PK PRIMARY KEY (FConsumableID, Course),
CONSTRAINT Food_Course_FK FOREIGN KEY (FConsumableID)
    REFERENCES Food (FConsumableID)
);

CREATE TABLE Fettucine_Alfredo (
                FAFConsumableID     NUMBER(5, 0)    NOT NULL,
                Butter              NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
                Chicken             NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Fettucine_Alfredo_PK PRIMARY KEY (FAFConsumableID),
CONSTRAINT Fettucine_Alfredo_FK FOREIGN KEY (FAFConsumableID)
    REFERENCES Food (FConsumableID)
);

CREATE TABLE Linguine (
                LFConsumableID      NUMBER(5, 0)    NOT NULL,
                Lemon               NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
                Shrimp              NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Linguine_PK PRIMARY KEY (LFConsumableID),
CONSTRAINT Linguine_FK FOREIGN KEY (LFConsumableID)
    REFERENCES Food (FConsumableID)
);

CREATE TABLE Lasagna_Classico (
                LAFConsumableID     NUMBER(5, 0)    NOT NULL,
                Garnish             NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Lasagna_Classico_PK PRIMARY KEY (LAFConsumableID),
CONSTRAINT Lasagna_Classico_FK FOREIGN KEY (LAFConsumableID)
    REFERENCES Food (FConsumableID)
);

CREATE TABLE Lasagna_Classico_Vegetables (
                LAFConsumableID     NUMBER(5, 0)    NOT NULL,
                Vegetables          VARCHAR2(10)    NOT NULL,
CONSTRAINT Lasagna_Classico_Vegetables_PK PRIMARY KEY (LAFConsumableID, Vegetables),
CONSTRAINT Lasagna_Classico_Vegetables_FK FOREIGN KEY (LAFConsumableID)
    REFERENCES Lasagna_Classico (LAFConsumableID)
);

CREATE TABLE Italian_Pasta (
                IPFConsumableID     NUMBER(5, 0)    NOT NULL,
                Pasta_Type          VARCHAR2(10)    NOT NULL,
                Chicken             NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Italian_Pasta_PK PRIMARY KEY (IPFConsumableID),
CONSTRAINT Italian_Pasta_FK FOREIGN KEY (IPFConsumableID)
    REFERENCES Food (FConsumableID)
);

CREATE TABLE Spaghetti (
                SFConsumableID      NUMBER(5, 0)    NOT NULL,
                Meatballs           NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Spaghetti_PK PRIMARY KEY (SFConsumableID),
CONSTRAINT Spaghetti_FK FOREIGN KEY (SFConsumableID)
    REFERENCES Food (FConsumableID)
);

CREATE TABLE Beverage (
                BConsumableID       NUMBER(5, 0)    NOT NULL,
                Carbonated          NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
                Alcoholic           NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Beverage_PK PRIMARY KEY (BConsumableID),
CONSTRAINT Beverage_FK FOREIGN KEY (BConsumableID)
    REFERENCES Consumable (ConsumableID)
);

CREATE TABLE Supplier (
                SupplierID          NUMBER(5, 0)    NOT NULL,
                Supplier_Name       VARCHAR2(25)    NOT NULL,
                Street              VARCHAR2(30),
                City                VARCHAR2(20),
                State               CHAR(2),
                Postal_Code         VARCHAR2(9),
                RestaurantID        NUMBER(5, 0),
CONSTRAINT Supplier_PK PRIMARY KEY (SupplierID),
CONSTRAINT Supplier_FK FOREIGN KEY (RestaurantID)
    REFERENCES Restaurant (RestaurantID)
);

CREATE TABLE Ingredients (
                IngredientID        NUMBER(5, 0)    NOT NULL,
                Ingredient_Name     VARCHAR2(25)    NOT NULL,
                Quantity            NUMBER(3, 0)    NOT NULL,
                Solid_Or_Liquid     NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
                Ingredient_Type     VARCHAR2(15)    NOT NULL,
                ExpiryDate          DATE            NOT NULL,
                RestaurantID        NUMBER(5, 0)    NOT NULL,
CONSTRAINT Ingredients_PK PRIMARY KEY (IngredientID),
CONSTRAINT Ingredients_FK FOREIGN KEY (RestaurantID)
    REFERENCES Restaurant (RestaurantID)
);

CREATE TABLE Shipment (
                IngredientID        NUMBER(5, 0)    NOT NULL,
                SupplierID          NUMBER(5, 0)    NOT NULL,
CONSTRAINT Shipment_PK PRIMARY KEY (IngredientID, SupplierID),
CONSTRAINT Shipment_FK1 FOREIGN KEY (IngredientID)
    REFERENCES Ingredients (IngredientID),
CONSTRAINT Shipment_FK2 FOREIGN KEY (SupplierID)
    REFERENCES Supplier (SupplierID)
);

CREATE TABLE Recipe (
                IngredientID        NUMBER(5, 0)        NOT NULL,
                FConsumableID       NUMBER(5, 0)        NOT NULL,
                Instructions        VARCHAR2(4000)    NOT NULL,
CONSTRAINT Recipe_PK PRIMARY KEY (IngredientID, FConsumableID),
CONSTRAINT Recipe_FK1 FOREIGN KEY (IngredientID)
    REFERENCES Ingredients (IngredientID),
CONSTRAINT Recipe_FK2 FOREIGN KEY (FConsumableID)
    REFERENCES Food (FConsumableID)
);     

CREATE TABLE Customers (
                CustomerID          NUMBER(5, 0)    NOT NULL,
                Name                VARCHAR2(25)    NOT NULL,
                Phone_Number        VARCHAR2(14),
                Email               VARCHAR2(30),
                Allergies           NUMBER(1, 0)    NOT NULL, --0 if No, 1 if Yes
CONSTRAINT Customers_PK PRIMARY KEY (CustomerID)
);

CREATE TABLE Orders (
                OrderNo             NUMBER(5, 0)    NOT NULL,
                MenuNo              NUMBER(5, 0)    NOT NULL,
                Time_Ordered        VARCHAR2(14)    NOT NULL,
CONSTRAINT Orders_PK PRIMARY KEY (OrderNo),
CONSTRAINT Orders_FK FOREIGN KEY (MenuNo)
    REFERENCES Menu (MenuNo)
);      

CREATE TABLE Payment (
                CustomerID           NUMBER(5, 0)    NOT NULL,
                OrderNo             NUMBER(5, 0)    NOT NULL,
                Amount              NUMBER(4, 0)    NOT NULL,
                Cash_Or_Card        NUMBER(1, 0)    NOT NULL, --0 if Cash, 1 if Card
CONSTRAINT Payment_PK PRIMARY KEY (CustomerID, OrderNo),
CONSTRAINT Payment_FK1 FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID),
CONSTRAINT Payment_FK2 FOREIGN KEY (OrderNo)
    REFERENCES Orders (OrderNo)
);

CREATE TABLE Order_Item (
                OrderNo             NUMBER(5, 0)    NOT NULL,
                MenuNo              NUMBER(5, 0)    NOT NULL,
                Quantity            NUMBER(2, 0)    NOT NULL,
CONSTRAINT Order_Item_PK PRIMARY KEY (OrderNo, MenuNo),
CONSTRAINT Order_Item_FK1 FOREIGN KEY (OrderNo)
    REFERENCES Orders (OrderNo),
CONSTRAINT Order_Item_FK2 FOREIGN KEY (MenuNo)
    REFERENCES Menu (MenuNo)
);      
            
            
            
            
            
            
            
            
            