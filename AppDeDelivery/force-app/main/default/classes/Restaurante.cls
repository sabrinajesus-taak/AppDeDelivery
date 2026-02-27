public class Restaurante {
    private String nome;
    private String endereco;
    CategoriaRestaurante categoria; //atributo do tipo enum
    private List<Produto> cardapio; //os produtos são adicionados nos testes

    public Restaurante (String nome, String endereco, CategoriaRestaurante categoria, List<Produto> categoria ){
        this.nome = nome;
        this.endereco = endereco;
        this.categoria = categoria;
        this.cardapio = new List<Produto>(); //garante que a lista inicie vazia
    }

    // O Getter retorna uma das opções do Enum
    public CategoriaRestaurante getCategoria() {
        return categoria;
    }
    public List<Produto> getCardapio() { return cardapio; }

    // O Setter exige que escolha uma das opções do Enum
    public void setCategoria(CategoriaRestaurante categoria) {
        this.categoria = categoria;
    }

    //metodos------------------------------
    public void adicionarProduto(Produto produto) {
        for (Produto p: cardapio) {
            if (p.nome.toLowerCase() == produto.nome.toLowerCase()) {
                System.debug(LoggingLevel.ERROR, 'Mensagem de erro: O produto ' + produto.getNome() + ' já existe.');
            }
        cardapio.add(produto);
        System.debug('Produto Adicionado com sucesso.');
        }
    }

    //-----------------------------------------
    public String exibirCardapio() {
        for (Integer i = 0; i < cardapio.size(); i++) {
            Produto p = cardapio.get(i);
            System.debug((i + 1) + p.getNome() + '- R$' + p.getPreco());
        }
    }

    //-------------------------------------------
    public List<Produtos> buscarProdutos(String termoBusca) {
        List<Produto> produtosEncontrados = new List<Produto>();

        for (Produto p: cardapio) {
            if (p.getNome().containsIgnoreCase(termoBusca)) {
                produtosEncontrados.add(p);
            }
        }
        if (produtosEncontrados.size() != 0) {
            return produtosEncontrados;
            System.debug(produtosEncontrados.getNome() + produtosEncontrados.getPreco());
        } else {
            return produtosEncontrados;
            System.debug('Nenhum produto encontrado com essse termos de busca.');
        }
    }
}