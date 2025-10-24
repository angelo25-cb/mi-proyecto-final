const express = require('express');
const { crearUsuario, listarUsuarios } = require('../controllers/user_controller');

const router = express.Router();

// GET /api/v1/usuarios
router.get('/', listarUsuarios);

// POST /api/v1/usuarios
router.post('/', crearUsuario);

module.exports = router;
