## Fall 2018 CS6400 CorkBoard Project by Team061

## Getting Started
Follow these instructions to set up and run the CorkBoard project on your local machine for development and testing purposes. 

## Installation
Install Bitnami *AMP stack: [https://bitnami.com/stacks/infrastructure](https://bitnami.com/stacks/infrastructure)

Move the Phase 3 folder into: C:\Bitnami\wampstack-7.0.11-0\apache2\htdocs\

Now login as ‘root’ to phpMyAdmin: [http://127.0.0.1:80/phpmyadmin/](http://127.0.0.1:80/phpmyadmin/)

## Configure the application
Modify the config file at `lib/config.php` with your DB login
```
define('DB_HOST', "localhost");
define('DB_PORT', "3306");
define('DB_USER', <your DB username>);
define('DB_PASS', <your DB password>);
define('DB_SCHEMA', "cs6400_fall18_team061");
```

## Set up DB
Run the SQL script at `sql/team061_p3_schema.sql` through phpMyAdmin to create the DB and SQL schema. Next, load sample data for testing from `sql/team061_p3_demo_sample_data.sql`

Then restart your Apache server: (here alternative http port 8080 is used)
Now launch the URL: 
<a href="http://localhost:8080/Phase%203/login.php">http://localhost:8080/Phase%203/login.php</a>
 
Lastly, login with username and password below (prefilled): 
```
username: dschrute@dundermifflin.com
password: 1234
```

### Congratulations!
You've successfully set up the CorkBoard project on your local development machine!