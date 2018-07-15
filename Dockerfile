FROM trestletech/plumber

# Install ODBC drivers for MSSQL, Postgress and SQL-Lite 
RUN apt-get update \ 
 && apt-get install -y unixodbc unixodbc-dev tdsodbc odbc-postgresql libsqliteodbc 

RUN Rscript -e "install.packages('odbc')"
