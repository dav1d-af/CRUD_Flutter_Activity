const mysql = require('mysql');
const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'crud_activity'
});


//Create a user
exports.createUser = (req, res) => {
  pool.getConnection((error, connection) => {
      if (error) throw error;
      console.log(`connected as id ${connection.threadId}`);

      const params = req.body;

      connection.query('INSERT INTO students SET ?', params, (error, rows) => {
          connection.release();

          if (!error) {
              res.status(200).json({ message: `Record of ${[params.lastName, params.firstName]} has been added.`});
          } else {
              console.log(error);
              res.status(500).json({ message: error});
          };
      });
  });
};

//List all users
exports.getAllUsers = (req, res) => {
  const year = req.query.year;
  if (!year) {
    return res.status(400).json({ error: 'Year query parameter is required' });
  }
  const validYears = ['1', '2', '3', '4', '5'];
  if (!validYears.includes(year)) {
    return res.status(400).json({ error: 'Invalid year parameter. Must be between 1 and 4.' });
  }
  pool.getConnection((error, connection) => {
    if (error) {
      console.error('Database connection error:', error);
      return res.status(500).json({ error: 'Database connection error' });
    }
    console.log(`Connected as id ${connection.threadId}`);
    connection.query('SELECT * FROM students WHERE year = ?', [year], (error, rows) => {
      connection.release();
      if (error) {
        console.error('Query error:', error);
        return res.status(500).json({ error: 'Query error' });
      }
      res.status(200).json(rows);
    });
  });
};



//Get specific user
exports.getUserProfile = (req, res) => {
  pool.getConnection((error, connection) => {
    if (error) {
      console.error('Error getting MySQL connection:', error);
      return res.status(500).json({ message: 'Server error occurred' });
    }

    console.log(`Connected as id ${connection.threadId}`);

    connection.query('SELECT * FROM students WHERE id = ?', [req.params.id], (error, rows) => {
      connection.release();

      if (error) {
        console.error('Error executing query:', error);
        return res.status(500).json({ message: 'Server error occurred' });
      }

      if (rows.length > 0) {
        res.status(200).json(rows[0]);
      } else {
        res.status(404).json({ message: 'User not found' });
      }
    });
  });
};

exports.updateUser = (req, res) => {
  pool.getConnection((error, connection) => {
      if (error) {
          console.error('Error getting connection:', error);
          return res.status(500).json({ message: 'Error connecting to the database' });
      }
      
      console.log(`Connected as id ${connection.threadId}`);

      const id = req.params.id;
      const params = req.body;  

      console.log('ID from params:', id);
      console.log('Params from body:', params);

      if (!id) {
          connection.release();
          return res.status(400).json({ message: 'School ID is required as a URL parameter' });
      }
      connection.query('UPDATE students SET ? WHERE id = ?', [params, id], (error, results) => {
          connection.release();
          if (error) {
              console.error('Error executing query:', error);
              return res.status(500).json({ message: 'Database query error' });
          }
          console.log('Query Results:', results);
          if (results.affectedRows === 0) {
              return res.status(404).json({ message: `No record found with ID ${id}.` });
          }
          res.status(200).json({ 
              message: `Record of ${[params.last_name, params.first_name, params.middle_name]} has been updated.` 
          });
      });
  });
};

//Delete a user
exports.deleteUser = (req, res) => {
  pool.getConnection((error, connection) => {
      if (error) {
          console.error('Error getting MySQL connection:', error);
          return res.status(500).json({ message: 'Server error occurred' });
      }
      console.log(`Connected as id ${connection.threadId}`);

      connection.query('DELETE FROM students WHERE id = ?', [req.params.id], (error, result) => {
          connection.release(); 

          if (error) {
              console.error('Error executing query:', error);
              return res.status(500).json({ message: 'Server error occurred' });
          }

          if (result.affectedRows > 0) {
              res.status(200).json({ message: `Record with ID # ${req.params.id} has been deleted.` });
          } else {
              res.status(404).json({ message: 'User not found' });
          }
      });
  });
};










