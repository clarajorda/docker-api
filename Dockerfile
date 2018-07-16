FROM trestletech/plumber

# Install ODBC drivers for MSSQL, Postgress and SQL-Lite 
RUN apt-get update \ 
 && apt-get install -y unixodbc unixodbc-dev tdsodbc odbc-postgresql libsqliteodbc 

RUN Rscript -e " \
  install.packages('RODBC'); \
  install.packages('stringr'); \
  install.packages('compiler'); \
  install.packages('tools'); \ 
  install.packages('itertools'); \   
  install.packages('tm'); \
  install.packages('gofastr'); \
  install.packages('dplyr'); \
  install.packages('Matrix'); \
  install.packages('quanteda'); \ 
  install.packages('data.table'); \ 
  install.packages('rjson'); \ 
  "

VOLUME /api

EXPOSE 8000

ENTRYPOINT ["Rscript", "/api/DedupeAPI.R"]
