const bcrypt = require('bcryptjs');
const User = require('../models/user_model');

// POST /api/v1/usuarios
async function crearUsuario(req, res) {
  try {
    const { email, password, rol = 'estudiante', estado = 'activo' } = req.body;
    if (!email || !password) {
      return res.status(400).json({ message: 'email y password son obligatorios' });
    }

    const existe = await User.findOne({ email });
    if (existe) return res.status(400).json({ message: 'El correo ya está registrado' });

    const passwordHash = await bcrypt.hash(password, 10);

    // Datos comunes
    const base = { email, passwordHash, rol, estado };

    // Si es estudiante, exigir y mapear extras
    if (rol === 'estudiante') {
      const {
        codigoAlumno,
        nombreCompleto,
        ubicacionCompartida = false,
        carrera = 'No especificada',
      } = req.body;

      if (!codigoAlumno || !nombreCompleto) {
        return res.status(400).json({
          message: 'Faltan campos de estudiante: codigoAlumno y nombreCompleto',
        });
      }

      Object.assign(base, {
        codigoAlumno,
        nombreCompleto,
        ubicacionCompartida,
        carrera,
      });
    }

    const nuevo = await User.create(base);
    const json = nuevo.toJSON();
    delete json.passwordHash;

    return res.status(201).json({ message: 'Usuario creado', usuario: json });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Error al crear usuario', error: err.message });
  }
}

// GET /api/v1/usuarios
async function listarUsuarios(_req, res) {
  try {
    const usuarios = await User.find().select('-passwordHash');
    return res.json(usuarios);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Error al listar usuarios', error: err.message });
  }
}

module.exports = { crearUsuario, listarUsuarios };