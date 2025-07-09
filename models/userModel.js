const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    nome: String,
    email: { type: String, unique: true },
    senha: String,
    matricula: { type: String, unique: true },
    role: { type: String, enum: ['aluno', 'professor', 'admin'], default: 'aluno' },
    curso: { type: String, enum: ['Engenharia de Alimentos', 'Agropecuária', 'Informática para Internet']},
    turmas: [String],
    saldo: { type: Number, default: 0 },
    fotoPerfil: { type: String, default: '' }, // usar multer para upload de arquivos
}, 
{ timestamps: true });

module.exports = mongoose.model('User', userSchema);
