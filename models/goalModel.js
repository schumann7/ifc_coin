const mongoose = require('mongoose');

const goalSchema = new mongoose.Schema({
    titulo: String,
    descricao: String,
    tipo: { type: String, enum: ['evento', 'indicacao', 'desempenho', 'custom'] },
    requisito: Number, // Ex: 10 horas, 2 convites, 1 ação
    recompensa: Number, // coins
    usuariosConcluidos: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
}, { timestamps: true });

module.exports = mongoose.model('Goal', goalSchema);