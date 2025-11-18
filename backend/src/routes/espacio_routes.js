// src/routes/espacio_routes.js
const express = require('express');
const {
  listarEspacios,
  crearEspacio,
  obtenerEspacio,
} = require('../controllers/espacio_controller');
const { requireAuth, requireRole } = require('../middlewares/auth_middleware');

const router = express.Router();

// ✅ Cualquier usuario puede ver los espacios (si quieres puedes poner requireAuth)
router.get('/', listarEspacios);

// ✅ Ver detalle de un espacio por idEspacio
router.get('/:idEspacio', obtenerEspacio);

// ✅ Solo admin puede crear espacios nuevos
router.post('/', requireAuth, requireRole('admin'), crearEspacio);

module.exports = router;
