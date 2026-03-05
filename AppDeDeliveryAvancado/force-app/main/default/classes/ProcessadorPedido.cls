public class ProcessadorPedido {
    
    public void confirmarPedido(Pedido pedido) {
        //colocar 
        if ( pedido.getStatus() != StatusPedido.CARRINHO) {
            throw new BusinessException('Apenas pedidos no carrinho podem ser confirmados.');
        }
        
        if (pedido.getItens().isEmpty()) {
            throw new BusinessException('Não é possível confirmar um pedido sem itens.');
        }
        
        pedido.recalcularTotal();
        // Ao mudar o status, todos os métodos que chamam validarSePodeAlterar()
        // ficam automaticamente "travados".
        pedido.status = StatusPedido.ENTREGUE;
    }
}

// Confirmar pedido
// Cancelar pedido
// Aplicar regras antes de mudar estado
// Recalcular total se necessário
// Aplicar política de frete (futuro)