const express = require('express');
const morgan = require('morgan');
const cors = require('cors');

const app = express();

app.use(express.json());
app.use(morgan('dev'));
app.use(cors());

// Ruta base
app.get('/', (_req, res) => res.json({ message: 'API SmartBreak funcionando 🧠' }));

// Rutas de usuario
app.use('/api/v1/usuarios', require('./routes/user_routes'));

module.exports = app;
