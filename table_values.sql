USE CTE_TRIAL;

INSERT INTO cte_trial.employee (emp_id, emp_name, salary)
VALUES 	(101, 'Mohan', 40000),
		(102, "James", 50000),
        (103, 'Rubert', 60000),
        (104, 'Carol', 70000),
        (105, 'Alice', 80000),
        (106, 'Leremy', 90000);
        
INSERT INTO cte_trial.sales(store_id, store_name, product, quantity, cost)
VALUES 	(1, 'Apple Originals 1', 'iPhone 12 Pro', 1, 1000),
		(1, 'Apple Originals 1', 'MacBook pro 13', 3, 2000),
        (1, 'Apple Originals 1', ' AirPods Pro', 2, 200),
        (2, 'Apple Originals 2', 'iPhone 12 Pro', 2, 1000),
        (3, 'Apple Originals 3', 'iPhone 12 Pro', 1,1000),
        (3, 'Apple Originals 3', 'MacBook pro 13', 1, 2000),
        (3, 'Apple Originals 3', 'MackBook Air', 4, 1100),
        (3, 'Apple Originals 3', 'iPhone 12', 2, 1000),
        (3, 'Apple Originals 3', 'AirPods Pro', 3, 280),
        (4, 'Apple Originals 4', 'iPhone 12 Pro', 2,1000),
        (4, 'Apple Originals 4', ' MacBook Pro 13', 1, 2500);
	
    
INSERT INTO sales VALUES 
(1, 'Apple Originals 1', 'iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1', 'MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1', ' AirPods Pro', 2, 200),
(2, 'Apple Originals 2', 'iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3', 'iPhone 12 Pro', 1,1000),
(3, 'Apple Originals 3', 'MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3', 'MackBook Air', 4, 1100),
(3, 'Apple Originals 3', 'iPhone 12', 2, 1000),
(3, 'Apple Originals 3', 'AirPods Pro', 3, 280),
(4, 'Apple Originals 4', 'iPhone 12 Pro', 2,1000),
(4, 'Apple Originals 4', ' MacBook Pro 13', 1, 2500);

