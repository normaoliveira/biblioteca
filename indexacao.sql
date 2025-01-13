-- Índices para melhorar a performance
CREATE INDEX idx_livro_disponibilidade ON Livro(disponibilidade);
CREATE INDEX idx_emprestimo_usuario_status ON Emprestimo(id_usuario, status);
CREATE INDEX idx_multa_status_pagamento ON Multa(status_pagamento);
CREATE INDEX idx_usuario_nome ON Usuario(nome);