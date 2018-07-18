FROM trestletech/plumber

ADD https://packages.microsoft.com/config/debian/9/prod.list /etc/apt/sources.list.d/mssql-release.list
ADD https://packages.microsoft.com/keys/microsoft.asc /etc/apt/keys/microsoft.asc

RUN apt-get install -y gnupg2 \
  && apt-key add /etc/apt/keys/microsoft.asc

# Install Microsoft ODBC Driver 17 for SQL Server
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-2017
RUN apt-get update \
  && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc unixodbc-dev

RUN Rscript -e " \
  install.packages('RODBC'); \
  install.packages('RODBCext'); \
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
WORKDIR /api

EXPOSE 8000

ENV SWAGGER=false

ENTRYPOINT ["Rscript", "/api/DedupeAPI.R"]
