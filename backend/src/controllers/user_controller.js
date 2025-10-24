const bcrypt = require('bcryptjs');
const User = require('../models/user_model');

// Crear usuario
async function crearUsuario(req, res) {
  try {
    const { email, password, rol, estado } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: 'email y password son obligatorios' });
    }

    const existe = await User.findOne({ email });
    if (existe) {
      return res.status(400).json({ message: 'El correo ya está registrado' });
    }

    const passwordHash = await bcrypt.hash(password, 10);

    const nuevoUsuario = await User.create({
      email,
      passwordHash,
      rol: rol || 'estudiante',
      estado: estado || 'activo',
    });

    const usuarioJson = nuevoUsuario.toJSON();
    delete usuarioJson.passwordHash;

    return res.status(201).json({ message: 'Usuario creado', usuario: usuarioJson });
  } catch (err) {
    console.error('Error al crear usuario:', err);
    res.status(500).json({ message: 'Error al crear usuario', error: err.message });
  }
}

// Listar usuarios
async function listarUsuarios(_req, res) {
  try {
    const usuarios = await User.find().select('-passwordHash');
    res.json(usuarios);
  } catch (err) {
    console.error('Error al listar usuarios:', err);
    res.status(500).json({ message: 'Error al listar usuarios', error: err.message });
  }
}

module.exports = { crearUsuario, listarUsuarios };
