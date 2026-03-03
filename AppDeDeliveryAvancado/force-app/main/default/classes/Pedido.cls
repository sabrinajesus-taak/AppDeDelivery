public class Pedido extends EntidadeBase {
    private Cliente cliente;
    private Restaurante restaurante;
    private List<ItemPedido> itens;
    StatusPedido status; //enum
    private Dinheiro total;
    
    // Construtor principal
    public Pedido(Cliente cliente) {
        if (cliente == null) {
            throw new BusinessException('Um pedido deve obrigatoriamente ter um cliente.');
        }
        this.cliente = cliente;
        this.status = StatusPedido.CARRINHO; // Regra da Parte 4: Iniciar no CARRINHO
        this.itens = new List<ItemPedido>();      // Inicializa a lista para evitar nulos
        this.total = Dinheiro.zero();        // Parte 3: Total começa em zero
    }
    
    //só altera se estiver no carrinho
    private void possivelAlterar() {
        if (this.status != StatusPedido.CARRINHO) {
            throw new BusinessException('Não é permitido alterar itens.');
        }
    }
    
    public void adicionarProduto(Produto produto, Integer quantidade) {
        possivelAlterar();
        
        if (quantidade < = 0) {
            throw new BusinessException('A quantidade deve ser positiva');
        }
        
        ItemPedido existeItem = encontrarItemPorProduto(produto);
        if (existeItem != null) {
            existeItem.adicionarQuantidade(quantidade);
        } else {
            this.itens.add(new Pedido(produto, quantidade));
        }
        
        recalcularTotal();
    }
    
    public void removerProduto(Produto produto) {
        validarSePodeAlterar();
        
        for (Integer i = 0; i < itens.size(); i++) {
            if (itens[i].getProduto().equals(produto)) {
                itens.remove(i);
                break;
            }
        }
        recalcularTotal();
    }
    
    public void alterarQuantidade(Produto produto, Integer novaQuantidade) {
        possivelAlterar();
        
        if(novaQuantidade == null || novaQuantidade < 0) {
            this.removerProduto(produto);
            return;
        }

        ItemPedido itemExistente = encontrarItemPorProduto(produto);
        
        if (itemExistente != null) {
            itemExistente.definirNovaQuantidade(novaQuantidade);
            recalcularTotal();
        } else {
            this.adicionarProduto(produto, novaQuantidade); // se o produto não estava no carrinho é adicionado. 
        }
    }
    
    // --- MÉTODO DE CONFIRMAÇÃO  ---

    public void confirmar() {
        if (this.status != StatusPedido.CARRINHO) {
            throw new BusinessException('Apenas pedidos no carrinho podem ser confirmados.');
        }
        
        if (this.itens.isEmpty()) {
            throw new BusinessException('Não é possível confirmar um pedido sem itens.');
        }

        recalcularTotal();
        // Ao mudar o status, todos os métodos que chamam validarSePodeAlterar() 
        // ficam automaticamente "travados".
        this.status = StatusPedido.CONFIRMADO;
    }

    private ItemPedido encontrarItemPorProduto(Produto produto) {
        for (ItemPedido item : this.itens) {
            if (item.getProduto().equals(produto)) {
                return item;
            }
        }
        return null;
    }
    
    private void recalcularTotal(){
        this.total = Dinheiro.zero(); //zero o total antes de recalcular
        
        for (ItemPedido ip: itens) {
            this.total = this.total.somar(ip.getSubtotal());
        }
    }
}