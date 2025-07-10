const jwt = require('jsonwebtoken');
const User = require('../models/userModel');

// Middleware para verificar token JWT
const verificarToken = async (req, res, next) => {
    try {
        // Pegar o token do header Authorization
        const authHeader = req.headers.authorization;
        
        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return res.status(401).json({
                message: 'Token de acesso não fornecido'
            });
        }

        const token = authHeader.substring(7); // Remove 'Bearer ' do início

        // Verificar e decodificar o token
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        
        // Buscar o usuário no banco
        const user = await User.findById(decoded.userId).select('-senha');
        
        if (!user) {
            return res.status(401).json({
                message: 'Usuário não encontrado'
            });
        }

        if (!user.ativo) {
            return res.status(401).json({
                message: 'Usuário inativo'
            });
        }

        // Adicionar o usuário ao request
        req.user = user;
        next();
    } catch (error) {
        if (error.name === 'JsonWebTokenError') {
            return res.status(401).json({
                message: 'Token inválido'
            });
        }
        
        if (error.name === 'TokenExpiredError') {
            return res.status(401).json({
                message: 'Token expirado'
            });
        }

        console.error('Erro na verificação do token:', error);
        return res.status(500).json({
            message: 'Erro interno do servidor'
        });
    }
};

// Middleware para verificar roles específicas
const verificarRole = (...roles) => {
    return (req, res, next) => {
        if (!req.user) {
            return res.status(401).json({
                message: 'Usuário não autenticado'
            });
        }

        if (!roles.includes(req.user.role)) {
            return res.status(403).json({
                message: 'Acesso negado. Permissão insuficiente.'
            });
        }

        next();
    };
};

// Middleware para verificar se é admin
const verificarAdmin = verificarRole('admin');

// Middleware para verificar se é professor ou admin
const verificarProfessor = verificarRole('professor', 'admin');

// Middleware para verificar se é aluno
const verificarAluno = verificarRole('aluno');

// Middleware opcional para verificar token (não falha se não houver token)
const verificarTokenOpcional = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;
        
        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return next(); // Continua sem usuário
        }

        const token = authHeader.substring(7);
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        
        const user = await User.findById(decoded.userId).select('-senha');
        
        if (user && user.ativo) {
            req.user = user;
        }
        
        next();
    } catch (error) {
        // Se houver erro, continua sem usuário
        next();
    }
};

module.exports = {
    verificarToken,
    verificarRole,
    verificarAdmin,
    verificarProfessor,
    verificarAluno,
    verificarTokenOpcional
}; 