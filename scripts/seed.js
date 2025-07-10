const mongoose = require('mongoose');
const User = require('../models/userModel');
const Transaction = require('../models/transactionModel');
const Goal = require('../models/goalModel');
const Achievement = require('../models/achievementModel');
require('dotenv').config();

// Dados de exemplo
const usuariosExemplo = [
    {
        nome: 'João Silva',
        email: 'joao.silva@ifc.edu.br',
        senha: '123456',
        matricula: '2021001',
        role: 'aluno',
        curso: 'Informática para Internet',
        turmas: ['INFO-2021-1', 'INFO-2021-2'],
        saldo: 50
    },
    {
        nome: 'Maria Santos',
        email: 'maria.santos@ifc.edu.br',
        senha: '123456',
        matricula: '2021002',
        role: 'aluno',
        curso: 'Engenharia de Alimentos',
        turmas: ['ENGA-2021-1'],
        saldo: 30
    },
    {
        nome: 'Pedro Oliveira',
        email: 'pedro.oliveira@ifc.edu.br',
        senha: '123456',
        matricula: '2021003',
        role: 'aluno',
        curso: 'Agropecuária',
        turmas: ['AGRO-2021-1'],
        saldo: 75
    },
    {
        nome: 'Ana Costa',
        email: 'ana.costa@ifc.edu.br',
        senha: '123456',
        matricula: 'PROF001',
        role: 'professor',
        turmas: ['INFO-2021-1', 'INFO-2021-2'],
        saldo: 0
    },
    {
        nome: 'Carlos Ferreira',
        email: 'carlos.ferreira@ifc.edu.br',
        senha: '123456',
        matricula: 'PROF002',
        role: 'professor',
        turmas: ['ENGA-2021-1'],
        saldo: 0
    },
    {
        nome: 'Administrador Sistema',
        email: 'admin@ifc.edu.br',
        senha: 'admin123',
        matricula: 'ADMIN001',
        role: 'admin',
        turmas: [],
        saldo: 0
    }
];

async function seedDatabase() {
    try {
        // Conectar ao MongoDB
        await mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/ifc_coin', {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });

        console.log('Conectado ao MongoDB');

        // Limpar coleção de usuários
        await User.deleteMany({});
        console.log('Coleção de usuários limpa');

        // Inserir usuários de exemplo (individualmente para garantir que o hash seja aplicado)
        const usuariosCriados = [];
        for (const usuarioData of usuariosExemplo) {
            const usuario = new User(usuarioData);
            await usuario.save(); // Isso vai executar o middleware de hash
            usuariosCriados.push(usuario);
        }
        console.log(`${usuariosCriados.length} usuários criados com sucesso`);

        // Criar metas de exemplo
        const metasExemplo = [
            {
                titulo: 'Primeira Aula',
                descricao: 'Participe da sua primeira aula do semestre',
                tipo: 'evento',
                requisito: 1,
                recompensa: 10,
                usuariosConcluidos: [],
                ativo: true,
                requerAprovacao: false, // Aprovação automática
                evidenciaObrigatoria: false
            },
            {
                titulo: 'Participação em Evento',
                descricao: 'Participe de um evento institucional',
                tipo: 'evento',
                requisito: 1,
                recompensa: 25,
                usuariosConcluidos: [],
                ativo: true,
                requerAprovacao: true, // Precisa de aprovação
                evidenciaObrigatoria: true,
                tipoEvidencia: 'foto',
                descricaoEvidencia: 'Envie uma foto do evento'
            },
            {
                titulo: 'Indicação de Amigo',
                descricao: 'Indique um amigo para participar do sistema',
                tipo: 'indicacao',
                requisito: 1,
                recompensa: 15,
                usuariosConcluidos: [],
                ativo: true,
                requerAprovacao: false,
                evidenciaObrigatoria: false
            },
            {
                titulo: 'Excelente Desempenho',
                descricao: 'Mantenha excelente desempenho acadêmico',
                tipo: 'desempenho',
                requisito: 1,
                recompensa: 50,
                usuariosConcluidos: [],
                ativo: true,
                requerAprovacao: true, // Precisa de aprovação
                evidenciaObrigatoria: true,
                tipoEvidencia: 'documento',
                descricaoEvidencia: 'Envie comprovante de boas notas'
            },
            {
                titulo: 'Meta Limitada',
                descricao: 'Meta com limite de conclusões',
                tipo: 'evento',
                requisito: 1,
                recompensa: 30,
                usuariosConcluidos: [],
                ativo: true,
                requerAprovacao: false,
                maxConclusoes: 5, // Máximo 5 pessoas podem concluir
                evidenciaObrigatoria: false
            }
        ];

        // Mostrar informações dos usuários criados
        console.log('\nUsuários criados:');
        usuariosCriados.forEach(user => {
            console.log(`- ${user.nome} (${user.role}) - Matrícula: ${user.matricula} - Saldo: ${user.saldo} coins`);
        });

        console.log('\nScript de seed concluído com sucesso!');
        console.log('\nCredenciais de teste:');
        console.log('Aluno: matrícula 2021001, senha 123456');
        console.log('Professor: matrícula PROF001, senha 123456');
        console.log('Admin: matrícula ADMIN001, senha admin123');

    } catch (error) {
        console.error('Erro durante o seed:', error);
    } finally {
        // Fechar conexão
        await mongoose.connection.close();
        console.log('Conexão com MongoDB fechada');
        process.exit(0);
    }
}

// Executar o script
seedDatabase(); 