// src/models/espacio_model.js
const mongoose = require('mongoose');
const { randomUUID } = require('crypto');

// --- Subdocumento Ubicación ---
const ubicacionSchema = new mongoose.Schema(
  {
    latitud: { type: Number, required: true },
    longitud: { type: Number, required: true },
    piso: { type: String },
    edificio: { type: String },
  },
  { _id: false }
);

// --- Subdocumento Característica ---
const caracteristicaSchema = new mongoose.Schema(
  {
    idCaracteristica: { type: String, required: true },
    nombre: { type: String, required: true },
    valor: { type: String, required: true },      // 👈 NUEVO
    tipoFiltro: { type: String, required: true }, // 👈 NUEVO
  },
  { _id: false }
);

const NIVEL_OCUPACION = ['vacio', 'bajo', 'medio', 'alto', 'lleno'];

const espacioSchema = new mongoose.Schema(
  {
    idEspacio: {
      type: String,
      unique: true,
      required: true,
      index: true,
    },
    nombre: {
      type: String,
      required: true,
      trim: true,
    },
    tipo: {
      type: String,
      required: true,
      trim: true, // "Biblioteca", "Cafetería", etc.
    },
    nivelOcupacion: {
      type: String,
      enum: NIVEL_OCUPACION,
      default: 'vacio',
    },
    promedioCalificacion: {
      type: Number,
      default: 0,
      min: 0,
      max: 5,
    },
    ubicacion: {
      type: ubicacionSchema,
      required: true,
    },
    caracteristicas: {
      type: [caracteristicaSchema],
      default: [],
    },
    categoriaIds: {
      type: [String],
      default: [],
    },
  },
  { versionKey: false }
);

// Generar idEspacio si no viene
espacioSchema.pre('validate', function (next) {
  if (!this.idEspacio) this.idEspacio = randomUUID();
  next();
});

// Formato JSON que encaja bien con tu front
espacioSchema.set('toJSON', {
  transform: (_doc, ret) => {
    delete ret._id;
    return ret;
  },
});

module.exports = mongoose.model('Espacio', espacioSchema, 'espacios');
