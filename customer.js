const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const path = require('path');

const fs = require('fs');
const app = express();
const port = 3000;

app.use(bodyParser.json());

// Setup connection to the database
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'sunwaytask',
    multipleStatements: true
});

connection.connect();



////////////////////////////////////////////////////////////////////////////////--API Routing--////////////////////////////////////////////////////////////////////////////

// Serve static files from the  public directory (Used this as my default page)
app.use(express.static(path.join(__dirname, '/')));

// Redirect the root URL to customerAdd.html
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'customerList.html'));
    })


//To get ALL data
app.get('/customers', (req, res) => {
  connection.query('Select * from customers', (error, results) => {
      if (error) {
          return res.status(500).send(error);
      }
      res.status(200).json(results);
  });
});

// To get data from API, using ID
app.get('/customers/:id', (req, res) => {
    const { id } = req.params;

    connection.query('SELECT * FROM customers WHERE id = ?', [id], (error, results) => {
        if (error) {
            return res.status(500).send(error);
        }
        if (results.length > 0) {
            console.log(results.status);
            res.status(200).json(results[0]);
        } else {
            res.status(404).send('Customer not found.');
        }
    });
});


// To post data
app.post('/customersAdd', (req, res) => {
    const { customer_name, ic_number, date_of_birth, customer_address, country, postcode} = req.body;
    console.log(req.body);
    connection.query('INSERT INTO customers SET ?', { customer_name, ic_number, date_of_birth, customer_address, country, postcode }, (error, results) => {
        if (error) throw error;
        res.status(201).send(`Customer added with ID: ${results.insertId}`);
    });
});

// To Edit Data
app.put('/customersEdit/:id', (req, res) => {
  const { id } = req.params;
  const {customer_name, ic_number, date_of_birth, customer_address, country, postcode } = req.body;
  
  connection.query('UPDATE customers SET ? WHERE id = ?', [{ customer_name, ic_number, date_of_birth, customer_address, country, postcode }, id], (error, results) => {
      if (error) {
          return res.status(500).send(error);
      }
      if (results.affectedRows === 0) {
          // No rows updated means the customer with the provided ID was not found
          return res.status(404).send('Customer not found.');
      }
      res.status(200).send(`Customer with ID: ${id} updated.`);
  });
});


const sqlFilePath = path.join(__dirname, 'customerDatabase.sql');
async function executeSQLFile(filePath) {
    try {
        const data = fs.readFileSync(filePath, { encoding: 'utf-8' }); // Read file synchronously
        const sqlStatements = data.split(/;\s*$/m);

        for (const statement of sqlStatements) {
            if (statement.trim()) {
                console.log('Executing statement:', statement);
                await executeQuery(statement); // Await the completion of each query
            }
        }
    } catch (err) {
        console.error('Error during SQL file execution:', err);
    }
}

function executeQuery(statement) {
    return new Promise((resolve, reject) => {
        connection.query(statement, (err, result) => {
            if (err) {
                console.error('Error executing statement:', err);
                reject(err);
            } else {
                resolve(result);
            }
        });
    });
}

(async () => {
    await executeSQLFile(sqlFilePath);
    app.listen(port, () => {
        console.log(`Server running on http://localhost:${port}`);
    });
})();



/*app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});*/

  
