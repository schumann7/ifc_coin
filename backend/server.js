require('dotenv').config(); // <--- DEVE vir antes de tudo
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');

const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');

// Importar modelos da pasta models na raiz
const User = require('./models/userModel');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware de segurança
app.use(helmet());

// Configuração do CORS
app.use(cors({
  origin: ['http://localhost:3000', 'http://localhost:8080', 'http://localhost:8000'],
  credentials: true
}));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 100, // limite de 100 requests por IP
  message: 'Muitas requisições deste IP, tente novamente mais tarde.'
});
app.use('/api/', limiter);

// Middleware para parsing JSON
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

console.log('Tentando conectar ao MongoDB...');
console.log('String de conexão:', process.env.MONGODB_URI);
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/ifc_coin', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => {
  console.log('Conectado ao MongoDB');
})
.catch((err) => {
  console.error('Erro ao conectar ao MongoDB:', err);
  process.exit(1);
});
console.log('Depois do mongoose.connect');

//rotas
app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);

//rota de teste
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: 'API está funcionando',
    timestamp: new Date().toISOString()
  });
});

//tratamento de erros
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    message: 'Erro interno do servidor',
    error: process.env.NODE_ENV === 'development' ? err.message : {}
  });
});

// Rota 404
app.use('*', (req, res) => {
  res.status(404).json({ message: 'Rota não encontrada' });
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Servidor rodando na porta 3000');
  console.log('API disponível em: http://localhost:3000/api');
}); 
