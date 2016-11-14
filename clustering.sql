---------------------------------------------------DYNAMIC SQL IN STORED PROCEDURE---------------------------------------------------------------------------------

Create Procedure sp_Clustering

    /* Input Parameters */

     @No_of_Clusters INT

      ,@Column NVARCHAR(MAX)

      ,@TABLENAME as NVARCHAR(MAX)

       

AS

    Set NoCount ON

    /* Variable Declaration */

    Declare @SQL AS NVarchar(4000)

    Declare @ParamDefinition AS NVarchar(2000)

    /* Build the Transact-SQL String with the input parameters */

    SET @SQL = 'SELECT MIN(Column1), MAX(Column1) FROM (SELECT ' + CAST(@Column AS NVARCHAR(25))+ ' [Column1], NTILE('

                        + CAST(@No_of_Clusters AS NVARCHAR(25)) + ') OVER (ORDER BY ' + CAST(@Column AS NVARCHAR(25))+ ' ASC) R FROM '

                        + CAST(@TABLENAME AS NVARCHAR(25)) + ' WHERE ' + CAST(@Column AS NVARCHAR(25))+ ' IS NOT NULL ) TABELA 
                        GROUP BY TABELA.R 
                        ORDER BY TABELA.R ASC'

    /* Specify Parameter Format for all input parameters included in the stmt */

    Set @ParamDefinition =      '@No_of_Clusters INT,

                                                @Column NVARCHAR(250),

                                                @TABLENAME NVARCHAR(250)'

    /* Execute the Transact-SQL String with all parameter value's Using sp_executesql Command */

    Execute sp_Executesql     @SQL,

                @ParamDefinition,

                @No_of_Clusters,

                @Column,

                @TABLENAME
--USAGE:
--EXEC sp_Clustering 8, 'INV_ASSIGN_AMOUNT', 'COLLECTION'
