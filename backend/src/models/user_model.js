const mongoose = require('mongoose');
const { randomUUID } = require('crypto');

const ESTADOS = ['activo', 'inactivo', 'suspendido'];
const ROLES = ['admin', 'estudiante'];

const userSchema = new mongoose.Schema(
  {
    idUsuario: {
      type: String,
      unique: true,
      index: true,
      required: true,
    },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true,
      match: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    },
    passwordHash: {
      type: String,
      required: true,
      select: false,
    },
    fechaCreacion: {
      type: Date,
      default: Date.now,
    },
    estado: {
      type: String,
      enum: ESTADOS,
      default: 'activo',
    },
    rol: {
      type: String,
      enum: ROLES,
      default: 'estudiante',
    },
  },
  { versionKey: false }
);

userSchema.pre('validate', function (next) {
  if (!this.idUsuario) this.idUsuario = randomUUID();
  next();
});

userSchema.set('toJSON', {
  transform: (_doc, ret) => {
    if (ret.fechaCreacion instanceof Date) {
      ret.fechaCreacion = ret.fechaCreacion.toISOString();
    }
    delete ret._id;
    return ret;
  },
});

module.exports = mongoose.model('User', userSchema, 'usuarios');
