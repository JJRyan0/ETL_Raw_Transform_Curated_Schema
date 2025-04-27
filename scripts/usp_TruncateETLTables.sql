-- usp_TruncateETLTables is used to truncate multiple tables—like your raw_, dim_, and fact_ tables—in a 
--clean and reusable way.

CREATE PROCEDURE usp_TruncateETLTables
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Disable foreign key constraints if needed
        -- You may need to disable and re-enable constraints if truncating dim/fact tables with relationships

        PRINT 'Truncating staging/raw tables...';
        TRUNCATE TABLE raw_customers;
        TRUNCATE TABLE raw_orders;

        PRINT 'Truncating dimension tables...';
        TRUNCATE TABLE dim_customers;
        TRUNCATE TABLE dim_products;

        PRINT 'Truncating fact tables...';
        TRUNCATE TABLE fact_sales;
        TRUNCATE TABLE fact_order_lines;

        PRINT 'Truncation completed successfully.';

    END TRY
    BEGIN CATCH
        PRINT 'Error occurred during truncation.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
