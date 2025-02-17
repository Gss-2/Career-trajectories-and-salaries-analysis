create database final_project;
use final_project;
select * from salary_survey;

-- a).Average Salary by Industry and Gender 
SELECT Industry, Gender, Round(AVG(Annual_Salary_INR),0) AS avg_salary
FROM salary_survey
GROUP BY Industry, gender;

-- b. Total Salary Compensation by Job Title
SELECT Job_Title,SUM(Additional_Monetary_Compensation) as total_salary_compensation
FROM salary_survey
Group by Job_Title
Order by total_salary_compensation desc; 

-- c. Salary Distribution by Education Level 
SELECT Min(Annual_Salary_INR) as Minimum_Salary ,
	   Max(Annual_Salary_INR) as Maximum_Salary ,
	   Round(AVG(Annual_Salary_INR),0) as Average_Salary ,
       Highest_level_of_Education_Completed 
FROM salary_survey
GROUP BY Highest_Level_of_Education_Completed;

-- d. Number of Employees by Industry and Years of Experience
SELECT  Distinct(Industry) , Years_of_Professional_Experience_in_field,
		COUNT(Years_of_Professional_Experience_in_field) as Total_employees
        FROM salary_survey
        Group By Industry,Years_of_Professional_Experience_in_field
        ORDER By Total_employees desc;

-- e. Median Salary by Age Range and Gender
SELECT Age_Range , Gender ,Round(AVG(Annual_Salary_INR),0) as Median_Salary
	FROM salary_survey
    GROUP By Age_Range,Gender;
    
-- f. Job Titles with the Highest Salary in Each Country 
SELECT Country ,Job_Title , Total_salary_INR as Highest_salary
 From(
	SELECT Country ,Job_Title , Total_salary_INR ,
	rank() over(Partition by Country Order By Total_salary_INR desc) as Highest_salary_rank
    From salary_survey) ranked
    where Highest_salary_rank = 1
    order by Country;
    
-- g. Average Salary by City and Industry
Select City , Industry , Round(Avg(Annual_Salary_INR),0) as Average_Salary
From salary_survey
Group by Industry,City 
Order by Average_Salary desc;

-- h. Percentage of Employees with Additional Monetary Compensation by Gender 

Select Gender , 
		Round(count(case when Add_Monetory_Compensation_INR > 0 then 1 End)*100/count(*),2) as Percentage_of_Employees_with_AMC
From salary_survey
Group by Gender
Order by Percentage_of_Employees_with_AMC desc;

-- i. Total Compensation by Job Title and Years of Experience 

Select Job_Title, 
		Years_of_Professional_Experience_in_Field ,
		Sum(Add_Monetory_Compensation_INR) as Total_Compensation
        From salary_survey
        Group by Job_Title,Years_of_Professional_Experience_in_Field
        Order by Total_Compensation desc;
        
-- j. Average Salary by Industry, Gender, and Education Level     
Select Industry , 
		Gender , 
        Highest_Level_of_Education_Completed ,  
        Round(Avg(Annual_salary_INR),0) as Average_salary
        From salary_survey
        Group by Gender,Industry,Highest_Level_of_Education_Completed
        Order by Average_salary desc;


    

        