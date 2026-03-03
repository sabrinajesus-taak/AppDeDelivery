public class ItemPedido {
    private final Produto produto;
    private int quantidade;
    private Dinheiro subtotal;
    
    // Construtor protegido: só o Pedido pode criar
    ItemPedido(Produto produto, int quantidade) {
        if (produto == null) throw new BusinessException('Produto é obrigatório.');
        if (quantidade <= 0) throw new BusinessException('Quantidade deve ser maior que zero');
        this.produto = produto;
        this.quantidade = quantidade;
        this.calcularSubtotal();
    }
    
    private void calcularSubtotal() {
        this.subtotal = this.produto.getPreco().multiplicar(this.quantidade);
    }
    
    // Método quando o produto já existe na lista
    void adicionarQuantidade(int qtd) {
        this.quantidade += qtd;
        this.calcularSubtotal();
    }
    
    public void definirNovaQuantidade(Integer novaQuantidade) {
        if (novaQuantidade <= 0) {
            throw new BusinessException('A quantidade deve ser maior que zero.');
        }
        this.quantidade = novaQuantidade;
        this.calcularSubtotal(); 
    }
    
    
    public Boolean equals(Object obj) {
        if (obj instanceof ItemPedido) {
            ItemPedido other = (ItemPedido)obj;
            // A igualdade é baseada no ID do produto
            return this.produto == other.produto;
        }
        return false;
    }
    
    // Getters
    public Dinheiro getSubtotal() { return subtotal; }
    public Produto getProduto() { return produto; }
    public int getQuantidade() { return quantidade; }
}