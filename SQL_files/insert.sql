INSERT INTO `b_airways`.`organizational_info`
(`airline_name`,
`airline_hotline`,
`airline_email`,
`address`,
`airline_account_no`)
VALUES
('B Airways',
'+9411123456',
'customersupport@bairways.com',
'No1, Colombo, Sri Lanka',
'123456789');

INSERT INTO user VALUES ('1','guest');
INSERT INTO user VALUES ('2','guest');
INSERT INTO user VALUES ('3','guest');
INSERT INTO user VALUES ('4','guest');
INSERT INTO user VALUES ('5','registered');
INSERT INTO user VALUES ('6','registered');

INSERT INTO user_category VALUES ('General','0','0');
INSERT INTO user_category VALUES ('Gold','0.05','10');
INSERT INTO user_category VALUES ('Frequent','0.09','50');

INSERT INTO Registered_User VALUES ('5','Gold','john@gmail.com','1234','john','doe',str_to_date('10/12/1999','%d/%c/%Y'),'Male','PP039402','London, UK',NULL);
INSERT INTO Registered_User VALUES ('6','Frequent','jane@gmail.com','5678','jane','doe',str_to_date('09/06/1999','%d/%c/%Y72'),'Female','PP438294','London, UK',NULL);
