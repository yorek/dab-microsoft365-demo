# Data API builder and Microsoft 365

Sample demo for using [Data API builder](https://aka.ms/dab) with Microsoft 365

## Deploy the database

You can deploy the TodoDB database in Azure SQL using the provided database project in `TodoDB` folder. The database project is created using the new "SDK-Style" project format. You can read more about that here: [Use SDK-style SQL projects with the SQL Database Projects extension](https://learn.microsoft.com/sql/azure-data-studio/extensions/sql-database-project-extension-sdk-style-projects).

If you want to do everything manually, you just need to build the database project:

```shell
dotnet build ./TodoDB/TodoDB.sqlproj 
```

once the project has been built you'll have a `TodoDB.dacpac` in the `./TodoDB/bin/Debug` folder. Deploy the dacpac file to your Azure SQL instance. If you need any help doing so, take a look at the following resources:

- [Quickstart: Create a single database - Azure SQL Database](https://learn.microsoft.com/azure/azure-sql/database/single-database-create-quickstart?view=azuresql&tabs=azure-portal)
- [Quickstart: Import a .bacpac file to a database in Azure SQL Database or Azure SQL Managed Instance](https://learn.microsoft.com/azure/azure-sql/database/database-import?view=azuresql&tabs=azure-portal)

## Use Data API builder on-prem

You can download and install Data API builder from [here](https://aka.ms/dab). You can use the provided `dab-config.json` to run Data API builder against your database. You need to set the environment variable `AZURE_SQL` so that it contains the connection string to your Azure SQL database. You can do that by running the following command in a Linux shell:

```bash  
export AZURE_SQL="Server=tcp:<SERVER_NAME>.database.windows.net,1433;Initial Catalog=TodoDB;Persist Security Info=False;User ID=<USER_NAME>;Password=<PASSWORD>;"
```

or with PowerShell:

```powershell
$env:AZURE_SQL="Server=tcp:<SERVER_NAME>.database.windows.net,1433;Initial Catalog=TodoDB;Persist Security Info=False;User ID=<USER_NAME>;Password=<PASSWORD>;"
```

and then you can start Data API builder using the following command:

```shell
dab start
```

and you'll be able to use Data API builder on-prem. The REST endpoints will be available at `https://localhost:5001/rest/todo`.

## Use Data API builder in the cloud

There are various ways to run Data API builder in Azure, the easieast for integrating with Sharepoint and Viva Connection is probably using it in Web App. 

The provided `./azure-deploy.sh` script will do that for you. Create an `.env` with the following content:

```shell
RESOURCE_GROUP=
APP_NAME=
APP_PLAN_NAME=
STORAGE_ACCOUNT=
LOCATION=
AZURE_SQL=
```

adding the appropriate values for your environment. `AZURE_SQL` must contain the connection string to the Azure SQL database where you have deployed the `TodoDB` database. The run the script using a Linux shell. If you don't have one you can use the Azure Shell in the Azure Portal: [Azure Cloud Shell](https://shell.azure.com/).

Once the deployment is done, you'll be able to query the REST endpoints at `https://<APP_NAME>.azurewebsites.net/rest/todo`.

**ATTENTION** : Make sure to configure CORS on the Web App that has been created to allow calls from your client application.